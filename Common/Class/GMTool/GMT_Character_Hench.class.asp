<!--#include virtual="/common/Function/option_explicit.asp"-->
<object runat="Server" progid="Scripting.FileSystemObject" id="fsc"></object>
<!--#include virtual="/Common/JSON_INI/Server_CONFIG.asp"-->
<% Now_Position ="GMTool"%>
<script language="javascript" runat="server" src="/common/function/json2.min.asp"></script>
<!--#include virtual="/Common/Function/db.asp"-->
<!--#include virtual="/Member/GM_login_ck.asp"-->

<%

	Dim rServer 	:	rServer			= Request("Server")
	Dim rC_serial	:	rC_serial		= trim(Request("C_serial"))
	Dim rGBN		:	rGBN			= trim(Request("GBN"))
	Dim rid_idx		:	rid_idx			= trim(Request("id_idx"))
	Dim rSocket		: 	rSocket			= trim(Request("Socket"))
	Dim Right_num	: 	Right_num		= right(rid_idx,1)
	Dim rItem_SO	: 	rItem_SO		= trim(Request("Item_so"))
	Dim rItem_SO2	: 	rItem_SO2		= trim(Request("Item_so2"))
	Dim rItem_Qty	: 	rItem_Qty		= trim(Request("Item_Qty"))
	Dim rItem_Type	: 	rItem_Type		= trim(Request("Item_Type"))
	Dim rI_Pro		: 	rI_Pro			= Trim(Request("I_Pro"))
	Dim Page		:	Page			= Request("Page")
	Dim pagesize	:	pagesize		= Request("pagesize")
	Dim s_gubun		:	s_gubun			= Request("s_gbn")
	Dim S_str		:	S_str			= unescape(Request("S_item"))
	Dim m_sort		:	m_sort			= Request("m_sort")
	Dim key			:	key				= Request("key")
	Dim CNT			:	CNT				= 0 
	Dim Store_Count :	Store_Count		= 0
	Dim zero_check 	: zero_check		= 0
	Dim growthType 	: growthType  	= Request ("growthType")
	Dim rType		: rType			= Request ("rType")
	Dim tH_position : tH_position 	= Request("tH_position")
	Dim Sel_SO 		: Sel_SO 		= Request("Sel_SO")
	Dim H_code 		: H_code 		= Request("H_code")
	Dim tH_name 	: tH_name 		= Request("tH_name")
	Dim tH_sex 		: tH_sex 		= Request("tH_sex")
	Dim tH_level 	: tH_level 		= Request("tH_level")
	Dim tH_maxlevel 	: tH_maxlevel 		= Request("tH_maxlevel")
	Dim tH_exp 		: tH_exp 		= Request("tH_exp")
	Dim tH_spmove 	: tH_spmove 	= Request("tH_spmove")
	Dim tH_spattack : tH_spattack 	= Request("tH_spattack")
	Dim tH_spskill 	: tH_spskill 	= Request("tH_spskill")
	Dim tH_str 		: tH_str 		= Request("tH_str")
	Dim tH_dex 		: tH_dex 		= Request("tH_dex")
	Dim tH_ami 		: tH_ami 		= Request("tH_ami")
	Dim tH_luck 	: tH_luck 		= Request("tH_luck")
	Dim tH_ap 		: tH_ap 		= Request("tH_ap")
	Dim tH_dp 		: tH_dp 		= Request("tH_dp")
	Dim tH_hc 		: tH_hc 		= Request("tH_hc")
	Dim tH_hd 		: tH_hd 		= Request("tH_hd")
	Dim tH_hp 		: tH_hp 		= Request("tH_hp")
	Dim tH_mp 		: tH_mp 		= Request("tH_mp")
	Dim tH_maxhp 	: tH_maxhp 		= Request("tH_maxhp")
	Dim tH_maxmp 	: tH_maxmp 		= Request("tH_maxmp")
	Dim tH_spc 		: tH_spc 		= Request("tH_spc")
	Dim tH_race_val : tH_race_val 	= Request("tH_race_val")
	Dim tH_Islot	: tH_Islot		= Request("tH_Islot")
	
	Dim zone_idx, duration_type, duration, i_serial, q_serial, q_hname, maxCnt
	Dim log_type, log_sub_type	
	Dim data_type, Item_Store_Count, Hench_cd
	Dim Char_Item_List, Select_List, i,w_str, O_fields, q_Player, q_id_idx, q_Block,j 
	
	Dim SQL
	Dim MixDSN		:	MixDSN			= "MixSdata"
	Dim MixDSN2		:	MixDSN2			= rServer
	Dim MixDSN3		:	MixDSN3			= "MixMember"
	Dim MixDSN4		:	MixDSN4			= "MixLogData"
	Dim MixComm, MixConn
	Dim arrRSMix, arrRSMixCnt
	Dim pMixComm, pMixConn
	Dim parrRSMix, parrRSMixCnt
	
	Dim obj_Server, Server_index
	Set obj_Server = JSON.parse (Server_List)

	For i = 0  to obj_Server.length-1
		if (trim(obj_Server.get(i).N2) = rServer) Then
		Server_index = obj_Server.get(i).N1
		End if
	Next
	
	if rI_Pro = "" Then
	'// 캐릭터가 소유한 헨치 목록을 가지고 온다.	
	
		if rGBN = "HI" Then
			SQL = "select monster_type, name, serial, position, hench_order, baselevel, sex, growthtype, max_baselevel from u_hench_"& Right_num 
			SQL = SQL &" where id_idx = "& rid_idx &" and hero_order = " & rSocket 
			SQL = SQL &" order by position, hench_order asc "
		Else
			SQL = "select monster_type, name, serial, 2, hench_order, baselevel, sex, growthtype, max_baselevel from u_store_hench_"& Right_num 
			SQL = SQL &" where id_idx = "& rid_idx  
			SQL = SQL &" order by hench_order asc "
		End if
		
		DBConnCommandMy MixComm, MixConn, MixDSN2, SQL
		DBSelect2 MixComm, MixConn, arrRSMix, arrRSMixCnt
	
		If arrRSMixCnt > -1 Then
			CNT = arrRSMixCnt
			
			For i = 0 To arrRSMixCnt Step 1
				if arrRSMix(4,i) = 0 Then
					zero_check = 1
				End if 
		
				Char_Item_List = Char_Item_List & "{""N1"":""" & arrRSMix(0,i) &""",""N2"":"""& escape(arrRSMix(1,i)) &""",""N3"":"""& arrRSMix(2,i) &""",""N4"":"""& arrRSMix(3,i) &""",""N5"":"""& arrRSMix(4,i) &""",""N6"":"""& arrRSMix(5,i) &""",""N7"":"""& arrRSMix(6,i) &""",""N8"":"""& arrRSMix(7,i)  &""",""N9"":"""& arrRSMix(8,i) &"""}"
			
				If (i <> arrRSMixCnt) then
					Char_Item_List = Char_Item_List & ","
				End if
			Next
		Else
			Char_Item_List = ""
		End if
		
		 	'// 비어있는 소켓을 확인한다.
			If rGBN = "HI" Then
				SQL = "select A.ROWNUM, B.hench_order from (SELECT @RNUM:=(@RNUM+1) AS ROWNUM  FROM (SELECT @RNUM:=0) R, "
				SQL = SQL &" (select id_idx from u_item limit 19) t) A left join "
				SQL = SQL &" (select hench_order from u_hench_"& Right_num &" where id_idx = "& rid_idx &" and hero_order ="& rSocket &" ) AS B "
				SQL = SQL &" on A.ROWNUM = B.hench_order "
				SQL = SQL &" where B.hench_order is NULL "
			Else
				
			'// 헨치창고 인경우 창고 개설 갯수에 따라 계산을 한다. 창고 개설 갯수는 0 ~ 19까지 기본 20개제공됨 추가 될때마다 10개씩 증가. 
				SQL = "select store_state from u_store where id_idx = "&rid_idx
				DBConnCommandMy MixComm, MixConn, MixDSN2, SQL
				DBSelect2 MixComm, MixConn, arrRSMix, arrRSMixCnt
				
				If arrRSMixCnt > -1 Then
					Store_Count = 19 + ((arrRSMix(0,0) -1) * 10)
				Else
					Store_Count = 19
				End if
			
			
				SQL = "select A.ROWNUM, B.hench_order from (SELECT @RNUM:=(@RNUM+1) AS ROWNUM  FROM (SELECT @RNUM:=0) R, "
				SQL = SQL &" (select id_idx from u_item limit "& Store_Count &") t) A left join "
				SQL = SQL &" (select hench_order from u_store_hench_"& Right_num &"  where id_idx = "& rid_idx &" ) AS B "
				SQL = SQL &" on A.ROWNUM = B.hench_order "
				SQL = SQL &" where B.hench_order is NULL "
			End if
			
			'Response.Write SQL
			DBConnCommandMy MixComm, MixConn, MixDSN2, SQL
			DBSelect2 MixComm, MixConn, arrRSMix, arrRSMixCnt		
			
			If arrRSMixCnt > -1 Then
				if zero_check <> 1 Then
					Select_List = Select_List & "{""N1"":""0""}," 
				End if
				For i = 0 To arrRSMixCnt Step 1
					Select_List = Select_List & "{""N1"":""" & arrRSMix(0,i) &"""}"
				
					If (i <> arrRSMixCnt) then
						Select_List = Select_List & ","
					End if
				Next
			Else
				Select_List = ""
			End if
			
			Response.Write "{""CNT"":"&CNT&",""List"":[" & Char_Item_List & "], ""Sel"":["& Select_List &"]}" 
		Response.End
	
	'// 헨치 시리얼번호로 검색한다.
	Elseif rI_Pro = "SEARCH" Then
	
		If pagesize = "" Then	pagesize =30	End If 
		If Page = "" Then Page = 0 Else Page = Page * pagesize	End If
		If  S_str <> "" Then
			w_str = w_str & " and a.serial = "& S_str  
			for j = 0 to 9
				SQL = "Select a.id_idx, b.name, b.hero_type, b.baselevel, a.hero_order, a.name, a.position, a.hench_order, a.baselevel, a.serial  from u_hench_"&j  
				SQL = SQL &" as a, u_hero as b where a.id_idx = b.id_idx and a.hero_order = b.hero_order"& w_str
				DBConnCommandMy MixComm, MixConn, MixDSN2, SQL
				DBSelect2 MixComm, MixConn, arrRSMix, arrRSMixCnt
				
				'Response.Write SQL
				If arrRSMixCnt > -1 Then
					For i = 0 To arrRSMixCnt Step 1
						
						Call Player_List_sub (arrRSMix(0,i),"S")
						
						Char_Item_List = Char_Item_List & "{""N1"":"""& escape(arrRSMix(0,i)) &""",""N2"":"""& escape(arrRSMix(1,i)) &""",""N3"":"""& escape(arrRSMix(2,i))  &""",""N4"":"""& escape(arrRSMix(3,i))  &""",""N5"":"""& escape(arrRSMix(4,i))  &""",""N6"":"""& escape(arrRSMix(5,i))   &""",""N7"":"""& escape(arrRSMix(6,i))  &""",""N8"":"""& escape(arrRSMix(7,i))  &""",""N9"":"""& escape(arrRSMix(8,i)) &""",""N10"":"""& escape(arrRSMix(9,i)) &""",""N11"":"""& escape(q_Player) &""",""N12"":"""& escape(q_Block) &"""}"
					
						If (i <> arrRSMixCnt) then
							Char_Item_List = Char_Item_List & ","
						End if
						
					Next
				End if
			next
			 
			for j = 0 to 9
				SQL = "Select a.id_idx, b.name, b.hero_type, b.baselevel, b.hero_order, a.name, 2 , a.hench_order, a.baselevel, a.serial from u_store_hench_"&j  
				SQL = SQL &" as a, u_hero as b where a.id_idx = b.id_idx "& w_str
				DBConnCommandMy MixComm, MixConn, MixDSN2, SQL
				DBSelect2 MixComm, MixConn, arrRSMix, arrRSMixCnt
				
			'Response.Write SQL
				If arrRSMixCnt > -1 Then
					For i = 0 To arrRSMixCnt Step 1
						
						Call Player_List_sub (arrRSMix(0,i),"S")
						
						Char_Item_List = Char_Item_List & "{""N1"":"""& escape(arrRSMix(0,i)) &""",""N2"":"""& escape(arrRSMix(1,i)) &""",""N3"":"""& escape(arrRSMix(2,i))  &""",""N4"":"""& escape(arrRSMix(3,i))  &""",""N5"":"""& escape(arrRSMix(4,i))  &""",""N6"":"""& escape(arrRSMix(5,i))   &""",""N7"":"""& escape(arrRSMix(6,i))  &""",""N8"":"""& escape(arrRSMix(7,i))  &""",""N9"":"""& escape(arrRSMix(8,i)) &""",""N10"":"""& escape(arrRSMix(9,i)) &""",""N11"":"""& escape(q_Player) &""",""N12"":"""& escape(q_Block) &"""}"
					
						If (i <> arrRSMixCnt) then
							Char_Item_List = Char_Item_List & ","
						End if
							
					Next
				End if
			next	
		
		End if	
		 Response.Write "{""CNT"":1,""PG"":1,""PN"":1,""List"":[" & Char_Item_List & "]}" 
		 
		 
	'//헨치를 삭제한다.	 
	ElseIf rI_Pro = "Q_DEL" Then
	
		log_type = 3 		'코어삭제
		log_sub_type = 6	'운영툴에서 삭제
		data_type = 2		'헨치
		
		'현재 캐릭터 정보를 가지고 온다.
		SQL = "Select serial, now_zone_idx, name from u_hero where id_idx = "& rId_Idx&" and hero_order =" & rSocket
		DBConnCommandMy MixComm, MixConn, MixDSN2, SQL
		DBSelect2 MixComm, MixConn, arrRSMix, arrRSMixCnt
		
		If arrRSMixCnt > -1 Then
			q_serial 	= arrRSMix(0,0)
			zone_idx 	= arrRSMix(1,0)
			q_hname 	= arrRSMix(2,0)
		End if
	
		
		'삭제할 핸치 정보를 가지고 온다. 
		If rGBN = "HI" Then
			SQL = " Select serial, monster_type  From u_hench_"& Right_num &"  where id_idx = " & rid_idx &" and hero_order ="& rSocket &" and hench_order = "& rItem_SO & " and serial=" & rItem_Type
		Else
			SQL = " Select serial, monster_type  From u_store_hench_"& Right_num &"  where id_idx = " & rid_idx &" and hench_order = "& rItem_SO 
		End If
		DBConnCommandMy MixComm, MixConn, MixDSN2, SQL
		DBSelect2 MixComm, MixConn, arrRSMix, arrRSMixCnt
		'Response.Write SQL
		'Response.End
		If arrRSMixCnt > -1 Then
			i_serial 	= arrRSMix(0, 0)
			Hench_cd	= arrRSMix(1, 0)
		End if
		
		
		' 해당 헨치를 삭제한다.
		If rGBN = "HI" Then
			SQL = " Delete From u_hench_"&Right_num&"  where id_idx = " & rid_idx &" and hero_order ="& rSocket &" and hench_order = "& rItem_SO & " and serial=" & rItem_Type
		Else
			SQL = " Delete From u_store_hench_"&Right_num&"  where id_idx = " & rid_idx &" and serial = "& rItem_SO 
		End If
		'Response.Write SQL
		DBExecuteMy MixDSN2, SQL
		
			
		if rServer = "Draco"  Then
			rServer = "LogDB"
		elseif rServer = "Garugon"  Then
			rServer = "LogDB"
		End if
			
		' 해당 로그 테이블에 핸치 로그를 쌓는다.
		SQL =" Insert Into "&rServer&".ObjLog (LogSerial,HeroSerial,HeroIdx,HeroOrder,HeroName,IP,LogType,LogSubType,DataType,ObjSerial,ObjIdx,ObjCount )"
		SQL = SQL &" Values (UNIX_TIMESTAMP(sysdate())<< 32 | "&Server_index&"<<24 | "&zone_idx&"<<16 | "&log_type&" <<12 | 1,"
		SQL = SQL & q_serial &","&rId_Idx&","&rSocket&",'"&q_hname&"', '"& Request.ServerVariables("REMOTE_HOST") &"',"&log_type&", "&log_sub_type&", "&data_type&","&i_serial&","& Hench_cd &", 1 )"
		
		
		DBExecuteMy MixDSN4, SQL
		
		
		Response.End
		
		
	'//소켓위 위치를 바꾼다.
	ElseIf rI_Pro = "Q_MOD_S" Then
	
		If rGBN = "HI" Then
			SQL = " Update u_hench_"&Right_num&" Set hench_order = "& rItem_SO2 &", position=1  where id_idx = " & rid_idx &" and hero_order ="& rSocket &" and hench_order = "& rItem_SO 
		Else
			SQL = " Update u_store_hench_"&Right_num&" Set hench_order = "& rItem_SO2 &" where id_idx = " & rid_idx &" and hench_order = "& rItem_SO
		End If
		Response.Write SQL
		DBExecuteMy MixDSN2, SQL
		Response.End	  
		
	ElseIf rI_Pro = "HENHCMOVE" Then   
		
		Dim target_char : 	target_char = Request("target_char")
		Dim Mitem_sel	:	Mitem_sel	= Request("MHench_sel")
		Dim mcnt
		
		
		'// 아이템을 넣을 캐릭터의 소캣을 구한다. 
		Dim SP_Target_Char
		SP_Target_Char = split(target_char, "|")
		
		
		Dim tRight_num : tRight_num = right(SP_Target_Char(0),1)
		
		
		SQL = "select A.ROWNUM, B.hench_order from (SELECT @RNUM:=(@RNUM+1) AS ROWNUM  FROM (SELECT @RNUM:=-1) R, "
		SQL = SQL &" (select id_idx from u_item limit 19) t) A left join "
		SQL = SQL &" (select hench_order from u_hench_"& tRight_num &" where id_idx = "& SP_Target_Char(0) &" and hero_order ="& SP_Target_Char(1) &" ) AS B "
		SQL = SQL &" on A.ROWNUM = B.hench_order "
		SQL = SQL &" where B.hench_order is NULL "
		
		Response.Write SQL & VbCrLf
		
		DBConnCommandMy MixComm, MixConn, MixDSN2, SQL
		DBSelect2 MixComm, MixConn, arrRSMix, arrRSMixCnt
		
		SQL = ""
		
		'// 아이템을 이동시킬 캐릭터로 Update 시킨다.
		Dim SP_Mitem_sel
		SP_Mitem_sel = split(Mitem_sel, ",")
		
		Dim SP_Mitem_sel_EP
		for mcnt = 0 to Ubound(SP_Mitem_sel)  
			
			SP_Mitem_sel_EP = split(SP_Mitem_sel(mcnt), "|")
			
			If trim(rGBN) = "HS" Then '// 헨치창고인 경우 인벤토리로 헨치를 넘긴다.
				'//창고에 있는 헨치를 Copy시킨 후  창고 핸치를 제거한다. 
				
				SQL = "Insert Into u_hench_"& tRight_num &" (id_idx, hero_order, serial, position, hench_order, monster_type, name, sex, state, mixnum, baselevel, max_baselevel, exp, speed_move, speed_attack, speed_skill, str, dex, aim, luck, ap, dp, hc, hd, hp, mp, maxhp, maxmp, item0, item1, item2, growthtype, race_val, ign_att_cnt, add_defense_cnt, enchant_grade, item_slot_total, item_idx_0, item_serial_0, item_duration_0, item_idx_1, item_serial_1, item_duration_1, item_idx_2, item_serial_2, item_duration_2, duration, last_check_time) "
				SQL = SQL &" select  "&SP_Target_Char(0) &", "& SP_Target_Char(1) &", serial, 1 , " &arrRSMix(0, mcnt) &", monster_type, name, sex, state, mixnum, baselevel, max_baselevel, exp, speed_move, speed_attack, speed_spell, str, dex, aim, luck, ap, dp, hc, hd, hp, mp, maxhp, maxmp, item0, item1, item2, growthtype, race_val, ign_att_cnt, add_defense_cnt, enchant_grade, item_slot_total, item_idx_0, item_serial_0, item_duration_0, item_idx_1, item_serial_1, item_duration_1, item_idx_2, item_serial_2, item_duration_2, duration, last_check_time " 
				SQL = SQL & "  From u_store_hench_"& Right_num  &" WHERE id_idx="&rId_Idx&" AND hench_order="&SP_Mitem_sel_EP(1)
				DBExecuteMy MixDSN2, SQL
				Response.Write SQL & VbCrLf
				SQL = "Delete From u_store_hench_"& Right_num  &" WHERE id_idx="&rId_Idx&" AND hench_order="&SP_Mitem_sel_EP(1)
				DBExecuteMy MixDSN2, SQL
				Response.Write SQL & VbCrLf
			Else
				 if tRight_num = Right_num Then

				    SQL = "Update u_hench_"& tRight_num &" Set id_idx="& SP_Target_Char(0) &" ,hero_order="& SP_Target_Char(1) &",position = 1, hench_order=" & arrRSMix(0, mcnt)
				    SQL = SQL & " WHERE id_idx="&rId_Idx&" AND hero_order="& rSocket &" AND position="&SP_Mitem_sel_EP(0)&" AND hench_order="&SP_Mitem_sel_EP(1)
				    DBExecuteMy MixDSN2, SQL
				    Response.Write SQL & VbCrLf

                Else
                    
                    SQL = "Insert into u_hench_"& tRight_num &" Select * From u_hench_"& Right_num &" WHERE id_idx="&rId_Idx&" AND hero_order="& rSocket &" AND position="&SP_Mitem_sel_EP(0)&" AND hench_order="&SP_Mitem_sel_EP(1)
                    
                    DBExecuteMy MixDSN2, SQL
				    Response.Write SQL & VbCrLf


                    SQL = "Delete From u_hench_"& Right_num &" WHERE id_idx="&rId_Idx&" AND hero_order="& rSocket &" AND position="&SP_Mitem_sel_EP(0)&" AND hench_order="&SP_Mitem_sel_EP(1)

                    DBExecuteMy MixDSN2, SQL
				    Response.Write SQL & VbCrLf


                    SQL = "Update u_hench_"& tRight_num &" Set id_idx="& SP_Target_Char(0) &" ,hero_order="& SP_Target_Char(1) &",position = 1, hench_order=" & arrRSMix(0, mcnt)
				    SQL = SQL & " WHERE id_idx="&rId_Idx&" AND hero_order="& rSocket &" AND position="&SP_Mitem_sel_EP(0)&" AND hench_order="&SP_Mitem_sel_EP(1)

				    DBExecuteMy MixDSN2, SQL
				    Response.Write SQL & VbCrLf
         End if
			End If
			
			'Response.Write SQL & VbCrLf
			
			SQL = ""
		Next
	 
		Response.End
		
		 
	ElseIf rI_Pro = "HENHCSOCKET" Then 
	
		if Cint (rGBN) = 0 Then					' 전투인경우
			Store_Count = 3 
		Elseif Cint (rGBN) = 1 Then				' 인벤토리인경우
			Store_Count = 20
		Else										' 창고인경우
			SQL = "select store_state from u_store where id_idx = "& rId_Idx
			DBConnCommandMy MixComm, MixConn, rServer, SQL
			DBSelect2 MixComm, MixConn, arrRSMix, arrRSMixCnt
			If arrRSMixCnt > -1 Then		 
				Store_Count = 20 + ((Cint(arrRSMix(0,0)) -1) * 10)
			Else
				Store_Count = 20 
			End if
		End if
		
		SQL = "select A.ROWNUM, B.hench_order from (SELECT @RNUM:=(@RNUM+1) AS ROWNUM  FROM (SELECT @RNUM:=-1) R, "
		SQL = SQL &" (select id_idx from u_item limit "& Store_Count &") t) A left join "
		SQL = SQL &" (select hench_order from u_hench_"& Right_num &" where id_idx = "& rId_Idx &" and hero_order ="& rSocket &" and position = " & rGBN &") AS B "
		SQL = SQL &" on A.ROWNUM = B.hench_order "
		SQL = SQL &" where B.hench_order is NULL"
		
		'Response.Write SQL & VbCrLf
		
		DBConnCommandMy MixComm, MixConn, MixDSN2, SQL
		DBSelect2 MixComm, MixConn, arrRSMix, arrRSMixCnt
		

		If arrRSMixCnt > -1 Then
			For i = 0 To arrRSMixCnt Step 1
				Select_List = Select_List & "{""N1"":""" & arrRSMix(0,i) &"""}"
			
				If (i <> arrRSMixCnt) then
					Select_List = Select_List & ","
				End if
			Next
		Else
			Select_List = ""
		End if
		Response.Write "{""Sel"":["& Select_List &"]}"
		Response.End
	
		
	ElseIf rI_Pro = "Hench_Base" Then
	
		SQL = "	select "
		SQL = SQL &"	a.start_base_level as base_level, "
		SQL = SQL &"	a.start_base_level + 25 as max_level, "
		SQL = SQL &"	a.speed_move,"
		SQL = SQL &"	a.speed_attack,"
		SQL = SQL &"	a.speed_skill,"
		SQL = SQL &"	truncate(b.STR  * a.HenchStatRate,0) as str, "
		SQL = SQL &"	truncate(b.DEX  * a.HenchStatRate,0) as dex, "
		SQL = SQL &"	truncate(b.AIM  * a.HenchStatRate,0) as aim, "
		SQL = SQL &"	truncate(b.Luck * a.HenchStatRate,0) as luck,"
		SQL = SQL &"	truncate(b.ATT  * a.HenchStatRate,0) as att, "
		SQL = SQL &"	b.AP,"
		SQL = SQL &"	b.DP,"
		SQL = SQL &"	b.HitCnt,"
		SQL = SQL &"	b.HitDice,"
		SQL = SQL &"	b.HP,"
		SQL = SQL &"	b.MP,"
		SQL = SQL &"	truncate(((b.STR * 13) + (b.DEX * 3) + (b.AIM * 12) + (b.Luck * 5)) * a.start_base_level / 150 + 15, 0) as maxhp,"
		SQL = SQL &"	b.Luck + 10 as maxmp,"
		SQL = SQL &"	a.HenchStatRate "
		SQL = SQL &" from "	
		SQL = SQL &"	s_monster as a,"
		SQL = SQL &"	s_LvMonInfo as b"
		SQL = SQL &" where a.type = " & rType
		SQL = SQL &" and a.start_base_level = b.Lv "
		DBConnCommandMy MixComm, MixConn, MixDSN, SQL
		DBSelect2 MixComm, MixConn, arrRSMix, arrRSMixCnt
		
		Select_List = "{""N1"":"& arrRSMix(0,0) &",""N2"":"& arrRSMix(1,0) &",""N3"":"& arrRSMix(2,0)&",""N4"":"& arrRSMix(3,0) &",""N5"":"& arrRSMix(4,0)&",""N6"":"& arrRSMix(5,0) &",""N7"":"& arrRSMix(6,0)&",""N8"":"& arrRSMix(7,0) &",""N9"":"& arrRSMix(8,0)&",""N10"":"& arrRSMix(9,0) &",""N11"":"& arrRSMix(10,0)&",""N12"":"& arrRSMix(11,0) &",""N13"":"& arrRSMix(12,0)&",""N14"":"& arrRSMix(13,0) &",""N15"":"& arrRSMix(14,0)&",""N16"":"& arrRSMix(15,0)&",""N17"":"& arrRSMix(16,0)&",""N18"":"& arrRSMix(17,0)&",""N19"":"& arrRSMix(18,0)&"}"
		
		Response.Write "{""Sel"":["& Select_List &"]}"
		
		Response.End
		
		
	ElseIf rI_Pro = "Level_CH" Then 

	
		Dim Req_b_level : Req_b_level = Request("b_level")
	
		SQL = "	select "
		SQL = SQL &"	b.AP,"
		SQL = SQL &"	b.DP,"
		SQL = SQL &"	b.HitCnt,"
		SQL = SQL &"	b.HitDice,"
		SQL = SQL &"	b.HP,"
		SQL = SQL &"	b.MP,"
		SQL = SQL &"	truncate(((b.STR * 13) + (b.DEX * 3) + (b.AIM * 12) + (b.Luck * 5)) * b.Lv / 150 + 15, 0) as maxhp,"
		SQL = SQL &"	b.Luck + 10 as maxmp"
		SQL = SQL &" from "	
		SQL = SQL &"	s_LvMonInfo as b"
		SQL = SQL &" where b.Lv = " & rType

		
		DBConnCommandMy MixComm, MixConn, MixDSN, SQL
		DBSelect2 MixComm, MixConn, arrRSMix, arrRSMixCnt
		
		Select_List = "{""N1"":"& arrRSMix(0,0) &",""N2"":"& arrRSMix(1,0) &",""N3"":"& arrRSMix(2,0)&",""N4"":"& arrRSMix(3,0) &",""N5"":"& arrRSMix(4,0)&",""N6"":"& arrRSMix(5,0) &",""N7"":"& arrRSMix(6,0)&",""N8"":"& arrRSMix(7,0) &"}"
		
		Response.Write "{""Sel"":["& Select_List &"]}"
		
		Response.End
		
	ElseIf rI_Pro = "HENCHADD" Then 
		log_type = 1 		'코어추가
		log_sub_type = 4	'운영툴에서 추가
		data_type = 2		'헨치
		
		'현재 캐릭터 정보를 가지고 온다.
		SQL = "Select serial, now_zone_idx, name from u_hero where id_idx = "& rId_Idx&" and hero_order =" & rSocket
		DBConnCommandMy MixComm, MixConn, MixDSN2, SQL
		DBSelect2 MixComm, MixConn, arrRSMix, arrRSMixCnt
		
		If arrRSMixCnt > -1 Then
			q_serial 	= arrRSMix(0,0)
			zone_idx 	= arrRSMix(1,0)
			q_hname 	= arrRSMix(2,0)
			
			SQL = "Select UNIX_TIMESTAMP(sysdate())<< 32 | "&Server_index&"<<24 | "&zone_idx&"<<16 | "&log_sub_type&" <<12 | 1 from dual "
			DBConnCommandMy MixComm, MixConn, MixDSN2, SQL
			DBSelect2 MixComm, MixConn, arrRSMix, arrRSMixCnt
			i_serial 	= arrRSMix(0,0)
		End if
	
		if Cint(tH_position) <> 2 Then
		
			SQL = " INSERT INTO u_hench_"& Right_num&" ( "			
			SQL = SQL & " id_idx, hero_order, serial, position," 
			SQL = SQL & " hench_order,monster_type, name, sex, " 
			SQL = SQL & " baselevel, max_baselevel, exp, " 
			SQL = SQL & " speed_move, speed_attack,speed_skill, " 
			SQL = SQL & " str,dex,aim,luck,ap,dp,hc,hd,hp, mp, " 
			SQL = SQL & " maxhp,maxmp,growthtype,race_val,item_slot_total) "
			SQL = SQL & " VALUES ( "
			SQL = SQL & " "& rId_Idx & ", " & rSocket& "," & i_serial &", "
			SQL = SQL & " "& tH_position &"," & Sel_SO &", "& H_code &", '"& tH_name &"', "& tH_sex & ", " & tH_level &", "& tH_maxlevel &", "
			SQL = SQL & " "& tH_exp &", "& tH_spmove &","& tH_spattack &", "& tH_spskill &", "
			SQL = SQL & " "& tH_str &", "& tH_dex &", "& tH_ami &", "& tH_luck &","
			SQL = SQL & " "& tH_ap &", "& tH_dp &", "& tH_hc &", "& tH_hd &","
		    SQL = SQL & " "& tH_hp &", "& tH_mp &", "& tH_maxhp &", "& tH_maxmp &","
		    SQL = SQL & " "& tH_spc &", "& tH_race_val &", 1)"
		Else
			SQL = " INSERT INTO u_store_hench_"& Right_num&" ( "		 	
			SQL = SQL & " id_idx,  serial, " 
			SQL = SQL & " hench_order,monster_type, name, sex, " 
			SQL = SQL & " baselevel, max_baselevel, exp, " 
			SQL = SQL & " speed_move, speed_attack,speed_skill, " 
			SQL = SQL & " str,dex,aim,luck,ap,dp,hc,hd,hp, mp, " 
			SQL = SQL & " maxhp,maxmp,growthtype,race_val,item_slot_total) "
			SQL = SQL & " VALUES ( "
			SQL = SQL & " "& rId_Idx & ", "&i_serial&", "
			SQL = SQL & " " & Sel_SO &", "& H_code &", '"& tH_name &"', "& tH_sex & ", " & tH_level &", "& tH_maxlevel &", "
			SQL = SQL & " "& tH_exp &", "& tH_spmove &","& tH_spattack &", "& tH_spskill &", "
			SQL = SQL & " "& tH_str &", "& tH_dex &", "& tH_ami &", "& tH_luck &","
			SQL = SQL & " "& tH_ap &", "& tH_dp &", "& tH_hc &", "& tH_hd &","
		    SQL = SQL & " "& tH_hp &", "& tH_mp &", "& tH_maxhp &", "& tH_maxmp &","
		    SQL = SQL & " "& tH_spc &", "& tH_race_val &", 1)"
		 
		End if
		DBExecuteMy MixDSN2, SQL
		'Response.Write SQL &"<br>"
		
		'3. 로그 저장
		
			
		if rServer = "Draco"  Then
			rServer = "LogDB"
		elseif rServer = "Garugon"  Then
			rServer = "LogDB"
		End if
		
		SQL = "Insert Into "&rServer&".ObjLog  Values (UNIX_TIMESTAMP(sysdate()) << 32 | "&Server_index&"<< 24 | "&zone_idx&" << 16 | "&log_type&" << 12 | 1,"&q_serial&","&rId_Idx&","&rSocket&",'"&q_hname&"', '"& Request.ServerVariables("REMOTE_HOST") &"',"&log_type&", "&log_sub_type&", "&data_type&","&i_serial&", "&H_code&",1, 0, 0, 0, 0 )"
		DBExecuteMy MixDSN4, SQL
		'Response.Write SQL
		Response.End
		
ElseIf rI_Pro = "HENCHEDIT" Then 
		
		if Cint(tH_position) <> 2 Then
		
			SQL = " Update u_hench_"& Right_num
			SQL = SQL & " SET	"
			SQL = SQL & " position  = "& tH_position & ", " 
			SQL = SQL & " hench_order  = "& Sel_SO & ", " 
			SQL = SQL & " name = '"& tH_name &"', "
			SQL = SQL & " sex  = "& tH_sex & ", " 
			SQL = SQL & " baselevel = " & tH_level &", " 
			SQL = SQL & " max_baselevel = "& tH_maxlevel &", " 
			SQL = SQL & " mixnum = "& tH_maxlevel &",  "
			SQL = SQL & " exp = "& tH_exp &", "
			SQL = SQL & " speed_move =  "& tH_spmove &", "
			SQL = SQL & " speed_attack = "& tH_spattack &", "
			SQL = SQL & " speed_skill = "& tH_spskill &", "
			SQL = SQL & " str = "& tH_str &","
			SQL = SQL & " dex = "& tH_dex &", "
			SQL = SQL & " aim = "& tH_ami &" , "
			SQL = SQL & " luck = "& tH_luck &" ,"
			SQL = SQL & " race_val = "& tH_race_val &","
			SQL = SQL & " ap = "& tH_ap &","
			SQL = SQL & " dp = "& tH_dp &","
			SQL = SQL & " hc = "& tH_hc &","
			SQL = SQL & " hd = "& tH_hd &"," 
			SQL = SQL & " hp = "& tH_hp &", "
			SQL = SQL & " mp = "& tH_mp &", "
			SQL = SQL & " maxhp = "& tH_maxhp &"," 
			SQL = SQL & " maxmp = "& tH_maxmp &","
			SQL = SQL & " item_slot_total = " & tH_Islot
			SQL = SQL & " WHERE "
			SQL = SQL & " (id_idx = "& rId_Idx & ") AND " 
			SQL = SQL & " (serial = "& rC_serial & ")"
		Else

			SQL = " Update u_store_hench_"& Right_num
			SQL = SQL & " SET	"
			SQL = SQL & " position  = 2 " 
			SQL = SQL & " name = '"& tH_name &"', "
			SQL = SQL & " sex  = "& tH_sex & ", " 
			SQL = SQL & " baselevel = " & tH_level &", " 
			SQL = SQL & " max_baselevel = "& tH_maxlevel &", " 
			SQL = SQL & " mixnum = "& tH_maxlevel &",  "
			SQL = SQL & " exp = "& tH_exp &", "
			SQL = SQL & " speed_move =  "& tH_spmove &", "
			SQL = SQL & " speed_attack = "& tH_spattack &", "
			SQL = SQL & " speed_spell = "& tH_spskill &", "
			SQL = SQL & " str = "& tH_str &","
			SQL = SQL & " dex = "& tH_dex &", "
			SQL = SQL & " aim = "& tH_ami &" , "
			SQL = SQL & " luck = "& tH_luck &" ,"
			SQL = SQL & " race_val = "& tH_race_val &","
			SQL = SQL & " ap = "& tH_ap &","
			SQL = SQL & " dp = "& tH_dp &","
			SQL = SQL & " hc = "& tH_hc &","
			SQL = SQL & " hd = "& tH_hd &"," 
			SQL = SQL & " hp = "& tH_hp &", "
			SQL = SQL & " mp = "& tH_mp &", "
			SQL = SQL & " maxhp = "& tH_maxhp &"," 
			SQL = SQL & " maxmp = "& tH_maxmp &"," 
			SQL = SQL & " item_slot_total = " & tH_Islot
			SQL = SQL & " WHERE "
			SQL = SQL & " (id_idx = "& rId_Idx & ") AND" 
			SQL = SQL & " (serial = "& rC_serial & ")"
		 
		End if
		DBExecuteMy MixDSN2, SQL
		'Response.Write SQL
		
		Response.End
		
	End if
	
 

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