<!--#include virtual="/common/Function/option_explicit.asp"-->
<!--#include virtual="/Common/Function/db.asp"-->
<!--#include virtual="/Member/GM_login_ck.asp"-->
<%
'/**************************DEFINE CONSTANT HERE***************************
'*  /Class/GmTool/Mix_Block_Player.class.asp
'*  Description: Block Player Manager Class
'*  Date: 2011.10.19
'*  Author: Tae-Young Kim(tykim@auroragames.co.kr, geojangbi@naver.com)
'*  Params: 
'*  Last Modified: 
'*************************************************************************/
%>
<%

	Dim SQL			: 	SQL 		= ""
	Dim MixDSN2		:	MixDSN2		= "MixMember"
	Dim MixComm, MixConn
	Dim arrRSMix, arrRSMixCnt, player_list, i


	Dim Page		  :	Page		  = Request("Page")
	Dim pagesize	:	pagesize	= Request("pagesize")

	Dim s_gubun		:	s_gubun		= Request("s_gbn")
	Dim S_str		  :	S_str		  = unescape(Request("S_item"))
	Dim m_sort		:	m_sort		= Request("m_sort")
	Dim key			  :	key			  = Request("key")
	Dim P_month		:	P_month		= Request("P_month")

	Dim CNT			:	CNT		= 0
	Dim PG, w_str, O_fields, Player, Player_id
	
	Dim rPlayer_id	:	rPlayer_id	= Request("Player_id")
	Dim rPchname	:	rPchname	= Request("Pchname")
	Dim rPServer	:	rPServer	= Request("PServer")
	Dim rBlockType	:	rBlockType	= Request("BlockType")
	Dim rBlockTypeNum : rBlockTypeNum = Request("BlockTypeNum")
	Dim rPcontent	: 	rPcontent	= Request("Pcontent")
	Dim rSubject	: 	rSubject	= Request("Subject")
	Dim rns_Sdate	:	rns_Sdate	= Request("ns_Sdate")
	Dim rns_Edate	:	rns_Edate	= Request("ns_Edate")
	Dim rrdoDeny	:	rrdoDeny	= Request("rdoDeny")
	Dim rPnum		:	rPnum		= Request("Pnum")
	Dim qid_idx
	
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
					w_str = w_str & " where "& O_fields &" = '"& S_str &"'"
				Case	"N"
					O_fields = "CharName"
					w_str = w_str & " where "& O_fields &" = '"& S_str &"'"
				Case	"C"
					O_fields = "Content"
					w_str = w_str & " where "& O_fields &" like '%"& S_str &"%'"
			End Select
			
		End If

		SQL = "select  count(id_idx) as cnt "
		SQL = SQL & " from Distraint " & w_str
		DBConnCommandMy MixComm, MixConn, MixDSN2, SQL
		DBSelect2 MixComm, MixConn, arrRSMix, arrRSMixCnt

		If arrRSMixCnt > -1 Then CNT = arrRSMix(0,0) End if
		
		SQL = "select PlayerID, BlockType, Access, Subject,ServerName, CharName, "
		SQL = SQL & " cast(RegDate as char(16)),cast(EndDate as char(16)), Id_Idx, num "
		SQL = SQL & " From Distraint "& w_str &" order by Num desc limit "&Page&", "&pagesize
		DBConnCommandMy MixComm, MixConn, MixDSN2, SQL
		DBSelect2 MixComm, MixConn, arrRSMix, arrRSMixCnt

		'Response.Write SQL

		If arrRSMixCnt > -1 Then
			For i = 0 To arrRSMixCnt Step 1
				player_list = player_list & "{""N1"":""" & arrRSMix(0,i) &""",""N2"":"""& arrRSMix(1,i) &""",""N3"":"""& arrRSMix(2,i) &""",""N4"":"""& arrRSMix(3,i) &""",""N5"":"""& arrRSMix(4,i) &""",""N6"":"""& arrRSMix(5,i)&""",""N7"":"""& arrRSMix(6,i)&""",""N8"":"""& escape(arrRSMix(7,i)) &""",""N9"":"""& escape(arrRSMix(8,i)) &""",""N10"":"""& escape(arrRSMix(9,i)) &"""}"
			
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
		
	ElseIf key = "NEW" Then 
		
		SQL = " Select id_idx From Member.Player where PlayerID = '"& rPlayer_id &"'"
		DBConnCommandMy MixComm, MixConn, MixDSN2, SQL
		DBSelect2 MixComm, MixConn, arrRSMix, arrRSMixCnt
		
		If arrRSMixCnt > -1 Then
			qid_idx = arrRSMix(0,0)
			
			Response.Write SQL & VbCrLf
			
			SQL = " INSERT INTO Member.Distraint (id_idx,PlayerID,AdminID, BlockType, Access, CharName, ServerName, "
			SQL = SQL & " Subject,Content,StartDate,EndDate,RegDate,B_Flag,BlockTypeNum) VALUES " & VbCrLf
			SQL = SQL & " ("& qid_idx &", '"& rPlayer_id &"','"& admin_id &"', '"& rBlockType &"', 'DENY', '"& rPchname &"', " 
			SQL = SQL & " '"& rPServer &"', '"& rSubject &"', '"& rPcontent &"', "
			SQL = SQL & " '"& rns_Sdate &" 00:00:00', '"& rns_Edate &" 00:00:00', NOW(), 'Y','0')"
			DBExecuteMy MixDSN2, SQL
			
			SQL = " UPDATE Member.Player SET Block = '"& rBlockType &"' , SecederDate=NOW()  WHERE PlayerID = '"& rPlayer_id &"' AND id_idx = "& qid_idx
			DBExecuteMy MixDSN2, SQL
		Else
			Response.Write "1002"
		End if
		Response.End
	ElseIf key = "RET" Then
	
		SQL = " UPDATE Member.Player SET Block = 'ALLOW', SecederDate=NOW() WHERE PlayerID = '"& rPlayer_id &"' "
		DBExecuteMy MixDSN2, SQL
		'Response.Write SQL & VbCrLf
		SQL = " UPDATE Member.Distraint SET AdminID = '"& admin_id &"', Access = 'ALLOW' WHERE PlayerID = '"& rPlayer_id &"' and num ="& rPnum
		DBExecuteMy MixDSN2, SQL
		'Response.Write SQL & VbCrLf
		Response.Write "0000"
		
	ElseIf key = "BLOC" Then
	
		SQL = " UPDATE Member.Player SET Block = '"& rBlockType &"', SecederDate=NOW() WHERE PlayerID = '"& rPlayer_id &"' "
		DBExecuteMy MixDSN2, SQL
		'Response.Write SQL & VbCrLf
		SQL = " UPDATE Member.Distraint SET AdminID = '"& admin_id &"', Access = 'DENY' WHERE PlayerID = '"& rPlayer_id &"' and num ="& rPnum
		DBExecuteMy MixDSN2, SQL
		'Response.Write SQL & VbCrLf
		Response.Write "0000"
		
  ElseIf key = "ABLOC" Then ' 자동 블럭 해제    2012-06-20
	
    SQL = " UPDATE Member.Distraint SET Access ='ALLOW',  Content = CONCAT(Content,'"& VbCrLf &  VbCrLf &  NOW() &" - 운영툴에서 자동 복구') WHERE cast(left(EndDate, 10) as char(10)) = cast(left(sysdate(), 10) as char(10)) "
		DBExecuteMy MixDSN2, SQL
		
		
		SQL = " Select PlayerID From Member.Distraint Where cast(left(EndDate, 10) as char(10)) = cast(left(sysdate(), 10) as char(10)) "
		DBConnCommandMy MixComm, MixConn, MixDSN2, SQL
		DBSelect2 MixComm, MixConn, arrRSMix, arrRSMixCnt
	
 	If arrRSMixCnt > -1 Then
			For i = 0 To arrRSMixCnt Step 1
        SQL = " UPDATE Member.Player SET Block = 'ALLOW', SecederDate=NOW() WHERE PlayerID = '"& arrRSMix(0,i) &"' "
        DBExecuteMy MixDSN2, SQL
			Next
		End if
		
	ElseIf key = "MOD" Then
	
		
		SQL = " UPDATE Member.Distraint SET AdminID = '"& admin_id &"', BlockType = '"&rBlockType&"'," 
		SQL = SQL & " Subject = '"& rSubject &"', Content = '"& rPcontent &"', StartDate='"& rns_Sdate &" 00:00:00'," 
		SQL = SQL & " EndDate = '"& rns_Edate &" 00:00:00' WHERE PlayerID = '"& rPlayer_id &"' and num ="& rPnum
		DBExecuteMy MixDSN2, SQL
		Response.Write "0000"
		'Response.Write SQL
		
	End If 

	
%>
