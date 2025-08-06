#Requires AutoHotkey v2+

Class OD_Colors {
    static OnMessageInit := (OnMessage(0x002C, OD_Colors.MeasureItem))
    static ItemHeight := 0
    static Controls := Map()

    static __New(P*) {
        return false
    }

    static Attach(Ctrl, Colors := "") {
        if (!IsObject(Colors)) {
            return false
        }

        if (Ctrl.Type = "ComboBox") {
            Ctrl.Opt("c" Format("{:X}", Colors["T"]) " Background" Format("{:X}", Colors["B"]))
        }
        
        this.Controls[Ctrl.Hwnd] := Map()
        Content := ControlGetItems(Ctrl.Hwnd)
        this.Controls[Ctrl.Hwnd].Items := Content
        this.Controls[Ctrl.Hwnd].Colors := Map()
        for k, v in Colors {
            if (k = "T") {
                this.Controls[Ctrl.Hwnd].Colors["T"] := ((v & 0xFF) << 16) | (v & 0x00FF00) | ((v >> 16) & 0xFF)
                continue
            }
            if (k = "B") {
                this.Controls[Ctrl.Hwnd].Colors["B"] := ((v & 0xFF) << 16) | (v & 0x00FF00) | ((v >> 16) & 0xFF)
                continue
            }
            if ((Item := Round(k)) = k) {
                if ((C := v.T) != "") {
                    this.Controls[Ctrl.Hwnd].Colors[Item]["T"] := ((C & 0xFF) << 16) | (C & 0x00FF00) | ((C >> 16) & 0xFF)
                }
                if ((C := v.B) != "") {
                    this.Controls[Ctrl.Hwnd].Colors[Item]["B"] := ((C & 0xFF) << 16) | (C & 0x00FF00) | ((C >> 16) & 0xFF)
                }
            }
        }

        if (!OnMessage(WM_DRAWITEM := 0x002B, OD_Colors.DrawItem)) {
            OnMessage(WM_DRAWITEM := 0x002B, OD_Colors.DrawItem, 1)
        }
        Ctrl.Redraw()
        return true
    }

    static Detach(Ctrl) {
        this.Controls.Delete(Ctrl.Hwnd)
        if (this.Controls.Count = 0) {
            OnMessage(WM_DRAWITEM := 0x002B, OD_Colors.DrawItem, 0)
        }
        Ctrl.Redraw()
        return true
    }

    static Update(Ctrl, Colors := "") {
        if (this.Controls.Has(Ctrl.Hwnd)) {
            this.Detach(Ctrl)
        }
        return this.Attach(Ctrl)
    }

    static SetItemHeight(FontOptions := "s10", FontName := "Default") {
        tempGui := Gui()
        tempGui.SetFont(FontOptions, FontName)
        tempGui.Add("Text", "0x200 vHTX", "sizer")
        Rect := Buffer(16, 0)
        DllCall("User32.dll\GetClientRect", "Ptr", tempGui["HTX"].Hwnd, "Ptr", Rect)
        tempGui.Destroy()
        return (OD_Colors.ItemHeight := NumGet(Rect, 12, "Int"))
    }

    static MeasureItem(lParam, Msg, Hwnd) {
        static offHeight := 16
        if (OD_Colors.ItemHeight = 0) {
            OD_Colors.SetItemHeight()
        }
        NumPut("Int", OD_Colors.ItemHeight, offHeight, lParam + 0)
        return true
    }

    static DrawItem(lParam, Msg, Hwnd) {
        static offItem := 8, offAction := OffItem + 4, offState := offAction + 4, offHwnd := offState + A_PtrSize,
               offDC := offHWND + A_PtrSize, offRECT := offDC + A_PtrSize, offData := offRECT + 16
        static ODT := Map(2, "LISTBOX", 3, "COMBOBOX")
        static ODA_DRAWENTIRE := 0x0001, ODA_SELECT := 0x0002, ODA_FOCUS := 0x0004
        static ODS_SELECTED := 0x0001, ODS_FOCUS := 0x0010
        static DT_FLAGS := 0x24

        Critical
        Hwnd := NumGet(lParam + offHWND, 0, "UPtr")
        if (OD_Colors.Controls.Has(Hwnd) && ODT.Has(NumGet(lParam + 0, 0, "UInt"))) {
            ODCtrl := OD_Colors.Controls[Hwnd]
            Item := NumGet(lParam + offItem, 0, "Int") + 1
            Action := NumGet(lParam + offAction, 0, "UInt")
            State := NumGet(lParam + offState, 0, "UInt")
            HDC := NumGet(lParam + offDC, 0, "UPtr")
            RECT := lParam + offRECT
            if (Action = ODA_FOCUS) {
                return true
            }
            if (ODCtrl.Colors.Has("B")) {
                CtrlBgC := ODCtrl.Colors["B"]
            }
            else {
                CtrlBgC := DllCall("Gdi32.dll\GetBkColor", "Ptr", HDC, "UInt")
            }
            if (ODCtrl.Colors.Has("T")) {
                CtrlTxC := ODCtrl.Colors["T"]
            }
            else {
                CtrlTxC := DllCall("Gdi32.dll\GetTextColor", "Ptr", HDC, "UInt")
            }

            BgC := ODCtrl.Colors.Has(Item) && ODCtrl.Colors[Item].Has("B") ? ODCtrl.Colors[Item].B : CtrlBgC
            Brush := DllCall("Gdi32.dll\CreateSolidBrush", "UInt", BgC, "UPtr")
            DllCall("User32.dll\FillRect", "Ptr", HDC, "Ptr", RECT, "Ptr", Brush)
            DllCall("Gdi32.dll\DeleteObject", "Ptr", Brush)
            if (ODCtrl.Items.Has(Item)) {
                Txt := A_Space ODCtrl.Items[Item], Len := StrLen(Txt)
                TxC := ODCtrl.Colors.Has(Item) && ODCtrl.Colors[Item].Has("T") ? ODCtrl.Colors[Item].T : CtrlTxC
                NumPut("Int", NumGet(RECT + 0, 0, "Int") - 2, RECT + 0, 0)
                DllCall("Gdi32.dll\SetBkMode", "Ptr", HDC, "Int", 1)
                DllCall("Gdi32.dll\SetTextColor", "Ptr", HDC, "UInt", TxC)
                DllCall("User32.dll\DrawText", "Ptr", HDC, "Ptr", StrPtr(Txt), "Int", Len, "Ptr", RECT, "UInt", DT_Flags)
                NumPut("Int", NumGet(RECT + 0, 0, "Int") - 2, RECT + 0, 0)
                if (State & ODS_SELECTED) {
                    DllCall("User32.dll\DrawFocusRect", "Ptr", HDC, "Ptr", RECT)
                }
                DllCall("Gdi32.dll\SetTextColor", "Ptr", HDC, "UInt", CtrlTxC)
            }
            return true
        }
    }
}
