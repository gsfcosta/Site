<%
	'--------------------------------------------------------------------------------------------------------------------------
	' 태그, 파일 필터링 조건
	'--------------------------------------------------------------------------------------------------------------------------
	Dim tag_allow				: tag_allow				= "p,br"
	Dim file_allow			: file_allow			= "jpg,gif,png,bmp,hwp,doc"
	Dim file_deny				: file_deny				= "asp,php,perl"

	'--------------------------------------------------------------------------------------------------------------------------
	' SQL Injection 방지
	'--------------------------------------------------------------------------------------------------------------------------
	Function sql_filter(str)

		Dim str_search(6), str_replace(6), cnt, data

		' 필수 필터링 문자 리스트
		str_search(0) = "'"
		str_search(1) = """"
		str_search(2) = "\"
		str_search(3) = "#"
		str_search(4) = "--"
		str_search(5) = ";"

		' 변환될 필터 문자   
		str_replace(0) = ""
		str_replace(1) = """"""
		str_replace(2) = "\\"
		str_replace(3) = "\#"
		str_replace(4) = "\--"
		str_replace(5) = "\;"
		
		data = str

		For cnt = 0 to 5
			If Not(data = "" Or IsNull(data)) Then
				data = Replace(data, LCase(str_search(cnt)), str_replace(cnt))
			End If
		Next

		sql_filter = data

	End Function

	'--------------------------------------------------------------------------------------------------------------------------
	' 크로스스크립트 방지
	'--------------------------------------------------------------------------------------------------------------------------
	Function xss_filter(str, tag_allow)

		Dim tag_list, tags, data

		data = Trim(str)
		data = Replace(data, "<", "<")
		data = Replace(data, "\0", "")
		
		tag_allow = Replace(tag_allow, " ", "")

		If tag_allow <> "" Then
			tag_list = Split(tag_allow, ",")
			For Each tags In tag_list
				data = Replace(data, "<"& tags &" ", "<"& tags &" ", 1, -1, 1)
				data = Replace(data, "<"& tags &">", "<"& tags &">", 1, -1, 1)
				data = Replace(data, "</"& tags &" ", "</"& tags &" ", 1, -1, 1)
			Next
		End If
		
		xss_filter = data

	End Function
%>