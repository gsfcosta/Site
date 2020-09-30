<!--#include virtual="/common/Function/option_explicit.asp"-->
<%
'/**************************DEFINE CONSTANT HERE***************************
'*  /Gmtool/Member/ifrm_login_ok.asp
'*  Description: Gmtool Login
'*  Date: 2011.10.10
'*  Author: Tae-Young Kim(tykim@auroragames.co.kr, geojangbi@naver.com)
'*  Params: 
'*  Last Modified: 
'*************************************************************************/
%>
<!--#include virtual="/common/Function/db.asp"-->
<!--#include virtual="/common/Function/function.asp"-->
<!--#include virtual="/common/Function/secure.asp"-->
<!--#include virtual="/common/Function/string.asp"-->
<!--#include virtual="/common/Function/aes.asp"-->
<!--#include virtual="/common/Function/base64.asp"-->
<%
	Response.Charset = "utf-8"
	
	'// Request
	Dim user_id				: user_id			= Request.Form("username")
	Dim user_passwd			: user_passwd		= Request.Form("password")
	
	
	Dim SQL
	Dim MixComm, MixConn
	Dim arrRSMix, arrRSMixCnt
	Dim MixDSN				:	MixDSN		= "Manager"

	Dim Member_FSO, Member_FileText

	Dim admin_info, admin_info_encoded, encode_string
	Dim admin_id, admin_name, admin_session, admin_ip, admin_referer

	admin_ip		= Request.ServerVariables("REMOTE_ADDR") 
	admin_referer	= Request.ServerVariables("HTTP_REFERER")

	SQL = "			SELECT AdminID, Passwd				"
	SQL = SQL & "	FROM Management						"
	SQL = SQL & "	WHERE AdminID = '"& user_id &"'		"
	SQL = SQL & "	AND Passwd = '"& user_passwd &"'	"

	DBConnCommandMy MixComm, MixConn, MixDSN, SQL
	DBSelect2 MixComm, MixConn, arrRSMix, arrRSMixCnt

	If arrRSMixCnt > -1 And arrRSMixCnt <> "" Then

		Set Member_FSO						= Server.CreateObject("Scripting.FileSystemObject")
		Set Member_FileText					= Member_FSO.OpenTextFile(Server.MapPath("/lib/aes_string.dat"),1,0,0)
		encode_string						= Member_FileText.Readline
		Set Member_FSO						= Nothing

		admin_id							= Trim(arrRSMix(0, 0))
		admin_name							= Trim(arrRSMix(1, 0))
		admin_session						= Session.SessionID
		Session.timeout 					= "60"

		admin_info							= admin_id &"|"& admin_session
		admin_info_encoded 					= AESEncrypt(admin_info, encode_string)
		admin_info_encoded 					= Base64encode(strUnicode2Ansi(admin_info_encoded) &"|"& admin_name)

		Response.Cookies("MixMaster_Admin") = admin_info_encoded
		
		SQL = " Update Management Set LastLoginDate = NOW(), LoginIP = '"& Request.ServerVariables("REMOTE_ADDR") &"' where AdminID = '"& user_id &"'"
		DBExecuteMy MixDSN, SQL
		
		Response.Write "0"
		Response.End
		
		
	Else

		Response.Write "99"
		Response.End

	End If
%>

