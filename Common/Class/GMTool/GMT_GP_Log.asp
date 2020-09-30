<!--#include virtual="/common/Function/option_explicit.asp"-->
<!--#include virtual="/Common/Function/db.asp"-->
<!--#include virtual="/Member/GM_login_ck.asp"-->

<%

	Dim SQL
	Dim MixDSN2		:	MixDSN2		= "MixMember"
	Dim MixComm, MixConn
	Dim arrRSMix, arrRSMixCnt, player_list, i


	Dim Page		:	Page		= Request("Page")
	Dim pagesize	:	pagesize	= Request("pagesize")

	Dim rServer		: 	rServer		= Request("Server")
	Dim s_gubun		:	s_gubun		= Request("s_gbn")
	Dim S_str		:	S_str		= unescape(Request("S_item"))
	Dim m_sort		:	m_sort		= Request("m_sort")
	Dim key			:	key			= Request("key")
	Dim P_month		:	P_month		= Request("P_month")
	Dim rPID		:	rPID 		= Request("Pid")
	Dim rPIDx		:	rPIDx 		= Request("Pidx")
	Dim rCK			:	rCK 		= Request("CK")

	Dim CNT			:	CNT			= 0
	Dim hero_order	: hero_order	=""
	Dim PG, w_str, O_fields, O_sort, Player, Player_id, charge_list
	

	'========================================================================
	''계정 목록 가져오기
	'========================================================================
	If key = "" Then 
		If pagesize = "" Then	pagesize =20	End If 
		If Page = "" Then Page = 0 Else Page = Page * pagesize	End If

		If  S_str <> "" Then
			Select Case s_gubun
				Case	"I"
					O_fields = "PlayerID"
				Case	"X"
					O_fields = "id_idx"
				Case	"N"
					O_fields = "Name"
				Case	"J"
					O_fields = "JuminNo"
			End Select
			if s_gubun = "C" Then
				SQL = "Select id_idx,hero_order, name From u_hero Where name = '"& S_str &"'"
				DBConnCommandMy MixComm, MixConn, rServer, SQL
				DBSelect2 MixComm, MixConn, arrRSMix, arrRSMixCnt
				If arrRSMixCnt > -1 Then
					For i = 0 To arrRSMixCnt Step 1
						if S_str = arrRSMix(2,i) Then
							w_str = " where id_idx = "& arrRSMix(0,i)
							hero_order =  arrRSMix(1,i)
						End if
					next
				Else 
					Response.Write "{""CNT"":0,""PG"":0,""PN"":1,""HO"":"""",""List"":[" & player_list & "]}"
					Response.End 
				End if
			ElseIf  s_gubun = "X" Then
				w_str = w_str & " where "& O_fields &" = "& S_str 
			Else
				w_str = w_str & " where "& O_fields &" = '"& S_str &"'"
			End if
		End If

		SQL = "select  count(id_idx) as cnt "
		SQL = SQL & " from Player " & w_str
		DBConnCommandMy MixComm, MixConn, MixDSN2, SQL
		DBSelect2 MixComm, MixConn, arrRSMix, arrRSMixCnt

		If arrRSMixCnt > -1 Then CNT = arrRSMix(0,0) End if
		
		SQL = "select id_idx, PlayerID, Name, JuminNo, Email, cast(LastLoginDate as char(16)), cast(RegDate as char(16)), Block from Member.Player "& w_str &" order by id_idx desc limit "&Page&", "&pagesize
		DBConnCommandMy MixComm, MixConn, MixDSN2, SQL
		DBSelect2 MixComm, MixConn, arrRSMix, arrRSMixCnt

		'Response.Write SQL

		If arrRSMixCnt > -1 Then
			For i = 0 To arrRSMixCnt Step 1
				player_list = player_list & "{""N1"":""" & arrRSMix(0,i) &""",""N2"":"""& arrRSMix(1,i) &""",""N3"":"""& arrRSMix(2,i) &""",""N4"":"""& arrRSMix(3,i) &""",""N5"":"""& arrRSMix(4,i) &""",""N6"":"""& arrRSMix(5,i)&""",""N7"":"""& arrRSMix(6,i)&""",""N8"":"""& escape(arrRSMix(7,i)) &"""}"
			
				If (i <> arrRSMixCnt) then
					player_list = player_list & ","
				End if
			Next
		Else
			player_list = ""
		End if
		PG = int(CLng(CNT)/ CLng(pagesize)) + 1
		If Page = 0 Then Page = 1 End if
		Response.Write "{""CNT"":"&CNT&",""PG"":"&PG&",""PN"":"&Page&",""HO"":"""& hero_order&""",""List"":[" & player_list & "]}" 
		Response.End
		
		
	'///// 	 아이디 체크		
	ElseIf key = "IDCK" Then  
		Response.Write id_check( S_str)
		Response.End
		
		
	'///// 	계정등록		
	ElseIf key = "NEW" Then
		Dim rtxtID			: rtxtID 		= Request("txtID")
		Dim rtxtName		: rtxtName		= Request("txtName")
		Dim rtxtPwd			: rtxtPwd		= Request("txtPwd")
		Dim rtxtSocialID	: rtxtSocialID	= Request("txtSocialID")
		Dim rtxtAccess		: rtxtAccess	= Request("txtAccess")
		
		Dim ID_Check_val 	: ID_Check_val 	= id_check( rtxtID )
		
		if Cint(ID_Check_val) <> 0 Then
			Response.Write "1001"	
			Response.End
		Else
			if rtxtAccess = "" Then
				rtxtAccess = "21"
			End if
			SQL = "Insert Into Member.Player"
			SQL = SQL & "(PlayerID,Passwd,Name,JuminNo,Access,ZipCode,RegDate, personal_auth) Values "
			SQL = SQL & "('"& rtxtID &"',PASSWORD('"&rtxtPwd&"') ,'"&rtxtName&"','"&rtxtSocialID&"',"&rtxtAccess&",'000-000',NOW(),'E') "
						
			DBExecuteMy MixDSN2, SQL
			Response.Write "0000"
			Response.End
			 
		End if
		
	ElseIf key = "REPW" Then	
		
		Dim q_PlayerID, q_Passwd
		
		If rCK = "1" Then
		
			
			SQL = " select Passwd from  Member.ChangePassword where id_idx = " & rPIDx
			DBConnCommandMy MixComm, MixConn, MixDSN2, SQL
			DBSelect2 MixComm, MixConn, arrRSMix, arrRSMixCnt
			
			q_Passwd 	= arrRSMix(0,0)
			if arrRSMix > -1 then
				SQL = " Update Member.Player Set Passwd = '"& q_Passwd &"' where id_idx = " & rPIDx
			'	Response.Write SQL
				DBExecuteMy MixDSN2, SQL
				
				SQL = " Delete From Member.ChangePassword where id_idx = " & rPIDx
			'	Response.Write SQL
				DBExecuteMy MixDSN2, SQL
			End if
			Response.End
		
		ElseIf rCK = "2" Then
			
			
			SQL = " Select PlayerID, Passwd From Member.Player where id_idx = " & rPIDx
			DBConnCommandMy MixComm, MixConn, MixDSN2, SQL
			DBSelect2 MixComm, MixConn, arrRSMix, arrRSMixCnt
			
			q_PlayerID	= arrRSMix(0,0)
			q_Passwd 	= arrRSMix(1,0)
			q_Passwd 	= arrRSMix(0,0)
			if arrRSMix > -1 then
			SQL = " Insert INTO Member.ChangePassword (AdminID, id_idx, PlayerID, Passwd, RegDate) Values ('"& admin_id &"', "& rPIDx &", '"& q_PlayerID&"', '"&q_Passwd&"' , NOW() )"
			'Response.Write SQL
			DBExecuteMy MixDSN2, SQL
			
			SQL = " Update Member.Player Set Passwd = password('mixmaster') where id_idx = " & rPIDx
			'Response.Write SQL
			DBExecuteMy MixDSN2, SQL
			End if
			Response.End
		
		Else
			Response.Write "error"
			Response.End 
		End if
	ElseIf key = "PLSP" Then
		
		Dim Block_M , Block_Date
		
		If rCK = "1" Then
			Block_M = "SECEDER"
			Block_Date = "NOW()"
		Else
			Block_M = "ALLOW"
			Block_Date = "''"
		End if
	
		SQL = " UPDATE Member.Player SET Block = '"& Block_M &"', SecederDate = "& Block_Date &" WHERE PlayerID = '"& rPID &"' AND id_idx = "&rPIDx
		
		'Response.Write SQL
		DBExecuteMy MixDSN2, SQL
		Response.End
	
	ElseIf key ="PLMOD" Then
		Dim rid_idx			: rid_idx 		= Request("id_idx") 
		Dim rPlayer_id		: rPlayer_id 	= Request("Player_id")
		Dim rPname			: rPname		= Request("Pname")
		Dim rsex			: rsex			= Request("sex")
		Dim rPjumin			: rPjumin		= Request("Pjumin")
		Dim rPyear			: rPyear		= Request("Pyear")
		Dim rPmonth			: rPmonth		= Request("Pmonth")
		Dim rPday			: rPday			= Request("Pday")
		Dim rPemail			: rPemail		= Request("Pemail")
		Dim rPpwrost		: rPpwrost		= Request("Ppwrost")
		Dim rPpw_lost_ans	: rPpw_lost_ans	= Request("Ppw_lost_ans")
		Dim rPzipcode		: rPzipcode		= Request("Pzipcode")
		Dim rPaddress1		: rPaddress1	= Request("Paddress1")
		Dim rPaddress2		: rPaddress2	= Request("Paddress2")
		Dim rPlevel			: rPlevel		= Request("Plevel")
		Dim rPnewletter		: rPnewletter	= Request("Pnewletter")
		Dim rPjob			: rPjob			= Request("Pjob")
		Dim rPtel1			: rPtel1		= Request("Ptel1")
		Dim rPtel2			: rPtel2		= Request("Ptel2")
		Dim rPtel3			: rPtel3		= Request("Ptel3")
		Dim rPpon1			: rPpon1		= Request("Ppon1")
		Dim rPpon2			: rPpon2		= Request("Ppon2")
		Dim rPpon3			: rPpon3		= Request("Ppon3")
		Dim rPpname			: rPpname		= Request("Ppname")
		Dim rPpjumin		: rPpjumin		= Request("Ppjumin")
		Dim rPptel1			: rPptel1		= Request("Pptel1")
		Dim rPptel2			: rPptel2		= Request("Pptel2")
		Dim rPptel3			: rPptel3		= Request("Pptel3")
		
		Dim A_Address 		: A_Address 	= ""
		Dim Address			: Address		= ""
		Dim AddressDO		: AddressDO		= ""
		Dim AddressSI		: AddressSI		= ""
		Dim AddressDong		: AddressDong	= ""
		
		A_Address = Split(rPaddress1, " ")
		
		If (uBound(A_Address) = 3) Then
			AddressDO	= A_Address(0)
			AddressSI	= A_Address(1) & " " &  A_Address(2)
			AddressDong	= A_Address(3)
			
			Address		= AddressDO  & " " &  AddressSI  & " " &  AddressDong  & " " & rPaddress2
		Elseif (uBound(A_Address) = 2) Then
			AddressDO	= A_Address(0)
			AddressSI	= A_Address(1)
			AddressDong	= A_Address(2)
			
			Address		= AddressDO  & " " &  AddressSI  & " " &  AddressDong  & " " & rPaddress2
		Else
			Address		= AddressDO  & " " &  AddressSI  & " " &  AddressDong  & " " & rPaddress2
		End if
		
		SQL = " Update Member.Player SET "
		SQL = SQL &" PlayerID = '"& rPlayer_id &"', "
		SQL = SQL &" Name = '"&rPname&"', "
		SQL = SQL &" JuminNo = '"&rPjumin&"', "
		SQL = SQL &" Sex = '"&rsex&"', " & VbCrLf
		SQL = SQL &" nYear ='"&rPyear&"', "
		SQL = SQL &" nMonth = '"&rPmonth&"', "
		SQL = SQL &" nDay = '"&rPday&"', " & VbCrLf
		SQL = SQL &" Email = '"&rPemail&"', "
		SQL = SQL &" Passwd_Q = '"&rPpwrost&"', "
		SQL = SQL &" Passwd_A = '"&rPpw_lost_ans&"', "& VbCrLf
		SQL = SQL &" ZipCode = '"&rPzipcode&"', "
		SQL = SQL &" AddressDo = '"&AddressDO&"', "
		SQL = SQL &" AddressSi = '"&AddressSI&"', "
		SQL = SQL &" AddressDong = '"&AddressDong&"', "& VbCrLf
		SQL = SQL &" AddressEtc = '"&rPaddress2&"', "
		SQL = SQL &" Address = '"&trim(Address)&"', "& VbCrLf
		SQL = SQL &" Access = "&rPlevel&", "
		SQL = SQL &" NewsLetter = '"&rPnewletter&"', "
		SQL = SQL &" JobType = '"&rPjob&"', " & VbCrLf
		SQL = SQL &" TelePhone1 = '"&rPtel1&"', "
		SQL = SQL &" TelePhone2 = '"&rPtel2&"', "
		SQL = SQL &" TelePhone3 = '"&rPtel3&"', "& VbCrLf
		SQL = SQL &" CPhone1 = '"&rPpon1&"', "
		SQL = SQL &" CPhone2 = '"&rPpon2&"', "
		SQL = SQL &" CPhone3 = '"&rPpon3&"', "& VbCrLf
		SQL = SQL &" ParentName = '"&rPpname&"', "
		SQL = SQL &" ParentJuminNo = '"&rPpjumin&"', "& VbCrLf
		SQL = SQL &" ParentPhone1 = '"&rPptel1&"', "
		SQL = SQL &" ParentPhone2 = '"&rPptel2&"', "
		SQL = SQL &" ParentPhone3 = '"&rPptel3&"' "& VbCrLf
		SQL = SQL &" Where id_idx = "& rid_idx
		
		'Response.Write SQL
		DBExecuteMy MixDSN2, SQL
	ElseIf key ="ZIPCODE" Then
		
		Dim txt_zipSearch : txt_zipSearch = unescape(Request("txt_zipSearch"))
		Dim Full_Address
		
		SQL = "Select code, CONCAT(sido,' ',gugun ,' ', dong, ' ', ri), st_bunji, ed_bunji from Web_Logs.Zipcode Where dong like '"& txt_zipSearch &"%'"
		'Response.Write SQL
		DBConnCommandMy MixComm, MixConn, MixDSN2, SQL
		DBSelect2 MixComm, MixConn, arrRSMix, arrRSMixCnt
		If arrRSMixCnt > -1 Then
			For i = 0 To arrRSMixCnt Step 1 
				If  (trim(arrRSMix(2,i)) = "") Then
					Full_Address = arrRSMix(1,i)
				ElseIf (trim(arrRSMix(3,i)) = "") Then
					Full_Address = arrRSMix(1,i) & " " & arrRSMix(2,i) 
				Else
					Full_Address = arrRSMix(1,i) & " " & arrRSMix(2,i)& "-" & arrRSMix(3,i) 
				End If
				
				player_list = player_list & "{""N1"":""" & escape(arrRSMix(0,i)) &""",""N2"":"""& escape(arrRSMix(1,i)) &""",""N3"":"""& escape(Full_Address)  &"""}"
			
				If (i <> arrRSMixCnt) then
					player_list = player_list & ","
				End if
			Next
		Else
			player_list = ""
		End if
		
		Response.Write "{""List"":[" & player_list & "]}" 
		Response.End
		
		
	End If 
		'///// 	 아이디 체크	함수
	Function id_check(id)
	
		SQL = "select  count(id_idx) as cnt "
		SQL = SQL & " from Member.Player where PlayerID = '"& id &"'"
		DBConnCommandMy MixComm, MixConn, MixDSN2, SQL
		DBSelect2 MixComm, MixConn, arrRSMix, arrRSMixCnt
	
		id_check = arrRSMix(0,0)
		
	End Function

	
%>
