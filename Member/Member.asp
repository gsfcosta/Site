<!--#include virtual="/common/function/aes.asp"-->
<!--#include virtual="/common/function/base64.asp"-->
<%
	PageNoCache

	Dim admin_info, admin_info_decoded, decode_string
	Dim admin_id, admin_name, admin_ip, admin_referer, admin_session

	admin_info = Trim(Request.Cookies("Gamebus")("MixMaster_Admin"))

	If admin_info <> "" Then

		Dim Member_FSO, Member_FileText

		Set Member_FSO		= Server.CreateObject("Scripting.FileSystemObject")
		Set Member_FileText	= Member_FSO.OpenTextFile("D:\Web\aes_string.dat",1,0,0)
		decode_string	= Member_FileText.Readline
		Set Member_FSO = Nothing

		admin_info = Split(Base64decode(admin_info), "|")
		admin_name = admin_info(1)

		
'		admin_info_decoded = AESDecrypt(strAnsi2Unicode(admin_info(0)), decode_string)
		admin_info_decoded = Split(AESDecrypt(strAnsi2Unicode(admin_info(0)), decode_string), "|")

		admin_id		= admin_info_decoded(0)
		admin_session	= admin_info_decoded(1)

	Else

			admin_id		= ""
			admin_name		= ""
			admin_session	= ""

	End If


	admin_ip		= Request.ServerVariables("REMOTE_ADDR") 
	admin_referer	= Request.ServerVariables("HTTP_REFERER")

	If left(admin_ip,11) <> "221.148.118" Then

		Response.Redirect "/"
		Response.End

	End If
%>