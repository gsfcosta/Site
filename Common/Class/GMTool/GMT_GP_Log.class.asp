<!--#include virtual="/common/Function/option_explicit.asp"-->
<!--#include virtual="/Common/Function/db.asp"-->
<!--#include virtual="/Member/GM_login_ck.asp"-->

<%

	Dim SQL
	Dim MixDSN2		:	MixDSN2		= "MixLogData"
	Dim MixComm, MixConn
	Dim arrRSMix, arrRSMixCnt, GP_Log_list, i, WeekDay

	SQL = "select 	date_format(concat(a.regdate, '0000') ,'%Y-%m-%d') ,	a.total_gp,	b.total_gp,	c.total_gp,	d.total_gp, WEEKDAY(date_format(concat(a.regdate, '0000') ,'%Y-%m-%d') ) "
	SQL = SQL & " from magirita.TotalGPLog as a, mekrita.TotalGPLog as b, herseba.TotalGPLog as c, prmai.TotalGPLog as d "
	SQL = SQL & " where a.regdate = b.regdate and b.regdate = c.regdate and c.regdate = d.regdate and d.regdate = a.regdate order by a.regdate desc"

	DBConnCommandMy MixComm, MixConn, MixDSN2, SQL
	DBSelect2 MixComm, MixConn, arrRSMix, arrRSMixCnt
	
	If arrRSMixCnt > -1 Then
	
	For i = 0 To arrRSMixCnt Step 1
	
	Select Case arrRSMix(5,i)
		Case "0"
			WeekDay = "월"
		Case "1"
			WeekDay = "화"
		Case "2"
			WeekDay = "수"
		Case "3"
			WeekDay = "목"
		Case "4"
			WeekDay = "금"
		Case "5"
			WeekDay = "토"
		Case "6"
			WeekDay = "일"
	End Select

	GP_Log_list = GP_Log_list & "{""N1"":""" & arrRSMix(0,i) &""",""N2"":"""& arrRSMix(1,i) &""",""N3"":"""& arrRSMix(2,i) &""",""N4"":"""& arrRSMix(3,i) &""",""N5"":"""& arrRSMix(4,i) &""",""N6"":"""& WeekDay &"""}"

	If (i <> arrRSMixCnt) then
		GP_Log_list = GP_Log_list & ","
	End if
	Next
	
	Else
		GP_Log_list = ""
	End if
  
 Response.Write "{""List"":[" & GP_Log_list & "]}"
%>
