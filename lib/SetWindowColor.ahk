#requires AutoHotkey v2

/** 
 * Sets the attributes of a window. Specifically, it can set the color of the window's caption, text, and border.
 * @param {integer} hwnd Window handle.
 * @param {integer} [titleText] Specifies the color(BGR) of the caption text. Specifying `0xFFFFFFFF` will reset to the system's default caption text color.  
 * @param {integer} [titleBackground] Specifies the color(BGR) of the caption. Specifying `0xFFFFFFFF` will reset to the system's default caption color.
 * @param {integer} [border] Specifies the color(BGR) of the window border.
 * - Specifying `0xFFFFFFFE` will suppress the drawing of the window border. 
 * - Specifying `0xFFFFFFFF` will reset to the system's default border color.  
 * The application is responsible for changing the border color in response to state changes, such as window activation.
 * @since This is supported starting with Windows 11 Build 22000.
 * @returns {String} - The result of the attribute setting operation.
 */
SetWindowColor(hwnd, titleText?, titleBackground?, border?)
{
    static DWMWA_BORDER_COLOR  := 34
    static DWMWA_CAPTION_COLOR := 35
    static DWMWA_TEXT_COLOR    := 36
    
    if (VerCompare(A_OSVersion, "10.0.22200") < 0)
        return MsgBox("This is supported starting with Windows 11 Build 22000.", "OS Version Not Supported.")

    if (border??0)
        DwmSetWindowAttribute(hwnd, DWMWA_BORDER_COLOR, border)
    
    if (titleBackground??0)
        DwmSetWindowAttribute(hwnd, DWMWA_CAPTION_COLOR, titleBackground)
    
    if (titleText??0)
        DwmSetWindowAttribute(hwnd, DWMWA_TEXT_COLOR, titleText)

    DwmSetWindowAttribute(hwnd?, dwAttribute?, pvAttribute?) => DllCall("Dwmapi\DwmSetWindowAttribute", "Ptr" , hwnd, "UInt", dwAttribute, "Ptr*", &pvAttribute, "UInt", 4)
}