#DllLoad 'Msftedit.dll'

styles  := (ES_SAVESEL := 0x00008000) | (ES_NOHIDESEL := 0x00000100) | (ES_MULTILINE := 0x00000004)
margins := (EC_LEFTMARGIN := 1) | (EC_RIGHTMARGIN := 2)
bgcolor := (cmode = "dark") ? 0x202020 : 0xFFFFFF
sg.rtfcol := (cmode = "dark") ? 0xFFFFFF : 0x000000
linkcolor := (cmode = "dark") ? 0xFF8000 : 0xEE0000
WM_LBUTTONDOWN := 0x0201, EM_SETREADONLY := 0x00CF, EM_SETEVENTMASK := 0x0445, EM_SETMARGINS := 0x00D3
WS_VSCROLL := 0x800, EN_LINK := 0x70B, ENM_LINK := 0x04000000, tomNullCaret := 2
guidir := A_ScriptDir . "\gui"
smad := (A_IsCompiled) ? "smaboutd.svg" : guidir . "\smaboutd.svg"
smal := (A_IsCompiled) ? "smaboutl.svg" : guidir . "\smaboutl.svg"
imagePath := (cmode = "dark") ? smad : smal
hbmap1 := svgToHBITMAP(imagePath)
;sg := Gui(, 'about snipman')
sg.MarginX := sg.MarginY := 15
tc1 := sg.AddText("xs ym+30 h80 w230", "snipman")
pc1 := sg.AddPicture("x+10 ym+25 -E0x200", "HBITMAP:" . hbmap1)
tc1.SetFont("s44 c" sg.txtcol, "Consolas")
re1 := sg.AddCustom('ClassRICHEDIT50W w485 h240 xm+95 ym+95 +VSCROLL ' . styles)
;re1 := sg.AddCustom('ClassRICHEDIT50W x15 y15 w395 h250 ' . styles)


RichEdit_SetPropertyBits(re1.Hwnd)
SendMessage EM_SETEVENTMASK,, ENM_LINK, re1
SendMessage EM_SETMARGINS, margins, 12 | 12 << 16, re1

TextDocument1 := GetDispatch(re1.hwnd)
TextDocument1.CaretType := tomNullCaret

rng := CreateRange1(0, 0,, 5)
rng.Text := '`n'

rng := CreateRange1(rng.End, rng.End, 'Consolas', 20, 0x38D3E2)
rng.Text := 'snippet manager'

rng := CreateRange1(rng.End, rng.End,, 5)
rng.Text := '`n`n'

rng := CreateRange1(rng.End, rng.End, 'Consolas', 9, sg.rtfcol)
rng.Text := 'Search, view, and use text snippets in any application.`n'

rng := CreateRange1(rng.End, rng.End,, 5)
rng.Text := '`n`n'

rng := CreateRange1(rng.End, rng.End, 'Consolas', 10, sg.rtfcol)
rng.Text := 'Instructions`n'

rng := CreateRange1(rng.End, rng.End,, 5)
rng.Text := '`n'

rng := CreateRange1(rng.End, rng.End, 'Consolas', 7, sg.rtfcol)
rng.Text := '•  Activate snipman using a hotkey. Default: SHIFT + BACKTICK (⇧ + ``)`n'

rng := CreateRange1(rng.End, rng.End, 'Consolas', 7, sg.rtfcol)
rng.Text := '•  A custom hotkey can be defined in the Interface tab or in '

rng := CreateRange1(rng.End, rng.End, 'Consolas', 7, linkcolor)
rng.Text := 'snipman.ini'
rng.Url := Format('"{1}"', sfile)

rng := CreateRange1(rng.End, rng.End, 'Consolas', 7, sg.rtfcol)
rng.Text := '`n'

rng := CreateRange1(rng.End, rng.End, 'Consolas', 7, sg.rtfcol)
rng.Text := '•  Search for snippets by name, language, or content`n'

