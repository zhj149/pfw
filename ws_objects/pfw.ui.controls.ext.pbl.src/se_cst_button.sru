﻿$PBExportHeader$se_cst_button.sru
$PBExportComments$PowerFramework~r~n(c)飞沃共享(深圳)科技有限公司
forward
global type se_cst_button from s_cst_button
end type
end forward

global type se_cst_button from s_cst_button
event type long onthemeregistering ( )
event onthemeregistered ( )
event onthememgrnotify ( boolean colorchanged,  boolean stylechanged )
end type
global se_cst_button se_cst_button

event onthememgrnotify(boolean colorchanged, boolean stylechanged);Boolean bLockUpdate

bLockUpdate = #LockUpdate
#LockUpdate = true

if colorChanged then
	theme.of_SetBkgndColorStyle(ThemeManager().#ColorStyle)
end if

if styleChanged then
	choose case ThemeManager().#Style
		case n_cst_thememanager.WIN8
			theme.of_SetBkgndStyle(Enums.SOLID)
			theme.of_SetBorderStyle(Enums.BS_SOLID)
		case n_cst_thememanager.WIN7
			theme.of_SetBkgndStyle(Enums.VISTAORIGINAL)
			theme.of_SetBorderStyle(Enums.BS_ROUND)
		case n_cst_thememanager.XP
			theme.of_SetBkgndStyle(Enums.XP)
			theme.of_SetBorderStyle(Enums.BS_ROUND)
		case n_cst_thememanager.QQ
			theme.of_SetBkgndStyle(Enums.XP)
			theme.of_SetBorderStyle(Enums.BS_ROUND)
	end choose
end if

#LockUpdate = bLockUpdate
if styleChanged then
	of_UpdatePoints()
else
	of_Redraw(true)
end if
end event

on se_cst_button.create
call super::create
end on

on se_cst_button.destroy
call super::destroy
end on

event ongetcolor;call super::ongetcolor;choose case colorFlag
	case theme.CLR_TRANSPARENT
		if Not #Transparent then
			color = ARGB(255,255,255,255)
		end if
	case theme.CLR_BKGND
		if BitTest(state,Enums.STATE_DISABLED) then
			color = ARGB(255,244,244,244)
		end if
	case theme.CLR_TEXT
		if BitTest(state,Enums.STATE_DISABLED) then
			color = ARGB(255,130,130,130)
		end if
	case theme.CLR_BORDER
		if BitTest(state,Enums.STATE_DISABLED) then
			color = ARGB(255,220,220,220)
		end if
end choose
end event

event onpreconstructor;call super::onpreconstructor;of_SetToolTipStyle(Enums.TTS_NORMAL)

if IsPrevented(Event OnThemeRegistering()) then return

ThemeManager().of_RegisterControl(this)

Event OnThemeRegistered()
end event

event onpredestructor;call super::onpredestructor;ThemeManager().of_UnregisterControl(this)
end event

