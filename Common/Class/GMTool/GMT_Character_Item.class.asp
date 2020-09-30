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
	Dim rItem_SO	: 	rItem_SO		= trim(Request("Item_so"))
	Dim rItem_SO2	: 	rItem_SO2		= trim(Request("Item_so2"))
	Dim rItem_Qty	: 	rItem_Qty		= trim(Request("Item_Qty"))
	Dim rItem_Type	: 	rItem_Type		= trim(Request("Item_Type"))
	Dim rI_Pro		: 	rI_Pro			= Trim(Request("I_Pro"))
	
	Dim ITEM_CD		: 	ITEM_CD			= trim(Request("F_Item_Name_Sel"))
	Dim Sel_SO		:	Sel_SO			= trim(Request("Sel_SO"))
	
	Dim CNT			:	CNT				= 0
	Dim Store_Count :	Store_Count		= 0
	Dim zero_check 	: 	zero_check		= 0
	Dim Page		:	Page			= Request("Page")
	Dim pagesize	:	pagesize		= Request("pagesize")
	Dim s_gubun		:	s_gubun			= Request("s_gbn")
	Dim S_str		:	S_str			= unescape(Request("S_item"))
	
	Dim MixDSN		:	MixDSN			= "MixSdata"
	Dim MixDSN2		:	MixDSN2			= rServer
	Dim MixDSN3		:	MixDSN3			= "MixMember"
	Dim MixDSN4		:	MixDSN4			= "MixLogData"
	
	Dim MixComm, MixConn
	Dim arrRSMix, arrRSMixCnt
	Dim pMixComm, pMixConn
	Dim parrRSMix, parrRSMixCnt
	Dim SQL
	Dim Char_Item_List, Select_List, i, w_str, O_fields, q_Player, q_id_idx, q_Block
	Dim Item_Store_Count
	
	Dim zone_idx, duration_type, duration, i_serial,q_serial, q_hname, maxCnt
	Dim log_type 		
	Dim log_sub_type	
	Dim data_type		
	
	Dim obj_Server, Server_index
	Set obj_Server = JSON.parse (Server_List)
	For i = 0  to obj_Server.length-1
		if (trim(obj_Server.get(i).N2) = rServer) Then
		Server_index = obj_Server.get(i).N1
		End if
	Next
	
	'// 아이템 리스트 및 남은 소캣정보
	If rI_Pro = "" or rI_Pro = "ITEM_GIVE" Then
		Dim Store_Gold : Store_Gold = 0
	
		if rGBN = "I" Then
		'//character 소유 아이템 List
			SQL = "select item_idx, serial, socket_type, count, socket_num, synergy, synergy_level from u_item " 
			SQL = SQL &" where id_idx = "& rid_idx &" and hero_order = " & rSocket 
			SQL = SQL &" order by socket_type desc, socket_num asc"
		Else
		'//character 창고 소유 아이템 List
		
			SQL = " SELECT store_gold FROM u_store WHERE id_idx= " & rid_idx
			DBConnCommandMy MixComm, MixConn, MixDSN2, SQL
			DBSelect2 MixComm, MixConn, arrRSMix, arrRSMixCnt
			
			if arrRSMixCnt > -1 Then
				Store_Gold = arrRSMix(0,0)
			End if
			
			
			SQL = "select item_idx, serial,1, count, socket_num, synergy, synergy_level from u_store_item " 
			SQL = SQL &" where id_idx = "& rid_idx  
			SQL = SQL &" order by socket_num asc "
		End if
		DBConnCommandMy MixComm, MixConn, MixDSN2, SQL
		DBSelect2 MixComm, MixConn, arrRSMix, arrRSMixCnt
	
		If arrRSMixCnt > -1 Then
			CNT = arrRSMixCnt
			
			For i = 0 To arrRSMixCnt Step 1
				if arrRSMix(4,i) = 0 Then
					zero_check = 1
				End if 
				Char_Item_List = Char_Item_List & "{""N1"":""" & arrRSMix(0,i) &""",""N2"":"""& arrRSMix(1,i) &""",""N3"":"""& Cint(arrRSMix(2,i)) &""",""N4"":"""& arrRSMix(3,i) &""",""N5"":"""& arrRSMix(4,i) &""",""N6"":"""& arrRSMix(5,i) &""",""N7"":"""& arrRSMix(6,i)&"""}"
			
				If (i <> arrRSMixCnt) then
					Char_Item_List = Char_Item_List & ","
				End if
			Next
		Else
			Char_Item_List = ""
		End if
		
		'남은 소캣을 구한다. 기본 80개 제공됨.
		If rGBN = "I" Then
			SQL = "select A.ROWNUM, B.socket_num from (SELECT @RNUM:=(@RNUM+1) AS ROWNUM  FROM (SELECT @RNUM:=0) R, "
			SQL = SQL &" (select id_idx from u_item limit 79) t) A left join "
			SQL = SQL &" (select socket_num from u_item where id_idx = "& rid_idx &" and hero_order ="& rSocket &" and socket_type = 0 ) AS B "
			SQL = SQL &" on A.ROWNUM = B.socket_num "
			SQL = SQL &" where B.socket_num is NULL "
		Else
		'// 소켓 추가했을경우 소캣갯수 0~19 기본 20개 제공됨.
			SQL = "select store_state from u_store where id_idx = "&rid_idx
			DBConnCommandMy MixComm, MixConn, MixDSN2, SQL
			DBSelect2 MixComm, MixConn, arrRSMix, arrRSMixCnt
			If arrRSMixCnt > -1 Then
				Store_Count = 19 + ((arrRSMix(0,0) -1) * 10)
			Else
				Store_Count = 19
			End if
		
		'아이템 창고 남은 소캣 	
			SQL = "select A.ROWNUM, B.socket_num from (SELECT @RNUM:=(@RNUM+1) AS ROWNUM  FROM (SELECT @RNUM:=0) R, "
			SQL = SQL &" (select id_idx from u_item limit "& Store_Count &") t) A left join "
			SQL = SQL &" (select socket_num from u_store_item where id_idx = "& rid_idx &" ) AS B "
			SQL = SQL &" on A.ROWNUM = B.socket_num "
			SQL = SQL &" where B.socket_num is NULL "
		End if
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
		
		Store_Gold
		Response.Write "{""CNT"":"&CNT&",""SG"":"& Store_Gold &",""List"":[" & Char_Item_List & "], ""Sel"":["& Select_List &"]}" 
		Response.End
	
	
	'// 아이템 갯수 수정
	Elseif rI_Pro = "Q_MOD" Then
	
		
		If rGBN = "I" Then
			SQL = " Update u_item Set count = "& rItem_Qty &" where id_idx = " & rid_idx &" and hero_order ="& rSocket &" and socket_num = "& rItem_SO & " and socket_type=" & rItem_Type
		Else
			SQL = " Update u_sotre_item Set count = "& rItem_Qty &" where id_idx = " & rid_idx &" and socket_num = "& rItem_SO 
		End If
		'Response.Write SQL
		DBExecuteMy MixDSN2, SQL
		Response.End
	
	
	
	'// 창고 GP 수정
	Elseif rI_Pro = "STORE_GP_MOD" Then
		
		Dim GMoney : GMoney = Request("GMoney")
		
		SQL = " Update u_store Set store_gold = "& GMoney &" where id_idx = " & rid_idx  

		DBExecuteMy MixDSN2, SQL
		Response.End	
		
	'// 아이템 갯수 삭제
	ElseIf rI_Pro = "Q_DEL" Then
	
		Dim del_synergy, del_synergy_level, del_opt, del_opt_level
		
		log_type = 2		'아이템 삭제 
		log_sub_type = 7	'운영툴에서 삭제
		data_type = 1		'아이템
		
		SQL = "Select serial, now_zone_idx, name from u_hero where id_idx = "& rId_Idx&" and hero_order =" & rSocket
		DBConnCommandMy MixComm, MixConn, MixDSN2, SQL
		DBSelect2 MixComm, MixConn, arrRSMix, arrRSMixCnt
		If arrRSMixCnt > -1 Then
			q_serial 	= arrRSMix(0,0)
			zone_idx 	= arrRSMix(1,0)
			q_hname 	= arrRSMix(2,0)
		End if
	
		If rGBN = "I" Then
			SQL = " select item_idx, count, serial, opt, opt_level, synergy, synergy_level From u_item  where id_idx = " & rid_idx &" and hero_order ="& rSocket &" and socket_num = "& rItem_SO & " and socket_type=" & rItem_Type
		Else
			SQL = " select item_idx, count, serial, opt, opt_level, synergy, synergy_level From u_store_item  where id_idx = " & rid_idx &" and socket_num = "& rItem_SO 
		End If
		DBConnCommandMy MixComm, MixConn, MixDSN2, SQL
		DBSelect2 MixComm, MixConn, arrRSMix, arrRSMixCnt
		If arrRSMixCnt > -1 Then
			ITEM_CD 	= arrRSMix(0,0)
			rItem_Qty 	= arrRSMix(1,0)
			i_serial 	= arrRSMix(2,0)
			del_opt		= arrRSMix(3,0)
			del_opt_level= arrRSMix(4,0)
			del_synergy		= arrRSMix(5,0)
			del_synergy_level= arrRSMix(6,0)
		End if
	
	
		
		if rServer = "Draco"  Then
			rServer = "LogDB"
		elseif rServer = "Garugon"  Then
			rServer = "LogDB"
		End if
			
	
		SQL = "Insert Into "&rServer&".ObjLog  Values (UNIX_TIMESTAMP(sysdate())<< 32 | "&Server_index&"<<24 | "&zone_idx&"<<16 | "&log_type&" <<12 | 1,"
		SQL = SQL & q_serial &","&rId_Idx&","&rSocket&",'"&q_hname&"', '"& Request.ServerVariables("REMOTE_HOST") &"',"&log_type&", "&log_sub_type&", "&data_type&","&i_serial&", "
		SQL = SQL & ITEM_CD &","&rItem_Qty&", "&del_opt&", "&del_opt_level&", "&del_synergy&", "&del_synergy_level&" )"
		
		DBExecuteMy MixDSN4, SQL
	
	'Response.Write SQL
	
		If rGBN = "I" Then
			SQL = " Delete From u_item  where id_idx = " & rid_idx &" and hero_order ="& rSocket &" and socket_num = "& rItem_SO & " and socket_type=" & rItem_Type
		Else
			SQL = " Delete From u_store_item  where id_idx = " & rid_idx &" and socket_num = "& rItem_SO 
		End If
		
		'Response.Write SQL
		DBExecuteMy MixDSN2, SQL
		
		
		Response.End
	
	
	'// 아이템 소캣위치 변경	
	ElseIf rI_Pro = "Q_MOD_S" Then
		If rGBN = "I" Then
			SQL = " Update u_item Set socket_num = "& rItem_SO2 &", socket_type=0  where id_idx = " & rid_idx &" and hero_order ="& rSocket &" and socket_num = "& rItem_SO 
		Else
			SQL = " Update u_store_item Set socket_num = "& rItem_SO2 &" where id_idx = " & rid_idx &" and socket_num = "& rItem_SO
		End If
		'Response.Write SQL
		DBExecuteMy MixDSN2, SQL
		Response.End
	
	'// 아이템 검색시
	ElseIf rI_Pro = "SEARCH" Then
	
		If pagesize = "" Then	pagesize =30	End If 
		If Page = "" Then Page = 0 Else Page = Page * pagesize	End If
		If  S_str <> "" Then
		
			w_str = w_str & " and a.serial = "& S_str  
			'// 아이템 검색
			SQL = "Select a.id_idx, b.name, b.hero_type, b.baselevel, a.hero_order, a.item_idx, a.socket_type, a.socket_num, a.opt_level, a.serial  from u_item "  
			SQL = SQL &" as a, u_hero as b where a.id_idx = b.id_idx and a.hero_order = b.hero_order"& w_str
			DBConnCommandMy MixComm, MixConn, MixDSN2, SQL
			DBSelect2 MixComm, MixConn, arrRSMix, arrRSMixCnt
			
			
			If arrRSMixCnt > -1 Then
				For i = 0 To arrRSMixCnt Step 1
					
					Call Player_List_sub (arrRSMix(0,i),"S")
					
					Char_Item_List = Char_Item_List & "{""N1"":"""& escape(arrRSMix(0,i)) &""",""N2"":"""& escape(arrRSMix(1,i)) &""",""N3"":"""& escape(arrRSMix(2,i))  &""",""N4"":"""& escape(arrRSMix(3,i))  &""",""N5"":"""& escape(arrRSMix(4,i))  &""",""N6"":"""& escape(arrRSMix(5,i))   &""",""N7"":"""& escape(arrRSMix(6,i))  &""",""N8"":"""& escape(arrRSMix(7,i))  &""",""N9"":"""& escape(arrRSMix(8,i)) &""",""N10"":"""& escape(arrRSMix(9,i)) &""",""N11"":"""& escape(q_Player) &""",""N12"":"""& escape(q_Block) &"""}"
				
					If (i <> arrRSMixCnt) then
						Char_Item_List = Char_Item_List & ","
					End if
					
				Next
			End if
			
			 
			'// 아이템창고 검색
			SQL = "Select a.id_idx, b.name, b.hero_type, b.baselevel, b.hero_order, a.item_idx, 2 , a.socket_num, a.opt_level, a.serial from u_store_item " 
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
				
		
		End if	
		 Response.Write "{""CNT"":1,""PG"":1,""PN"":1,""List"":[" & Char_Item_List & "]}" 
		 
	'아이템 추가	 
	ElseIf rI_Pro = "ITADD" Then
		
		log_type = 0 		'아이템 추가
		log_sub_type = 4	'운영툴에서 지급
		data_type = 1		'아이템
	
		if rItem_Qty ="" Then
			rItem_Qty = 0
		End if
		'1. 히어로 정보 (히어로 시리얼, 존넘버)
		SQL = "Select serial, now_zone_idx, name from u_hero where id_idx = "& rId_Idx&" and hero_order =" & rSocket
		DBConnCommandMy MixComm, MixConn, MixDSN2, SQL
		DBSelect2 MixComm, MixConn, arrRSMix, arrRSMixCnt
		If arrRSMixCnt > -1 Then
			q_serial 	= arrRSMix(0,0)
			zone_idx 	= arrRSMix(1,0)
			q_hname 	= arrRSMix(2,0)
		End if
		
		
		'2.아이템 조회 * 시히얼번호 생성  시리얼 번호  생성 - 
		SQL = "Select duration_type, duration, maxCnt, UNIX_TIMESTAMP(sysdate()) << 32 | "&Server_index&" << 24 | "&zone_idx&" << 16 | "&log_sub_type&" << 12 | 1 as i_serial from s_item where idx =" & ITEM_CD
		DBConnCommandMy MixComm, MixConn, MixDSN, SQL
		DBSelect2 MixComm, MixConn, arrRSMix, arrRSMixCnt
		'Response.Write SQL & VbCrLf
		If arrRSMixCnt > -1 Then
			duration_type 	= arrRSMix(0,0)
			duration 		= arrRSMix(1,0)
			maxCnt 			= arrRSMix(2,0)
			if maxCnt = 0 OR maxCnt = 1 Then
				i_serial		= arrRSMix(3,0)
			Else
				i_serial		= 0
			End if
			
			'입력된 아이템 수량이 Max 값보다 크면 저장을 멉춘다. 
			if Cint(rItem_Qty) > Cint(maxCnt) Then 
				Response.Write maxCnt
				Response.End 
			End if 
		End if
		if (duration_type = 3 OR duration_type = 4) Then
			duration = duration
		Else
			duration = duration * 60 
		End if
		if rItem_Qty = 0 Then
			rItem_Qty = 1
		End if
		'2. 아이템 저장
		if rGBN = "I" Then			'인벤토리인경우
			SQL = "Insert InTo u_item Values ("&rId_Idx&", "&rSocket&", "&i_serial&", "&ITEM_CD&", 0, "&Sel_SO&", "&rItem_Qty&", 0, 0, "& duration &", sysdate(), 0, 0 )"
		Else	'창고인경우
			SQL = "Insert InTo u_store_item Values ("&rId_Idx&", "&i_serial&", "&ITEM_CD&", "&Sel_SO&", "&rItem_Qty&", 0, 0, "& duration &", sysdate(), 0, 0 )"
		End if 
		Response.Write SQL & VbCrLf
		DBExecuteMy MixDSN2, SQL
		
		'3. 로그 저장
		
			
		if rServer = "Draco"  Then
			rServer = "LogDB"
		elseif rServer = "Garugon"  Then
			rServer = "LogDB"
		End if
			
		SQL = "Insert Into "&rServer&".ObjLog  Values (UNIX_TIMESTAMP(sysdate()) << 32 | "&Server_index&"<< 24 | "&zone_idx&" << 16 | "&log_type&" << 12 | 1,"&q_serial&","&rId_Idx&","&rSocket&",'"&q_hname&"', '"& Request.ServerVariables("REMOTE_HOST") &"',"&log_type&", "&log_sub_type&", "&data_type&","&i_serial&", "&ITEM_CD&","&rItem_Qty&", 0, 0, 0, 0 )"
		DBExecuteMy MixDSN4, SQL
		'Response.Write SQL & VbCrLf	
		'4. 완료	
		
	'// 아이템 이동 
	ElseIf rI_Pro = "ITEMMOVE" Then 
		Dim target_char : 	target_char = Request("target_char")
		Dim Mitem_sel	:	Mitem_sel	= Request("Mitem_sel")
		Dim mcnt
		
		
		'// 아이템을 넣을 캐릭터의 소캣을 구한다. 
		Dim SP_Target_Char
		SP_Target_Char = split(target_char, "|")
		
		SQL = "select A.ROWNUM, B.socket_num from (SELECT @RNUM:=(@RNUM+1) AS ROWNUM  FROM (SELECT @RNUM:=-1) R, "
		SQL = SQL &" (select id_idx from u_item limit 79) t) A left join "
		SQL = SQL &" (select socket_num from u_item where id_idx = "& SP_Target_Char(0) &" and hero_order ="& SP_Target_Char(1) &" and socket_type = 0 ) AS B "
		SQL = SQL &" on A.ROWNUM = B.socket_num "
		SQL = SQL &" where B.socket_num is NULL "
		
		DBConnCommandMy MixComm, MixConn, MixDSN2, SQL
		DBSelect2 MixComm, MixConn, arrRSMix, arrRSMixCnt
		
		SQL = ""
		
		'// 아이템을 이동시킬 캐릭터로 Update 시킨다.
		Dim SP_Mitem_sel
		SP_Mitem_sel = split(Mitem_sel, ",")
		
		Dim SP_Mitem_sel_EP
		for mcnt = 0 to Ubound(SP_Mitem_sel) 
			
			SP_Mitem_sel_EP = split(SP_Mitem_sel(mcnt), "|")
			
			If trim(rGBN) = "S" Then '// 창고인경우 인벤토리로 Item 을 넘긴다.
				'//창고에 있는 Item 을 Copy시킨 후  창고 Item을 제거한다. 
				SQL = "Insert Into u_item (id_idx, hero_order, serial, item_idx, socket_type, socket_num, count, opt, opt_level, duration, last_check_time, synergy, synergy_level ) "
				SQL = SQL &" select "& SP_Target_Char(0) &", "& SP_Target_Char(1) &", serial, item_idx, 0, " &arrRSMix(0, mcnt) &", count, opt, opt_level, duration, last_check_time, synergy, synergy_level "
				SQL = SQL & "  From u_store_item WHERE id_idx="&rId_Idx&" AND socket_num="&SP_Mitem_sel_EP(1)
				DBExecuteMy MixDSN2, SQL
				
				SQL = "Delete From u_store_item WHERE id_idx="&rId_Idx&" AND socket_num="&SP_Mitem_sel_EP(1)
				DBExecuteMy MixDSN2, SQL
				
			Else
				SQL = "Update u_item Set id_idx="& SP_Target_Char(0) &" ,hero_order="& SP_Target_Char(1) &",socket_type=0,socket_num=" & arrRSMix(0, mcnt)
				SQL = SQL & " WHERE id_idx="&rId_Idx&" AND hero_order="& rSocket &" AND socket_type="&SP_Mitem_sel_EP(0)&" AND socket_num="&SP_Mitem_sel_EP(1)
				DBExecuteMy MixDSN2, SQL
			End If
			
			
			'Response.Write SQL & VbCrLf
			
			SQL = ""
		Next
    Response.Write "0000"
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