rng := CreateRange1(rng.End, rng.End, 'Consolas', 7, sg.rtfcol)
rng.Text := '•  Use DOWN arrow (↓) to activate the tree or search results box.`n•  Use the arrow keys (↑↓) to navigate`n'

rng := CreateRange1(rng.End, rng.End, 'Consolas', 7, sg.rtfcol)
rng.Text := '•  Press ENTER or double click to copy a snippet to your clipboard`n'

rng := CreateRange1(rng.End, rng.End, 'Consolas', 7, sg.rtfcol)
rng.Text := '•  Escape key will clear search bar, hide snipman and return to last window`n'

rng := CreateRange1(rng.End, rng.End, 'Consolas', 7, sg.rtfcol)
rng.Text := '•  F5 will refresh the list of snippets from database (or disk)`n'

rng := CreateRange1(rng.End, rng.End, 'Consolas', 7, sg.rtfcol)
rng.Text := '•  Use snipman`'s tray icon to access the settings menu or exit the app`n'

rng := CreateRange1(rng.End, rng.End,, 5)
rng.Text := '`n`n'

rng := CreateRange1(rng.End, rng.End, 'Consolas', 10, sg.rtfcol)
rng.Text := 'Options`n'

rng := CreateRange1(rng.End, rng.End,, 5)
rng.Text := '`n'

rng := CreateRange1(rng.End, rng.End, 'Consolas', 7, linkcolor)
rng.Text := 'snipman.ini'
rng.Url := Format('"{1}"', sfile)

rng := CreateRange1(rng.End, rng.End, 'Consolas', 7, sg.rtfcol)
rng.Text := ', in the same folder as the script or executable, sets a few options:`n'

rng := CreateRange1(rng.End, rng.End,, 5)
rng.Text := '`n'

rng := CreateRange1(rng.End, rng.End, 'Consolas', 7, sg.rtfcol)
rng.Text := '  [General]`n  autorun=<true|false>`n`n  [Interface]`n  shortcut=!`` `n  winkeyon=<true|false>`n`n'

rng := CreateRange1(rng.End, rng.End, 'Consolas', 7, sg.rtfcol)
rng.Text := '  [Appearance]`n  apptheme=<auto|dark|light>`n  tiplimit=500 (chars)`n  tiptimer=30 (in seconds)`n`n  [Locations]`n'

rng := CreateRange1(rng.End, rng.End, 'Consolas', 7, sg.rtfcol)
rng.Text := '  database=<path to massCode snippet database>`n  snipsdir=<true|false>`n  iconhome=<path to store custom icons>`n'

rng := CreateRange1(rng.End, rng.End, 'Consolas', 7, sg.rtfcol)
rng.Text := '  uselocal=<true|false>`n'

rng := CreateRange1(rng.End, rng.End,, 5)
rng.Text := '`n'

rng := CreateRange1(rng.End, rng.End, 'Consolas', 7, sg.rtfcol)
rng.Text := 'Review the notes found in '

rng := CreateRange1(rng.End, rng.End, 'Consolas', 7, linkcolor)
rng.Text := 'snipman.ini'
rng.Url := Format('"{1}"', sfile)

rng := CreateRange1(rng.End, rng.End, 'Consolas', 7, sg.rtfcol)
rng.Text := ' for more details on each of these options. (Clicking the link will open the settings INI file.)`n'

rng := CreateRange1(rng.End, rng.End,, 5)
rng.Text := '`n'

rng := CreateRange1(rng.End, rng.End, 'Consolas', 8, sg.rtfcol)
rng.Text := 'Caret Position Control`n'

rng := CreateRange1(rng.End, rng.End,, 5)
rng.Text := '`n'

rng := CreateRange1(rng.End, rng.End, 'Consolas', 7, sg.rtfcol)
rng.Text := 'snipman can position the cursor if the following syntax is included on the last line of a snippet:`n'

rng := CreateRange1(rng.End, rng.End,, 5)
rng.Text := '`n'

