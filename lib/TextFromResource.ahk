TextFromResource(ResourceName){
    if (!A_IsCompiled){
        if !FileExist(ResourceName){
            return 0
        }
        return FileOpen(ResourceName, "r").Read()
    } 
    else {
        ResourceName := StrReplace(ResourceName, "/", "\")
        SplitPath(ResourceName, &OutFileName, &OutDir, &OutExt)
        ResourceType := OutExt = "bmp" || OutExt = "dib" ? 2 : OutExt = "ico" ? 14 : OutExt = "htm" || OutExt = "html" || OutExt = "mht" ? 23 : OutExt = "manifest" ? 24 : 10
        Module := DllCall("GetModuleHandle", "Ptr", 0, "Ptr")
        Resource := DllCall("FindResource", "Ptr", Module, "Str", ResourceName, "UInt", ResourceType, "Ptr")
        ResourceSize := DllCall("SizeofResource", "Ptr", Module, "Ptr", Resource)
        ResourceData := DllCall("LoadResource", "Ptr", Module, "Ptr", Resource, "Ptr")
        ConvertedData := DllCall("LockResource", "Ptr", ResourceData, "Ptr")
        return TextData := StrGet(ConvertedData, ResourceSize, "UTF-8")
    }
}
