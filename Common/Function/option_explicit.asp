<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<%
	Option Explicit

	Response.Charset = "UTF-8"
	
	
	Dim Host_Check 
	Host_Check = left(lcase(Request.ServerVariables("HTTP_HOST")), 6)
	
%>