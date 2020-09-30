<%
	Server.Execute("/Member/GM_login_ck.asp")
	
	Dim Path_info_header : Path_info_header = trim(Request.ServerVariables("PATH_INFO"))

	If Lcase(Left(Path_info_header,7)) = Lcase("/GMTool") Then
		Dim M_tab1 : M_tab1 ="on"
		Now_Position = "GMTool"
		Response.Write "<script>document.title='Mixmaster GMTool'</script>"
	Else
		Dim M_tab2 : M_tab2 ="on"
		Now_Position = "GMLog"
		Response.Write "<script>document.title='Mixmaster GMLog'</script>"
	End if
	
%>
<ul>
	<li class="<%=M_tab1%>"><a href="/GMTool/" >GM Tool</a></li>
	<li class="<%=M_tab2%>"><a href="/GMLOG/" >GM LOG</a></li>
</ul>