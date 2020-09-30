<!--#include virtual="/Function/option_explicit.do"-->
<!--#include virtual="/Function/db.do"-->
<!--#include virtual="/Function/function.do"-->
<!--#include virtual="/Function/secure.do"-->
<!--#include virtual="/Function/string.do"-->
<!--#include virtual="/Function/member.do"-->
<%
	Dim return_url		: return_url		= Request.ServerVariables("HTTP_REFERER")

	Dim SQL
	Dim MixComm, MixConn

	Response.Cookies("Gamebus")("MixMaster_Admin") = ""

	SQL = "INSERT INTO TBL_AdminLog (adl_id, adl_ip, adl_referer, adl_desc) VALUES('"& admin_id &"', '"& admin_ip &"', '"& admin_referer &"', '로그아웃')"

	DBConnCommand MixComm, MixConn, SQL
	DBExecute MixComm, MixConn

	Response.Write "<script language=""javascript"">top.location = '"& return_url &"';</script>"
	Response.End
%>