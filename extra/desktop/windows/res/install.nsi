; Script generated by the HM NIS Edit Script Wizard.

; HM NIS Edit Wizard helper defines
!define PRODUCT_NAME "Zentyal Desktop"
!define PRODUCT_VERSION "0.2"
!define PRODUCT_PUBLISHER "eBox Technologies S.L."
!define PRODUCT_WEB_SITE "http://www.zentyal.com"
!define PRODUCT_DIR_REGKEY "Software\Zentyal\${PRODUCT_NAME}"
!define PRODUCT_UNINST_KEY "Software\Zentyal\${PRODUCT_NAME}\Uninstall\"
!define PRODUCT_UNINST_ROOT_KEY "HKLM"

; MUI 1.67 compatible ------
!include "MUI.nsh"
!include nsDialogs.nsh
!include LogicLib.nsh

; MUI Settings
!define MUI_ABORTWARNING
!define MUI_ICON "zentyal.ico"
!define MUI_UNICON "${NSISDIR}\Contrib\Graphics\Icons\modern-uninstall.ico"

; Welcome page
!insertmacro MUI_PAGE_WELCOME
; License page
!define MUI_LICENSEPAGE_CHECKBOX
!insertmacro MUI_PAGE_LICENSE "LICENSE.txt"
; Components page
!insertmacro MUI_PAGE_COMPONENTS
; Directory page
!insertmacro MUI_PAGE_DIRECTORY
; Instfiles page
!insertmacro MUI_PAGE_INSTFILES
; Finish page
#!define MUI_FINISHPAGE_RUN "$INSTDIR\postinstall.exe"
#!insertmacro MUI_PAGE_FINISH

; Uninstaller pages
!insertmacro MUI_UNPAGE_INSTFILES

; Language files
!insertmacro MUI_LANGUAGE "English"

; MUI end ------
Page custom nsDialogsPage nsDialogsPageLeave
Page instfiles

Name "${PRODUCT_NAME} ${PRODUCT_VERSION}"
OutFile "Setup.exe"
InstallDir "$PROGRAMFILES\Zentyal Desktop"
InstallDirRegKey HKLM "${PRODUCT_DIR_REGKEY}" ""
ShowInstDetails show
ShowUnInstDetails show

Var Dialog
Var Label
Var Text

Function nsDialogsPage
	nsDialogs::Create 1018
	Pop $Dialog

	${If} $Dialog == error
		Abort
	${EndIf}

	${NSD_CreateLabel} 0 0 100% 12u "Enter Zentyal Server address:"
	Pop $Label

	${NSD_CreateText} 0 10u 100% 15u ""
	Pop $Text

	nsDialogs::Show
        DetailPrint "Server configuration"
FunctionEnd

Function nsDialogsPageLeave
	${NSD_GetText} $Text $0
        WriteRegStr HKLM "${PRODUCT_DIR_REGKEY}" "SERVER" "$0"
        MessageBox MB_OK "Installation finished"
        Quit
FunctionEnd

Section
  SetOutPath "$INSTDIR"
  SetOverwrite on
  File "Config.exe"
  CreateDirectory "$SMPROGRAMS\Zentyal Desktop"
SectionEnd

Section "Firefox" SEC01
  SetOutPath "$INSTDIR"
  SetOverwrite on
  File "Firefox Setup 3.6.12.exe"
  CreateDirectory "$SMPROGRAMS\Zentyal Desktop"
  ExecWait '$INSTDIR\Firefox Setup 3.6.12.exe'
SectionEnd

Section "Ekiga" SEC02
  SetOutPath "$INSTDIR"
  SetOverwrite on
  File "ekiga-setup-3.2.7.exe"
  CreateDirectory "$SMPROGRAMS\Zentyal Desktop"
  ExecWait '$INSTDIR\ekiga-setup-3.2.7.exe'
SectionEnd

