<!--#include virtual="/common/Function/option_explicit.asp"-->
<!--#include virtual="/Common/Function/db.asp"-->
<!--#include virtual="/Member/GM_login_ck.asp"-->

<%

	Dim SQL
	Dim MixDSN2		:	MixDSN2		= "MixLogData"
	Dim MixComm, MixConn
	Dim arrRSMix, arrRSMixCnt, Log_list, i
	
	Dim Cn_Cnt1   :  Cn_Cnt1 = 0
	Dim Cn_Cnt2   :  Cn_Cnt2 = 0
	Dim Cn_Cnt3   :  Cn_Cnt3 = 0
	Dim Cn_Cnt4   :  Cn_Cnt4 = 0
	Dim Cn_Cnt5   :  Cn_Cnt5 = 0
	
	Dim Cn_TOT
	
	Dim g_date : g_date = replace(Request("s_Sdate"), "-", "")

  SQL = "select "
	SQL = SQL & " a.level as lev, "
	SQL = SQL & " a.count + b.count + c.count + d.count as tcnt, "
	SQL = SQL & " a.count as cnt, "
	SQL = SQL & " b.count as bcnt, "
	SQL = SQL & " c.count as ccnt, "
	SQL = SQL & " d.count as dcnt "
  SQL = SQL & " from "
	SQL = SQL & " magirita.HeroCountLog as a "
	SQL = SQL & " left join mekrita.HeroCountLog as b on a.level = b.level "
	SQL = SQL & " left join herseba.HeroCountLog as c on a.level = c.level "
	SQL = SQL & " left join prmai.HeroCountLog as d on a.level = d.level	"
  SQL = SQL & " where "
	SQL = SQL & " a.regdate = '"& g_date &"' "
	SQL = SQL & " and b.regdate = '"& g_date &"' "
	SQL = SQL & " and c.regdate = '"& g_date &"'"
	SQL = SQL & " and d.regdate = '"& g_date &"' "
  DBConnCommandMy MixComm, MixConn, MixDSN2, SQL
	DBSelect2 MixComm, MixConn, arrRSMix, arrRSMixCnt
	
  If arrRSMixCnt > -1 Then
    For i = 0 To arrRSMixCnt Step 1
    
      Cn_Cnt1 = Cn_Cnt1 + CDbl (arrRSMix(1,i))
      Cn_Cnt2 = Cn_Cnt2 + CDbl (arrRSMix(2,i))
      Cn_Cnt3 = Cn_Cnt3 + CDbl (arrRSMix(3,i))
      Cn_Cnt4 = Cn_Cnt4 + CDbl (arrRSMix(4,i))
      Cn_Cnt5 = Cn_Cnt5 + CDbl (arrRSMix(5,i))
      
      Log_list = Log_list & "{""N1"":" & arrRSMix(0,i) &",""N2"":"& arrRSMix(1,i) &",""N3"":"& arrRSMix(2,i) &",""N4"":"& arrRSMix(3,i) &",""N5"":"& arrRSMix(4,i) &",""N6"":"& arrRSMix(5,i) &"}"

      If (i <> arrRSMixCnt) then
        Log_list = Log_list & ","
      End if
      
    Next
    Cn_TOT =  "{""T1"":" & Cn_Cnt1 &",""T2"":"& Cn_Cnt2 &",""T3"":"& Cn_Cnt3 &",""T4"":"& Cn_Cnt4 &",""T5"":"& Cn_Cnt5 &"}"
  Else
    Log_list = ""
  End if
  
 Response.Write "{""TOT_L"":["& Cn_TOT &"], ""List"":[" & Log_list & "]}"
%>
