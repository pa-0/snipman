#DllLoad 'Msftedit.dll'

styles  := (ES_SAVESEL := 0x00008000) | (ES_NOHIDESEL := 0x00000100) | (ES_MULTILINE := 0x00000004)
margins := (EC_LEFTMARGIN := 1) | (EC_RIGHTMARGIN := 2)
bgcolor := (cmode = "dark") ? 0x202020 : 0xFFFFFF
sg.rtfcol := (cmode = "dark") ? 0xFFFFFF : 0x000000
WM_LBUTTONDOWN := 0x0201, EM_SETREADONLY := 0x00CF, EM_SETEVENTMASK := 0x0445, EM_SETMARGINS := 0x00D3
WS_VSCROLL := 0x800, EN_LINK := 0x70B, ENM_LINK := 0x04000000, tomNullCaret := 2
guidir := A_ScriptDir . "\gui"
smad := (A_IsCompiled) ? "smaboutd.svg" : guidir . "\smaboutd.svg"
smal := (A_IsCompiled) ? "smaboutl.svg" : guidir . "\smaboutl.svg"
imagePath := (cmode = "dark") ? smad : smal
hbmap := svgToHBITMAP(imagePath)
;sg := Gui(, 'about snipman')
sg.MarginX := sg.MarginY := 15
tc := sg.AddText("xs ym+30 h80 w230", "snipman")
pc := sg.AddPicture("x+10 ym+25 -E0x200", "HBITMAP:" . hbmap)
tc.SetFont("s44 c" sg.txtcol, "Consolas")
re := sg.AddCustom('ClassRICHEDIT50W w485 h240 xm+95 ym+95 +VSCROLL ' . styles)
;re := sg.AddCustom('ClassRICHEDIT50W x15 y15 w395 h250 ' . styles)


RichEdit_SetPropertyBits(re.Hwnd)
SendMessage EM_SETEVENTMASK,, ENM_LINK, re
SendMessage EM_SETMARGINS, margins, 12 | 12 << 16, re

TextDocument := GetDispatch(re.hwnd)
TextDocument.CaretType := tomNullCaret

rng := CreateRange(0, 0,, 5)
rng.Text := '`n'

rng := CreateRange(rng.End, rng.End, 'Consolas', 20, 0x38D3E2)
rng.Text := 'snippet manager'

rng := CreateRange(rng.End, rng.End,, 5)
rng.Text := '`n`n'

rng := CreateRange(rng.End, rng.End, 'Consolas', 9, sg.rtfcol)
rng.Text := 'Search, view, and use text snippets in any application.`n'

rng := CreateRange(rng.End, rng.End,, 5)
rng.Text := '`n`n'

rng := CreateRange(rng.End, rng.End, 'Consolas', 10, sg.rtfcol)
rng.Text := 'Credits (and Thanks)`n'

rng := CreateRange(rng.End, rng.End,, 5)
rng.Text := '`n'

rng := CreateRange(rng.End, rng.End, 'Consolas', 7, sg.rtfcol)
rng.Text := 'To the AutoHotkey developers and forums.`nTo @ethanpil for '

rng := CreateRange(rng.End, rng.End, 'Consolas', 7, linkcolor)
rng.Text := 'snips'
rng.Url := '"https://github.com/ethanpil/snips"'

rng := CreateRange(rng.End, rng.End, 'Consolas', 7, sg.rtfcol)
rng.Text := ' (the inspiration for snipman)`n'

rng := CreateRange(rng.End, rng.End,, 5)
rng.Text := '`n`n'

rng := CreateRange(rng.End, rng.End, 'Consolas', 10, sg.rtfcol)
rng.Text := 'License and Copyright`n'

rng := CreateRange(rng.End, rng.End,, 5)
rng.Text := '`n'

rng := CreateRange(rng.End, rng.End, 'Consolas', 7, sg.rtfcol)
rng.Text := 'Copyright © Peter Abbasi 2025`n'

rng := CreateRange(rng.End, rng.End,, 12)
sp := '                 '
Loop 9 * A_ScreenDPI // 100 {
    sp .= A_Space
}
rng.Text := '`n`n`n' . sp

