;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
;by DreamRE
;date:2017/07/25
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
;Send.asm
;���ڼ���Ϣ����------->Send����
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
;���뻷����Windows  +  Notepad++  + masm32����
; ml /c /coff Send.asm
; Link /subsystem:windows Send.obj
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
		.386
		.model	flat,stdcall
		option casemap:none
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
;Include�ļ�����
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
include 	windows.inc
include		user32.inc
includelib	user32.lib
include 	kernel32.inc
includelib	kernel32.lib
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
;���ݶ�
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
		.data
hWnd	dd	?
szBuffer db	256 dup(?)

		.const
szCaption 	db	'���ų���',0
szStart		db 	'Send������OK��ť��ʼ������Ϣ������param�� %08x!',0
szReturn 	db	'Send:��Ϣ�ѷ���',0
szDestClass	db	'MyClass',0
szText		db	'send:�ף��յ�ô��',0
szNotFound	db	'send:�ף�û���ҵ����ܵĴ���',0
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
;�����
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
		.code
start:
		invoke FindWindow,addr szDestClass,NULL			;Ѱ��Ŀ�괰��
		.if eax
			mov hWnd,eax		
			invoke	wsprintf,addr szBuffer,addr szStart,addr szText	;�����szBuffer
			invoke 	MessageBox,NULL,offset szBuffer,offset szCaption,MB_OK		
			invoke 	SendMessage,hWnd,WM_SETTEXT,0,addr szText					;����Message
			invoke 	MessageBox,NULL,offset szReturn,offset szCaption,MB_OK		
		.else
			invoke 	MessageBox,NULL,offset szNotFound,offset szCaption,MB_OK
		.endif
		invoke ExitProcess,NULL
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
		end start