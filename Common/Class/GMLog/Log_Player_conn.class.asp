<!--#include virtual="/Common/Function/option_explicit.asp"-->
<!--#include virtual="/Common/Include/Default.asp"-->

<%

    	Dim SQL
    	Dim MixDSN		
		if Host_Check = "gmtest" Then
			MixDSN		= "MixConnData_t"
		else
			MixDSN		= "MixConnData"
		end if
    	
    	
    	Dim MixComm, MixConn
    	Dim arrRSMix, arrRSMixCnt, player_list, i, j
    	Dim P_day		:	P_day		= Request("P_day")
		Dim S_Date
		Dim m_count		: m_count	= 0
		Dim im_count	: im_count	= 0
		Dim cu_count	: cu_count	= 0
		Dim tot_count	: tot_count	= 0
		Dim NU_CNT		: NU_CNT	= 0
		Dim sw

		sw = 0

		if P_day = "" then
			S_Date = " where checkTime > curdate() " 
		Else
			S_Date = " where left(cast(checkTime as char(10)), 10) = '"& P_day &"'"
		End if
		
		SQL = " select SEQ, LGS, "
		SQL = SQL &"	GMS, zone1, zone2, "
		SQL = SQL &"	Server_Total, cast(checkTime as char(16)) "
		SQL = SQL &" from User_Count "& S_date & " order by SEQ desc "
		
		'Response.Write SQL
		'Response.End
		DBConnCommandMy MixComm, MixConn, MixDSN, SQL
		DBSelect2 MixComm, MixConn, arrRSMix, arrRSMixCnt

		If arrRSMixCnt > -1 Then
			For i = 0 To arrRSMixCnt Step 1
				if right(arrRSMix(16,i), 2) = "00" Then
					sw = 1
				else
					sw = 0
				End if

				
				player_list = player_list & "{""I1"":""" & escape(arrRSMix(6,i)) &""",""I2"":"& arrRSMix(1,i) &",""I3"":"& arrRSMix(2,i) &",""I4"":"& arrRSMix(3,i) &",""I5"":"& arrRSMix(4,i)&",""I6"":"& arrRSMix(5,i) &",""I20"":"& sw &"}"
							
				If (i <> arrRSMixCnt) then
					player_list = player_list & ","
				End if
			Next
		Else
			player_list = "{""I1"":""" & escape(P_day) &""",""I2"":0,""I3"":0,""I4"":0,""I5"":0,""I6"":0,""I20"":0}"
		End if

		Response.Write "{""IL"":[" & player_list & "]}"

	
%>
