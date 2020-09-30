<!--#include virtual="/common/Function/option_explicit.asp"-->
<object runat="Server" progid="Scripting.FileSystemObject" id="fsc"></object>
<!--#include virtual="/Common/JSON_INI/Server_CONFIG.asp"-->
<% Now_Position ="GMTool"%>
<script language="javascript" runat="server" src="/common/function/json2.min.asp"></script>
<!--#include virtual="/Common/Function/db.asp"-->
<!--#include virtual="/Member/GM_login_ck.asp"-->

<%

	Dim rServer 	:	rServer			= Request("Server")
	Dim rI_Pro		: 	rI_Pro			= Trim(Request("I_Pro"))
	Dim Page		:	Page			= Request("Page")
	Dim pagesize	:	pagesize		= Request("pagesize")
	Dim s_gubun		:	s_gubun			= Request("s_gbn")
	Dim S_str		:	S_str			= unescape(Request("S_item"))
	Dim key			:	key				= unescape(Request("key"))
	
	Dim rid_idx		:	rid_idx			= trim(Request("id_idx"))
	Dim rSocket		: 	rSocket			= trim(Request("Socket"))
	
	Dim rFid_idx	:	rFid_idx		= trim(Request("Fid_idx"))
	Dim rFSocket	: 	rFSocket		= trim(Request("FSocket"))

	Dim CNT			:	CNT				= 0 
	Dim PG			:	PG				= 0
	
	Dim SQL
	Dim MixDSN2		:	MixDSN2			= rServer
	Dim MixDSN3		:	MixDSN3			= "MixMember"
	Dim MixComm, MixConn
	Dim arrRSMix, arrRSMixCnt
	Dim pMixComm, pMixConn
	Dim parrRSMix, parrRSMixCnt
	
	Dim Char_Fri_List, q_Player, q_id_idx, q_Block, i ,j
	Dim S_id_idx, S_Baselevel, S_Hero_order, S_name, S_ID, S_Status
	
	if key = "F_DEL" Then
		
		' 서로의 친구 대상자를 제거한다.
		SQL = " Delete From u_messenger Where HeroIdx = "& rid_idx &" and HeroOrder = "& rSocket &" and TargetHeroIdx = "& rFid_idx &" and TargetHeroOrder = " & rFSocket
		DBExecuteMy MixDSN2, SQL
		'Response.Write SQL
		
		SQL = " Delete From u_messenger Where HeroIdx = "& rFid_idx &" and HeroOrder = "& rFSocket &" and TargetHeroIdx = "& rid_idx &" and TargetHeroOrder = " & rSocket 
		DBExecuteMy MixDSN2, SQL
		'Response.Write SQL
		
		
		Response.Write "0000"
		
		Response.End
		
	Else
	'// 친구 목록을 가져온다.
	
		If pagesize = "" Then	pagesize =20 End If 
		If Page = "" Then Page = 0 Else Page = Page * pagesize	End If
		If  S_str <> "" Then
			
			SQL = "Select id_idx, hero_order, name, baselevel  from u_hero where name = '"& S_str &"'"
			DBConnCommandMy MixComm, MixConn, MixDSN2, SQL
			DBSelect2 MixComm, MixConn, arrRSMix, arrRSMixCnt
			'Response.Write SQL 
			If arrRSMixCnt > -1 Then
				For i = 0 To arrRSMixCnt Step 1
					if arrRSMix(2,i) = S_str Then
						S_id_idx		= arrRSMix(0,i)
						Call Player_List_sub(S_id_idx, "S")
						S_Hero_order	= arrRSMix(1,i)
						S_Name			= arrRSMix(2,i)
						S_Baselevel		= arrRSMix(3,i)
						S_ID			= q_Player
					End if
				Next
			
				SQL = "Select count(HeroIdx) from u_messenger Where HeroIdx = "& S_id_idx &" And HeroOrder =" &  S_Hero_order
				DBConnCommandMy MixComm, MixConn, MixDSN2, SQL
				DBSelect2 MixComm, MixConn, arrRSMix, arrRSMixCnt
				
				'Response.Write SQL 
				If arrRSMixCnt > -1 Then CNT = arrRSMix(0,0) End if
					
					SQL = " Select A.id_idx, A.name, A.baselevel, B.status, A.hero_order, A.hero_type "
					SQL = SQL & " From u_hero as A, u_messenger as B "
					SQL = SQL & " Where  A.id_idx = B.TargetHeroIdx And "
					SQL = SQL & " A.hero_order = B.TargetHeroOrder And "
					SQL = SQL & " B.HeroIdx = "& S_id_idx &" And "
					SQL = SQL & " B.HeroOrder = "& S_Hero_order &" limit "&Page&", "&pagesize
					
					DBConnCommandMy MixComm, MixConn, MixDSN2, SQL
					DBSelect2 MixComm, MixConn, arrRSMix, arrRSMixCnt
					
					If arrRSMixCnt > -1 Then
						For i = 0 To arrRSMixCnt Step 1
							
							Call Player_List_sub(arrRSMix(0,i), "S")
							
							If ( ASC( Cint(S_Baselevel) -  Cint(arrRSMix(2,i)) ) <= 10 AND Cint(arrRSMix(3,i)) = 0 ) Then
								S_Status = 0
							Else
								S_Status = 1
							End If   
							
							Char_Fri_List = Char_Fri_List & "{""N1"":""" & escape(q_Player) &""",""N2"":"""& escape(q_Block) &""",""N3"":"""& escape(arrRSMix(0,i)) &""",""N4"":"""& escape(arrRSMix(1,i)) &""",""N5"":"""& escape(arrRSMix(2,i)) &""",""N6"":"""& escape(S_Status) &""",""N7"":"""& escape(arrRSMix(4,i))&""",""N8"":"""& escape(arrRSMix(5,i)) &"""}"
						
							If (i <> arrRSMixCnt) then
								Char_Fri_List = Char_Fri_List & ","
							End if
							
						Next
						
					
					End if
					
				End if	
				
				
				PG = int(CLng(CNT)/ CLng(pagesize)) + 1
				If Page = 0 Then Page = 1 End if
			End if	
			 Response.Write "{""CNT"":"& CNT &",""PG"":"& PG &",""PN"":"& page &",""N1"":""" & S_Name &""",""N2"":""" & S_id_idx  &""",""N3"":""" & S_Hero_order &""",""N4"":""" & S_ID  &""",""List"":[" & Char_Fri_List & "]}" 
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