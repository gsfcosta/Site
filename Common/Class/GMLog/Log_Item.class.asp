<!--#include virtual="/Common/Function/option_explicit.asp"-->
<!--#include virtual="/Common/Include/Default.asp"-->
<%
'/**************************DEFINE CONSTANT HERE***************************
'*  GmLog/Log_Item.class.asp
'*  Description:	Item & Core log list for JSON
'*  Date: 2011.10.13
'*  Author: Tae-Young Kim(tykim@auroragames.co.kr, geojangbi@naver.com)
'*  Params: 
'*  Last Modified: 
'*************************************************************************/
%>
<%

	Response.Charset = "utf-8"
	Dim SQL
	Dim MixDSN		
	if Host_Check = "gmtest" Then
		MixDSN		= "MixLogData_t"
	else
		MixDSN		= "MixLogData"
	end if
	Dim MixComm, MixConn
	Dim arrRSMix, arrRSMixCnt
	
	Dim Main_JSON, nLoop
	
	Dim rServer		: rServer	= Request("Server")
	
	if rServer = "Draco"  Then
		rServer = "LogDB"
	elseif rServer = "Garugon"  Then
		rServer = "LogDB"
	End if
		
		
	Dim rPage		: rPage		= Request("Page")
	Dim rPagesize	: rPagesize	= Request("pagesize")
	Dim rPeriod		: rPeriod	= Request("s_period")
	Dim rStr		: rStr		= unescape(Request("s_item"))
	Dim rSgbn		: rSgbn		= Request("s_gbn")
	Dim rSdate		: rSdate	= Request("s_Sdate")
	Dim rEdate		: rEdate	= Request("s_Edate")
	Dim rLogSerial	: rLogSerial= Request("LogSerial")
	
	Dim rObjSerial	: rObjSerial= Request("ObjSerial")
	Dim rObjIdx		: rObjIdx	= Request("ObjIdx")
	Dim rCN			: rCN		= Request("CN")
	
	
	Dim wStr, CNT, PG
	
	If rPagesize = "" Then
		rPagesize = 30
	End If 
	If rPage = "" Then
		rPage = 0
	Else 
		rPage = rPage * rPagesize
	End If
	
	If (trim(rStr&"") <> "") Then
	
		If (rSgbn = "IDX") Then
			wStr = " And HeroIdx = "& rStr 
		ElseIf (rSgbn = "Hname") Then
			wStr = " And HeroName = '"& rStr &"' "
		ElseIf (rSgbn = "IP") Then
			wStr = " And IP = '"& rStr &"' "
		ElseIf (rSgbn = "HIdx") Then
			wStr = " And ObjSerial = '"& rStr &"' "
		ElseIf (rSgbn = "OBJIDX") Then
			wStr = " And ObjIdx = '"& rStr &"' "
		Else
			wStr = ""
		End If
		
	End If
	
	If (rPeriod = "" ) Then
		rPeriod = "T"
	End If
	
	if (rCN = "LD1") Then
	
	
		SQL = SQL & " select distinct "
		SQL = SQL & "	a.IP, a.HeroName, a.HeroIdx,  a.HeroOrder,a.HeroSerial, a.DataType,LogType, "
		SQL = SQL & "	a.LogSubType,a.ObjCount, a.ObjIdx as name,a.ObjIdx,a.ObjSerial, "
		SQL = SQL & "	b.ValueType, b.Before, b.after, 0 "
		SQL = SQL & " from   "
		SQL = SQL & " "&rServer&".ObjLog  as a left outer Join "
		SQL = SQL & " "&rServer&".ObjDetailLog as b "
		SQL = SQL & " on 	 a.LogSerial = b.LogSerial and  a.ObjSerial = b.ObjSerial "
		SQL = SQL & " where    "
		SQL = SQL & "	 a.LogSerial = '"& rLogSerial &"' and  " 
	 	if (rPeriod = "T") Then
		SQL = SQL & " a.LogSerial Between (UNIX_TIMESTAMP('"& DateFormat(now(), "yyyy-MM-dd") &" 00:00:00') << 32) and  (UNIX_TIMESTAMP(now()) <<32) "
		Else 
		SQL = SQL & " a.LogSerial Between (UNIX_TIMESTAMP('"&rSdate&" 00:00:00') << 32 ) and (UNIX_TIMESTAMP('"&rEdate&" 23:59:59') << 32) "
		End if
		SQL = SQL & " order by a.HeroSerial "
	
		DBConnCommandMy MixComm, MixConn, MixDSN, SQL
		DBSelect2 MixComm, MixConn, arrRSMix, arrRSMixCnt
		'Response.Write SQL
		If arrRSMixCnt > -1 Then
			For nLoop = 0 To arrRSMixCnt
				Main_JSON = Main_JSON & "{""N1"":""" & escape(Trim(arrRSMix(0, nLoop))) &""",""N2"":"""& escape(Trim(arrRSMix(1, nLoop))) &""",""N3"":"""& escape(Trim(arrRSMix(2, nLoop)))  &""",""N4"":"""& escape(Trim(arrRSMix(3, nLoop))) &""",""N5"":"""& escape(Trim(arrRSMix(4, nLoop))) &""",""N6"":"""& escape(Trim(arrRSMix(5, nLoop))) &""",""N7"":"""& escape(Trim(arrRSMix(6, nLoop))) &""",""N8"":"""& escape(Trim(arrRSMix(7, nLoop))) &""",""N9"":"""& escape(Trim(arrRSMix(8, nLoop))) &""",""N10"":"""& escape(Trim(arrRSMix(9, nLoop))) &""",""N11"":"""& escape(Trim(arrRSMix(10, nLoop))) &""",""N12"":"""& escape(Trim(arrRSMix(11, nLoop))) &""",""N13"":"""& escape(Trim(arrRSMix(12, nLoop)&""))&""",""N14"":"""& escape(Trim(arrRSMix(13, nLoop)&""))&""",""N15"":"""& escape(Trim(arrRSMix(14, nLoop)&"")) &""",""N16"":"""& escape(Trim(arrRSMix(15, nLoop)))  &"""}"
				If (nLoop <> arrRSMixCnt) then 
					Main_JSON = Main_JSON & ","
				End if
			Next
		End If	
		
		Response.Write "{""List"":[" & Main_JSON & "]}"
		Response.End
		
	Elseif (rCN = "LD2" ) Then
	
		SQL = SQL & " SELECT "
		SQL = SQL & " HeroName,HeroIdx,HeroOrder,HeroSerial, "
		SQL = SQL & " FROM_UNIXTIME((LogSerial & 0xFFFFFFFF00000000) >> 32) AS LogTime,IP, "
		SQL = SQL & " (ObjSerial & 0x0000000000FF0000) >> 16 AS LogZoneIdx, "
		SQL = SQL & " (LogSerial & 0x000000000000F000) >> 12 AS LogCommonType, "
		SQL = SQL & " LogType,LogSubType,opt, opt_level, synergy >> 2, synergy_level, DataType,0 as TableType From "
		SQL = SQL & 	 rServer &".ObjLog "
		SQL = SQL & " WHERE ObjSerial="& rObjSerial & " AND ObjIdx="& rObjIdx 
		SQL = SQL & " order by LogSerial desc "
		
		DBConnCommandMy MixComm, MixConn, MixDSN, SQL
		DBSelect2 MixComm, MixConn, arrRSMix, arrRSMixCnt
		'Response.Write SQL
		If arrRSMixCnt > -1 Then
			For nLoop = 0 To arrRSMixCnt
				Main_JSON = Main_JSON & "{""N1"":""" & escape(Trim(arrRSMix(0, nLoop))) &""",""N2"":"""& escape(Trim(arrRSMix(1, nLoop))) &""",""N3"":"""& escape(Trim(arrRSMix(2, nLoop)))  &""",""N4"":"""& escape(Trim(arrRSMix(3, nLoop))) &""",""N5"":"""& escape(Trim(arrRSMix(4, nLoop))) &""",""N6"":"""& escape(Trim(arrRSMix(5, nLoop))) &""",""N7"":"""& escape(Trim(arrRSMix(6, nLoop))) &""",""N8"":"""& escape(Trim(arrRSMix(7, nLoop))) &""",""N9"":"""& escape(Trim(arrRSMix(8, nLoop))) &""",""N10"":"""& escape(Trim(arrRSMix(9, nLoop))) &""",""N11"":"""& escape(Trim(arrRSMix(10, nLoop)&"")) &""",""N12"":"""& escape(Trim(arrRSMix(11, nLoop)&"")) &""",""N13"":"""& escape(Trim(arrRSMix(12, nLoop)&"")) &""",""N14"":"""& escape(Trim(arrRSMix(13, nLoop)&""))&""",""N15"":"""& escape(Trim(arrRSMix(14, nLoop)&"")) &""",""N16"":"""& escape(Trim(arrRSMix(15, nLoop))) &"""}"&VbCrLf
				If (nLoop <> arrRSMixCnt) then 
					Main_JSON = Main_JSON & ","
				End if
			Next
		End If	
		
		Response.Write "{""List"":[" & Main_JSON & "]}"
		Response.End
	
	Else
		SQL = "select count(LogSerial) "
		SQL = SQL & " from  "
		SQL = SQL & " "&rServer&".ObjLog   "
		SQL = SQL & " where   "
		if (rPeriod = "T") Then
		SQL = SQL & " LogSerial Between (UNIX_TIMESTAMP('"& DateFormat(now(), "yyyy-MM-dd") &" 00:00:00') << 32) and  (UNIX_TIMESTAMP(now()) <<32) "
		Else 
		SQL = SQL & " LogSerial Between (UNIX_TIMESTAMP('"&rSdate&" 00:00:00') << 32 ) and (UNIX_TIMESTAMP('"&rEdate&" 23:59:59') << 32) "
		End if
		SQL = SQL &  wStr 
		
		'Response.Write SQL & VbCrLf
	
		DBConnCommandMy MixComm, MixConn, MixDSN, SQL
		DBSelect2 MixComm, MixConn, arrRSMix, arrRSMixCnt
		
		If arrRSMixCnt > -1 Then CNT = arrRSMix(0,0) End if
		
		SQL = "select "
		SQL = SQL & " FROM_UNIXTIME((LogSerial & 0xFFFFFFFF00000000) >> 32 )AS LogTime, "
		SQL = SQL & " (LogSerial & 0x0000000000FF0000) >> 16 AS ZoneIdx, "
		SQL = SQL & " (LogSerial & 0x000000000000F000) >> 12 AS LogCommonType,"
		SQL = SQL & " IP, HeroName,HeroIdx,HeroOrder,HeroSerial,DataType,LogType, "
		SQL = SQL & " LogSubType, ObjIdx as name,ObjIdx,ObjSerial,ObjCount, 0 as TableType,LogSerial, "
		SQL = SQL & " FROM_UNIXTIME((ObjSerial & 0xFFFFFFFF00000000) >> 32) AS ObjCreatedTime, "
		SQL = SQL & " (ObjSerial & 0x00000000FF000000) >> 24 AS ObjCreatedServer, "
		SQL = SQL & " (ObjSerial & 0x0000000000FF0000) >> 16 AS ObjCreatedZoneIdx, "
		SQL = SQL & " (ObjSerial & 0x000000000000F000) >> 12 AS ObjCreatedType"
		SQL = SQL & " from  "
		SQL = SQL & " "&rServer&".ObjLog  "
		SQL = SQL & " where   "
		if (rPeriod = "T") Then
		SQL = SQL & " LogSerial Between (UNIX_TIMESTAMP('"& DateFormat(now(), "yyyy-MM-dd") &" 00:00:00') << 32) and  (UNIX_TIMESTAMP(now()) <<32) "
		Else 
		SQL = SQL & " LogSerial Between (UNIX_TIMESTAMP('"&rSdate&" 00:00:00') << 32 ) and (UNIX_TIMESTAMP('"&rEdate&" 23:59:59') << 32) "
		End if
		SQL = SQL &  wStr & " order by LogSerial  desc "
		SQL = SQL & " limit "&rPage&", "&rPagesize
		'Response.Write SQL & VbCrLf
		DBConnCommandMy MixComm, MixConn, MixDSN, SQL
		DBSelect2 MixComm, MixConn, arrRSMix, arrRSMixCnt
		
		
		If arrRSMixCnt > -1 Then
			For nLoop = 0 To arrRSMixCnt
				Main_JSON = Main_JSON & "{""N1"":""" & escape(Trim(arrRSMix(0, nLoop))) &""",""N2"":"""& escape(Trim(arrRSMix(1, nLoop))) &""",""N3"":"""& escape(Trim(arrRSMix(2, nLoop)))  &""",""N4"":"""& escape(Trim(arrRSMix(3, nLoop))) &""",""N5"":"""& escape(Trim(arrRSMix(4, nLoop))) &""",""N6"":"""& escape(Trim(arrRSMix(5, nLoop))) &""",""N7"":"""& escape(Trim(arrRSMix(6, nLoop))) &""",""N8"":"""& escape(Trim(arrRSMix(7, nLoop))) &""",""N9"":"""& escape(Trim(arrRSMix(8, nLoop))) &""",""N10"":"""& escape(Trim(arrRSMix(9, nLoop))) &""",""N11"":"""& escape(Trim(arrRSMix(10, nLoop))) &""",""N12"":"""& escape(Trim(arrRSMix(11, nLoop))) &""",""N13"":"""& escape(Trim(arrRSMix(12, nLoop))) &""",""N14"":"""& escape(Trim(arrRSMix(13, nLoop))) &""",""N15"":"""& escape(Trim(arrRSMix(14, nLoop))) &""",""N16"":"""& escape(Trim(arrRSMix(15, nLoop))) &""",""N17"":"""& escape(Trim(arrRSMix(16, nLoop))) &""",""N18"":"""& escape(Trim(arrRSMix(17, nLoop))) &""",""N19"":"""& escape(Trim(arrRSMix(18, nLoop))) &""",""N20"":"""& escape(Trim(arrRSMix(19, nLoop))) &""",""N21"":"""& escape(Trim(arrRSMix(20, nLoop))) &"""}"
				If (nLoop <> arrRSMixCnt) then 
					Main_JSON = Main_JSON & ","
				End if
			Next
		End If	

		
	
		PG = cint(CLng(CNT)/ CLng(rPagesize) + 1) 
		If rPage = 0 Then rPage = 1 End if
		
		Response.Write "{""CNT"":"&CNT&",""PG"":"&PG&",""PN"":"&rPage&",""List"":[" & Main_JSON & "]}"

		'Response.Write SQL
	End if
	Response.End
%>
