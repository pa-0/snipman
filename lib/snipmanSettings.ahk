Gui.Prototype.DefineProp("AddDarkCheckBox", {Call: AddDarkCheckBox})
global conf
    ,  sfile
    ,  sg
    ,  tb
    ,  TabText
; Default Settings =================================================================
; Build 2D-array object to define the default values
; Put here the default settings

sfile := A_ScriptDir . "\snipman.ini"
defaultDbPath := A_MyDocuments . "\massCode\db.json"
defaultSvgDir := A_ScriptDir . "\icons"

conf_Default := []  
conf_Default.General := { 
      autorun: "false" }
conf_Default.Interface := { 
      shortcut: "+``" 
    , winkeyon: "false "}
conf_Default.Appearance := { 
      apptheme: "auto"
    , tiplimit: 500  
    , tiptimer: 30 }
conf_Default.Locations := { 
      database: defaultDbPath
    , snipsdir: "true"
    , iconhome: defaultSvgDir 
    , uselocal: "false" }

;Load the existing settings
conf := FileExist(sfile) ? ReadIni(sfile, conf_Default) : conf_Default
;SettingsGui()
SettingsGui(at?){
    global sg, tb, TabText
    static sgmade := false
    static sgvisi := false
    ui := { Name: "snipman v" . APPVERSION . " Settings", Version: APPVERSION }
    gat := GetAppTheme()
    cmode := (gat = "dark") ? "dark" : "light"
    OnMessage(0x200, WM_MOUSEMOVE) ; Calling Function when moving the mouse inside the gui    
    ; Define parameters of Gui
    wnd := {Width: 600, Height: 400, Title: ui.Name}
    MenuWidth := 100
    nav := {Label: ["General", "Interface", "Appearance", "Locations", "---", "Help", "About"]}
    if (sgmade = true){
        sg.Show(" w" wnd.Width " h" wnd.Height)
    }
    else {
        sg := Gui()
        sg.iniFile := sfile
        sg.OnEvent("Close", Gui_Escape)
        sg.OnEvent("Escape", Gui_Escape)
        sg.OnEvent("Size", Gui_Size)
        sg.Opt("+AlwaysOnTop +LastFound -Resize MinSize400x300")
        sg.BackColor := (cmode = "dark") ? "202020" : "FFFFFF"
        sg.txtcol := (cmode = "dark") ? "FFFFFF" : "000000"
        sg.ddlcol := (cmode = "dark") ? Map("T", 0xFFFFFF, "B", 0x383838) : Map("T", 0x000000, "B", 0xFFFFFF)
        tb := sg.Add("Tab2", "x-999 y-999 w0 h0 -Wrap +Theme vTabControl")
        sg.Tabs := tb

        tb.UseTab() ; Exclude future controls from any tab control

        sg.TabPicSelect := sg.AddText("x0 y0 w4 h32 vpMenuSelect Background0x0078D7")
        sg.TabPicHover := sg.AddText("x0 y0 w4 h32 vpMenuHover Background0xCCE8FF Hidden")
        
        sg.TabTitle := sg.Add("Text", "x" MenuWidth+10 " y" 0 " w" (wnd.Width-MenuWidth)-10 " h" 30 " +0x200 vPageTitle", "")
        sg.TabTitle.SetFont("s14 c" sg.txtcol "", "Segoe UI") ; Set Font Options
        TabText := Map()
        loop nav.Label.Length {
            tb.Add([nav.Label[A_Index]])
            if (nav.Label[A_Index] = "---") {
                continue
            }
            nb := sg.Add("Button", "default x220 y366 w80 h24", "Next").OnEvent("Click", NextTab)
            key := A_Index
            dim := MenuWidth . " +0x200 BackgroundTrans vMenuItem"
            tc := sg.Add("Text", "x0 y" (32*A_Index)-32 " h32 w" dim . A_Index, "     " nav.Label[A_Index])
            TabText[key] := tc
            ;MsgBox "TabText[" . key . "] = " TabText[key].Text
            TabText[key].SetFont("s9 c808080", "Segoe UI") ; Set Font Options
            TabText[key].OnEvent("Click", Gui_Menu)
            TabText[key].Index := A_Index
            if (A_Index = 1) {
                TabText[key].SetFont("c" sg.txtcol)
                sg.ActiveTab := TabText[key]
                sg.TabTitle.Value := trim(TabText[key].Text)
            }
        }

        div := sg.AddText("x" MenuWidth+10 " y32 w" wnd.Width-MenuWidth-10*2 " h1 Section BackgroundD8D8D8")
        div.LeftMargin := 10
        
        ; Start defining controls by Tab:

        tb.UseTab(1) ; GENERAL ;Future controls are owned by the specified tab
        if (cmode = "dark"){
            autorun := sg.AddDarkCheckBox("xp+100 yp+40 c" sg.txtcol " -Wrap vautorun", "")
            sg.Add("Text", "c" sg.txtcol " xs ys+40", "Run at Login:")
        }
        else {
            autorun := sg.Add("Checkbox", "yp+40 Right vautorun", "Run at Login:           ")
        }
        ;autorun.OnEvent("Click", OnAutoRun)
        autorun.Tooltip := "Run snipman automatically when Windows starts"

        tb.UseTab(2) ; INTERFACE ;Future controls are owned by the specified tab
        sg.Add("Text", "c" sg.txtcol " xs yp" ,"Activation Hotkey: ")
        lmtnum := "Limit1"
        shortcut := sg.AddHotkey("vshortcut xp+100 " lmtnum, "+``")
        shortcut.Tooltip := "Register a global hotkey for snipman.`n`nTIP: Enable the Windows Key first to use it (e.g.'⊞ + `')"
        if (cmode = "dark"){
            winkeyon := sg.AddDarkCheckBox("xs+85 yp+30 c" sg.txtcol " -Wrap Right vwinkeyon", "")
            sg.Add("Text", "c" sg.txtcol " xp+30 w120", "Use Windows Key (⊞)")
        }
        else {
            winkeyon := sg.Add("Checkbox", "yp+30 w120 vwinkeyon", "Use Windows Key (⊞)")
        }
        winkeyon.OnEvent("Click", OnWinKeyOn)
        winkeyon.ToolTip := "Activate to use Windows key (⊞) as part of hotkey combination."
        
        tb.UseTab(3) ; APPEARANCE ;Future controls are owned by the specified tab
        sg.Add("Text", "c" sg.txtcol " xs ys+40", "Application Theme: ")
        apptheme := sg.Add("DropDownList", "xp+120 w100 +0x210 vapptheme", ["Auto", "Dark", "Light"])
        apptheme.ToolTip := "Auto:`tsnipman theme will follow system settings`nDark:`tdark mode`nLight:`tlight mode"
        OD_Colors.Attach(apptheme, sg.ddlcol)
        OD_Colors.SetItemHeight("s9", "Segoe UI")
        sectitle := sg.Add("Text", "xs yp+35 r2 w140 +0x200 vsectitle", "Snippet Preview")
        sectitle.SetFont("s10 c" sg.txtcol "", "Segoe UI")
        sg.Add("Text", "c" sg.txtcol " xs yp+40", "Character Limit:`n(0 = No Limit)")
        bd1 := sg.Add("Edit", "w35 vbd1", "")
        bd1.ToolTip := "Number of characters to include in displayed snippet previews"
        bd1.OnEvent("Change", OnBd1Change)
        tiplimit := sg.Add("Slider", "xp+115 ys+120 vtiplimit Range0-1000 AltSubmit Tooltip TickInterval50 Buddy2" bd1.hwnd, "")
        tiplimit.ToolTip := "Number of characters to include in displayed snippet previews"
        tiplimit.OnEvent("Change", OnCharSlide)
        sg.Add("Text", "c" sg.txtcol " xs yp+45", "Time Limit:`n(in seconds)")
        bd2 := sg.Add("Edit", "w35 vbd2", "")
        bd2.ToolTip := "Number of seconds snippet previews will be displayed"
        bd2.OnEvent("Change", OnBd2Change)
        tiptimer := sg.Add("Slider", "xp+115 ys+170 vtiptimer Range0-300 AltSubmit Tooltip TickInterval15 Buddy2" bd2.hwnd, "")
        tiptimer.ToolTip := "Number of seconds snippet previews will be displayed"
        tiptimer.OnEvent("Change", OnTimeSlide)

        tb.UseTab(4) ; LOCATIONS ;Future controls are owned by the specified tab
        sg.Add("Text","c" sg.txtcol " xs ys+40","Database Path: ")
        dbed := sg.Add("Edit", "xp+100 yp-1 w250 vdatabase")
        dbed.Tooltip := "Path to snippets database ('db.json')"
        ;dbed.OnEvent("Change", OnDbEdChange)
        dbtn := sg.Add("Button", "yp", "Browse")
        dbtn.ToolTip := "Click to select snippets database file ('db.json') that snipman should load"
        dbtn.OnEvent("Click", BrowseForDb)
        if (cmode = "dark"){
            snipsdir := sg.AddDarkCheckBox("xs+85 yp+30 cWhite -Wrap Right vsnipsdir ", "")
            sg.Add("Text", "c" sg.txtcol " xs+120 ys+70", "Read snippets from 'snips' folder")
        }
        else {
            snipsdir := sg.Add("Checkbox", "xs+100 yp+30 vsnipsdir", "Read snippets from 'snips' folder")
        }
        snipsdir.ToolTip := "Activating this will override the database path and load snippets from 'snips' folder."
        idirtxt := sg.Add("Text","c" sg.txtcol " xs yp+40","Icon Folder: ")
        idirtxt.ToolTip := "This is the folder where snipman will store and search for icons used in snippet previews"
        svged := sg.Add("Edit", "xp+100 yp w250 viconhome")
        svged.ToolTip := "This is the folder where snipman will store and search for icons used in snippet previews"
        svgbtn := sg.Add("Button", "yp", "Browse")
        svgbtn.ToolTip := "This is the folder where snipman will store and search for icons used in snippet previews"
        svgbtn.OnEvent("Click", BrowseIDir)
        if (cmode = "dark"){
            uselocal := sg.AddDarkCheckBox("xs+85 yp+30 cWhite -Wrap Right vuselocal ", "")
            sg.Add("Text", "c" sg.txtcol " xs+120 ys+141", "Use custom icons")
        }
        else {
            uselocal := sg.Add("Checkbox", "xs+100 yp+30 vuselocal", "Use custom icons")
        }
        uselocal.ToolTip := "Enabe to extract syntax icons (in SVG format) to above folder.`nOverwrite with custom icons as desired."

        ;tb.UseTab(5) ; Future controls are owned by the specified tab


        tb.UseTab(6) ; Future controls are owned by the specified tab
        #Include HelpSM.ahk
        
        tb.UseTab(7) ; Future controls are owned by the specified tab
        #Include AboutSM.ahk
        
        tb.UseTab("")

        okb := sg.Add("Button", "x" (wnd.Width - 260) - 10 " y" (wnd.Height - 24) - 10 " w80 h24 vButtonOK", "OK")
        okb.OnEvent("Click", gApply.Bind("Destroy"))
        ;okb.LeftDistance := "10"
        ;okb.BottomDistance := "10"
        cnb := sg.Add("Button", "x" (wnd.Width - 170) - 10 " y" (wnd.Height - 24) - 10 " w80 h24 vButtonCancel", "Cancel")
        cnb.OnEvent("Click", gExit)
        ;cnb.LeftDistance := "100"
        ;cnb.BottomDistance := "10"

        ab := sg.Add("Button", "x" (wnd.Width - 80) - 10 " y" (wnd.Height - 24) - 10 " w80 vButtonApply Disabled", "Apply")
        ab.OnEvent("Click", gApply.Bind(""))

        sg.Title := wnd.Title
        LoadSettings(conf)
        
        if(cmode = "dark"){
            SetDarkControls(sg)
            SetWindowColor(WinExist(sg.hWnd), 0xFFFFFF, 0x202020, 0x202020)
        }
        
        sg.Show(" w" wnd.Width " h" wnd.Height)
        sgmade := true
    }
    if(IsSet(at)){
        ChooseTab(at)
    }

    ; Nested Functions ==============================================================================

    /*ButtonOK(*){
        Saved := sg.Submit(0)
        MsgBox("autorun`t[" Saved.autorun "]`n")
        MsgBox("WinKey`t[" Saved.winkeyon "]")
        ExitApp()
    }
    */
    
    ChooseTab(i){
        fc := (cmode = "dark") ? "FFFFFF" : "000000"
        sg.ActiveTab.SetFont("c808080")
        tb.Choose(i)
        sg.TabTitle.Value := trim(tb.Text)
        sg.ActiveTab := TabText[i]
        sg.ActiveTab.SetFont("c" fc)
        sg.TabPicSelect.Move(0, (32*i) - 32)
    }

    NextTab(guiCtrlObj, *){
        nti := tb.Value < nav.Label.Length ? ++tb.Value : 1
        While nav.Label[nti] = "---" ; needs to be skipped
            nti := nti < nav.Label.Length ? ++nti : 1
        Gui_Menu(guiCtrlObj.Gui["MenuItem" nti], 0)
    }

    Gui_Escape(*){ 
        sg.Destroy()
        sgmade := false
        return
    }

    Gui_Menu(obj, info, *){
        ; Called when clicking the menu
        tg := obj.Gui
        fc := (cmode = "dark") ? "FFFFFF" : "000000"
        tg.ActiveTab.SetFont("c808080")
        tg.Tabs.Choose(trim(obj.text))
        tg.TabTitle.Value := trim(obj.text)
        tg.ActiveTab := obj
        obj.SetFont("c" fc)
        tg.TabPicSelect.Move(0, (32*obj.Index) - 32)
        return
    }

    Gui_Size(tg, MinMax, Width, Height) {
        if MinMax = -1	; The window has been minimized. No action needed.
            return
        DllCall("LockWindowUpdate", "Uint", tg.Hwnd)
        For Hwnd, obj in tg{
            if obj.HasProp("LeftMargin"){
                obj.GetPos(&cX, &cY, &cWidth, &cHeight)
                obj.Move(, , Width-cX-obj.LeftMargin,)
            }
            if obj.HasProp("LeftDistance") {
                obj.GetPos(&cX, &cY, &cWidth, &cHeight)
                obj.Move(Width -cWidth - obj.LeftDistance, , , )
            }
            if obj.HasProp("BottomDistance") {
                obj.GetPos(&cX, &cY, &cWidth, &cHeight)
                obj.Move(, Height - cHeight - obj.BottomDistance, ,  )
            }
            if obj.HasProp("BottomMargin") {
                obj.GetPos(&cX, &cY, &cWidth, &cHeight)
                obj.Move(, , , Height -cY - obj.BottomMargin)
            }  
        }
        DllCall("LockWindowUpdate", "Uint", 0)
    }

    OnWinKeyOn(A_GuiEvent := "", GuiCtrlObj := "", Info := "", *){
        if (winkeyon.Value = 1) {
            shortcut.Opt("-Limit")
            shortcut.Value := ""
        }
        else {
            shortcut.Opt("+Limit1")
            shortcut.Value := ""
        }
    }

    OnCharSlide(A_GuiEvent := "", GuiCtrlObj := "", Info := "", *){
        tlv := tiplimit.Value
        bd1.Value := tlv
    }

    OnTimeSlide(A_GuiEvent := "", GuiCtrlObj := "", Info := "", *){
        ttv := tiptimer.Value
        bd2.Value := ttv
    }

    OnBd1Change(A_GuiEvent := "", GuiCtrlObj := "", Info := "", *){
        bd1v := bd1.Value
        tiplimit.Value := bd1v
    }

     OnBd2Change(A_GuiEvent := "", GuiCtrlObj := "", Info := "", *){
        bd2v := bd2.Value
        tiptimer.Value := bd2v
    }

    WM_MOUSEMOVE(wParam, lParam, Msg, Hwnd) {
        static PrevHwnd := 0
        static HoverControl := 0
        cc := GuiCtrlFromHwnd(Hwnd)
        sghwnd := 0
        ; Setting the highlighting of the hovered menu
        if (sgmade = false){
            return
        }
        if cc {
            tg := cc.Gui
            if tg.HasProp("TabPicHover"){
                If (InStr(cc.Name, "MenuItem") and cc != tg.ActiveTab) {
                    tg.TabPicHover.Visible := true
                    tg.TabPicHover.Move(0, (32 * cc.Index) - 32)
                } else {
                    tg.TabPicHover.Visible := false
                }
            }
        } else {
            tg := GuiFromHwnd(Hwnd)
            if (isObject(tg) and tg.HasProp("TabPicHover")) {
                tg.TabPicHover.Visible := false
            }
        }
        
        ; Setting the tooltips for controls with a property tooltip
        if (Hwnd != PrevHwnd){
            Text := "", ToolTip()   ; Turn off any previous tooltip.
            if cc {
                if !cc.HasProp("ToolTip")
                    return  ; No tooltip for this control.
                SetTimer(CheckHoverControl, 50) ; Checks if hovered control is still the same
                SetTimer(DisplayToolTip, -500)
            }
            PrevHwnd := Hwnd
        }

        CheckHoverControl(){
            If hwnd != prevHwnd {
                SetTimer(DisplayToolTip, 0), SetTimer(CheckHoverControl, 0)
            }
        }
        DisplayToolTip(){
            DestroyTip()
            ToolTip(cc.ToolTip)
            SetTimer(CheckHoverControl, 0)
        }

        return
    }
   ;--------------------------------------------------------------
    LoadSettings(conf1){   ;Loads settings from the object
        ;----------------------------------------------------------    
        ; Set a reference to the Section 
        ;(Keys must be unique!, if not, please add a property .Section to the control, the name will be used as the key)
        sect := Map()
        For Section, SubObject in conf1.OwnProps() {
            For Key, Value in SubObject.OwnProps() {
                sect[StrLower(Key)] := Section
            }
        }
        
        ; Loading the values based on the Object
        For hwnd, gco in sg {

            if (gco.Type="Button") || (gco = bd1) || (gco = bd2){
                continue 
                ;DllCall("uxtheme\SetWindowTheme", "ptr", gco.hwnd, "str", "DarkMode_Explorer", "ptr", 0)
            }
            key := gco.HasOwnProp("key") ? gco.key : gco.Name
            if (gco.Type = "Radio" and key = "" and gco_Prev.Type= "Radio") {
                ; Keys of radio controls will be copied from the previous radio control if no name
                key := gco_Prev.HasOwnProp("key") ? gco_Prev.key : gco_Prev.Name
            }
    
            Section := gco.HasOwnProp("section") ? gco.section : sect.Has(StrLower(key)) ? sect[StrLower(Key)] : ""
    
            if (Section !="" and key != ""){
                if conf1.HasOwnProp(Section) and conf1.%Section%.HasOwnProp(Key){
                    KeyValue := conf1.%Section%.%Key%
                }
    
                ; Add a Section and Key property to the Gui control object
                gco.Section := Section
                gco.Key := key
    
                ; Setting the values of the control
                if (gco.Type ~= "^(?i:ComboBox|DDL|Edit|ListBox)$"){
                    gco.Text := KeyValue
                    gco.OnEvent("Change", gEdit)
                }
                else if (gco.Type ~= "^(?i:DateTime|Hotkey|MonthCal|Slider)$") {
                    gco.Value := KeyValue
                    gco.OnEvent("Change", gEdit)
                    if (gco = tiplimit){
                        bd1.Text := KeyValue 
                    }
                    if (gco = tiptimer){
                        bd2.Text := KeyValue
                    }
                }
                else if (gco.Type = "Checkbox") {
                    gco.Value := KeyValue = "true" ? 1 : 0
                    gco.OnEvent("Click", gEdit)
                }
                else if (gco.Type = "Radio") {
                    gco.Value := KeyValue = gco.Text ? 1 : 0
                    gco.OnEvent("Click", gEdit)
                }
                else{
                    MsgBox("Error`nControl had no settings: `nname: " gco.name "`nType: " gco.type)
                }
            }
            else{
                if (gco.Type ~= "^(?i:Checkbox|ComboBox|DateTime|DDL|Edit|Hotkey|ListBox|MonthCal|Slider)$"){
                    MsgBox("Error`nControl had no settings: `nname: " gco.name "`nType: " gco.type)
                }
            }
            gco_Prev := gco
        }
        return
    }

    ; Saves the Settings to the Ini file.
    gApply(Mode, gco, Info, *){ 

        For hwnd, gco in gco.Gui {

            if (gco.HasOwnProp("Section")){
                KeyValue := gco.Text
                if (gco.Type ~= "^(?i:DateTime|Hotkey|MonthCal|Slider)$") {
                    KeyValue := gco.Value
                }
                if (gco.Type = "Radio"){
                    if gco.Value = 0 {
                        continue
                    }
                }
                if (gco.Type = "Checkbox"){
                    KeyValue := gco.Value = 1 ? "true" : "false"
                }
                if (gco = apptheme){
                    KeyValue := StrLower(gco.Text)
                }
                ; Saves the settings in the ini file and global variable conf
                IniWrite(KeyValue , gco.Gui.iniFile, gco.Section, gco.Key)
                Section := gco.Section
                Key := gco.Key
                if !conf.HasOwnProp(Section) {
                    conf.%Section% := []
                }
                conf.%Section%.%Key% := KeyValue
            }
        }
        ab.Enabled := False
        if (Mode="Destroy"){
            ;gco.Gui.Destroy()
            Reload()
            sgmade := false
        }
    }

    gEdit(gco, Info, *){ ; Detects a change and enables the Apply button
        ab.Enabled := true
        return
    }

    gExit(*){ ; Exit without saving the changes
        sg.Destroy()
        sgmade := false
        ;ExitApp ; Just for testing, Reload may be removed
        return
    }
    
    ;OnDbEdChange(gco, info){
    ;    ab.Enabled := true
    ;    return
    ;}
    
    BrowseForDb(ctrlObj, info){  ; probably can be combined with chooseDb
        dbed.Value := FileSelect(3, , "Select a massCode snippet database to load into snipman", "JSON (*.json)")
        return
    }

    BrowseIDir(ctrlObj, info){
        svghome := DirSelect(A_ScriptDir, 3, "Select a default folder for snipman's icons")
        ;WriteIni(svghome, "Locations", "iconhome")
    }

}