;InsertPicture(imagePath, CreateRange(rng.End, rng.End), 2000, 2000) ; HIMETRIC := 0.01 mm
SendMessage EM_SETREADONLY, true,, re
SendMsg(0x443, 0, bgcolor) ; EM_SETBKGNDCOLOR

;sg.Show()

OnLinkClick(link) => Run(link)

re.OnNotify(EN_LINK, (e, lParam) => (
    NumGet(lParam, A_PtrSize * 3, 'UInt') = WM_LBUTTONDOWN && (
        start := NumGet(lParam, A_PtrSize * 5 + 4, 'UInt'),
        end   := NumGet(lParam, A_PtrSize * 5 + 8, 'UInt'),
        OnLinkClick(TextDocument.Range(start, end).Text)
    )
))

CreateRange(start, end, fontName := 'Verdana', fontSize := 12, fontColor?) {
    rng := TextDocument.Range(start, end)
    rng.Font.Name := fontName
    rng.Font.Size := fontSize
    IsSet(fontColor) && rng.Font.ForeColor := fontColor
    return rng
}

InsertPicture(imagePath, rng, w, h) {
    buf := FileRead(imagePath, 'RAW')
    BSTR := DllCall('OleAut32\SysAllocString', 'Str', 'pic')
    pIStream := DllCall('Shlwapi\SHCreateMemStream', 'Ptr', buf, 'UInt', buf.size, 'Ptr')
    ComCall(InsertImage := 107, ComObjValue(rng), 'UInt', w, 'UInt', h, 'UInt', 1,
                                'UInt', TA_BASELINE := 0x18, 'Ptr', BSTR, 'Ptr', pIStream)
    ObjRelease(pIStream)
}

GetDispatch(hEdit) {
    static EM_GETOLEINTERFACE := 0x43C, VT_DISPATCH := 9, VT_UNKNOWN := 13, F_OWNVALUE := 1
         , IID_ITextDocument2 := '{01C25500-4268-11D1-883A-3C8B00C10000}'
         
    DllCall('SendMessage', 'Ptr', hEdit, 'UInt', EM_GETOLEINTERFACE,
                           'Ptr', 0, 'PtrP', IRichEditOle := ComValue(VT_UNKNOWN, 0))
    ITextDocument := ComObjQuery(IRichEditOle, IID_ITextDocument2)
    Return ComValue(VT_DISPATCH, ITextDocument, F_OWNVALUE)
}

RichEdit_SetPropertyBits(hRich){
    Local OnTxPropertyBitsChange := 19
        , Unknown
        , pUnknown
        , TxtSrv

    SendMessage(0x43C, 0, Unknown := Buffer(8), hRich)                              ; EM_GETOLEINTERFACE
    pUnknown  :=  NumGet(Unknown, "ptr")
    TxtSrv    :=  ComObjQuery(pUnknown, "{8D33F740-CF58-11CE-A89D-00AA006CADC5}")   ; IID_ITextServices
    ObjRelease(pUnknown)

    If  A_Ptrsize = 8
    {
        ComCall(OnTxPropertyBitsChange, TxtSrv, "int",0x802, "int",0x2)             ; TXTBIT_ALLOWBEEP|TXTBIT_MULTILINE
        TxtSrv :=  ""
        Return
    }

    Local vtbl                    :=  NumGet(TxtSrv.Ptr, "ptr")
        , pOnTxPropertyBitsChange :=  NumGet(vtbl + (19 * A_PtrSize), "ptr")
        , thiscall_thunk          :=  Buffer(8)

    NumPut("int64", 0xE2FF50595A58, thiscall_thunk)
    DllCall("Kernel32\VirtualProtect", "ptr",thiscall_thunk, "ptr",8, "int",0x40, "uint*",0)
    DllCall(thiscall_thunk, "ptr",pOnTxPropertyBitsChange, "ptr",TxtSrv, "int",0x802, "int",0x2)
    TxtSrv  :=  ""
}

SendMsg(Msg, wParam, lParam) => SendMessage(msg, wParam, lParam, re.Hwnd)
