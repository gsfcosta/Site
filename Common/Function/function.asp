<%


	Rem ////////// 날짜출력 함수
	Public Function DateFormat(ByVal dateStr, ByVal dType)
		Dim yyyy, MM, dd, hh, mn, ss, dddd, tt
		Dim yy, M, d, h, n, s, ddd, t
		Dim strDate
		Dim dateType,returnStr

		If Not IsDate(dateStr) Or dateStr="" Then strDate = Now Else strDate = dateStr
		If dType="" Then dateType = "yyyy-MM-dd" Else dateType = dType

		yy = Year(strDate)
		M = Month(strDate)
		d = Day(strDate)
		h = Hour(strDate)
		n = Minute(strDate)
		s = Second(strDate)
		ddd = WeekDayName(DatePart("w",strDate))
		t = TimeValue(strDate)
		t = Mid(t,1,InStr(t," "))

		If InStr(dateType,"dddd")>0 Then dddd = ddd Else dddd = Left(ddd,1)
		If InStr(dateType,"yyyy")>0 Then yyyy = yy Else yyyy = Right(yy,2)
		If InStr(dateType,"MM")>0 Then
			If Len(M)<2 Then MM = "0" & M Else MM = M
		Else
			MM = M
		End If
		If InStr(dateType,"dd")>0 Then
			If Len(d)<2 Then dd = "0" & d Else dd = d
		Else
			dd = d
		End If
		If InStr(dateType,"tt")>0 Or InStr(dateType," t") Then
			If h > 12 Then h = h - 12
		End If
		If InStr(dateType,"hh")>0 Then
			If Len(h) < 2 Then hh= "0" & h Else hh = h
		Else
			hh = h
		End If
		If InStr(dateType,"mm")>0 Then
			If Len(n)<2 Then mn= "0" & n Else mn = n
		Else
			mn = n
		End If
		If InStr(dateType,"ss")>0 Then
			If Len(s) < 2 Then ss= "0" & s Else ss = s
		Else
			ss = s
		End If
		If InStr(dateType,"tt") > 0 Then tt = t Else tt = Left(t,1)

		returnStr = dateType
		returnStr = Replace(returnStr, "dddd", dddd)
		returnStr = Replace(returnStr, "ddd", dddd)
		returnStr = Replace(returnStr, "yyyy", yyyy)
		returnStr = Replace(returnStr, "yy", yyyy)
		returnStr = Replace(returnStr, "MM", MM)
		returnStr = Replace(returnStr, "M", MM)
		returnStr = Replace(returnStr, "dd", dd)
		returnStr = Replace(returnStr, "d", dd)
		returnStr = Replace(returnStr, "tt", tt)
		returnStr = Replace(returnStr, "t", tt)
		returnStr = Replace(returnStr, "hh", hh)
		returnStr = Replace(returnStr, "h", hh)
		returnStr = Replace(returnStr, "mm", mn)
		returnStr = Replace(returnStr, "m", mn)
		returnStr = Replace(returnStr, "ss", ss)
		returnStr = Replace(returnStr, "s", ss)

		DateFormat = returnStr
	End Function

		Rem ////////// 메시지키를 검색해서 내용을 리턴하는 함수
	Function MsgReturn(ByVal ptrn, ByVal str, ByVal brk)
		Dim regEx, Matches
		Dim bracket

		Set regEx = New RegExp
		regEx.IgnoreCase = False
		regEx.Global = True

		If brk="" Then brk = "(,)"
		bracket = Split(brk, ",")

		regEx.Pattern = "(" & ptrn & ")(.*)(\" & bracket(0) & ")(.*)(\" & bracket(1) & ")" '//해당 문자열과 앞뒤가 지정된 문자로 묶여 있는 문자열 찾기

		'//정규식 실행
		Set Matches = regEx.Execute(str)
	 
		If Matches.Count>0 Then
			MsgReturn = Matches(0).SubMatches(3) '//묶인 내용만 리턴
		Else
			MsgReturn = "Null String."
		End If
	End Function


	Rem ////////// MsgReturn함수에서 검색된 메시지를 추출하는 함수
	Public Function MsgExtract(ByVal msgkey)
		'//전역 개체 확인
		Dim LangFile,strLang
		If Not IsObject(LangFile) Or IsEmpty(lang) Then
			'//에러메시지 및 알림메시지 언어파일 로드
			Set LangFile = fsc.OpenTextFile(Server.MapPath("/common/Language/" & lang &"_"& Now_Position & ".asp"), 1, False)
			strLang = LangFile.ReadAll
		End If
		MsgExtract = Trim(MsgReturn(msgkey, strLang, ":," & VbCrLf))
	End Function
	 
	
	Private sub Server_Select
	
		dim obj_Server
		Set obj_Server = JSON.parse (Server_List)
		dim i
		Response.Write "<select name='Server'>"& VbCrLf
		For i = 0  to obj_Server.length-1
			
			Response.Write "<option value='"& trim(obj_Server.get(i).N2) & "'>"
			Response.Write ucword(obj_Server.get(i).N2)& "</option>"& VbCrLf
		Next
		Response.Write"</select>"& VbCrLf
	
	end Sub
	
	
	Private sub Server_Tab(str)
	
		dim obj_Server
		Set obj_Server = JSON.parse (Server_List)
		Dim Tabs_Ui
		Dim i
		Dim Tab_URL
		
	
		Tabs_Ui  = Tabs_Ui & "								<ul>"& VbCrLf
		
		For i = 0  to obj_Server.length-1
			If str = "NONE" Then
				Tab_URL = "#NONE"
			Else
				Tab_URL = "#"& trim(obj_Server.get(i).N2)
			End If
			Tabs_Ui  = Tabs_Ui & "									<li><a href='"&Tab_URL&"'>"& ucword(obj_Server.get(i).N2)&"<span id='tab_"& obj_Server.get(i).N2 &"'>[0]</span></a></li> "& VbCrLf
		Next
		Tabs_Ui  = Tabs_Ui & "								</ul>"
		Response.Write Tabs_Ui & VbCrLf
	
	end Sub
	
	Function ucword(str)
	  ucword = UCase(Left(str, 1)) & Lcase(Right(str, Len(str)-1))
	End Function 

	
	'////////////////////////////////
	'//// 문자열 관련 함수들
	'////////////////////////////////
	'--------------------------------
	'-- 문자열 길이 바이트로 추출 (SubstringK 함수 에서 사용)
	'-- Use : 문자열 길이 = HLen (스트링)
	'--------------------------------
	Function HLen(byval str)
		Dim nIndex, nLen
		For nIndex = 1 To Len(str)
			If Asc(Mid(str, nIndex, 1)) < 0 Then
				nLen = nLen + 2
			Else
				nLen = nLen + 1
			End If
		Next
		str = ""
		HLen = nLen
	End Function

	'--------------------------------
	'-- 문자열을 바이트로 계산하여 자르기 (SubstringK 함수 에서 사용)
	'-- Use : 잘린 문자열 = HMid (스트링, 처음 바이트, 자를길이)
	'--------------------------------
	Function HMid(byval sSourceStr, byval sStartPosition, byval nLength)
		Dim nIndex, nLen, sResult
		If Not IsNull( sSourceStr ) Then
			For nIndex = 1 To Len(sSourceStr)
				If Asc(Mid(sSourceStr, nIndex, 1)) < 0 Then
					nLen = nLen + 2
				Else
					nLen = nLen + 1
				End If

				If (nLen >= sStartPosition) And (nLen <= sStartPosition + nLength - 1) Then
					sResult = sResult + Mid(sSourceStr, nIndex, 1)
				End If
			Next
			sSourceStr = ""
			HMid = sResult
		Else
			HMid = ""
		End If
	End Function

	'--------------------------------
	'-- 문자열을 바이트로 계산하여 자르기 (뒤에 .. 붙임)
	'-- Use : 잘린 문자열 = SubstringK (스트링, 자를길이)
	'--------------------------------
	Function SubstringK (sStr, nLen)
		Dim sResult
		If nLen > 0 Then
			If sStr <> "" Then
				If HLen(sStr) > nLen Then
					sResult = HMid(sStr, 1, nLen) & ".."
				Else
					sResult = sStr
				End If
			Else
				sResult = sStr
			End If
		End If

		SubstringK = sResult
	End Function


	'--------------------------------
	'-- Left Padding (1234 -> 00001234)
	'-- Use : 패딩된문자열 = LPad (문자열, 전체길이, 채울문자)
	'--------------------------------
	Function LPad (psStr, pnTotalLen, pcPadChar)
		Dim sTempStr, sResult
		Dim PadLength

		If pnTotalLen - Len(CStr (psStr)) <= 0 Then
			PadLength = 0
		Else
			PadLength = pnTotalLen - Len(CStr (psStr))
		End If

		If psStr <> "" And Not IsEmpty(psStr) And Not IsNull (psStr) Then
			sResult = String(PadLength, CStr(pcPadChar)) & psStr
		End If

		LPad = sResult
	End Function

	'--------------------------------
	'-- Right Padding (1234 -> 12340000)
	'-- Use : 패딩된문자열 = RPad (문자열, 전체길이, 채울문자)
	'--------------------------------
	Function RPad (psStr, pnTotalLen, pcPadChar)
		Dim sTempStr, sResult
		Dim PadLength

		If pnTotalLen - Len(CStr (psStr)) <= 0 Then
			PadLength = 0
		Else
			PadLength = pnTotalLen - Len(CStr (psStr))
		End If

		If psStr <> "" And Not IsEmpty(psStr) And Not IsNull (psStr) Then
			sResult = psStr & String(PadLength, CStr(pcPadChar))
		End If

		RPad = sResult
	End Function

	'--------------------------------
	'-- 알파벳으로된 문자열인지 검사
	'-- Use : T/F = isAlpha (문자열)
	'--------------------------------
	Function isAlpha(ByVal str)
		dim i
		dim ch
		dim result

		result = true

		for i = 1 to len(str)
			ch = mid(str, i, 1)

			if not ((strComp(ch, "A") >= 0 and strComp(ch, "Z") <= 0) or (strComp(ch, "a") >= 0 and strComp(ch, "z"))) then
				result = false

				i = len(str) + 1
			end if
		next

		isLowerAlphaNumeric = result
	End Function


	'--------------------------------
	'-- 캐리지리턴을 <br> 태그로 변환
	'-- Use : 변환된문자열 = nl2br (변환할 문자열)
	'--------------------------------
	Function nl2br(Expression)
		If Expression <> "" Then
			nl2br = Replace(Expression, VBCRLF, "<BR>")
		End If
	End Function

	'--------------------------------
	'-- Text <-> HTML 변환
	'-- Use : 변환된문자열 = HtmlSpecialChars(변환할 문자열, 변환포맷)
	'--------------------------------
	Function HtmlSpecialChars(Expression, NamedFormat)
		If Not IsNULL (Expression) Or Expression <> "" Then
			Select Case NamedFormat
			Case "TEXT"
				Expression = Replace(Expression, "&lt;"  , "<")
				Expression = Replace(Expression, "&gt;"  , ">")
				Expression = Replace(Expression, "&amp;" , "&")
				Expression = Replace(Expression, "&quot;", "&#034;")
				Expression = Replace(Expression, """"    , "&#034;")
				Expression = Replace(Expression, "'"     , "&#039;")
			Case "HTML"
				Expression = Replace(Expression, "  "    , "&nbsp;&nbsp;")
				Expression = Replace(Expression, "<"     , "&lt;")
				Expression = Replace(Expression, ">"     , "&gt;")
				Expression = Replace(Expression, "&"     , "&amp;")
				Expression = Replace(Expression, """"    , "&#034;")
				Expression = Replace(Expression, "'"     , "&#039;")
			Case "CODE"
				Expression = Replace(Expression, "&#034;", """")
				Expression = Replace(Expression, "&#039;", "'")
			Case "SQL"
				Expression = Replace(Expression, "'"	 , "''")
				Expression = Replace(Expression, "\"	 , "\\")
				Expression = Replace(Expression, "''''"	 , "''")
				Expression = Replace(Expression, "\\\\"	 , "\\")
			End Select
		End If

		HtmlSpecialChars = Expression
	End Function

	' --------------------------------------------------------
	' Function Name : regular_replace
	' Description : 정규표현식을 이용한 대치
	' --------------------------------------------------------
	Function eregi_replace(pattern, replace, text)
		Dim eregObj

		If text <> "" Then
			Set eregObj= New RegExp

			eregObj.Pattern= pattern ' Set Pattern(패턴 설정)
			eregObj.IgnoreCase = True ' Set Case Insensitivity(대소문자 구분 여부)
			eregObj.Global= True ' Set All Replace(전체 문서에서 검색)
			eregi_replace = eregObj.Replace(text, replace) ' Replace String
		End If
	End Function

	'--------------------------------
	'-- NVL 함수 (Expression 값이 Null 일경우 ReplaceWith 값으로 변환, Default 기본값)
	'-- Use : 문자열 = NVL (입력문자열, NULL 일 경우 변환된 문자열, 기본값)
	'--------------------------------
	Function NVL(Expression, ReplaceWith, Default)
		If IsNull(Expression) Or IsEmpty(Expression) Or Expression = "" Then
			NVL = ReplaceWith
		ElseIf IsNull(Default) Then
			NVL = Expression
		Else
			NVL = Default
		End If
	End Function


	'--------------------------------
	'-- 사내 IP 체크 (어드민 혹은 사내로만 검사할 일이 있을때)
	'-- Use : T/F = AuroraIPCheck
	'--------------------------------
	Function AuroraIPCheck ()
		If Left (REMOTE_ADDR, 12) = "220.117.218." Then
			AuroraIPCheck = True
		Else
			AuroraIPCheck = False
		End If
	End Function

	'--------------------------------
	'-- URL Decode 함수
	'-- Use : ReturnSTR = URLDecode (OriginalStr)
	'--------------------------------
	Function URLDecode(Expression)
		Dim strSource, strTemp, strResult, strchr
		Dim lngPos, AddNum, IFKor
		strSource = Replace(Expression, "+", " ")
		For lngPos = 1 To Len(strSource)
			AddNum  = 2
			strTemp = Mid(strSource, lngPos, 1)
			If strTemp = "%" Then
				If lngPos + AddNum < Len(strSource) + 1 Then
					strchr = CInt("&H" & Mid(strSource, lngPos + 1, AddNum))
					If strchr > 130 Then
						AddNum = 5
						IFKor = Mid(strSource, lngPos + 1, AddNum)
						IFKor = Replace(IFKor, "%", "")
						strchr = CInt("&H" & IFKor )
					End If
					strResult = strResult & Chr(strchr)
					lngPos    = lngPos + AddNum
				End If
			Else
				strResult = strResult & strTemp
			End If
		Next
		URLDecode = strResult
	End Function

	'////////////////////////////////
	'//// 페이징 관련 함수들
	'////////////////////////////////
	'--------------------------------
	'-- Unsigned 숫자인가? (주로 페이지 번호)
	'-- Use : 페이지번호 = IsUnsigned (확인문자열)
	'--------------------------------
	Function IsUnsigned (pnStr)
		Dim rtnNumber

		rtnNumber = pnStr

		If IsNull(rtnNumber) Or IsEmpty(rtnNumber) Or rtnNumber = "" Then rtnNumber = 1
		If Not IsNumeric (rtnNumber) Then rtnNumber = 1
		If CDbl (rtnNumber) < 0 Then rtnNumber = 1

		IsUnsigned = rtnNumber
	End Function

	'////////////////////////////////
	'//// 페이징 관련 함수들
	'////////////////////////////////
	'--------------------------------
	'-- 0이상의 숫자인가? (인덱스 번호 체크)
	'-- Use : 인덱스 번호 = IsNumericZero (확인문자열)
	'--------------------------------
	Function IsNumericZero (pnStr)
		Dim rtnNumber

		rtnNumber = pnStr

		If IsNull(rtnNumber) Or IsEmpty(rtnNumber) Or rtnNumber = "" Then rtnNumber = 0
		If Not IsNumeric (rtnNumber) Then rtnNumber = 0
		If CDbl (rtnNumber) < 0 Then rtnNumber = 0

		IsNumericZero = rtnNumber
	End Function

	'--------------------------------
	'-- 총 페이지 수 구하기
	'-- Use : 전체페이지수 = GetTotalPage (전체 레코드 개수, 한화면의 리스트 개수)
	'--------------------------------
	Function GetTotalPage (pnTotalCnt, pnPageSize)
		Dim nTotPage

		If Clng(pnTotalCnt) > 0 And CLng(pnPageSize) > 0 Then
			IF ((pnTotalCnt Mod pnPageSize) = 0) Then
				nTotPage = Fix(pnTotalCnt / pnPageSize)
			Else
				nTotPage = Fix(pnTotalCnt / pnPageSize) + 1
			End If
		End If

		GetTotalPage = nTotPage
	End Function

	'--------------------------------
	'-- 하단의 페이징 블럭의 시작/끝 번호 구하기
	'-- Use : 페이징번호 = GetPageNum (받아온페이지번호 , 한화면의 리스트 개수 , 하단에 보여질 페이징 개수 , 타입)
	'--------------------------------
	Function GetPageNum (pnPageNo, pnViewPageNum, psType)
		Dim prev_block_start

		If psType = "N" Then				'// 다음 블럭 페이지 시작
			GetPageNum = ((Fix((pnPageNo - 1) / pnViewPageNum) + 1) * pnViewPageNum) + 1

		ElseIf psType = "P" Then			'// 이전 블럭 페이지 시작
'			prev_block_start = (Fix (((pnPageNo - 1) / pnViewPageNum) - 1) * pnViewPageNum) + 1
			prev_block_start = (Int (( pnPageNo - 1 ) / pnViewPageNum ) * pnViewPageNum + 1) - pnViewPageNum
			If prev_block_start < 1 Then
				prev_block_start = 1
			End If
			GetPageNum = prev_block_start
		End If
	End Function

	'////////////////////////////////
	'//// 메일링 관련 함수들
	'////////////////////////////////
	'--------------------------------
	'-- 메일 보내기 (2000 서버용)
	'-- Use : sendMail (받는메일, 제목, 메세지, 보내는메일)
	'--------------------------------
	Function sendMail(tomail, subject, message, from)
		Set objMAIL = Server.CreateObject("CDONTS.Newmail")

		objMAIL.To			= tomail
		objMAIL.From		= from
		objMAIL.Subject		= subject
		objMAIL.Body		= message
		objMAIL.BodyFormat	= 0
		objMAIL.MailFormat	= 0
		objMAIL.Send

		Set objMAIL = Nothing
		sendMail = True
	End Function

	'--------------------------------
	'-- 메일 보내기 (2003 서버용)
	'-- Use : sendMail3 (받는메일, 제목, 메세지, 보내는메일)
	'--------------------------------
	Function sendMail3(tomail, subject, message, from)
		Dim iMsg
		Dim iConf
		Dim Flds
		Const cdoSendUsingPickup = 1

		Set iMsg	= CreateObject("CDO.Message")
		Set iConf	= CreateObject("CDO.Configuration")

		'set the CDOSYS configuration fields to use the SMTP service pickup directory
		Set Flds	= iConf.Fields
		With Flds
			.Item("http://schemas.microsoft.com/cdo/configuration/sendusing") = cdoSendUsingPickup
			.Item("http://schemas.microsoft.com/cdo/configuration/smtpserverpickupdirectory") = "c:\inetpub\mailroot\pickup"
			.Update
		End With

		With iMsg
			Set .Configuration	= iConf
			    .To				= tomail
			    .From			= from
			    .Subject		= subject
			    .HTMLBody		= message
			    .Send
		End With

		Set iMsg	= Nothing
		Set iConf	= Nothing
		Set Flds	= Nothing
		sendMail3	= True
	End Function


	'////////////////////////////////
	'//// 기타
	'////////////////////////////////
	'--------------------------------
	'-- 페이지의 No-Cache 선언
	'-- Use : PageNoCache()
	'--------------------------------
	Sub PageNoCache()
		Response.CacheControl = "no-cache"
		Response.Expires = 0
		Response.Expiresabsolute = Now() - 1
		Response.AddHeader "pragma","no-cache"
		Response.AddHeader "cache-control","private"
	End Sub

	'--------------------------------
	'-- AJAX/AHAH 를 위하여 페이지 속성을 EUC-KR 로 변경
	'-- Use : PageNoCache()
	'--------------------------------
	Sub PageCharSetEucKr ()
		Response.Expires = -1
		Response.ContentType = "text/html"
		Response.CharSet = "euc-kr"
	End Sub

	'--------------------------------
	'-- 에러메시지를 alert로 출력 후 행동 코드에 따라 행동의 내용을 담은 자바스크립트를 작성 (액션코드 없으면 걍 에러메세지만 출력)
	'-- Use : ErrorMessage (에러메세지, 액션코드, AHAH코드)
	'--------------------------------
	Sub ErrorMessage (ErrorMsg, ActCode, AHAHCode)
		Response.Write	"<script language=""javascript"">"  & VBCRLF &_
						"<!--"  & VBCRLF
		if ErrorMsg <> "" Then
			Response.Write	"alert('"& ErrorMsg &"');"  & VBCRLF
		End If

		If ActCode <> "" Then
			Select Case ActCode
				Case "BACK" :
					Response.Write "history.back();" & VBCRLF
				Case "CLOSE" :
					Response.Write "window.close();" & VBCRLF
				Case "AHAH" :
					Response.Write AHAHCode & VBCRLF
				Case "STOP" :
					Response.Write ""  & VBCRLF
				Case Else
					Response.Write "window.location.href = '"& ActCode &"';"  & VBCRLF
			End Select
		End If

		Response.Write	"-->"  & VBCRLF &_
						"</script>"
		Response.End

	End Sub

	'--------------------------------
	'-- List Paging
	'--------------------------------
	Sub paging

		Dim page_first	:	page_first	= Int (( rpage - 1 ) / page_block ) * page_block + 1
		Dim page_last	:	page_last	= GetTotalPage (total_cnt, page_size)
		Dim prev_block	:	prev_block	= GetPageNum (rpage, page_block, "P")
		Dim next_block	:	next_block	= GetPageNum (rpage, page_block, "N")

		Dim i, page_num, page_prev, page_next

		If CInt (page_first) > CInt (page_block) Then
			page_prev = "<a href=""javascript:paging(1)""><img src=""/images/btn/btn_prev.gif"" alt=""10칸 이전으로"" /></a>" & VBCRLF
			page_prev = page_prev & "<a href=""javascript:paging("& prev_block &")"" class=""first"">이전</a>" & VBCRLF
		Else
			page_prev = "<a href=""#""><img src=""/images/btn/btn_prev.gif"" alt=""10칸 이전으로"" /></a>" & VBCRLF
			page_prev = page_prev & "<a href=""#"" class=""first"">이전</a>" & VBCRLF
		End If

		For i = 0 To (page_block - 1)
			If CInt (page_first + i) > CInt (page_cnt) Then Exit For

			If CInt (rpage) = CInt (page_first + i) Then
				page_num = page_num & "<a href=""#"" class=""on"">" & page_first + i & "</a>" & VBCRLF
			Else
				page_num = page_num & "<a href=""javascript:paging(" & page_first + i & ")"">" & page_first + i & "</a>" & VBCRLF
			End If
		Next

		If CInt (page_first + page_block - 1) < CInt (page_cnt) Then
			page_next = "<a href=""javascript:paging(" & page_first + page_block & ")"" class=""last"">다음</a>" & VBCRLF
			page_next = page_next & "<a href=""javascript:paging(" & page_last & ")""><img src=""/images/btn/btn_next.gif"" alt=""10칸 다음으로"" /></a>" & VBCRLF
		Else
			page_next = "<a href=""#"" class=""last"">다음</a>" & VBCRLF
			page_next = page_next & "<a href=""#""><img src=""/images/btn/btn_next.gif"" alt=""10칸 다음으로"" /></a>" & VBCRLF
		End If

		page_num = "<div id=""paging"">" & page_prev & page_num & page_next & "</div>"
		Response.Write page_num

	End Sub
	Function putZero(str)
		if Cint(str) < 10 Then
			putZero = "0" & str
		Else
			putZero = str
		End if
	End Function
%>