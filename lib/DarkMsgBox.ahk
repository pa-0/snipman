/*
***********************************************************************
 * @description Apply dark theme to the built-in MsgBox and InputBox. (This is for 2.1-alpha users)
 * @file Dark_MsgBox.ahk
 * @link https://github.com/nperovic/DarkMsgBox/tree/alpha
 * @author Nikola Perovic
 * @date 2024/06/16
 * @version 1.1.0
 ***********************************************************************
 */
#Requires AutoHotkey v2.1-alpha.13
; #Module Dark_MsgBox
Import AHK

#DllLoad gdi32.dll

 /**
 * Display the specified text in a small window containing one or more buttons (such as'Yes' and'No').
 * @param Options indicates the type of message box and possible button combinations. If it is empty or omitted, the default is 0. Please refer to the table below for the allowed values. In addition, you can specify zero or more of the following options: 
 * 
 * Owner: To specify the owner window for the message box, use the word Owner followed by HWND (window ID).
 * 
 * T: Timeout. If the user does not close the message box within the specified time, to make the message box close automatically, please use the letter T followed by the timeout seconds, which can include a decimal point. If the value exceeds 2147483 (24.8 days), it will be Set to 2147483. If the message box times out, the return value is the word Timeout.
 * 
 * 0x0 confirm
 * 
 * 0x1 Confirm/Cancel
 * 
 * 0x2 abort/retry/ignore
 * 
 * 0x3 Yes/No/Cancel
 * 
 * 0x4 yes/no
 * 
 * 0x5 Retry/Cancel
 * 
 * 0x6 cancel/retry/continue
 * 
 * 0x10 Stop/error icon.
 * 
 * 0x20 question mark icon.
 * 
 * 0x30 exclamation point icon.
 * 
 * 0x40 star icon (information).
 * 
 * 0x100 makes the second button the default button.
 * 
 * 0x200 makes the third button the default button.
 * 
 * 0x300 Make the fourth button the default. A Help button is required
 * 
 * 0x1000 system mode (always on top)
 * 
 * 0x2000 mission mode
 * 
 * 0x40000 to the top (WS_EX_TOPMOST style) (similar to the system mode, but the title bar icon is omitted)
 * 
 * 0x4000 Add a help button (please refer to the remarks below)
 * 
 * 0x80000 Let the text be displayed right-aligned.
 * 
 * 0x100000 is used for Hebrew/Arabic right-to-left reading order.
 * @returns When called from an expression, MsgBox returns one of the following strings to indicate which button the user pressed: 
 * OK, Cancel, Yes, No, Abort, Retry, Ignore, TryAgain, Continue, Timeout
 */
DMsgBox(Text?, Title?, Options?, IconPath?) => DarkMsgBox(AHK.MsgBox, Text?, Title?, Options?, IconPath?)

 /**
 * Display an input box, asking the user to enter a string.
 * @param Options is a case-insensitive string option, and each option is separated from the last option with a space or tab.
 * 
 * Xn Yn: The X and Y coordinates of the dialog box. For example, X0 Y0 places the window in the upper left corner of the desktop. If any of the coordinates is omitted, the dialog box will be centered in that dimension. Any coordinate can be a negative number to make The dialog box is partially or completely off the desktop (or on a secondary monitor in a multi-monitor setup).
 * 
 * Wn Hn: The width and height of the client area of the dialog box, excluding the title bar and border. For example, W200 H100.
 * 
 * T: Specify the timeout time in seconds. For example, T10.0 is 10 seconds. If this value exceeds 2147483 (24.8 days), then it will be set to 2147483. After the timeout period is reached, the input box window will be closed automatically at the same time Set Result to the word "Timeout". Value will still contain what the user entered.
 * 
 * Password: shield the user's input. To specify which character to use, as shown in this example: Password
 */
DInputBox(Prompt?, Title?, Options?, Default?) => DarkMsgBox(AHK.InputBox, Prompt?, Title?, Options?, Default?)

class DarkMsgBox
{
    ; for v2.1.alpha.9 or later
    class RECT  {
        left: i32, top: i32, right: i32, bottom: i32
    }