;-------------------------------------------------------------------------------
WriteIni(&Array2D, INI_File) {  ; write 2D-array to INI-file
    ;---------------------------------------------------------------------------
    for SectionName, Entry in Array2D {
        Pairs := ""
        for Key, Value in Entry {
            if (Key = "apptheme"){
                uval := StrLower(Value)
                Pairs .= Key "=" uval "`n"
            }
            else {
                Pairs .= Key "=" Value "`n"
            }
            IniWrite(Pairs, INI_File, SectionName)
        }    
    }
}

;-------------------------------------------------------------------------------
ReadIni(INI_File, oResult := "") {  ; return 2D-array from INI-file
    ;---------------------------------------------------------------------------
    oResult := IsObject(oResult) ? oResult : []
    oResult.Section := []
    SectionNames := IniRead(INI_File)
    for each, Section in StrSplit(SectionNames, "`n") {
        OutputVar_Section := IniRead(INI_File, Section)
        if !oResult.HasOwnProp(Section){
            oResult.%Section% := []
        }
        for each, Haystack in StrSplit(OutputVar_Section, "`n"){
            RegExMatch(Haystack, "(.*?)=(.*)", &match)
            ArrayProperty := match[1]
            oResult.%Section%.%ArrayProperty% := match[2]
        }
    }
    return oResult
}

