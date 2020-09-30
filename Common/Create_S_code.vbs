
    Dim SQL

    Dim Main_JSON , Main_JSON1, Main_JSON2, Main_JSON3, Main_JSON4 

    Set Db = CreateObject("ADODB.CONNECTION")
    Db.Open "Provider=MSDASQL.1;Persist Security Info=False;User ID=root;Data Source=MixSdata;Initial Catalog=S_Data"

    'Item
    SQL = "		Select idx, name, type, MaxCnt, duration, rarity, price from s_item	"
    Set Rs = Db.execute(SQL)
       
    Do Until RS.EOF
      Main_JSON1 = Main_JSON1 & "{""N1"":""" & escape(Trim(Rs(0))) &""",""N2"":"""& escape(Trim(Rs(1))) &""",""N3"":"& Rs(2) &",""N4"":"& Rs(3)&",""N5"":"& Rs(4) &",""N6"":"& Rs(5) &",""N7"":"& Rs(6) &"}"
      RS.MoveNext
      if Not RS.EOF Then
        Main_JSON1 = Main_JSON1 & ","
      End  If
    Loop
  
		Main_JSON = " var s_item_json = [" & Main_JSON1 & "];" & VbCrLf


    'Monster 
    SQL = "		Select type, name, race ,start_base_level From s_monster  "
    Set Rs = Db.execute(SQL)
		
		Do Until RS.EOF
      Main_JSON2 = Main_JSON2 & "{""N1"":""" & escape(Trim(Rs(0))) &""",""N2"":"""& escape(Trim(Rs(1)))  &""",""N3"":"""& escape(Trim(Rs(2)))  &""",""N4"":"""& escape(Trim(Rs(3))) &"""}"
      RS.MoveNext
      if Not RS.EOF Then
        Main_JSON2 = Main_JSON2 & ","
      End  If
		Loop
		Main_JSON = Main_JSON & " var s_monster_json = [" & Main_JSON2 & "];"  & VbCrLf
		
		
		'Zone
		SQL = "		Select idx, name From s_zone 	"
		Set Rs = Db.execute(SQL)
		 
		 
		Do Until RS.EOF
			Main_JSON3 = Main_JSON3 & "{""N1"":""" & escape(Trim(Rs(0))) &""",""N2"":"""& escape(Trim(Rs(1))) &"""}"
			RS.MoveNext
      if Not RS.EOF Then
        Main_JSON3 = Main_JSON3 & ","
      End  If
		Loop

		Main_JSON = Main_JSON & " var s_zone_json = [" & Main_JSON3 & "];" & VbCrLf
		
    
    'Userinfo
		SQL = "		Select Lv, LvUpExp 	From s_LvUserInfo "
		Set Rs = Db.execute(SQL)
		
		
		Do Until RS.EOF
			Main_JSON4 = Main_JSON4 & "{""N1"":" & escape(Trim(Rs(0))) &",""N2"":"& escape(Trim(rs(1))) &"}"
			RS.MoveNext
      if Not RS.EOF Then
        Main_JSON4 = Main_JSON4 & ","
      End  If
		Loop	

		Main_JSON = Main_JSON & " var s_LvUserInfo = [" & Main_JSON4 & "];" & VbCrLf
	'	Response.Write Main_JSON

    Rs.close
    DB.Close
    Set Rs = Nothing
    Set DB = Nothing
    
    
    Set adoFile = CreateObject("ADODB.Stream") 
		adoFile.Mode = 3
		adoFile.Type = 2
		adoFile.Charset = "utf-8"
		adoFile.Open()
		adoFile.WriteText(Main_JSON), 1
		adoFile.SaveToFile "C:\Users\saudeebemestar02\Documents\Ferramenta\Code1.js", 2
		adoFile.Flush
		adoFile.Close()
		Set adoFile = Nothing
		
		Wscript.Quit		

