<%
'/**************************DEFINE CONSTANT HERE***************************
'*  /Gmtool/Member/ifrm_login_ck.asp
'*  Description: Gmtool Login check
'*  Date: 2011.10.10
'*  Author: Tae-Young Kim(tykim@auroragames.co.kr, geojangbi@naver.com)
'*  Params: 
'*  Last Modified: 
'*************************************************************************/
%>
<!--#include virtual="/Common/Function/function.asp"-->
<!--#include virtual="/Common/Function/secure.asp"-->
<!--#include virtual="/Common/Function/string.asp"-->
<!--#include virtual="/Common/Function/aes.asp"-->
<!--#include virtual="/Common/Function/base64.asp"-->
<%
	

	Dim admin_info, admin_info_decoded, decode_string
	Dim admin_id, admin_name, admin_ip, admin_referer, admin_session

	admin_info 				= Trim(Request.Cookies("MixMaster_Admin"))

	If admin_info <> "" Then

		Dim Member_FSO, Member_FileText

		Set Member_FSO		= Server.CreateObject("Scripting.FileSystemObject")
		Set Member_FileText	= Member_FSO.OpenTextFile(Server.MapPath("/lib/aes_string.dat"),1,0,0)
		decode_string		= Member_FileText.Readline
		Set Member_FSO 		= Nothing

		admin_info 			= Split(Base64decode(admin_info), "|")
		admin_name 			= admin_info(1)

		admin_info_decoded 	= Split(AESDecrypt(strAnsi2Unicode(admin_info(0)), decode_string), "|")

		admin_id			= admin_info_decoded(0)
		admin_session		= admin_info_decoded(1)


	Else

			admin_id		= ""
			admin_name		= ""
			admin_session	= ""
			
			Response.Redirect "/"

	End If


	admin_ip		= Request.ServerVariables("REMOTE_ADDR") 
	admin_referer	= Request.ServerVariables("HTTP_REFERER")

'	If left(admin_ip,11) <> "221.148.118" Then

'		Response.Redirect "/index.htm"
'		Response.End

'	End If
%>