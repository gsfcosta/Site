<%
Function byte_cut(strtxt, MaxLen)
	 
		DIM i, strLen, VarResult, Intcount, nVal
	 
		If Not(IsNull(strtxt) Or strtxt = "") Then

		strLen = Len(Trim(strtxt))
	 
		If strtxt = "" Then
				VarResult = ""
		Else
				For i = 1 To strLen
						
	 nVal = Asc(Mid(Trim(strtxt), i, 1))
						
	 If 0 >= nVal Then
								Intcount = Intcount + 2
						Else
								Intcount = Intcount + 1
						End If
	 
						If MaxLen < Intcount Then
								VarResult = VarResult + ".."
								Exit For
						End If
				VarResult = VarResult + Mid(Trim(strtxt), i, 1)
				Next
		End If

		byte_cut = VarResult

		End If

End Function

Function sql_filter(str)

	DIM temp_str
	temp_str = str
	temp_str = Replace(temp_str, "'", "")
	temp_str = Replace(temp_str, """", "\""")
	sql_filter = temp_str

End Function

Function html_filter(str)

	DIM temp_str
	temp_str = str
	temp_str = Replace(temp_str, "<", "&lt;")
	temp_str = Replace(temp_str, ">", "&gt;")
	temp_str = Replace(temp_str, "&", "&amp;")
	html_filter = temp_str

End Function

Function delete_blank(str)

	DIM temp_str
	temp_str = Replace(Trim(temp_str), " ", "")
	delete_blank = temp_str

End Function

Function format_datetime(format, intTimeStamp)

	DIM unUDate, A

	If Not(IsNumeric(intTimeStamp)) Then
		If IsDate(intTimeStamp) Then
			intTimeStamp = DateDiff("S", "01/01/1970 00:00:00", intTimeStamp)
		Else
			response.write "Date Invalid"
			Exit Function
		End If
	End If

	If intTimeStamp = 0 Then
		unUDate = Now()
	Else
		unUDate = DateAdd("s", intTimeStamp, "01/01/1970 00:00:00")
	End If
 
	unUDate = Trim(unUDate)

	DIM startM : startM = InStr(1, unUDate, "-", vbTextCompare) + 1
	DIM startD : startD = InStr(startM, unUDate, "-", vbTextCompare) + 1
	DIM startHour : startHour = InStr(startD, unUDate, " ", vbTextCompare) + 3
	DIM startMin : startMin = InStr(startHour, unUDate, ":", vbTextCompare) + 1
 
	DIM dateKorHour	: dateKorHour = Mid(unUDate, InStr(startD, unUDate, " ", vbTextCompare) + 1, 2)

	DIM dateYear : dateYear = Mid(unUDate, 1, 4)			 
	DIM dateMonth : dateMonth = Mid(unUDate, startM, 2)	
	DIM dateDay : dateDay = Mid(unUDate, startD, 2)	 
	DIM dateHour : dateHour = Mid(unUDate, startHour, 2)	 
	DIM dateMinute : dateMinute = Mid(unUDate, startMin, 2)	 
	DIM dateSecond : dateSecond = Mid(unUDate, InStr(startMin, unUDate, ":", vbTextCompare) + 1, 2)		 
 
	if InStr(1, format, "%h", vbTextCompare) <> 0 Or InStr(1, format, "%H", vbTextCompare) <> 0 Then
			 If dateHour < 10 Then
					 dateHour = "0" & Trim(dateHour)
			 End If
	End If
	If InStr(1, format, "%h", vbTextCompare) <> 0 Or InStr(1, format, "%g", vbTextCompare) <> 0 Then
			 If dateKorHour = "오후" Then
					 dateHour = CInt(dateHour) + 12
			 End If
	End If

	format = Replace(format, "%Y", Right(dateYear, 4))	
	format = Replace(format, "%y", Right(dateYear, 2)) 
	format = Replace(format, "%m", dateMonth) 
	format = Replace(format, "%n", CInt(dateMonth))	
	format = Replace(format, "%F", MonthName(CInt(dateMonth))) 
	format = Replace(format, "%M", Left(MonthName(CInt(dateMonth)), 3)) 
	format = Replace(format, "%E", MonthNameEng(CInt(dateMonth)))
	format = Replace(format, "%d", dateDay)	
	format = Replace(format, "%j", CInt(dateDay)) 
	format = Replace(format, "%h", dateHour)	
	format = Replace(format, "%g", dateHour)
	format = Replace(format, "%H", dateHour)
	format = Replace(format, "%G", dateHour)

	If CInt(dateHour) > 12 Then
		A = "PM"
	Else 
		A = "AM"
	End If

	format = Replace(format, "%A", A) 
	format = Replace(format, "%a", LCase(A))		 
	format = Replace(format, "%i", dateMinute) 
	format = Replace(format, "%I", CInt(dateMinute)) 
	format = Replace(format, "%s", dateSecond) 
	format = Replace(format, "%S", CInt(dateSecond)) 
	format = Replace(format, "%L", Weekday(unUDate)) 
	format = Replace(format, "%D", left(WeekDayName(Weekday(unUDate)), 3)) 
	format = Replace(format, "%l", WeekDayName(Weekday(unUDate))) 
	format = Replace(format, "%U", intTimeStamp) 
	format = Replace(format, "11%O", "11th") 
	format = Replace(format, "1%O", "1st") 
	format = Replace(format, "12%O", "12th") 
	format = Replace(format, "2%O", "2nd") 
	format = Replace(format, "13%O", "13th") 
	format = Replace(format, "3%O", "3rd") 
	format = Replace(format, "%O", "th")

	format_datetime = format

End Function

Function MonthNameEng( mon )

	Select Case mon
		Case 1
			MonthNameEng = "Jan"
		Case 2
			MonthNameEng = "Feb"
		Case 3
			MonthNameEng = "Mar"
		Case 4
			MonthNameEng = "Apr"
		Case 5
			MonthNameEng = "May"
		Case 6
			MonthNameEng = "June"
		Case 7
			MonthNameEng = "July"
		Case 8
			MonthNameEng = "Aug"
		Case 9
			MonthNameEng = "Sept"
		Case 10
			MonthNameEng = "Oct"
		Case 11
			MonthNameEng = "Nov"
		Case 12
			MonthNameEng = "Dec"
	End Select

End Function
%>