    static Call(_this, params*)
    {
        static WM_COMMNOTIFY := 0x44
        static WM_INITDIALOG := 0x0110
        
        iconNumber := 1
        iconFile   := ""
        
        if (params.length = (_this.MaxParams + 2))
            iconNumber := params.Pop()
        
        if (params.length = (_this.MaxParams + 1)) 
            iconFile := params.Pop()
        
        SetThreadDpiAwarenessContext(-3)

        if InStr(_this.Name, "MsgBox")
            OnMessage(WM_COMMNOTIFY, ON_WM_COMMNOTIFY, -1)
        else
            OnMessage(WM_INITDIALOG, ON_WM_INITDIALOG, -1)

        return  _this(params*)

        ON_WM_INITDIALOG(wParam, lParam, msg, hwnd)
        {
            OnMessage(WM_INITDIALOG, ON_WM_INITDIALOG, 0)
            WNDENUMPROC(hwnd)
        }
        
        ON_WM_COMMNOTIFY(wParam, lParam, msg, hwnd)
        {
            if (msg = 68 && wParam = 1027)
                OnMessage(0x44, ON_WM_COMMNOTIFY, 0),                    
                EnumThreadWindows(GetCurrentThreadId(), CallbackCreate(WNDENUMPROC), 0)
        }

        WNDENUMPROC(hwnd, *)
        {
            static SM_CICON         := "W" SysGet(11) " H" SysGet(12)
            static SM_CSMICON       := "W" SysGet(49) " H" SysGet(50)
            static ICON_BIG         := 1
            static ICON_SMALL       := 0
            static WM_SETICON       := 0x80
            static WS_CLIPCHILDREN  := 0x02000000
            static WS_CLIPSIBLINGS  := 0x04000000
            static WS_EX_COMPOSITED := 0x02000000
            static winAttrMap       := Map(10, true, 17, true, 20, true, 38, 4, 35, 0x2b2b2b)

            SetWinDelay(-1)
            SetControlDelay(-1)
            DetectHiddenWindows(true)

            if !WinExist("ahk_class #32770 ahk_id" hwnd)
                return 1

            WinSetStyle("+" (WS_CLIPSIBLINGS | WS_CLIPCHILDREN))
            WinSetExStyle("+" (WS_EX_COMPOSITED))
            SetWindowTheme(hwnd, "DarkMode_Explorer")

            if iconFile {
                hICON_SMALL := LoadPicture(iconFile, SM_CSMICON " Icon" iconNumber, &handleType)
                hICON_BIG   := LoadPicture(iconFile, SM_CICON " Icon" iconNumber, &handleType)
                PostMessage(WM_SETICON, ICON_SMALL, hICON_SMALL)
                PostMessage(WM_SETICON, ICON_BIG, hICON_BIG)
            }

            for dwAttribute, pvAttribute in winAttrMap
                DwmSetWindowAttribute(hwnd, dwAttribute, pvAttribute)
            
            GWL_WNDPROC(hwnd, hICON_SMALL?, hICON_BIG?)
            return 0
        }
        
        GWL_WNDPROC(winId := "", hIcons*)
        {
            static SetWindowLong     := DllCall.Bind(A_PtrSize = 8 ? "SetWindowLongPtr" : "SetWindowLong", "ptr",, "int",, "ptr",, "ptr")
            static BS_FLAT           := 0x8000
            static BS_BITMAP         := 0x0080
            static DPI               := (A_ScreenDPI / 96)
            static WM_CLOSE          := 0x0010
            static WM_CTLCOLORBTN    := 0x0135
            static WM_CTLCOLORDLG    := 0x0136
            static WM_CTLCOLOREDIT   := 0x0133
            static WM_CTLCOLORSTATIC := 0x0138
            static WM_DESTROY        := 0x0002
            static WM_SETREDRAW      := 0x000B

            SetControlDelay(-1)

            btns    := []
            btnHwnd := ""

            for ctrl in WinGetControlsHwnd(winId)
            {
                classNN := ControlGetClassNN(ctrl)
                SetWindowTheme(ctrl, !InStr(classNN, "Edit") ? "DarkMode_Explorer" : "DarkMode_CFD")

                if InStr(classNN, "B") 
                    btns.Push(btnHwnd := ctrl)
            }

            WindowProcOld := SetWindowLong(winId, -4, CallbackCreate(WNDPROC))
            
            WNDPROC(hwnd, uMsg, wParam, lParam)
            {
                static hbrush := []
                SetWinDelay(-1)
                SetControlDelay(-1)
                
                if !hbrush.Length
                    for clr in [0x202020, 0x2b2b2b]
                        hbrush.Push(CreateSolidBrush(clr))

                switch uMsg {
                case WM_CTLCOLORSTATIC: 
                {
                    SelectObject(wParam, hbrush[2])
                    SetBkMode(wParam, 0)
                    SetTextColor(wParam, 0xFFFFFF)
                    SetBkColor(wParam, 0x2b2b2b)

                    for _hwnd in btns
                        PostMessage(WM_SETREDRAW,,,_hwnd)

                    GetClientRect(winId, rcC := this.RECT())
                    WinGetClientPos(&winX, &winY, &winW, &winH, winId)
                    ControlGetPos(, &btnY,, &btnH, btnHwnd)
                    hdc        := GetDC(winId)
                    rcC.top    := btnY - (rcC.bottom - (btnY+btnH))
                    rcC.bottom *= 2
                    rcC.right  *= 2
                    
                    SetBkMode(hdc, 0)
                    FillRect(hdc, rcC, hbrush[1])
                    ReleaseDC(winId, hdc)

                    for _hwnd in btns
                        PostMessage(WM_SETREDRAW, 1,,_hwnd)

                    return hbrush[2]
                }
                case WM_CTLCOLORBTN, WM_CTLCOLORDLG, WM_CTLCOLOREDIT: 
                {         
                    brushIndex := !(uMsg = WM_CTLCOLORBTN)
                    SelectObject(wParam, brush := hbrush[!(uMsg = WM_CTLCOLORBTN)+1])
                    SetBkMode(wParam, 0)
                    SetTextColor(wParam, 0xFFFFFF)
                    ; SetBkColor(wParam, !brushIndex ? 0x202020 : 0x2b2b2b)
                    return brush
                }
                case WM_DESTROY: 
                {
                    for v in hIcons
                        (v??0) && DestroyIcon(v)

                    while hbrush.Length
                        DeleteObject(hbrush.Pop())
                }}

                return CallWindowProc(WindowProcOld, hwnd, uMsg, wParam, lParam) 
            }
        }

        CreateSolidBrush(crColor) => DllCall('Gdi32\CreateSolidBrush', 'uint', crColor, 'ptr')
        
        CallWindowProc(lpPrevWndFunc, hWnd, uMsg, wParam, lParam) => DllCall("CallWindowProc", "Ptr", lpPrevWndFunc, "Ptr", hwnd, "UInt", uMsg, "Ptr", wParam, "Ptr", lParam)

        DestroyIcon(hIcon) => DllCall("DestroyIcon", "ptr", hIcon)

         /** 
         @see — https://learn.microsoft.com/en-us/windows/win32/api/dwmapi/ne-dwmapi-dwmwindowattribute 
         */
        DWMSetWindowAttribute(hwnd, dwAttribute, pvAttribute, cbAttribute := 4) => DllCall("Dwmapi\DwmSetWindowAttribute", "Ptr" , hwnd, "UInt", dwAttribute, "Ptr*", &pvAttribute, "UInt", cbAttribute)
        
        DeleteObject(hObject) => DllCall('Gdi32\DeleteObject', 'ptr', hObject, 'int')
        
        EnumThreadWindows(dwThreadId, lpfn, lParam) => DllCall("User32\EnumThreadWindows", "uint", dwThreadId, "ptr", lpfn, "uptr", lParam, "int")
        
        FillRect(hDC, lprc, hbr) => DllCall("User32\FillRect", "ptr", hDC, "ptr", lprc, "ptr", hbr, "int")
        
        GetClientRect(hWnd, lpRect) => DllCall("User32\GetClientRect", "ptr", hWnd, "ptr", lpRect, "int")
        
        GetCurrentThreadId() => DllCall("Kernel32\GetCurrentThreadId", "uint")
        
        GetDC(hwnd := 0) => DllCall("GetDC", "ptr", hwnd, "ptr")

        ReleaseDC(hWnd, hDC) => DllCall("User32\ReleaseDC", "ptr", hWnd, "ptr", hDC, "int")
        
        SelectObject(hdc, hgdiobj) => DllCall('Gdi32\SelectObject', 'ptr', hdc, 'ptr', hgdiobj, 'ptr')
        
        SetBkColor(hdc, crColor) => DllCall('Gdi32\SetBkColor', 'ptr', hdc, 'uint', crColor, 'uint')
        
        SetBkMode(hdc, iBkMode) => DllCall('Gdi32\SetBkMode', 'ptr', hdc, 'int', iBkMode, 'int')

        SetTextColor(hdc, crColor) => DllCall('Gdi32\SetTextColor', 'ptr', hdc, 'uint', crColor, 'uint')
        
        SetThreadDpiAwarenessContext(dpiContext) => DllCall("SetThreadDpiAwarenessContext", "ptr", dpiContext, "ptr")

        SetWindowTheme(hwnd, pszSubAppName, pszSubIdList := "") => (!DllCall("uxtheme\SetWindowTheme", "ptr", hwnd, "ptr", StrPtr(pszSubAppName), "ptr", pszSubIdList ? StrPtr(pszSubIdList) : 0) ? true : false)
    }
}

; Example: 
if (A_LineFile = A_ScriptFullPath && !A_IsCompiled) {
    ipb := InputBox("Enter something here`nAnd here.", "InputBox Title")
    MsgBox(ipb.value, "Your Input", "0x36")
    ExitApp()
}