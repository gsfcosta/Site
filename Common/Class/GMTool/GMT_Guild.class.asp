<!--#include virtual="/common/Function/option_explicit.asp"-->
<!--#include virtual="/Common/Function/db.asp"-->
<!--#include virtual="/Member/GM_login_ck.asp"-->

<%

	Dim Page		:	Page		= Request("Page")
	Dim pagesize	:	pagesize	= Request("pagesize")
	Dim rServer 	:	rServer		= Request("Server")
	Dim s_gubun		:	s_gubun		= Request("s_gbn")
	Dim S_str		:	S_str		= unescape(Request("S_item"))
	Dim key			:	key			= Request("key")
	Dim rid_idx		:	rid_idx		= trim(Request("id_idx"))
	Dim rSocket		: 	rSocket		= trim(Request("Socket"))
	Dim CNT			:	CNT			= 0
	Dim Guild_Code	:	Guild_Code	= Request("Guild_code")
	Dim SQL
	Dim MixDSN2		:	MixDSN2		= rServer
	Dim MixDSN3		:	MixDSN3		= "MixMember"
	Dim MixComm, MixConn
	Dim arrRSMix, arrRSMixCnt, player_list, i
	Dim pMixComm, pMixConn
	Dim parrRSMix, parrRSMixCnt
	
	Dim PG, w_str1, w_str2, Player, Player_id, charge_list,q_Player, q_id_idx, q_Block
	

	'========================================================================
	''Guild 목록 가져오기
	'========================================================================
	If key = "" Then 

		If pagesize = "" Then	pagesize =20	End If 
		If Page = "" Then Page = 0 Else Page = Page * pagesize	End If
		
		If  S_str <> "" Then
			Select Case s_gubun
				Case	"G"
					w_str1 = w_str1 & " where name = '"& S_str &"'"
					w_str2 = w_str2 & " And a.name = '"& S_str &"'"
			End Select
			
		End If

		SQL = "select  count(GuildIdx) as cnt "
		SQL = SQL & " from u_guild " & w_str1
		
		DBConnCommandMy MixComm, MixConn, MixDSN2, SQL
		DBSelect2 MixComm, MixConn, arrRSMix, arrRSMixCnt

		If arrRSMixCnt > -1 Then CNT = arrRSMix(0,0) End if
		
		
		SQL = "Select "
		SQL = SQL & "	a.GuildIdx, a.Name, d.CNT, a.gold, c.name, c.hero_type, "  
		SQL = SQL & "	cast(a.EstablishDate as char(16)), cast(a.MarkRegDate as char(16)), a.MarkRegCnt, c.id_idx, c.hero_order "
		SQL = SQL & " From  "
		SQL = SQL & "	u_guild as a left outer Join " 
		SQL = SQL & "	( "
		SQL = SQL & "		select GuildIdx, count(Heroidx) as CNT " 
		SQL = SQL & "		from u_guildmember where Grade in (3,10,11,12,13) Group By GuildIdx  "
		SQL = SQL & "	) as d  "
		SQL = SQL & "	on (a.GuildIdx = d.GuildIdx ),  "
		SQL = SQL & "	u_guildmember as b,  "
		SQL = SQL & "	u_hero as c  "
		SQL = SQL & " Where  "
		SQL = SQL & "	a.GuildIdx = b.GuildIdx And b.Grade = 12 And  " 
		SQL = SQL & "	b.HeroIdx = c.id_idx And b.HeroOrder = c.hero_order  " & w_str2
		SQL = SQL & " Order By a.GuildIdx Desc Limit  "&Page&", "&pagesize
		
		DBConnCommandMy MixComm, MixConn, MixDSN2, SQL
		DBSelect2 MixComm, MixConn, arrRSMix, arrRSMixCnt

		'Response.Write SQL

		If arrRSMixCnt > -1 Then
			For i = 0 To arrRSMixCnt Step 1
				
				Call Player_List_sub(arrRSMix(9,i), "S")
				
				player_list = player_list & "{""N1"":""" & escape(arrRSMix(0,i)) &""",""N2"":"""& escape(arrRSMix(1,i)) &""",""N3"":"""& escape(arrRSMix(2,i)) &""",""N4"":"""& escape(arrRSMix(3,i)&"") &""",""N5"":"""& escape(arrRSMix(4,i)) &""",""N6"":"""& escape(arrRSMix(5,i)) &""",""N7"":"""& escape(arrRSMix(6,i)&"") &""",""N8"":"""& escape(arrRSMix(7,i)&"") &""",""N9"":"""& escape(arrRSMix(8,i)) &""",""N10"":"""& escape(q_Player) &""",""N11"":"""& escape(q_id_idx)  &""",""N12"":"""& escape(arrRSMix(10,i))&"""}"
			
				If (i <> arrRSMixCnt) then
					player_list = player_list & ","
				End if
			Next
		Else
			player_list = ""
		End if
		PG = int(CLng(CNT)/ CLng(pagesize)) + 1
		If Page = 0 Then Page = 1 End if
		Response.Write "{""CNT"":"&CNT&",""PG"":"&PG&",""PN"":"&Page&",""List"":[" & player_list & "]}" 
		Response.End
		
	'// Guild Member List
	ElseIF key = "GUILD" Then
	
		Dim GUILD_MASTER : GUILD_MASTER = 12
		Dim Guild_M, Guild_name
		
		
		if rid_idx <> "" and rSocket <> "" Then
		
			SQL = "select GuildIdx from u_guildmember where HeroIdx = "&rid_idx&" and HeroOrder = "& rSocket
			
			DBConnCommandMy MixComm, MixConn, MixDSN2, SQL
			DBSelect2 MixComm, MixConn, arrRSMix, arrRSMixCnt
			
			If arrRSMixCnt > -1 Then
				Guild_Code	=	arrRSMix(0,0)
				
			Else
				Response.Write "{""Gname"":"""&Guild_name&""",""List"":[" & player_list & "]}" 
				Response.End	
			End if
		
		End if
		
		SQL = "select c.Name, cast(c.EstablishDate as char(19)), b.id_idx, b.hero_order, b.name, a.Grade, b.baselevel, cast(a.UpgradeDate as char(19)) from "
		SQL = SQL & " u_guildmember as a, u_hero as b, u_guild as c where "
		SQL = SQL & " a.HeroIdx = b.id_idx	and a.HeroOrder = b.hero_order and a.GuildIdx = c.GuildIdx and a.GuildIdx =" & Guild_Code &" order by a.Grade desc, a.UpgradeDate asc "
		
		DBConnCommandMy MixComm, MixConn, MixDSN2, SQL
		DBSelect2 MixComm, MixConn, arrRSMix, arrRSMixCnt
		'Response.Write SQL
		
		If arrRSMixCnt > -1 Then
		
			
			Guild_name = arrRSMix(0,0)
			
			For i = 0 To arrRSMixCnt Step 1
				Call Player_List_sub(arrRSMix(2,i), "S")
				if (Cint(arrRSMix(5,i)) = GUILD_MASTER) Then
					if  (arrRSMix(1,i) = arrRSMix(7,i) ) Then
						Guild_M = 	0		'양도받음
					Else
						Guild_M =	1		'개설함
					End if
				Else 
					Guild_M =	""
				End if 
				
				player_list = player_list & "{""N1"":""" & escape(arrRSMix(4,i)) &""",""N2"":"""& escape(arrRSMix(5,i)) &""",""N3"":"""& escape(arrRSMix(6,i)) &""",""N4"":"""& escape(arrRSMix(7,i)&"") &""",""N5"":"""& escape(q_Player) &""",""N6"":"""& escape(q_Block) &""",""N7"":"""& escape(arrRSMix(2,i)&"") &""",""N8"":"""& escape(arrRSMix(7,i))  &""",""N9"":"""& escape(Guild_M)  &""",""N10"":"""& escape(arrRSMix(3,i)) &"""}"
				If (i <> arrRSMixCnt) then
					player_list = player_list & ","
				End if
			Next
		Else
			player_list = ""
		End if
		
		Response.Write "{""Gname"":"""&escape(Guild_name) &""",""Guild_Code"":"""&escape(Guild_Code) &""",""List"":[" & player_list & "]}"
		
		Response.End
	
	'// Guild Info Edit
	ElseIF key = "GEdit" Then 
	
		Dim tInfo		:	tInfo		= Request("tInfo")
		Dim tCert		:	tCert		= Request("tCert")
		Dim tgold		:	tgold		= Request("tgold")
		
		SQL = " Update u_guild SET Info = '"& tInfo &"', Cert='"& tCert &"' , gold="& tgold &" where GuildIdx = " & Guild_Code
		
		DBExecuteMy MixDSN2, SQL
		
		Response.Write "0000"
		Response.End
	
	'// Guild Member Out
	ElseIF key = "GUILD_DEL" Then	
		
		SQL = " Delete From u_guildmember Where GuildIdx = "& Guild_Code &" and HeroIdx = "& rid_idx &" and HeroOrder = " & rSocket
		
		DBExecuteMy MixDSN2, SQL
		Response.Write "0000"
		Response.End
		
	End If	
%>
<%

	public Sub Player_List_sub(str, gbn)
		if str <> "" Then
			If gbn = "I" Then
				SQL = "Select id_idx, PlayerID, Block From Member.Player Where PlayerID = '"& str &"'"
			Else
				SQL = "Select id_idx, PlayerID, Block From Member.Player Where id_idx = "& str 
			End If
			' Response.Write SQL
			DBConnCommandMy pMixComm, pMixConn, MixDSN3, SQL
			DBSelect2 pMixComm, pMixConn, parrRSMix, parrRSMixCnt
			
			
			If parrRSMixCnt > -1 Then
				q_id_idx	= parrRSMix(0,0)
				q_Player	= parrRSMix(1,0)
				q_Block		= parrRSMix(2,0)
			End if
			 
		End if
	End Sub

%>