AddDarkCheckBox(obj, Options, Text){
    static SM_CXMENUCHECK := 71
    static SM_CYMENUCHECK := 72
    static checkBoxW      := SysGet(SM_CXMENUCHECK)
    static checkBoxH      := SysGet(SM_CYMENUCHECK)
    
    chbox := obj.Add("Checkbox", Options " r1.2 +0x4000000", text)

    if !InStr(Options, "right")
        txt := obj.Add("Text", "xp+" (checkBoxW+5) " yp+1 HP-4 +0x4000200", Text)
    else
        txt := obj.Add("Text", "xp+5 yp+1 HP-4 +0x4000200", Text)
    
    chbox.Text := ""
    chbox.DeleteProp("Text")
    chbox.DefineProp("Text", {
        Get: this => txt.Text,
        Set: (this, value) => txt.Text
    })

    ;SetWindowPos(txt.hwnd,0,,,,, 0x43)
    return chbox
}

/*
SetDarkControl(ctrl, style := "DarkMode_Explorer"){
    static IsWin11 := (VerCompare(A_OSVersion, "10.0.22000") > 0)
    hwnd := IsObject(ctrl) ? ctrl.hwnd : ctrl
    DllCall("uxtheme\SetWindowTheme", "ptr", hwnd, "ptr", StrPtr(style), "ptr", 0)
    if IsWin11
        DllCall("Dwmapi\DwmSetWindowAttribute", "Ptr", hwnd, "UInt", 33, "Ptr*", 3, "UInt", 4)
}

SetDarkMode(_obj){
    For v in [135, 136]
        DllCall(DllCall("GetProcAddress", "ptr", DllCall("GetModuleHandle", "str", "uxtheme", "ptr"), "ptr", v, "ptr"), "int", 2)

    if !(attr := VerCompare(A_OSVersion, "10.0.18985") >= 0 ? 20 : VerCompare(A_OSVersion, "10.0.17763") >= 0 ? 19 : 0)
        return false
    
    DllCall("dwmapi\DwmSetWindowAttribute", "ptr", _obj.hwnd, "int", attr, "int*", true, "int", 4)
}


*/