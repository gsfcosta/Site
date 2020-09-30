<!--#include virtual="/common/Function/option_explicit.asp"-->
<!--#include virtual="/common/include/default.asp"-->
<!--#include virtual="/common/Function/file.asp"-->
<%
	Dim SQL
	Dim nLoop
	Dim MixComm, MixConn
	Dim arrRSMix, arrRSMixCnt
	
	Dim MixDSN				:	MixDSN		= "MixSdata"
	Dim Main_JSON , Main_JSON1, Main_JSON2, Main_JSON3

		
		SQL = "		Select idx, name, type, MaxCnt, duration, rarity, price	"
		SQL = SQL & "	From s_item where rarity not in (100) order by idx"
		
		DBConnCommandMy MixComm, MixConn, MixDSN, SQL
		DBSelect2 MixComm, MixConn, arrRSMix, arrRSMixCnt
		
		If arrRSMixCnt > -1 Then
			For nLoop = 0 To arrRSMixCnt
				Main_JSON1 = Main_JSON1 & "{""N1"":""" & escape(Trim(arrRSMix(0, nLoop))) &""",""N2"":"""& escape(Trim(arrRSMix(1, nLoop))) &""",""N3"":"& arrRSMix(2, nLoop) &",""N4"":"& arrRSMix(3, nLoop) &",""N5"":"& arrRSMix(4, nLoop) &",""N6"":"& arrRSMix(5, nLoop) &",""N7"":"& arrRSMix(6, nLoop) &"}"
				If (nLoop <> arrRSMixCnt) then 
					Main_JSON1 = Main_JSON1 & ","
				End if
			Next
		End If	

		Main_JSON = Main_JSON & " var s_item_json = [" & Main_JSON1 & "]; " & VbCrLf

		'Response.Write Main_JSON 
		
		
		SQL = "		Select type, name, race ,start_base_level From s_monster  "
		
		DBConnCommandMy MixComm, MixConn, MixDSN, SQL
		DBSelect2 MixComm, MixConn, arrRSMix, arrRSMixCnt
		
		If arrRSMixCnt > -1 Then
			For nLoop = 0 To arrRSMixCnt
				Main_JSON2 = Main_JSON2 & "{""N1"":""" & escape(Trim(arrRSMix(0, nLoop))) &""",""N2"":"""& escape(Trim(arrRSMix(1, nLoop)))  &""",""N3"":"""& escape(Trim(arrRSMix(2, nLoop)))  &""",""N4"":"""& escape(Trim(arrRSMix(3, nLoop))) &"""}"
				If (nLoop <> arrRSMixCnt) then 
					Main_JSON2 = Main_JSON2 & ","
				End if
			Next
		End If	

		Main_JSON = Main_JSON & " var s_monster_json = [" & Main_JSON2 & "];"  & VbCrLf

		'Response.Write Main_JSON 
		
		SQL = "		Select idx, name 						"
		SQL = SQL & "	From s_zone 						"
		
		DBConnCommandMy MixComm, MixConn, MixDSN, SQL
		DBSelect2 MixComm, MixConn, arrRSMix, arrRSMixCnt
		
		If arrRSMixCnt > -1 Then
			For nLoop = 0 To arrRSMixCnt
				Main_JSON3 = Main_JSON3 & "{""N1"":""" & escape(Trim(arrRSMix(0, nLoop))) &""",""N2"":"""& escape(Trim(arrRSMix(1, nLoop))) &"""}"
				If (nLoop <> arrRSMixCnt) then 
					Main_JSON3 = Main_JSON3 & ","
				End if
			Next
		End If	

		Main_JSON =  Main_JSON & " var s_zone_json = [" & Main_JSON3 & "];" & VbCrLf

		'Response.Write Main_JSON 
		
		Main_JSON3 = ""
		
		SQL = "		Select Lv, LvUpExp 						"
		SQL = SQL & "	From s_LvUserInfo 						"
		
		DBConnCommandMy MixComm, MixConn, MixDSN, SQL
		DBSelect2 MixComm, MixConn, arrRSMix, arrRSMixCnt
		
		If arrRSMixCnt > -1 Then
			For nLoop = 0 To arrRSMixCnt
				Main_JSON3 = Main_JSON3 & "{""N1"":" & escape(Trim(arrRSMix(0, nLoop))) &",""N2"":"& escape(Trim(arrRSMix(1, nLoop))) &"}"
				If (nLoop <> arrRSMixCnt) then 
					Main_JSON3 = Main_JSON3 & ","
				End if
			Next
		End If	

		Main_JSON = Main_JSON & " var s_LvUserInfo = [" & Main_JSON3 & "];" & VbCrLf
		'Response.Write Main_JSON

		Dim adoFile : Set adoFile = Server.CreateObject("ADODB.Stream") 
		adoFile.Mode = 3
		adoFile.Type = 2
		adoFile.Charset = "utf-8"
		adoFile.Open
		adoFile.WriteText(Main_JSON), 1
		adoFile.SaveToFile Server.MapPath("\Common\JSON_INI\S_Code.js"), 2
		adoFile.Flush
		adoFile.Close
		Set adoFile = Nothing

	
%>
