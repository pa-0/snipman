#Requires AutoHotkey v2.1-alpha.10

#NoTrayIcon
#SingleInstance force

APPNAME := "snipman", APPVERSION := "1.0.24"
;@Ahk2Exe-Let Name = %A_PriorLine~U)^(.+"){1}(.+)".*$~$2%
;@Ahk2Exe-Let Version = %A_PriorLine~U)^(.+"){3}(.+)".*$~$2%
;@Ahk2Exe-Let Svg = %A_ScriptDir%\icons
;@Ahk2Exe-Let Gui = %A_ScriptDir%\gui
;@Ahk2Exe-Base C:\Program Files\AutoHotkey\v2\AutoHotkey32.exe, %A_ScriptDir%\build\x32\%A_ScriptName~\.ahk%.exe 
;@Ahk2Exe-Base C:\Program Files\AutoHotkey\v2\AutoHotkey64.exe, %A_ScriptDir%\build\x64\%A_ScriptName~\.ahk%.exe 
;@Ahk2Exe-UpdateManifest 0, %U_Name%, %U_Version%.0
;@Ahk2Exe-SetName %U_Name%
;@Ahk2Exe-SetCompanyName POA
;@Ahk2Exe-SetVersion %U_Version%.0
;@Ahk2Exe-SetDescription %U_Name% Snippet Manager
;@Ahk2Exe-SetCopyright Copyright (C) 2025 POA
;@Ahk2Exe-SetMainIcon ico\smdark.ico
;@Ahk2Exe-AddResource ico\smlite.ico, 160
;@Ahk2Exe-AddResource ico\smdark.ico, 206
;@Ahk2Exe-AddResource ico\smdark_alt.ico, 207
;@Ahk2Exe-AddResource ico\smlite_alt.ico, 208

; gui icons
;@Ahk2Exe-AddResource %U_Gui%\smaboutd.svg, smaboutd.svg
;@Ahk2Exe-AddResource %U_Gui%\smaboutl.svg, smaboutl.svg

; svg icons - used to identify syntax in snippet preview
;@Ahk2Exe-AddResource %U_Svg%\applescript.svg, applescript.svg
;@Ahk2Exe-AddResource %U_Svg%\assembly_x86.svg, assembly_x86.svg
;@Ahk2Exe-AddResource %U_Svg%\autohotkey.svg, autohotkey.svg
;@Ahk2Exe-AddResource %U_Svg%\autoit.svg, autoit.svg
;@Ahk2Exe-AddResource %U_Svg%\batchfile.svg, batchfile.svg
;@Ahk2Exe-AddResource %U_Svg%\c.svg, c.svg
;@Ahk2Exe-AddResource %U_Svg%\cpp.svg, cpp.svg
;@Ahk2Exe-AddResource %U_Svg%\csharp.svg, csharp.svg
;@Ahk2Exe-AddResource %U_Svg%\css.svg, css.svg
;@Ahk2Exe-AddResource %U_Svg%\d.svg, d.svg
;@Ahk2Exe-AddResource %U_Svg%\delphi.svg, delphi.svg
;@Ahk2Exe-AddResource %U_Svg%\diff.svg, diff.svg
;@Ahk2Exe-AddResource %U_Svg%\dockerfile.svg, dockerfile.svg
;@Ahk2Exe-AddResource %U_Svg%\freepascal.svg, freepascal.svg
;@Ahk2Exe-AddResource %U_Svg%\git.svg, git.svg
;@Ahk2Exe-AddResource %U_Svg%\golang.svg, golang.svg
;@Ahk2Exe-AddResource %U_Svg%\haskell.svg, haskell.svg
;@Ahk2Exe-AddResource %U_Svg%\html.svg, html.svg
;@Ahk2Exe-AddResource %U_Svg%\ini.svg, ini.svg
;@Ahk2Exe-AddResource %U_Svg%\java.svg, java.svg
;@Ahk2Exe-AddResource %U_Svg%\javascript.svg, javascript.svg
;@Ahk2Exe-AddResource %U_Svg%\json.svg, json.svg
;@Ahk2Exe-AddResource %U_Svg%\lua.svg, lua.svg
;@Ahk2Exe-AddResource %U_Svg%\makefile.svg, makefile.svg
;@Ahk2Exe-AddResource %U_Svg%\markdown.svg, markdown.svg
;@Ahk2Exe-AddResource %U_Svg%\nim.svg, nim.svg
;@Ahk2Exe-AddResource %U_Svg%\objectivec.svg, objectivec.svg
;@Ahk2Exe-AddResource %U_Svg%\objectivecpp.svg, objectivecpp.svg
;@Ahk2Exe-AddResource %U_Svg%\perl.svg, perl.svg
;@Ahk2Exe-AddResource %U_Svg%\php.svg, php.svg
;@Ahk2Exe-AddResource %U_Svg%\plain_text.svg, plain_text.svg
;@Ahk2Exe-AddResource %U_Svg%\powershell.svg, powershell.svg
;@Ahk2Exe-AddResource %U_Svg%\python.svg, python.svg
;@Ahk2Exe-AddResource %U_Svg%\ruby.svg, ruby.svg
;@Ahk2Exe-AddResource %U_Svg%\rust.svg, rust.svg
;@Ahk2Exe-AddResource %U_Svg%\shell.svg, shell.svg
;@Ahk2Exe-AddResource %U_Svg%\swift.svg, swift.svg
;@Ahk2Exe-AddResource %U_Svg%\symbols.svg, symbols.svg
;@Ahk2Exe-AddResource %U_Svg%\toml.svg, toml.svg
;@Ahk2Exe-AddResource %U_Svg%\typescript.svg, typescript.svg
;@Ahk2Exe-AddResource %U_Svg%\vb_net.svg, vb_net.svg
;@Ahk2Exe-AddResource %U_Svg%\vba.svg, vba.svg
;@Ahk2Exe-AddResource %U_Svg%\vbscript.svg, vbscript.svg
;@Ahk2Exe-AddResource %U_Svg%\webassembly.svg, webassembly.svg
;@Ahk2Exe-AddResource %U_Svg%\xml.svg, xml.svg
;@Ahk2Exe-AddResource %U_Svg%\yaml.svg, yaml.svg
;@Ahk2Exe-AddResource %U_Svg%\zig.svg, zig.svg

;post-compile directives
;@Ahk2Exe-Obey U_Bin,= "%A_BasePath~^.+\.%" = "bin" ? "Cont" : "Nop" ; .bin?
;@Ahk2Exe-Obey U_au, = "%A_IsUnicode%" ? 2 : 1 ; Base file ANSI or Unicode?
;@Ahk2Exe-PostExec "BinMod.exe" "%A_WorkFileName%"
;@Ahk2Exe-%U_Bin%  "%U_au%2.>AUTOHOTKEY SCRIPT<.$APPLICATION SOURCE"
;@Ahk2Exe-Cont  "%U_au%.AutoHotkeyGUI.snipman_class"
;@Ahk2Exe-PostExec "BinMod.exe" "%A_WorkFileName%" /SetUTC
;@Ahk2Exe-PostExec "pwsh.exe" "%A_ScriptDir%\.github\SignCode.ps1" -exe "%A_WorkFileName%"

#Include <JSON>
#Include <mcParser>
#Include <DarkListView>
#Include <DarkMsgBox>
#Include <SetWindowColor>
#Include <ToolTipOptions>
#Include <TextFromResource>
#Include <svgToHBITMAP>
#Include <DefaultIni>
#Include <snipmanSettings>
#Include <OD_Colors>

/*
* TODO: FileInstall(sm.cmd) as CLI alias 'sm'           *
* TODO: CLI parameters '-mode dark/light' (force)       *
* TODO: Make functions nested and remove global vars    *
* TODO: Add switch for full mode / compact mode1        *
* TODO: Full mode: add rich edit control for preview    *
* TODO: ↳ Add syntax highlighting to rich edit control  *
*/
CoordMode("Mouse","Screen")
CoordMode("ToolTip","Screen")
CoordMode("Pixel", "Screen")

Persistent
DetectHiddenWindows True

global exe
     , lastHwnd
     , snipmode
     , icodir
     , svgmap
svgmap   := BuildSvgMap()
exe      := GetExeName()
lastHwnd := 0 
snipmode := 1 ;COPY MODE
icodir   := A_ScriptDir "\ico\"
uselocal := GetConfig("uselocal", "Locations")
if(uselocal = "true"){
    ExtractSvg()
}
snipmanGUI("8","Segoe UI")

snipmanGUI(fontSize :=8, font := "Segoe UI"){
    global mg, ed, lv, tv, btn, sb, btnText
    static WS_EX_COMPOSITED
    static WS_EX_COMPOSITED := 0x02000000
    static WM_LBUTTONDOWN   := 0x0201
    static WM_RBUTTONDOWN   := 0x0204
    static WM_RBUTTONUP     := 0x0205
    static WM_SETCURSOR     := 0x0020
    static WM_MOVING        := 0x0216
    static TVS_INFOTIP      := 0x0800
    btnText     := Chr(0xECCD)
    guiTheme    := GetAppTheme()
    sysTheme    := isDarkMode("sys")

    DllCall("shell32\SetCurrentProcessExplicitAppUserModelID", "ptr", StrPtr("snipman"))
    snpTray := A_TrayMenu 
    snpTray.Delete()
    snpTray.Add("snipman", OpenSnipmanCM)
    snpTray.Add()
    snpTray.Add("Load", chooseDB)
    snpTray.Add("Refresh", RefreshSnipman)
    snpTray.Add("Settings", OpenSettings)
    snpTray.Add()
    snpTray.Add("About", AboutSnipman)
    snpTray.Add("Help", GetHelp)
    snpTray.Add()
    snpTray.Add("Run at Login", (*) => StartUpSM())
    if(FileExist(A_Startup . "\" . APPNAME . ".lnk")){
        snpTray.Check("Run at Login")
    }
    snpTray.Add()
    snpTray.Add("Exit", exit)
    snpTray.Default := "snipman"
    SetTrayIcon()
    A_IconTip := "snipman v" . APPVERSION
    
    mg := GUI("AlwaysOnTop -Resize MinSize240x440 MaxSize240x440 +DPIScale +" WS_EX_COMPOSITED, "snipman")
    mg.BackColor := (guiTheme = "dark") ? 0x202020 : 0xFFFFFF
    mg.width := 240
    mg.height := 440
    mg.MarginY := 10
    mg.MarginX := 10
    mg.SetFont("s" . fontSize . " q5", font)
    mg.Opt("+OwnDialogs")
    ctrlbgc := (guiTheme = "dark") ? "191919" : "FFFFFF"
    fontcol := (guiTheme = "dark") ? "F8F8F8" : "000000"
    ed := mg.Add("Edit", "xm ym w220 r1 c" fontcol " Background" ctrlbgc " -Wrap +0x200 -E0x200", "")
    tv := mg.Add("TreeView", "xm ym+25 w220 r25 -E0x200 +" TVS_INFOTIP)
    tv.Opt("c" fontcol " Background" mg.BackColor)    
    btn := mg.Add("Button", "xm h20 w20 -Wrap", btnText)
    stg := mg.Add("Button", "xp+200 y+35 h20 w20 -Wrap", Chr(0xE115))
    btn.SetFont("s8", "Segoe MDL2 Assets")
    lv := mg.Add("ListView", "xm ym+25 w220 r25 c" fontcol " Background" mg.BackColor " -E0x200", ["Language", "Match", "ID"])
    lv.Opt("-Multi -Grid +HDR")
    sb := mg.Add("Text","c" fontcol " xm y+37 r1 w100", (statustxt := "Snippet Count: "))
    if (guiTheme = "dark") {
        lv.SetDarkMode()                
        SetDarkControls(mg)
        SetWindowColor(WinExist(mg.hWnd), 0xFFFFFF, 0x202020, 0x202020) ;0x719CC0
    }
    ob := mg.Add("Button", "Hidden Default", "OK")   
    mg.OnEvent("Escape", (*) => onEscape())
    ed.OnEvent("Change", (*) => onSearch(ed))
    tv.OnEvent("DoubleClick", onTvDblClick)
    ;btn.OnEvent("Click",OnBtnClick)
    btn.OnEvent("Click", onToggle)
    stg.OnEvent("Click", OpenSettings)
    stg.ToolTip := "Open snipman settings menu"
    lv.OnEvent("DoubleClick", onLvDblClick)
    tv.OnEvent("ItemSelect", onTvSelect)
    lv.OnEvent("ItemSelect", onLvSelect)
    lv.OnEvent("ItemFocus", onLvSelect)
    LVM_SETHOVERTIME := 0x1047
    timeToWait := 05 ; in ms
    tv.OnNotify(-414, TV_ToolTip)
    SendMessage LVM_SETHOVERTIME, 0, timeToWait, lv, mg
    mg.OnMessage(WM_LBUTTONDOWN, DragWindow)
    OnMessage(0x0200, On_WM_MOUSEMOVE)
    ;OnMessage(0x200, WM_MOUSEMOVE)
    ;tv.OnMessage(WM_LBUTTONDOWN, DragWindow)
    sb.OnMessage(WM_LBUTTONDOWN, DragWindow)
    ;ed.OnMessage(WM_LBUTTONDOWN, DragWindow)
    ed.OnMessage(WM_SETCURSOR, SetCursor)
    EnumSnippets(&smcount)
    lv.ModifyCol(1, 60)
    lv.ModifyCol(2, 140)
    lv.ModifyCol(3, 0) 
    lv.Visible := false
    sb.value := "Snippet Count: " smcount
    SetHotkey()

    StartUpSM(*) {
        ini := A_ScriptDir . "\snipman.ini"
        sec := "General"
        key := "autorun"
        lnk := A_Startup "\" APPNAME ".lnk"
        if FileExist(lnk){
            FileDelete(lnk)
            IniWrite("false", ini, sec, key)
            snpTray.Uncheck("Run at Login")
            TrayTip "" APPNAME " removed from Startup Apps.", APPNAME, 4
        }
        else {
            ext := (A_IsCompiled) ? ".exe" : ".ahk"
            FileCreateShortcut(A_WorkingDir "\" APPNAME ext, lnk
            , A_WorkingDir, , APPNAME " snippet manager" , , , )
            IniWrite("true", ini, sec, key)
            snpTray.Check("Run at Login")
            TrayTip "" APPNAME " will now run at Login.", APPNAME, 4
        }
        Reload()
    } 

    OnSearch(A_GuiEvent := "", GuiCtrlObj := "", Info := "", *){
        global smArray
        tv.Visible := false
        btn.Visible := false
        lv.Delete() 
        lv.Visible := true
        lv.Opt("-Redraw")
        search := ed.Value
        dbPath := GetConfig("database", "Locations")
        sdo    := GetConfig("snipsdir", "Locations")
        if (sdo = "false"){
            snipMap   := parseMassCode(dbPath)
            smdirMap := Map()
            dirArray := []
        }
        if (search != ""){
            lv.Opt("-Redraw")
            lv.ModifyCol(1, 60)
            lv.ModifyCol(2, 140)
            lv.ModifyCol(3, 0)
            loop smArray.length {
                if(sdo = "true"){
                    for sid, sname in smArray[A_Index] {
                        SplitPath sname, &name, &dir, &ext, &base, &drv
                        fpos := InStr(dir, "\", , -1)
                        fpos += 1
                        cat  := SubStr(dir, fpos)
                        if (InStr(base, search)) || (InStr(cat, search)){
                            lv.Add("", cat, base, sid)
                        }
                    }
                }
                else {
                    for sid, smap in smArray[A_Index] {
                        for name, nsmap in smap {
                            for nmap1, nmap2 in nsmap {
                                for dir, syn in nmap1 { 
                                    for val, info in nmap2 {
                                        if (InStr(dir, search)) || (InStr(name, search)) || (InStr(val, search)){
                                            lv.Add("", dir, name, sid)
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
            Items := lv.GetCount()
            sb.value := "Snippet Count: " Items
            if (Items = 0){
              lv.Add("", "No Results.")  
            }
            lv.ModifyCol(1, 60) 
            lv.ModifyCol(2, 140) 
            lv.ModifyCol(3, 0)
            lv.Opt("+Redraw")
        }
        else {
            lv.Visible  := false
            tv.Visible  := true
            btn.Visible := true
            btnText     := Chr(0xECCD)
            sb.value := "Snippet Count: " smArray.Length
        }
    }

    TV_ToolTip(TV, lParam){
        sdo := GetConfig("snipsdir", "Locations")
        tts := GetConfig("tiptimer", "Appearance")
        tto := tts * 1000
        hItem := NumGet(lParam, A_PtrSize * 5, "Ptr")
        ;pszText := NumGet(lParam, A_PtrSize * 3, "Ptr")
        htitle := TV.GetText(hItem)
        if (tv.Visible = false){
            return
        }
        if (hItem > 0){
            loop smArray.length {
                if (sdo = "true"){
                    for sid, sname in smArray[A_Index] {
                        SplitPath sname, &name, &dir, &ext, &base, &drv
                        fpos := InStr(dir, "\", , -1)
                        fpos += 1
                        cat  := SubStr(dir, fpos)
                        if (htitle = base){
                            ;StrPut(val, pszText)
                            val := FileRead(sname)
                            langico := GetLangIcon(cat, cat)
                            if (langico != false){
                                CreateTip(val, base, langico)
                            }
                            else {
                                CreateTip(val, base)
                            }
                        }
                    }
                }
                else {
                    for sid, smap in smArray[A_Index] {
                        for name, nsmap in smap {
                            for nmap1, nmap2 in nsmap {
                                for dir, syn in nmap1 { 
                                    for val, info in nmap2 {
                                        if (htitle = name){
                                            ;StrPut(val, pszText)
                                            snip := val
                                            langico := GetLangIcon(syn, dir)
                                            if (langico != false){
                                                CreateTip(val, name, langico)
                                            }
                                            else {
                                                CreateTip(val, name)
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                SetTimer () => ToolTip(), tto
            }
        }
        else {
            DestroyTip()
            SetTimer () => ToolTip(), tto
        }
    }

    On_WM_MOUSEMOVE(wParam, lParam, msg, Hwnd){
        global smArray
        static lvid := lv.hwnd
        static prevrow := 0
        dbp := GetConfig("database", "Locations")
        sdo := GetConfig("snipsdir", "Locations")
        tts := GetConfig("tiptimer", "Appearance")
        tto := tts * 1000
        if (lv.Visible = false){
            return
        }
        if (Hwnd = lvid) {
            row := GetLvRow(lvid)
            if (row > 0){
                rowId := lv.GetText(row, 3)
                if (rowId != prevrow){
                    loop smArray.length {
                        if (sdo = "true"){
                            for sid, sname in smArray[A_Index] {
                                SplitPath sname, &name, &dir, &ext, &base, &drv
                                fpos := InStr(dir, "\", , -1)
                                fpos += 1
                                cat  := SubStr(dir, fpos)
                                if (rowId = sid){
                                    val := FileRead(sname)
                                    langico := GetLangIcon(cat, cat)
                                    if (langico != false){
                                        CreateTip(val, base, langico)
                                    }
                                    else {
                                        CreateTip(val, base)
                                    }
                                    prevrow := rowId
                                }
                            }
                        }
                        else {
                            for sid, smap in smArray[A_Index] {
                                for name, nsmap in smap {
                                    for nmap1, nmap2 in nsmap {
                                        for dir, syn in nmap1 {
                                            for val, info in nmap2 {
                                                if (rowId = sid){
                                                    langico := GetLangIcon(syn, dir)
                                                    if (langico != false){
                                                        CreateTip(val, name, langico)
                                                    }
                                                    else {
                                                        CreateTip(val, name)
                                                    }
                                                    prevrow := rowId
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        SetTimer () => ToolTip(), tto
                    }
                }
            }
            else {
                DestroyTip()
                SetTimer () => ToolTip(), -50 ; Remove the tooltip.
            }
        }
        else {
            DestroyTip()
            SetTimer () => ToolTip(), -50 ; Remove the tooltip.
        } 
    }

/*    OnBtnClick(A_GuiEvent := "", GuiCtrlObj := "", Info := "", *){
        toggleState := (btnText = "Expand") ? 500 : 240
        mg.Move(, , toggleState)
        btnText := (toggleState = 500) ? "Collapse" : "Expand"
        btn.Text := btnText
    }
*/

    SetHotkey(){
        iswinkey := GetConfig("winkeyon", "Interface")
        hkcomb := GetConfig("shortcut", "Interface")
        if(iswinkey = "true"){
            hkey := "#" . hkcomb
        }
        else {
            hkey := hkcomb
        } 
        Hotkey(hkey, OpenSnipman)
    }

    OpenSnipmanCM(A_ThisMenuItem:="", A_ThisMenuItemPos:="", A_ThisMenu:=""){
        try {
            SaveLastHwnd()
        }
        finally {
            mg.show("Autosize")
            ed.Focus()
            if(WinWait("snipman", , 3)){
                WinSetAlwaysOnTop(1, "snipman")
            }
        }
    }

    OpenSnipman(A_ThisMenuItem:="", A_ThisMenuItemPos:="", A_ThisMenu:=""){
        try {
            SaveLastHwnd()
        }
        finally {
            MouseGetPos &xpos, &ypos
            mg.show("Autosize x" xpos " y" ypos)
            ed.Focus()
            if(WinWait("snipman", , 3)){
                WinSetAlwaysOnTop(1, "snipman")
            }
        }
    }
}

#HotIf WinActive("ahk_id " mg.hwnd)
Enter:: {
    lvshown := lv.Visible
    ctrlfocus := ControlGetFocus(mg)
    if (ctrlfocus = ed.hwnd){
        if (lvshown){
            lv.Focus()
            lv.Modify(0, "-Select")
            lv.Modify(1, "+Select")
        }
        else {
            tv.Focus()
        }
    }
    else if (ctrlfocus = lv.hwnd) {
        onLvDblClick()
    }   
    else if (ctrlfocus = tv.hwnd) {
        sel := tv.GetSelection()
        par := tv.GetParent(sel)
        if (par = 0) {
            Send("{RIGHT}")
        }
        else {
            SendSnippet(tv.GetSelection())
        }
    }
} 

Down:: {
    lvshown := lv.Visible
    ctrlfocus := ControlGetFocus(mg)
    if (ctrlfocus = ed.hwnd){        
        if (lvshown){
            lv.Focus()
            lv.Modify(0, "-Select")
            lv.Modify(1, "+Select")
        }
        else {
            tv.Focus()
            lv.Modify(0, "-Select")
            tv.Modify(1, "+Select")
        }
    }
    else {
        Send("{Down}")
    }
}

Up:: {
    lvshown := lv.Visible
    ctrlfocus := ControlGetFocus(mg)
    if (ctrlfocus = ed.hwnd){        
        if (lvshown){
            lv.Focus()
            lv.Modify(0, "-Select")
            lv.Modify(0, "vis")
        }
        else {
            tv.Focus()
            lv.Modify(0, "-Select")
            tv.Modify(0, "vis")
        }
    }
    else {
        Send("{Up}")
    }
}

F1::SettingsGui(6)
F5::RefreshSnipman()

#HotIf

OnClick(A_GuiEvent := "", GuiCtrlObj := "", Info := "", *){
    ctrlfocus := GuiCtrlObj
    ControlGetFocus(ctrlfocus)
}

RefreshSnipman(A_ThisMenuItem:="", A_ThisMenuItemPos:="", A_ThisMenu:=""){
    global sb
    smcount := unset
    tv.Delete()
    EnumSnippets(&smcount)
    sb.value := "Snippet Count: " smcount
}

OpenSettings(*){
        SettingsGui()
}

OnToggle(A_GuiEvent := "", GuiCtrlObj := "", Info := "", *){
    global btn, btnText
    toggleState := (btnText = Chr(0xECCD)) ? "+Expand" : "-Expand"
    ItemID := 0
    Loop {
        ItemID := tv.GetNext(ItemID)
        If (!ItemID) {
            Break
        }
        tv.Modify(ItemID, toggleState)
    }    
    btnText := (toggleState = "+Expand") ? Chr(0xF165) : Chr(0xECCD)
    btn.Text := btnText
}

OnEscape(*){
    global btn, btnText
    lvshown := lv.Visible
    ctrlfocus := ControlGetFocus(mg)
    if (ctrlfocus = ed.hwnd){
        if (ed.Value != ""){
            ed.Value := ""
            RefreshSnipman()
            lv.Visible  := false
            tv.Visible  := true
            btn.Visible := true
            btnText     := Chr(0xECCD)
            btn.Text    := btnText
        }
        else{
            DestroyTip()
            mg.Hide()
        }
    }
    else{
        ed.Focus() 
    }
}

SetDarkControls(gui){
    for ctl in gui {
        isCFD := (ctl.Type = "Edit" || ctl.Type = "ComboBox" || ctl.Type = "DDL") ? "DarkMode_CFD" : "DarkMode_Explorer"
        if (isEdit := ctl.Type = "Edit"){
            ctl.Opt("-VScroll cF8F8F8 Background191919")
        }
        if (!HasMethod(ctl, "SetFont")){
            ctl.SetFont("cF8F8F8")
        }
        SetDarkControl(ctl, isCFD)
        if (ctl.Type = "ComboBox"){
            MsgBox ctl.Type
            DllCall("InvalidateRect", "Ptr", ctl.hWnd, "Ptr", 0, "Int", true)
        }
    }
    SetDarkMode(gui)
}

SetDarkControl(ctrl, style := "DarkMode_Explorer"){
    static IsWin11 := (VerCompare(A_OSVersion, "10.0.22000") > 0)
    hwnd := IsObject(ctrl) ? ctrl.hwnd : ctrl
    if IsWin11 {
        DllCall("Dwmapi\DwmSetWindowAttribute", "Ptr", hwnd, "UInt", 33, "Ptr*", 3, "UInt", 4)
        VarSetStrCapacity(&className, 1024)
        if (DllCall("user32\GetClassName", "ptr", hwnd, "str", className, "int", 512, "int")){
            if (className = "SysListView32") || (className = "SysTreeView32" || (className = "ComboBox")){
                return !DllCall("uxtheme\SetWindowTheme", "ptr", hwnd, "str", style, "ptr", 0)
            }
            else {
                return DllCall("uxtheme\SetWindowTheme", "ptr", hwnd, "ptr", StrPtr(style), "ptr", 0)
            }
        }
    }
}

SetDarkMode(_obj){
    For v in [135, 136]{
        DllCall(DllCall("GetProcAddress", "ptr", DllCall("GetModuleHandle", "str", "uxtheme", "ptr"), "ptr", v, "ptr"), "int", 2)
    }
    if !(attr := VerCompare(A_OSVersion, "10.0.18985") >= 0 ? 20 : VerCompare(A_OSVersion, "10.0.17763") >= 0 ? 19 : 0){
        return false
    }
    DllCall("dwmapi\DwmSetWindowAttribute", "ptr", _obj.hwnd, "int", attr, "int*", true, "int", 4)
    DllCall("RedrawWindow", "Ptr", _obj.Hwnd, "Ptr", 0, "Ptr", 0, "UInt", 0x0285)
    for hWnd, gco in _obj {
        DllCall("RedrawWindow", "Ptr", gco.Hwnd, "Ptr", 0, "Ptr", 0, "UInt", 0x0001)
        DllCall("InvalidateRect", "Ptr", gco.Hwnd, "Ptr", 0, "Int", true)
    }
}

OnTvDblClick(A_GuiEvent := "", GuiCtrlObj := "", Info := "", *){   
    sel := tv.GetSelection()
    par := tv.GetParent(sel)
    if (par = 0){
        ItemID := tv.GetNext(sel, "F")
        if (ItemID > 0){
            tv.Modify(ItemID, "+Expand")
        }
    }
    else{
        SendSnippet(tv.GetSelection())
    }
}

OnLvDblClick(A_GuiEvent := "", GuiCtrlObj := "", Info := "", *){
    gotText := ""
    if(A_GuiEvent == "DoubleClick"){
        gotText := lv.GetText(A_EventInfo, 3)
    }
    else{
        rowFocus := lv.GetNext(0, "F")
        if (rowFocus){
            gotText := lv.GetText(rowFocus, 3)
        }
    }
    if (gotText != ""){
        SendSnippet(gotText)
    }
}

GetLvRow(LVhwnd) {
   ; https://www.autohotkey.com/board/topic/80265-solved-which-column-is-clicked-in-listview/
   LVhwnd := (LVhwnd.HasProp("hwnd")) ? LVhwnd.hwnd : LVhwnd
   Static LVM_SUBITEMHITTEST := 0x1039
   POINT := Buffer(8, 0)
   ; Get the current cursor position in screen coordinates
   DllCall("User32.dll\GetCursorPos", "Ptr", POINT)
   ; Convert them to client coordinates related to the ListView
   DllCall("User32.dll\ScreenToClient", "Ptr", LVhwnd, "Ptr", POINT)
   ; Create a LVHITTESTINFO structure (see below)
   LVHITTESTINFO := Buffer(24, 0)
   ; Store the relative mouse coordinates
   NumPut("Int", NumGet(POINT, 0, "Int"), LVHITTESTINFO, 0)
   NumPut("Int", NumGet(POINT, 4, "Int"), LVHITTESTINFO, 4)
   ; Send a LVM_SUBITEMHITTEST to the ListView
   SendMessage(LVM_SUBITEMHITTEST, 0, LVHITTESTINFO, , "ahk_id " LVhwnd)
   ; Get the corresponding subitem (column)
   Subitem := NumGet(LVHITTESTINFO, 12, "Int") + 1
   Return Subitem
}

OnLvSelect(A_GuiEvent := "", GuiCtrlObj := "", Info := "", *){
    global smArray
    static prer := 0
    rowId := ""
    dbp   := GetConfig("database", "Locations")
    sdo   := GetConfig("snipsdir", "Locations")
    rowFocus := lv.GetNext(0, "F")
    if (rowFocus){
        rowId := lv.GetText(rowFocus, 3)
    }
    if(rowId != "") && (prer != rowId){
        Loop smArray.Length
        if (sdo = "true"){
            for sid, sname in smArray[A_Index] {
                SplitPath sname, &name, &dir, &ext, &base, &drv
                fpos := InStr(dir, "\", , -1)
                fpos += 1
                cat  := SubStr(dir, fpos)
                if (rowId = sid) && (rowId != prer ){
                    val := FileRead(sname)
                    langico := GetLangIcon(cat, cat)
                    if (langico != false){
                        CreateTip(val, base, langico)
                    }
                    else {
                        CreateTip(val, base)
                    }
                }
            }
        }
        else {
            for sid, smap in smArray[A_Index] {
                for name, nsmap in smap {
                    for nmap1, nmap2 in nsmap {
                        for dir, syn in nmap1 { 
                            for val, info in nmap2 {
                                if (rowId = sid){
                                    langico := GetLangIcon(syn, dir)
                                    if (langico != false){
                                        CreateTip(val, name, langico)
                                    }
                                    else {
                                        CreateTip(val, name)
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    prer := rowId
}

OnTvSelect(A_GuiEvent := "", GuiCtrlObj := "", Info := "", *){
    global smArray
    sdo := GetConfig("snipsdir", "Locations")
    gotText := ""
    snipid := tv.GetSelection()
    hiroot := tv.GetParent(snipid)
    if (hiroot = 0){
        return
    }
    loop smArray.length {
        if(sdo = "false"){
            for sid, smap in smArray[A_Index] {
                for name, nsmap in smap {
                    for nmap1, nmap2 in nsmap {
                        for dir, syn in nmap1 { 
                            for val, info in nmap2 {
                                if (snipid = sid) {
                                    langico := GetLangIcon(syn, dir)
                                    if (langico != false){
                                        CreateTip(val, name, langico)
                                    }
                                    else {
                                        CreateTip(val, name)
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        else {
            for sid, sname in smArray[A_Index] {
                SplitPath sname, &name, &dir, &ext, &base, &drv
                fpos := InStr(dir, "\", , -1)
                fpos += 1
                cat  := SubStr(dir, fpos)
                if (snipId = sid){
                    val := FileRead(sname)
                    langico := GetLangIcon(cat, cat)
                    if (langico != false){
                        CreateTip(val, base, langico)
                    }
                    else {
                        CreateTip(val, base)
                    }
                }
            }
        }
    }
}

SendSnippet(snipid){
    global lastHwnd
    global snipmode
    global smArray
    dbp := GetConfig("database", "Locations")
    sdo := GetConfig("snipsdir", "Locations")
    ;Hide the GUI
    DestroyTip()
    mg.hide()
    ControlSetText("`"`"", ed)
    ed.Value := ""
    lv.Visible := false
    tv.Visible := true
    ;Reset the tree
    tv.Opt("-Redraw")
    ItemID := "0"  
    loop {
        ItemID := tv.GetNext(ItemID, "Full") 
        if not ItemID {
            break
        }
        tv.Modify(ItemID, "-Expand")
    }
    tv.Opt("+Redraw")
    loop smArray.length {
        if (sdo = "true"){
            for sid, sname in smArray[A_Index] {
                SplitPath sname, &name, &dir, &ext, &base, &drv
                fpos := InStr(dir, "\", , -1)
                fpos += 1
                cat  := SubStr(dir, fpos)
                if (snipid = sid){
                    snip := FileRead(sname)
                }
            }
        }
        else{
            for sid, smap in smArray[A_Index] {
                for name, nsmap in smap {
                    for nmap1, nmap2 in nsmap {
                        for dir, syn in nmap1 { 
                            for val, info in nmap2 {
                                if (snipid = sid){
                                    snip := val
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    ClipSaved := ClipboardAll()
    FoundPos := RegExMatch(snip, "\n<<\-(\d*)\Z", &ReversePos)
    if (FoundPos > 0){
        snipLen := StrLen(snip)
        jstsnip := snipLen - ReversePos.Len
        snip := SubStr(snip, 1, jstsnip)
    }
    A_Clipboard := snip
    Errorlevel := !ClipWait()
    if (snipmode != 1){
        WinActivate("ahk_id " lastHwnd)
        Sleep(300)
        if WinActive("ahk_class ConsoleWindowClass"){
            Send("!{Space}ep")
            Sleep(50)
        }
        else {
            Send("{Control down}")
            Sleep(50)
            Send("v")
            Sleep(50)
            Send("{Control up}")
        }
        if (ReversePos){
            SendInput("{Left " . ReversePos[1] . "}") 
        }
        A_Clipboard := ClipSaved    
    }
    else {
        message := "snipman did not register a paste target. The selected snippet is now loaded as the active clipboard item."
        TrayTip message, "snipman", 4
    }
}

Exit(A_ThisMenuItem := "", A_ThisMenuItemPos := "", MyMenu := "", *){
    DestroyTip()
    ExitApp()
}

EnumSnippets(smn?){  
    global smArray, tv
    smArray  := []
    dirArray := []
    smdirMap := Map()
    dbPath   := GetConfig("database", "Locations")
    sdo      := GetConfig("snipsdir", "Locations")
    if(sdo = "true"){
        snipdir := A_ScriptDir . "\snips"
        AddFolderToTree(snipdir)
    }
    else {
        if (!FileExist(dbPath)){
            dbPath := chooseDB()
        }
        else {
            snipMap := parseMassCode(dbPath)
            for snippetname in snipMap {
                for nmap1, nmap2 in snipMap[snippetname] {
                    for dir, syn in nmap1 { 
                        for val, info in nmap2 {
                            smdirMap[dir] := val
                        }
                    }
                }
            }
            for dir, val in smdirMap {
                if !smdirMap.Has(val) {
                    dirArray.Push(dir)
                }
            }
            loop dirArray.Length {
                currentDir := dirArray[A_Index]
                rootId := tv.Add(currentDir,0)
                for name in snipMap {
                    for nmap1, nmap2 in snipMap[name] {
                        for dir, syn in nmap1 {
                            for val, info in  nmap2 {
                                if(currentDir = dir){
                                    snipID := tv.Add(name, rootId)
                                    smArray.Push(Map(snipID, Map(name, snipMap[name])))
                                }
                            }
                        }
                    }
                }  
            }
        }
    }
    if (IsSet(smn)){
        %smn% := smArray.Length
    }  
}

AddFolderToTree(dir, dirid := 0){
    global smArray
    fp:= dir . "\*.*"
    Loop Files fp, "D" {
        tid := tv.add(A_LoopFileName, dirid)
        AddFolderToTree(A_LoopFileFullPath, tid)   
    }
    Loop Files fp {
        SplitPath A_LoopFileFullPath, &name, &dir, &ext, &base, &drv
        tid := tv.add(base, dirid)
        smArray.Push(Map(tid, A_LoopFileFullPath))
    }
}

GetConfig(key,sect){
    iniPath := A_ScriptDir . "\snipman.ini"
    if FileExist(iniPath) {
        try {
            iniValue := IniRead(iniPath, sect, key)
        }
        catch as e {
            if (FileExist(iniPath)){
                try {
                    FileDelete(iniPath)
                }
                catch as e {
                    try {
                        FileSetAttrib("-R", iniPath)
                    }
                    finally {
                        FileDelete(iniPath)
                    }
                }
                finally {
                    createIni(iniPath)
                }
            }
            else {
                createIni(iniPath)
            }
        }
        finally{
            iniValue := IniRead(iniPath, sect, key)
        }
        return iniValue
    }    
    else {
        createIni(iniPath)
        iniValue := getConfig(key, sect)
        return iniValue
    }
}

SetTrayIcon(){
    try {
        iniTheme := getConfig("apptheme", "Appearance")
        isDarkOn := IsDarkMode("sys")
        if ((iniTheme = "auto") && (isDarkOn)) {
            (A_IsCompiled) ? TraySetIcon(A_ScriptFullPath, GetAppIcon("smdark")) : TraySetIcon(GetAppIcon("smdark"))
        }
        else if ((iniTheme = "auto") && (!isDarkOn)){
            (A_IsCompiled) ? TraySetIcon(A_ScriptFullPath, GetAppIcon("smlite")) : TraySetIcon(GetAppIcon("smlite"))
        }
        else if (iniTheme = "dark") {
            (A_IsCompiled) ? TraySetIcon(A_ScriptFullPath, GetAppIcon("smdark")) : TraySetIcon(GetAppIcon("smdark"))
        }
        else {
            (A_IsCompiled) ? TraySetIcon(A_ScriptFullPath, GetAppIcon("smlite")) : TraySetIcon(GetAppIcon("smlite"))
        }
    }
    catch as e {
        MsgBox("Error: " e.message, e.what)
    }
    finally {
        A_IconHidden := false
    }
}

chooseDB(A_ThisMenuItem := "", A_ThisMenuItemPos := "", MyMenu := "", *){
    ;Todo: Determine what message to show user (no snippets to load! open snipman with previous snippets?, etc.)
    apptheme := GetAppTheme()
    icopath := (apptheme = "dark") ? GetAppIcon("smdark") : GetAppIcon("smlite")
    iniPath := A_ScriptDir . "\snipman.ini"
    SelectedFile := FileSelect(3, , "Select a massCode snippet database to load into snipman", "JSON (*.json)")
    if (SelectedFile = ""){
       TrayTip "No file selected. Snipman will now exit", "snipman", 4
       ExitApp    
    }
    else {
        IniWrite(SelectedFile, iniPath, "Locations", "database")
        TrayTip "Snippet database loaded.",  "snipman", 4
    }
    RefreshSnipman()
}

SaveLastHwnd(){
    global lastHwnd
         , snipmode
         , exe
    snipmode := 1 ;Copy Mode
    try {
        hwnd := WinActive("A")
        proc := WinGetProcessName(hwnd)
        if (hwnd) && (proc != exe){
            lastHwnd := hwnd
            snipmode := 0
            return lasthwnd
        }
    }
    catch as e {
        snipmode := 1
        TrayTip e.message "`nCompatible app not in focus`nEntering COPY mode", "snipman: " e.what, 4
    }    
}

DragWindow(GuiCtrlObj, wParam, lParam, msg){
    static WM_NCLBUTTONDOWN := 0x00A1
    PostMessage(WM_NCLBUTTONDOWN, 2,,, GuiCtrlObj is Gui.Control ? GuiCtrlObj.Gui : GuiCtrlObj)
    return 0
}

SetCursor(GuiCtrlObj, wParam, lParam, Msg){
    static hCursor := DllCall("LoadCursor", "ptr", 0, "ptr", 32512)
    DllCall("SetCursor", "ptr", hCursor, "ptr")
    return 0
}

; scope = [ "sys" || "app" ]
isDarkMode(scope := "sys") { 
    regPath := "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize"
    if (scope = "sys"){
        try {
            ; Check Windows registry for system theme setting
            regTheme := RegRead(regPath, "SystemUsesLightTheme")
            if (regTheme = 0) {
                return true
            }
            else {
                return false    
            }
        }
        catch {
            ; If key does not exist, default to alternate key
            regTheme := RegRead(regPath, "AppsUseLightTheme")
            if (regTheme = 0){
                return true
            }
            else {
                return false
            } 
        }
    }
    else if (scope = "app"){
        try {
            regTheme := RegRead(regPath, "AppsUseLightTheme")
            if (regTheme = 0){
                return true
            }
            else {
                return false
            } 
        }
        catch {
            ; Check Windows registry for system theme setting
            regTheme := RegRead(regPath, "SystemUsesLightTheme")
            if (regTheme = 0) {
                return true
            }
            else {
                return false    
            }
        }
    }
    else {
        return false
    }
}

GetAppTheme(){
    iniTheme := getConfig("apptheme", "Appearance")
    isDarkOn := isDarkMode("app")
    if ((iniTheme = "auto") && (isDarkOn)){
        return "dark"
    }
    else if ((iniTheme = "auto") && (!isDarkOn)){
        return "light"
    }
    else {
        return iniTheme
    }
}

GetExeName(){
    global exe
    if (A_IsCompiled){
        exe := A_ScriptName
    }
    else {
        exePath := A_AhkPath
        SplitPath exePath, &name
        exe := name
    }
    return exe
}

GetLangIcon(syntax, folder){
    global svgmap
    tipicon  := ""
    if (svgmap.Has(folder)){
        tipicon := svgmap[folder]
    }
    else if (svgmap.Has(syntax)) && (syntax != "autohotkey") && (syntax != "sh"){
        tipicon := svgmap[syntax]
    }
    else if (syntax = "c_cpp"){
        tipicon := (folder = "c") ? svgmap["c"] : svgmap["cpp"]
    }
    else if (syntax = "asp_vb_net"){
        tipicon := (folder = "vb.net") ? svgmap["vb_net"] : svgmap[folder]
    }
    else if (syntax = "pascal"){
        tipicon := (folder = "delphi") ? svgmap["delphi"] : svgmap["freepascal"]
    }
    else if (syntax = "autohotkey"){
        tipicon := (folder = "autohotkey") ? svgmap["autohotkey"] : svgmap["autoit"]
    }
    else if (syntax = "sh"){
        tipicon := svgmap["sh"]
    }
    else if (syntax = "f3"){
        tipicon := svgmap["php"]
    }
    else if (syntax = "js"){
        tipicon := svgmap["javascript"]
    }
    else if ((syntax = "ahk") || (folder = "ahk")){
        tipicon := svgmap["autohotkey"]
    }
    else if ((syntax = "au3") || (folder = "au3")){
        tipicon := svgmap["autoit"]
    }
    else if ((syntax = "txt") || (folder = "txt") || (syntax = "text") || (folder = "text")){
        tipicon := svgmap["plain_text"]
    }
    else {
        if (svgmap.Has(syntax)){
            tipicon := svgmap[syntax]
        }
        else {
            tipicon := false
        }
    }
    return tipicon  
}

GetAppIcon(object){
    switch{
        case InStr(object, "smdark"): 
            icopath := (A_IsCompiled) ? -206 : icodir . "smdark.ico"
            return icopath
        case InStr(object, "smlite"): 
            icopath := (A_IsCompiled) ? -160 : icodir . "smlite.ico"
            return icopath
        case InStr(object, "altdark"):
            icopath := (A_IsCompiled) ? -207 : icodir . "smdark_alt.ico"
            return icopath
        case InStr(object, "altlite"):
            icopath := (A_IsCompiled) ? -208 : icodir . "smlite_alt.ico"
            return icopath
    }
}

ShowMsgBox(txt, title:="snipman", params*){
    apptheme := GetAppTheme()
    darkmode := IsDarkMode("app")
    if ((apptheme = "auto") && (!darkmode)){
        return MsgBox(txt, title, params[1])
    }
    else if ((apptheme = "auto") && (darkmode)){
        return DMsgBox.Call(txt, title, params*)
    }
    else if (apptheme := "dark"){
        return DMsgBox.Call(txt, title, params*)
    }
    else if (apptheme := "light"){
        return MsgBox(txt, title, params[1])
    }
    else {
        return DMsgBox.Call(txt, title, params*)
    }
}

CreateTip(tipTxt, tipTitle := "snipman", ico?){
    static isinit := false
    static hicon := ""
    apptheme  := GetAppTheme()
    charlimit := GetConfig("tiplimit", "Appearance")
    fontSize  := "s8"
    fontFam   := "Consolas"
    fontcol   := (apptheme = "dark") ? "White" : "Black"
    backcol   := (apptheme = "dark") ? "191919" : "White"
    if (isinit = false){
        ToolTipOptions.Init()        
        isinit := true
    }
    if (hicon != ""){
        DestroyTip(hicon)
    }
    else {
        DestroyTip()
    }
    if IsSet(ico) {
        hicon := LoadPicture("HBITMAP:" svgToHBITMAP(ico), "Icon1", &imgtype)
    }
    else {
        dicon := (apptheme = "dark") ? GetAppIcon("smdark") : GetAppIcon("smlite")
        hicon := LoadPicture(dicon, "Icon1", &imgtype)
    }
    ToolTipOptions.SetTitle(tipTitle , hicon)
    ToolTipOptions.SetFont(fontSize, fontFam)
    ToolTipOptions.SetMargins(12, 12, 12, 12)
    ToolTipOptions.SetColors(backcol, fontcol)
    trunc := SubStr(tipTxt, 1, charlimit)
    return ToolTip(trunc, , , 1)
}

DestroyTip(handle?){
    static imgtype := ""
    if IsSet(handle){
        if (not imgtype){  ; IMAGE_BITMAP (0) or the imgtype parameter was omitted.
            DllCall("DeleteObject", "ptr", handle)
        }
        else if (imgtype = 1){  ; IMAGE_ICON
            DllCall("DestroyIcon", "ptr", handle)
        }
            
        else if (imgtype = 2){  ; IMAGE_CURSOR
            DllCall("DestroyCursor", "ptr", handle)
        }
    }
    ToolTip()
    EmptyMem()
    ToolTipOptions.SetFont()
    ToolTipOptions.Reset()
    ToolTipOptions.Init()
    return
}

EmptyMem(){
    processid := ProcessExist()
    ;scriptpid := ProcessExist()
    ;processid := (processid = scriptpid) ? DllCall("GetCurrentProcessId") : processid
    h := DllCall("OpenProcess", "UInt", 0x001F0FFF, "Int", 0, "Int", processid)
    DllCall("SetProcessWorkingSetSize", "UInt", h, "Int", -1, "Int", -1)
    DllCall("CloseHandle", "Int", h)
}

AboutSnipman(A_ThisMenuItem := "", A_ThisMenuItemPos := "", MyMenu := "", *){
    SettingsGui(7)
}

GetHelp(A_ThisMenuItem := "", A_ThisMenuItemPos := "", MyMenu := "", *){
    SettingsGui(6)
}

BuildSvgMap(){
    global svgmap           := Map()
    uselocal                := GetConfig("uselocal", "Locations")
    iconhome                := GetConfig("iconhome", "Locations")
    svgmap["smaboutd"]      := iconhome . "\smaboutd.svg"
    svgmap["smaboutl"]      := iconhome . "\smaboutl.svg"
    svgmap["applescript"]   := iconhome . "\applescript.svg"
    svgmap["assembly_x86"]  := iconhome . "\assembly_x86.svg"
    svgmap["autohotkey"]    := iconhome . "\autohotkey.svg"
    svgmap["autoit"]        := iconhome . "\autoit.svg"
    svgmap["batchfile"]     := iconhome . "\batchfile.svg"
    svgmap["c"]             := iconhome . "\c.svg"
    svgmap["cpp"]           := iconhome . "\cpp.svg"
    svgmap["csharp"]        := iconhome . "\csharp.svg"
    svgmap["css"]           := iconhome . "\css.svg"
    svgmap["d"]             := iconhome . "\d.svg"
    svgmap["delphi"]        := iconhome . "\delphi.svg"
    svgmap["diff"]          := iconhome . "\diff.svg"
    svgmap["dockerfile"]    := iconhome . "\dockerfile.svg"
    svgmap["freepascal"]    := iconhome . "\freepascal.svg"
    svgmap["git"]           := iconhome . "\git.svg"
    svgmap["golang"]        := iconhome . "\golang.svg"
    svgmap["haskell"]       := iconhome . "\haskell.svg"
    svgmap["html"]          := iconhome . "\html.svg"
    svgmap["ini"]           := iconhome . "\ini.svg"
    svgmap["java"]          := iconhome . "\java.svg"
    svgmap["javascript"]    := iconhome . "\javascript.svg"
    svgmap["json"]          := iconhome . "\json.svg"
    svgmap["lua"]           := iconhome . "\lua.svg"
    svgmap["makefile"]      := iconhome . "\makefile.svg"
    svgmap["markdown"]      := iconhome . "\markdown.svg"
    svgmap["nim"]           := iconhome . "\nim.svg"
    svgmap["objectivec"]    := iconhome . "\objectivec.svg"
    svgmap["objectivecpp"]  := iconhome . "\objectivecpp.svg"
    svgmap["perl"]          := iconhome . "\perl.svg"
    svgmap["php"]           := iconhome . "\php.svg"
    svgmap["plain_text"]    := iconhome . "\plain_text.svg"
    svgmap["powershell"]    := iconhome . "\powershell.svg"
    svgmap["python"]        := iconhome . "\python.svg"
    svgmap["ruby"]          := iconhome . "\ruby.svg"
    svgmap["rust"]          := iconhome . "\rust.svg"
    svgmap["shell"]         := iconhome . "\shell.svg"
    svgmap["swift"]         := iconhome . "\swift.svg"
    svgmap["symbols"]       := iconhome . "\symbols.svg"
    svgmap["toml"]          := iconhome . "\toml.svg"
    svgmap["typescript"]    := iconhome . "\typescript.svg"
    svgmap["vb_net"]        := iconhome . "\vb_net.svg"
    svgmap["vba"]           := iconhome . "\vba.svg"
    svgmap["vbscript"]      := iconhome . "\vbscript.svg"
    svgmap["webassembly"]   := iconhome . "\webassembly.svg"
    svgmap["xml"]           := iconhome . "\xml.svg"
    svgmap["yaml"]          := iconhome . "\yaml.svg"
    svgmap["zig"]           := iconhome . "\zig.svg"
    if(!A_IsCompiled){
        return svgmap
    }
    else {
        if (uselocal = "true"){
            return svgmap
        }
        else {
            for key, val in svgmap {
                svgmap[key] := key . ".svg"
            }
            return svgmap
        }         
    }
}

ExtractSvg(name?){
    global svgmap
    if(!A_IsCompiled){
        return
    }
    else {
       if(IsSet(name)){
            resname := name . ".svg"
            svgpath := svgmap[name]
            svgtext := TextFromResource(resname)
            if(FileExist(svgpath)){
                FileDelete svgpath
            }
            FileAppend svgtext, svgpath
        }
        else {
            for key, val in svgmap {
                if (!FileExist(val)){
                    ExtractSvg(key)
                }
            }        
        }    
    }
}

SetStartUp(state?){
    sec := "General"
    key := "autorun"
    cfg := GetConfig(key, sec)
    tgt := (A_IsCompiled) ? A_WorkingDir . "\" . APPNAME . ".exe" : A_WorkingDir . "\" . APPNAME . ".ahk"
    lnk := A_Startup . "\" . APPNAME . ".lnk"
    inf := APPNAME . " snippet manager"
    ini := A_ScriptDir . "\" APPNAME . ".ini"
    if (cfg = "true") {
        if(!FileExist(lnk)){
            FileCreateShortcut(tgt, lnk, A_WorkingDir, , inf , , , )
            IniWrite("true", ini, sec, key)
            TrayTip "" APPNAME " will now start with Windows.", APPNAME, 4
            Reload()        
        }
    }
    else {
        if(FileExist(lnk)){
            FileDelete(lnk)
        }
    }
}
