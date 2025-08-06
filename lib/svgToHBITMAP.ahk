#Requires AutoHotkey v2.0

svgToHBITMAP(svgPath, width := "", height := "") {
	if (width = "" || height = ""){
		svgContent := (TextFromResource(svgPath))		
		;Find the opening <svg> tag and its contents
		if RegExMatch(svgContent, "i)<svg[^>]+>", &svgTag) {
			; Priority 1: Look for explicit width and height attributes.
			if RegExMatch(svgTag[0], 'i)width="([^"]+)"', &wMatch) && RegExMatch(svgTag[0], 'i)height="([^"]+)"', &hMatch) {
				RegExMatch(wMatch[1], "\d+", &numW), RegExMatch(hMatch[1], "\d+", &numH)
				detectedWidth := numW[0], detectedHeight := numH[0]
			}
			; Priority 2: Fallback to the viewBox attribute.
			else if RegExMatch(svgTag[0], 'i)viewBox="([^"]+)"', &vbMatch) 
			{
				; viewBox is "min-x min-y width height"
				vbParts := StrSplit(vbMatch[1], A_Space)
				if (vbParts.Length >= 4){
					detectedWidth := Round(vbParts[3]), detectedHeight := Round(vbParts[4])
				}
			}
		}
		width := (width = "") ? (detectedWidth ?? 100) : width
		height := (height = "") ? (detectedHeight ?? 100) : height
	}	
	;https://gist.github.com/smourier/5b770d32043121d477a8079ef6be0995
	;https://stackoverflow.com/questions/75917247/convert-svg-files-to-bitmap-using-direct2d-in-mfc#75935717
	; ID2D1DeviceContext5::CreateSvgDocument is the carrying api
	hModule:=DllCall("GetModuleHandleA","AStr","WindowsCodecs.dll","Ptr")||DllCall("LoadLibraryA","AStr","WindowsCodecs.dll","Ptr")
	CLSID_WICImagingFactory:=Buffer(0x10)
	NumPut("UInt64",0x433D5F24317D06E8,CLSID_WICImagingFactory,0x0)
	NumPut("UInt64",0xC2ABD868CE79F7BD,CLSID_WICImagingFactory,0x8)
	IID_IClassFactory:=Buffer(0x10)
	NumPut("UInt64",0x0000000000000001,IID_IClassFactory,0x0)
	NumPut("UInt64",0x46000000000000C0,IID_IClassFactory,0x8)
	DllGetClassObject:=DllCall("GetProcAddress","Ptr",hModule,"AStr","DllGetClassObject","Ptr")
	DllCall(DllGetClassObject,"Ptr",CLSID_WICImagingFactory,"Ptr",IID_IClassFactory,"Ptr*",&IClassFactory:=0)

	IID_IWICImagingFactory:=Buffer(0x10)
	NumPut("UInt64",0x4314C395EC5EC8A9,IID_IWICImagingFactory,0x0)
	NumPut("UInt64",0x70FF35A9D754779C,IID_IWICImagingFactory,0x8)
	ComCall(3,IClassFactory,"Ptr",0,"Ptr",IID_IWICImagingFactory,"Ptr*",&IWICImagingFactory:=0) ;HRESULT IClassFactory::CreateInstance(IUnknown *pUnkOuter,REFIID riid,void **ppvObject)

	GUID_WICPixelFormat32bppPBGRA:=Buffer(0x10)
	NumPut("UInt64",0x4BFE4E036FDDC324,GUID_WICPixelFormat32bppPBGRA,0x0)
	NumPut("UInt64",0x10C98D76773D85B1,GUID_WICPixelFormat32bppPBGRA,0x8)
	ComCall(17,IWICImagingFactory,"Uint",width,"Uint",height,"Ptr",GUID_WICPixelFormat32bppPBGRA,"Int",0x2,"Ptr*",&IWICBitmap:=0) ;HRESULT IWICImagingFactory::CreateBitmap(UINT uiWidth,UINT uiHeight,REFWICPixelFormatGUID pixelFormat,WICBitmapCreateCacheOption option,IWICBitmap **ppIBitmap); 0x2=WICBitmapCacheOnLoad


	IID_ID2D1Factory:=Buffer(0x10)
	NumPut("UInt64",0x465A6F5006152247,IID_ID2D1Factory,0x0)
	NumPut("UInt64",0x07603BFD8B114592,IID_ID2D1Factory,0x8)

	DllCall("GetModuleHandleA", "AStr", "d2d1") || DllCall("LoadLibraryA", "AStr", "d2d1") ;this is needed to avoid "Critical Error: Invalid memory read/write"
	DllCall("d2d1\D2D1CreateFactory","Int",0,"Ptr",IID_ID2D1Factory,"Ptr",0,"Ptr*",&ID2D1Factory:=0) ;Int 0=D2D1_FACTORY_TYPE_SINGLE_THREADED

	D2D1_RENDER_TARGET_PROPERTIES:=Buffer(0x1c,0)
	ComCall(13,ID2D1Factory,"Ptr",IWICBitmap,"Ptr",D2D1_RENDER_TARGET_PROPERTIES,"Ptr*",&ID2D1RenderTarget:=0) ;HRESULT ID2D1Factory::CreateWicBitmapRenderTarget(IWICBitmap *target,D2D1_RENDER_TARGET_PROPERTIES &renderTargetProperties,ID2D1RenderTarget **renderTarget)

	if (!A_IsCompiled){
		DllCall("shlwapi\SHCreateStreamOnFileW","WStr",svgPath,"Uint",0,"Ptr*",&IStream:=0)
	}
	else {
		hMod := DllCall("GetModuleHandle", "Ptr", 0, "Ptr")
	    hRes := DllCall("FindResource", "Ptr", hMod, "Str", svgPath, "UInt", 10, "Ptr")
        if (!hres) {
            throw ValueError("Resource not found", -1, svgPath)
        }
	    resSize := DllCall("SizeofResource", "Ptr", hMod, "Ptr", hRes)
	    hResData := DllCall("LoadResource", "Ptr", hMod, "Ptr", hRes, "Ptr")
	    pBuff := DllCall("LockResource", "Ptr", hResData, "Ptr")
	    IStream := DllCall("shlwapi\SHCreateMemStream", "Ptr", pBuff, "UInt", resSize, "Ptr")
	}
	D2D1_SIZE_F:=Buffer(8)
	NumPut("float",width,D2D1_SIZE_F,0x0)
	NumPut("float",height,D2D1_SIZE_F,0x4)
	ComCall(115,ID2D1RenderTarget,"Ptr",IStream,"Uint64",NumGet(D2D1_SIZE_F,"Uint64"),"Ptr*",&ID2D1SvgDocument:=0) ;HRESULT ID2D1DeviceContext5::CreateSvgDocument(IStream *inputXmlStream,D2D1_SIZE_F viewportSize,ID2D1SvgDocument **svgDocument)

	ComCall(48,ID2D1RenderTarget,"int") ;void ID2D1RenderTarget::BeginDraw()
	ComCall(116,ID2D1RenderTarget,"Ptr",ID2D1SvgDocument,"int") ;void ID2D1DeviceContext5::DrawSvgDocument(ID2D1SvgDocument *svgDocument)
	ComCall(49,ID2D1RenderTarget,"Ptr",0,"Ptr",0) ;HRESULT ID2D1RenderTarget::EndDraw(D2D1_TAG *tag1,D2D1_TAG *tag2)

	cbStride:=4*width ;stride=bpp*width
	pData:=Buffer(cbStride * height) ;bpp*width*height
	ComCall(7,IWICBitmap,"Ptr",0,"Uint",cbStride,"Uint",pData.Size,"Ptr",pData) ;HRESULT IWICBitmapSource::CopyPixels(WICRect *prc,UINT cbStride,UINT cbBufferSize,BYTE *pbBuffer)

	HBITMAP := DllCall("gdi32\CreateBitmap","Int",width,"Int",height,"Uint",1,"Uint",32,"Ptr",pData,"Ptr")
	return HBITMAP
}
