<!--#include virtual="/common/Function/option_explicit.asp"-->
<object runat="Server" progid="Scripting.FileSystemObject" id="fsc"></object>
<!--#include virtual="/Common/JSON_INI/Server_CONFIG.asp"-->
<% Now_Position ="GMTool"%>
<script language="javascript" runat="server" src="/common/function/json2.min.asp"></script>
<!--#include virtual="/Common/Function/db.asp"-->
<!--#include virtual="/Member/GM_login_ck.asp"-->

<%

	Dim SQL
	Dim MixDSN2		:	MixDSN2		= "MixMember"
	Dim MixDSN4		:	MixDSN4		= "MixLogData"
	Dim MixComm, MixConn
	Dim arrRSMix, arrRSMixCnt
	Dim pMixComm, pMixConn
	Dim parrRSMix, parrRSMixCnt

	Dim rid_idx		: 	rid_idx		= Request("id_idx") 
	Dim rSocket		: 	rSocket		= Request("Socket")
	Dim rServer		: 	rServer		= Request("Server")
	Dim s_gubun		:	s_gubun		= Request("s_gbn")
	Dim rGBN		:	rGBN		= Request("GBN")
	Dim S_str		:	S_str		= unescape(Request("S_item"))
	Dim m_sort		:	m_sort		= Request("m_sort")
	Dim key			:	key			= trim(Request("key"))
	Dim Page		:	Page		= Request("Page")
	Dim pagesize	:	pagesize	= Request("pagesize")
	
	Dim charSocket  : charSocket= 	Request("charSocket")	'소캣넘버(INSERT)
	Dim charTYPE	: charTYPE	= 	Request("charTYPE")
	
	Dim charname	: charname	=	Request("charname")		'캐릭터명
	Dim charlevel	: charlevel	=	Request("charlevel")	'레벨
	Dim charExp 	: charExp	=	Request("charExp")		'경험치
	Dim charemp 	: charemp	=	Request("charemp")		'여유수치
	Dim charadb 	: charadb	=	Request("charadb") 		'class
	
	Dim charGP 		: charGP	=	Request("charGP")		'GP
	Dim charSkillP 	: charSkillP=	Request("charSkillP") 	'Skill Point
	
	'머리, 몸, 발
	Dim charhead 	: charhead	=	Request("charhead")
	Dim charbody 	: charbody	=	Request("charbody")
	Dim charfoot 	: charfoot	=	Request("charfoot")
	
	'속도
	Dim charMoveS	: charMoveS =	Request("charMoveS")
	Dim charAttS 	: charAttS	=	Request("charAttS")
	Dim charSkillS 	: charSkillS=	Request("charSkillS")
	
	'스텟
	Dim charStra 	: charStra	=	Request("charStra")
	Dim charDext 	: charDext	=	Request("charDext")
	Dim charAim 	: charAim	=	Request("charAim")
	Dim charLuck 	: charLuck	=	Request("charLuck")
	
	'공격력 방어력
	Dim charAP 		: charAP	=	Request("charAP")
	Dim charDP 		: charDP	=	Request("charDP")
	
	'Hit Count Hit Dice
	Dim charHC 		: charHC	=	Request("charHC")
	Dim charHD 		: charHD	=	Request("charHD")
	'mphp
	Dim charNHP 	: charNHP	=	Request("charNHP")
	Dim charNMP 	: charNMP	=	Request("charNMP")
	Dim charMHP 	: charMHP	=	Request("charMHP")
	Dim charMMP 	: charMMP	=	Request("charMMP")
	
	Dim rs_charname	:  	rs_charname = trim(unescape(Request("s_charname")))
	Dim q_Player, q_id_idx, q_Block, cn, player_list, i, CH_List, O_fields, w_str, CNT, PG
	Dim q_serial
	
	Dim obj_Server, Server_index
	Set obj_Server = JSON.parse (Server_List)
	For i = 0  to obj_Server.length-1
		if (trim(obj_Server.get(i).N2) = rServer) Then
		Server_index = obj_Server.get(i).N1
		End if
	Next
	
	
	'// 서버별  캐릭터 조회
	if key = "" Then
		if pagesize ="" Then	
			Dim obj_Ser
			Set obj_Ser = JSON.parse (Server_List)
			For cn = 0  to obj_Ser.length-1
				
				SQL = " Select id_idx, name, hero_type, baselevel, cast(regdate as char(16)),serial, hero_order  from u_hero where id_idx = "& rid_idx
				DBConnCommandMy MixComm, MixConn, obj_Ser.get(cn).N2, SQL
				DBSelect2 MixComm, MixConn, arrRSMix, arrRSMixCnt
					
				If arrRSMixCnt > -1 Then
					For i = 0 To arrRSMixCnt Step 1
						player_list = player_list & "{""N3"":"""& escape(arrRSMix(1,i)) &""",""N4"":"""& escape(arrRSMix(2,i)) &""",""N5"":"""& escape(arrRSMix(3,i)) &""",""N6"":"""& escape(arrRSMix(4,i)) &""",""N7"":"""& escape(arrRSMix(5,i))&""",""N8"":"""& escape(arrRSMix(6,i)) &"""}"
					
						If (i <> arrRSMixCnt) then
							player_list = player_list & ","
						End if
					Next
				Else
					player_list = ""
					i = 0
				End if
				
				CH_List = CH_List & "{""N1"":"""&obj_Ser.get(cn).N2 &""",""N2"":"&i&",""N3"":[" & player_list & "]}"
				If obj_Ser.length -1 <> cn Then
					CH_List = CH_List & ","
				End if
				
				player_list = ""
			Next
			
		
		Response.Write "{""LIST"":["& CH_List &"]}"
		
		
		'//캐릭터 리스트
		Elseif pagesize <> "" Then
		
			If pagesize = "" Then	pagesize =20	End If 
			If Page = "" Then Page = 0 Else Page = Page * pagesize	End If
	
			If  S_str <> "" Then
				Select Case s_gubun
					Case	"C"
						O_fields = "Name"
					Case	"I"
						Call Player_List_sub (S_str,"I")
						S_str = q_id_idx
						O_fields = "id_idx"
				End Select
				w_str = w_str & " where "& O_fields &" = '"& S_str &"'"  
			End if	
				SQL = "select  count(id_idx) as cnt "
				SQL = SQL & " from u_hero " & w_str
				DBConnCommandMy MixComm, MixConn, rServer, SQL
				DBSelect2 MixComm, MixConn, arrRSMix, arrRSMixCnt
		
				If arrRSMixCnt > -1 Then CNT = arrRSMix(0,0) End if
	
				SQL = " Select  name, hero_type, baselevel, id_idx, serial, hero_order,  cast(regdate as char(16))  from u_hero " & w_str & " order by regdate desc, id_idx desc limit "&Page&", "&pagesize
				DBConnCommandMy MixComm, MixConn, rServer, SQL
				DBSelect2 MixComm, MixConn, arrRSMix, arrRSMixCnt
				
				If arrRSMixCnt > -1 Then
					For i = 0 To arrRSMixCnt Step 1
						if s_gubun = "C" Then
							Call Player_List_sub (arrRSMix(3,i),"S")
						End if
						player_list = player_list & "{""N1"":"""& escape(arrRSMix(0,i)) &""",""N2"":"""& escape(arrRSMix(1,i)) &""",""N3"":"""& escape(arrRSMix(2,i))  &""",""N4"":"""& escape(arrRSMix(3,i))  &""",""N5"":"""& escape(q_Player) &""",""N6"":"""& escape(q_id_idx) &""",""N7"":"""& escape(arrRSMix(6,i))&""",""N8"":"""& escape(q_Block)&""",""N9"":"""& escape(arrRSMix(5,i)) &"""}"
					
						If (i <> arrRSMixCnt) then
							player_list = player_list & ","
						End if
					Next
				Else
					player_list = ""
					i = 0
				End if
				
				'Response.Write Player_list
				PG = int(CLng(CNT)/ CLng(pagesize)) + 1
				If Page = 0 Then Page = 1 End if
				Response.Write "{""CNT"":"&CNT&",""PG"":"&PG&",""PN"":"&Page&",""List"":[" & player_list & "]}" 
				Response.End
				
			End If
			
		'//캐릭터 정보 수정	
		Elseif key = "CHMOD" Then
			
		
			SQL = " UPDATE u_hero SET " 
			SQL = SQL & "	name='"& charname &"', "
			SQL = SQL & "	baselevel="& charlevel &", "
			SQL = SQL & "	class="& charadb &", "
			SQL = SQL & "	exp="& charExp &", "
			SQL = SQL & "	gold="& charGP &", "
			SQL = SQL & "	speed_move="& charMoveS &"," 
			SQL = SQL & "	speed_attack="& charAttS &", " 
			SQL = SQL & "	speed_skill="& charSkillS &", "
			SQL = SQL & "	str="& charStra &", "
			SQL = SQL & "	dex="& charDext &", "
			SQL = SQL & "	aim="& charAim &", "
			SQL = SQL & "	luck="& charLuck &", "
			SQL = SQL & "	ap="& charAP &", "
			SQL = SQL & "	dp="& charDP &", "
			SQL = SQL & "	hc="& charHC &", "
			SQL = SQL & "	hd="& charHD &", "
			SQL = SQL & "	hp="& charNHP &", "
			SQL = SQL & "	mp="& charNMP &", "
			SQL = SQL & "	maxhp="& charMHP &", "
			SQL = SQL & "	maxmp="& charMMP &", "
			SQL = SQL & "	avatar_head="& charhead &", "
			SQL = SQL & "	avatar_body="& charbody &", "
			SQL = SQL & "	avatar_foot="&charfoot  &", "
			SQL = SQL & "	abil_freepoint="& charemp &", "
			SQL = SQL & "	skill_point="& charSkillP &" "
			SQL = SQL & "	WHERE id_idx = "&rid_idx&" AND hero_order = " & rSocket
			
		
			DBExecuteMy rServer, SQL
			Response.End()
			
		'//비어있는 캐릭터 소캣 조회
		Elseif key = "CHEMSOCK" Then
		
			Dim NewM_CHAR : NewM_CHAR = "012"
			Dim len_char, c_seri 
			
			SQL = "Select hero_order from u_hero where id_idx = "& rid_idx &" order by hero_order "
			DBConnCommandMy MixComm, MixConn, rServer, SQL
			DBSelect2 MixComm, MixConn, arrRSMix, arrRSMixCnt
			
			If arrRSMixCnt > -1 Then
				For i = 0 To arrRSMixCnt
					NewM_CHAR = Replace( NewM_CHAR , arrRSMix(0,i),"" )
					
				Next
			End if
			
			len_char = len(trim(NewM_CHAR))
			
			if len_char = 1 Then
				c_seri = "{""N1"":"""& trim(NewM_CHAR) &""",""N2"":"""& trim(NewM_CHAR) &"""}"
			Elseif len_char = 2 Then
				c_seri = "{""N1"":"""& left(trim(NewM_CHAR),1) &""",""N2"":"""& left(trim(NewM_CHAR),1) &"""}," & "{""N1"":"""& right(trim(NewM_CHAR),1) &""",""N2"":"""& right(trim(NewM_CHAR),1) &"""}"
			Elseif len_char = 3 Then
				c_seri = "{""N1"":""0"",""N2"":""0""}," & "{""N1"":""1"",""N2"":""1""}," & "{""N1"":""2"",""N2"":""2""}"
			Else
			
			End If
			
			Response.Write "{""CNT"":"& len_char &",""List"":[" & c_seri & "]}" 
			
			Response.End
			
		'// 캐릭터 이름 조회
		Elseif key = "CHRCK" Then
		
			SQL = "Select count(id_idx) from u_hero where name = '"&S_str&"'"
			DBConnCommandMy MixComm, MixConn, rServer, SQL
			DBSelect2 MixComm, MixConn, arrRSMix, arrRSMixCnt
			Response.Write arrRSMix(0,0)
			
		'// 캐릭터 추가.
		Elseif key = "CHADD" Then 
		
			'// 중복되는 캐릭터 이름이 있는지 확인한다.
			SQL = "Select count(id_idx),  cast(sysdate() as char(19)) from u_hero where name = '"&charname&"'"
			DBConnCommandMy MixComm, MixConn, rServer, SQL
			DBSelect2 MixComm, MixConn, arrRSMix, arrRSMixCnt
			
			if Cint(arrRSMix(0,0)) > 0 Then
				Response.Write "1001"
				Response.End
			End if
			
			'// 시리얼 번호로 이용 될 sysdate()를 뽑아온다.
			q_serial = arrRSMix(1,0)
			
			'// 캐릭터 등록
			SQL = "INSERT INTO u_hero ( "
			SQL = SQL & "		id_idx,  "
			SQL = SQL & "		hero_order, " 
			SQL = SQL & "		serial, "
			SQL = SQL & "		class, "
			SQL = SQL & "		name, "
			SQL = SQL & "		hero_type," 
			SQL = SQL & "		now_zone_idx, "
			SQL = SQL & "		now_zone_x, "
			SQL = SQL & "		now_zone_y, "
			SQL = SQL & "		init_pos_layer, "
			SQL = SQL & "		revive_zone_idx, "
			SQL = SQL & "		baselevel, "
			SQL = SQL & "		gold, "
			SQL = SQL & "		attr, "
			SQL = SQL & "		exp, "
			SQL = SQL & "		speed_move," 
			SQL = SQL & "		speed_attack," 
			SQL = SQL & "		speed_skill, "
			SQL = SQL & "		str, "
			SQL = SQL & "		dex, "
			SQL = SQL & "		aim, "
			SQL = SQL & "		luck, "
			SQL = SQL & "		ap, "
			SQL = SQL & "		dp, "
			SQL = SQL & "		hc, "
			SQL = SQL & "		hd, "
			SQL = SQL & "		hp, "
			SQL = SQL & "		mp, "
			SQL = SQL & "		maxhp," 
			SQL = SQL & "		maxmp, "
			SQL = SQL & "		abil_freepoint," 
			SQL = SQL & "		res_fire,"
			SQL = SQL & "		res_water," 
			SQL = SQL & "		res_earth, "
			SQL = SQL & "		res_wind, "
			SQL = SQL & "		res_devil, "
			SQL = SQL & "		regdate, "
			SQL = SQL & "		avatar_head," 
			SQL = SQL & "		avatar_body, "
			SQL = SQL & "		avatar_foot,"
			SQL = SQL & "		skill_point) "
			SQL = SQL & "		VALUES ( "
			SQL = SQL & 	 rid_idx &", "
			SQL = SQL & 	 charSocket &", "
			SQL = SQL & "	UNIX_TIMESTAMP('"&q_serial&"') << 32 | "& Server_index &" << 24 | 130 << 16 | "& charTYPE &" << 12 | 4096, " 'sysdate , server_idx, zone_idx, character type
			SQL = SQL & 	charadb &", "
			SQL = SQL & "	'"& charname &"', "
			SQL = SQL & 	charTYPE &",130, 0, 0, 254, 130, "
			SQL = SQL & 	charlevel &", "
			SQL = SQL & 	charGP &", 0,"
			SQL = SQL & 	charExp &",  "
			SQL = SQL & 	charMoveS &"," 
			SQL = SQL & 	charAttS &", " 
			SQL = SQL & 	charSkillS &", "
			SQL = SQL & 	charStra &", "
			SQL = SQL & 	charDext &", "
			SQL = SQL & 	charAim &", "
			SQL = SQL & 	charLuck &", "
			SQL = SQL & 	charAP &", "
			SQL = SQL & 	charDP &", "
			SQL = SQL & 	charHC &", "
			SQL = SQL & 	charHD &", "
			SQL = SQL & 	charNHP &", "
			SQL = SQL & 	charNMP &", "
			SQL = SQL & 	charMHP &", "
			SQL = SQL & 	charMMP &", "
			SQL = SQL & 	charemp &", 0,0,0,0,0, sysdate(),"
			SQL = SQL & 	charhead &", "
			SQL = SQL & 	charbody &", "
			SQL = SQL & 	charfoot  &", "
			SQL = SQL & 	charSkillP &" ) "
			DBExecuteMy rServer, SQL
			'Response.Write SQL
			
			
			if rServer = "Draco"  Then
				rServer = "LogDB"
			elseif rServer = "Garugon"  Then
				rServer = "LogDB"
			End if
				
			
			'// 행위관련 로그에 저장한다. MovementLog 
			SQL = " Insert Into "&rServer&".MovementLog values( UNIX_TIMESTAMP('"& q_serial &"') << 32 | "& Server_index &" << 24 | 130 << 16 | 0 << 12 | 1, " '
			SQL = SQL &" UNIX_TIMESTAMP('"&q_serial&"') << 32 | "& Server_index &" << 24 | 130 << 16 | "& charTYPE &" << 12 | 1, "& rid_idx &", "& charSocket &", '"& charname &"', '"& Request.ServerVariables("REMOTE_HOST") &"', 0, 2, "& charTYPE &"  ) "
			DBExecuteMy MixDSN4, SQL
			'Response.Write SQL
			Response.Write "0000"
			Response.End()
		
		'//캐릭터 삭제	
		Elseif key = "CHDEL" Then 
			
			Dim Right_num : Right_num = Right(rid_idx,1)
			
			SQL = "Select serial, now_zone_idx, baselevel, cast(sysdate() as char(19)), hero_type, name from u_hero where id_idx = " & rid_idx &" and hero_order= " & rSocket
			DBConnCommandMy MixComm, MixConn, rServer, SQL
			DBSelect2 MixComm, MixConn, arrRSMix, arrRSMixCnt
			
			q_serial = arrRSMix(0,0)
			charTYPE = arrRSMix(4,0)
			charname = arrRSMix(5,0)
			Dim nzone_idx 	: nzone_idx 	= arrRSMix(1,0)
			Dim nbaselevel 	: nbaselevel 	= arrRsMix(2,0)
			Dim nsysdate	: nsysdate		= arrRSMix(3,0)
			
			
			'/***************************DELETE ROW FROM U_HERO*******************/ 
			SQL = "DELETE FROM u_hero WHERE id_idx = " & rid_idx &" AND hero_order = " &rSocket
			DBExecuteMy rServer, SQL
			'/***************************DELETE ROW FROM U_HERO_EVENT*******************/
			SQL = "DELETE FROM u_hero_event WHERE id_idx = " & rid_idx &" AND hero_order = " &rSocket
			DBExecuteMy rServer, SQL
			'/***************************DELETE ROW FROM U_HERO_QUEST*******************/
			SQL = "DELETE FROM u_hero_quest WHERE id_idx = " & rid_idx &" AND hero_order = " &rSocket
			DBExecuteMy rServer, SQL
			'/***************************DELETE ROW FROM u_QuestLog*******************/
			SQL = "DELETE FROM u_QuestLog WHERE id_idx = " & rid_idx &" AND hero_order = " &rSocket
			DBExecuteMy rServer, SQL
			'/***************************DELETE ROW FROM U_HENCH*******************/
			SQL = "DELETE FROM u_hench_"&Right_num&" WHERE id_idx = " & rid_idx &" AND hero_order = " &rSocket
			DBExecuteMy rServer, SQL
			'/***************************DELETE ROW FROM U_ITEM*******************/
			SQL = "DELETE FROM u_item WHERE id_idx = " & rid_idx &" AND hero_order = " &rSocket
			DBExecuteMy rServer, SQL
			'/***************************DELETE ROW FROM u_messenger*******************/
			SQL = "DELETE FROM u_messenger WHERE HeroIdx=" & rid_idx &" AND HeroOrder=" &rSocket 
			DBExecuteMy rServer, SQL
			
			'/***************************DELETE ROW FROM U_GUILDMEMBER*******************/
			SQL = "DELETE FROM u_guildmember WHERE HeroIdx=" & rid_idx &" AND HeroOrder=" &rSocket
			DBExecuteMy rServer, SQL
			
			
			
			'/***************************Insert ROW FROM MovementLog*******************/

			if rServer = "Draco"  Then
				rServer = "LogDB"
			elseif rServer = "Garugon"  Then
				rServer = "LogDB"
			End if
				
			SQL = " Insert Into "&rServer&".MovementLog values( UNIX_TIMESTAMP('"&nsysdate&"') << 32 | "& Server_index &" << 24 | "& nzone_idx &" << 16 | 1 << 12 | 4096, " '
			SQL = SQL & q_serial &", "& rid_idx &", "& rSocket &", '"& charname &"', '"& Request.ServerVariables("REMOTE_HOST") &"', 1 ,2, "& charTYPE &"  ) "
			DBExecuteMy MixDSN4, SQL
			
			'Response.Write SQL
			'/***************************Insert ROW FROM MovementDetailLog*******************/
			SQL = " Insert Into "&rServer&".MovementDetailLog values( UNIX_TIMESTAMP('"&nsysdate&"') << 32 | "& Server_index &" << 24 | "& nzone_idx &" << 16 | 1 << 12 | 4096, " '
			SQL = SQL & q_serial &", 14, "& nbaselevel &", " & nbaselevel& ")"
			DBExecuteMy MixDSN4, SQL
			'Response.Write SQL
			
			
			Response.Write "0000"
			Response.End()
		
		
		'아이템 이동 시켜줄 캐릭터 검색	
		Elseif key = "IMOVE_CHAR" Then
		
			Call Player_List_sub (S_str,"I")
			Dim Store_Count
			
			if q_id_idx = "" Then
				'// 조회된 계정이 없으면 0 리턴
				Response.Write "{""CNT"":0,""List"":[]}"
				Response.End
				
			End if
			
			
			' 계정이 존재하면 캐릭터별 남은 소캣 조회
			
			if len(rGBN) = 1 THen
			
			SQL = " select  "
			SQL = SQL &"		a.id_idx, "
			SQL = SQL &"		a.hero_order, "
			SQL = SQL &"		a.name, "
			SQL = SQL &"		80 - sum( case when b.socket_type = 0 Then 1 else 0 end )  as s_cnt "
			SQL = SQL &"	from  "
			SQL = SQL &"		u_hero as a left join  "
			SQL = SQL &"		u_item as b on a.id_idx = b.id_idx and a.hero_order = b.hero_order "
			SQL = SQL &"	where a.id_idx = " & q_id_idx 
			SQL = SQL &"	group by a.id_idx, b.hero_order,a.name "
			SQL = SQL &"	order by b.hero_order "
			
			elseif len(rGBN) = 2 Then
			
			SQL = "select store_state from u_store where id_idx = "&q_id_idx
			DBConnCommandMy MixComm, MixConn, rServer, SQL
			DBSelect2 MixComm, MixConn, arrRSMix, arrRSMixCnt
			
			
			If arrRSMixCnt > -1 Then		'화면상에 남은 소캣 갯수를 보여줄때에는 20개로 보여준다.
				Store_Count = 20 + ((Cint(arrRSMix(0,0)) -1) * 10)
			Else
				Store_Count = 20
			End if
			
			
			SQL = " select  "
			SQL = SQL &"		a.id_idx, "
			SQL = SQL &"		a.hero_order, "
			SQL = SQL &"		a.name, "
			SQL = SQL &"		"& Store_Count &" - sum( case when b.position = 1 Then 1 else 0 end )  as s_cnt "
			SQL = SQL &"	from  "
			SQL = SQL &"		u_hero as a left join "
			SQL = SQL &"		u_hench_"& right(q_id_idx,1) &" as b on a.id_idx = b.id_idx and a.hero_order = b.hero_order "
			SQL = SQL &"	where a.id_idx = " & q_id_idx 
			SQL = SQL &"	group by a.id_idx, b.hero_order,a.name "
			SQL = SQL &"	order by b.hero_order "
			
			End if
			DBConnCommandMy MixComm, MixConn, rServer, SQL
			DBSelect2 MixComm, MixConn, arrRSMix, arrRSMixCnt
			'Response.Write SQL
			If arrRSMixCnt > -1 Then
				For i = 0 To arrRSMixCnt Step 1
				
					player_list = player_list & "{""N1"":"""& escape(arrRSMix(0,i)) &""",""N2"":"""& escape(arrRSMix(1,i)) &""",""N3"":"""& escape(arrRSMix(2,i))  &""",""N4"":"""& escape(arrRSMix(3,i)) &"""}"
				
					If (i <> arrRSMixCnt) then
						player_list = player_list & ","
					End if
				Next
			Else
				player_list = ""
				i = 0
			End if
			
			Response.Write "{""CNT"":"& i &",""List"":[" & player_list & "]}" 
			Response.End
		End if
	
	

	public Sub Player_List_sub(str, gbn)
		if str <> "" Then
			If gbn = "I" Then
				SQL = "Select id_idx, PlayerID, Block From Member.Player Where PlayerID = '"& str &"'"
			Else
				SQL = "Select id_idx, PlayerID, Block From Member.Player Where id_idx = "& str 
			End If
			 
			DBConnCommandMy pMixComm, pMixConn, MixDSN2, SQL
			DBSelect2 pMixComm, pMixConn, parrRSMix, parrRSMixCnt
			
			If parrRSMixCnt > -1 Then
				q_id_idx	= parrRSMix(0,0)
				q_Player	= parrRSMix(1,0)
				q_Block		= parrRSMix(2,0)
			End if
			 
		End if
	End Sub

%>