rng := CreateRange1(rng.End, rng.End, 'Consolas', 7, sg.rtfcol)
rng.Text := '`t<<-n`n'

rng := CreateRange1(rng.End, rng.End,, 5)
rng.Text := '`n'

rng := CreateRange1(rng.End, rng.End, 'Consolas', 7, sg.rtfcol)
rng.Text := 'Replace n with the number of spaces from the end of the snippet to reverse the cursor. '

rng := CreateRange1(rng.End, rng.End, 'Consolas', 7, sg.rtfcol)
rng.Text := 'If your snippet’s last line contained the following code:`n'

rng := CreateRange1(rng.End, rng.End,, 5)
rng.Text := '`n'

rng := CreateRange1(rng.End, rng.End, 'Consolas', 7, sg.rtfcol)
rng.Text := '`t#Include "<>"`n`t<<-2`n'

rng := CreateRange1(rng.End, rng.End,, 5)
rng.Text := '`n'

rng := CreateRange1(rng.End, rng.End, 'Consolas', 7, sg.rtfcol)
rng.Text := 'then, after the snippet is inserted, the cursor will be positioned between the brackets <|>`n'

rng := CreateRange1(rng.End, rng.End,, 5)
rng.Text := '`n`n'

rng := CreateRange1(rng.End, rng.End, 'Consolas', 10, sg.rtfcol)
rng.Text := 'Get Help`n'

rng := CreateRange1(rng.End, rng.End,, 5)
rng.Text := '`n'

rng := CreateRange1(rng.End, rng.End, 'Consolas', 7, sg.rtfcol)
rng.Text := 'Post a question at snipman`'s '

rng := CreateRange1(rng.End, rng.End, 'Consolas', 7, linkcolor)
rng.Text := 'GitHub Discussions page'
rng.Url := '"https://github.com/pa-0/snipman/discussions/new/choose"'

rng := CreateRange1(rng.End, rng.End, 'Consolas', 7, sg.rtfcol)
rng.Text := '`n`n'

rng := CreateRange1(rng.End, rng.End, 'Consolas', 10, sg.rtfcol)
rng.Text := 'Report a Bug`n'

rng := CreateRange1(rng.End, rng.End,, 5)
rng.Text := '`n'

rng := CreateRange1(rng.End, rng.End, 'Consolas', 7, sg.rtfcol)
rng.Text := 'To report any bugs you find in snipman, '

rng := CreateRange1(rng.End, rng.End, 'Consolas', 7, linkcolor)
rng.Text := 'create an issue here.'
rng.Url := '"https://github.com/pa-0/snipman/issues/new"'

rng := CreateRange1(rng.End, rng.End, 'Consolas', 7, sg.rtfcol)
rng.Text := '`n`n'

rng := CreateRange1(rng.End, rng.End,, 12)
sp := '                 '
Loop 9 * A_ScreenDPI // 100 {
    sp .= A_Space
}
rng.Text := '`n`n`n' . sp


SendMessage EM_SETREADONLY, true,, re1
SendMsg1(0x443, 0, bgcolor) ; EM_SETBKGNDCOLOR

re1.OnNotify(EN_LINK, (e, lParam) => (
    NumGet(lParam, A_PtrSize * 3, 'UInt') = WM_LBUTTONDOWN && (
        start := NumGet(lParam, A_PtrSize * 5 + 4, 'UInt'),
        end   := NumGet(lParam, A_PtrSize * 5 + 8, 'UInt'),
        OnLinkClick(TextDocument1.Range(start, end).Text)
    )
))

CreateRange1(start, end, fontName := 'Verdana', fontSize := 12, fontColor?) {
    rng := TextDocument1.Range(start, end)
    rng.Font.Name := fontName
    rng.Font.Size := fontSize
    IsSet(fontColor) && rng.Font.ForeColor := fontColor
    return rng
}

SendMsg1(Msg, wParam, lParam) => SendMessage(msg, wParam, lParam, re1.Hwnd)
