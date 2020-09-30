<%
	//Server
	dim Server_List 

	if left(lcase(Request.ServerVariables("HTTP_HOST")), 6) = "gmtest" Then
		Server_List = "[{""N1"":""0"",""N2"":""gametest""}]"
	Else
		Server_List = "[{""N1"":""0"",""N2"":""Draco""},{""N1"":""1"",""N2"":""Garugon""}]"
	End if
	
	// Gmtool / Gmlog
	Dim Now_Position : Now_Position = "" 
	
	Const lang ="EN" 
%>