Section "Thunderbird" SEC03
  SetOutPath "$INSTDIR"
  SetOverwrite on
  File "Thunderbird Setup 3.1.6.exe"
  CreateDirectory "$SMPROGRAMS\Zentyal Desktop"
  ExecWait '$INSTDIR\Thunderbird Setup 3.1.6.exe'
SectionEnd

Section "Pidgin" SEC04
  SetOutPath "$INSTDIR"
  SetOverwrite on
  File "pidgin-2.7.3.exe"
  CreateDirectory "$SMPROGRAMS\Zentyal Desktop"
  ExecWait '$INSTDIR\pidgin-2.7.3.exe'
SectionEnd

Section -AdditionalIcons
  WriteIniStr "$INSTDIR\${PRODUCT_NAME}.url" "InternetShortcut" "URL" "${PRODUCT_WEB_SITE}"
  CreateShortCut "$SMPROGRAMS\Zentyal Desktop\Website.lnk" "$INSTDIR\${PRODUCT_NAME}.url"
  CreateShortCut "$SMPROGRAMS\Zentyal Desktop\Uninstall.lnk" "$INSTDIR\uninst.exe"
  CreateShortCut "$SMPROGRAMS\Zentyal Desktop\Zentyal Desktop (Configure).lnk" "$INSTDIR\Config.exe"
SectionEnd

Section -Post
  WriteUninstaller "$INSTDIR\uninst.exe"
  WriteRegStr HKLM "${PRODUCT_DIR_REGKEY}" "" "$INSTDIR\Config.exe"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayName" "$(^Name)"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "UninstallString" "$INSTDIR\uninst.exe"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayIcon" "$INSTDIR\Config.exe"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayVersion" "${PRODUCT_VERSION}"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "URLInfoAbout" "${PRODUCT_WEB_SITE}"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "Publisher" "${PRODUCT_PUBLISHER}"
SectionEnd

; Section descriptions
!insertmacro MUI_FUNCTION_DESCRIPTION_BEGIN
  !insertmacro MUI_DESCRIPTION_TEXT ${SEC01} ""
  !insertmacro MUI_DESCRIPTION_TEXT ${SEC02} ""
  !insertmacro MUI_DESCRIPTION_TEXT ${SEC03} ""
  !insertmacro MUI_DESCRIPTION_TEXT ${SEC04} ""
!insertmacro MUI_FUNCTION_DESCRIPTION_END


Function un.onUninstSuccess
  HideWindow
  MessageBox MB_ICONINFORMATION|MB_OK "$(^Name) was successfully removed from your computer."
FunctionEnd

Function un.onInit
  MessageBox MB_ICONQUESTION|MB_YESNO|MB_DEFBUTTON2 "Are you sure you want to completely remove $(^Name) and all of its components?" IDYES +2
  Abort
FunctionEnd

Section Uninstall
  Delete "$INSTDIR\${PRODUCT_NAME}.url"
  Delete "$INSTDIR\uninst.exe"
  Delete "$INSTDIR\pidgin-2.7.3.exe"
  Delete "$INSTDIR\Thunderbird Setup 3.1.6.exe"
  Delete "$INSTDIR\ekiga-setup-3.2.7.exe"
  Delete "$INSTDIR\Firefox Setup 3.6.12.exe"

  Delete "$SMPROGRAMS\Zentyal Desktop\Uninstall.lnk"
  Delete "$SMPROGRAMS\Zentyal Desktop\Website.lnk"
  Delete "$DESKTOP\Zentyal Desktop.lnk"
  Delete "$SMPROGRAMS\Zentyal Desktop\Zentyal Desktop (Configure).lnk"

  RMDir "$SMPROGRAMS\Zentyal Desktop"
  RMDir "$INSTDIR"

  DeleteRegKey ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}"
  DeleteRegKey HKLM "${PRODUCT_DIR_REGKEY}"
  SetAutoClose true
SectionEnd
