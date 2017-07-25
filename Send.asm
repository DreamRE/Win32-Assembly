;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
;by DreamRE
;date:2017/07/25
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
;Send.asm
;窗口间消息互发------->Send程序
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
;编译环境：Windows  +  Notepad++  + masm32环境
; ml /c /coff Send.asm
; Link /subsystem:windows Send.obj
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
		.386
		.model	flat,stdcall
		option casemap:none
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
;Include文件定义
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
include 	windows.inc
include		user32.inc
includelib	user32.lib
include 	kernel32.inc
includelib	kernel32.lib
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
;数据段
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
		.data
hWnd	dd	?
szBuffer db	256 dup(?)

		.const
szCaption 	db	'发信程序',0
szStart		db 	'Send：按下OK按钮开始发送消息，参数param是 %08x!',0
szReturn 	db	'Send:消息已发送',0
szDestClass	db	'MyClass',0
szText		db	'send:亲，收到么？',0
szNotFound	db	'send:亲，没有找到接受的窗口',0
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
;代码段
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
		.code
start:
		invoke FindWindow,addr szDestClass,NULL			;寻找目标窗口
		.if eax
			mov hWnd,eax		
			invoke	wsprintf,addr szBuffer,addr szStart,addr szText	;输出至szBuffer
			invoke 	MessageBox,NULL,offset szBuffer,offset szCaption,MB_OK		
			invoke 	SendMessage,hWnd,WM_SETTEXT,0,addr szText					;发送Message
			invoke 	MessageBox,NULL,offset szReturn,offset szCaption,MB_OK		
		.else
			invoke 	MessageBox,NULL,offset szNotFound,offset szCaption,MB_OK
		.endif
		invoke ExitProcess,NULL
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
		end start