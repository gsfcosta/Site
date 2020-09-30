<%
	Response.Buffer			= True
	Response.Expires		= -1
	Response.CacheControl	= "no-cache"
	Response.AddHeader		"pragma","no-cache"
	Response.AddHeader		"cache-control","private"

	On Error Resume Next

	'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	'상수설정
	'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	' CursorType
	Const adOpenForwardOnly		= 0	' 복사본을 가져온다. 앞으로 전진만 가능. 기본값.
	Const adOpenKeyset			= 1	' Dynamic과 비슷. 다른 사용자가 추가한 레코드는 볼 수 없다.
	Const adOpenDynamic			= 2	' 다른 사용자가 변경한 모든 자료를 볼 수 있다.
	Const adOpenStatic			= 3	' 복사본을 가져온다. 모든 방향 이동 가능.

	' LockType
	Const adLockReadOnly		= 1	' 읽기전용. 수정 불가능.
	Const adLockPessimistic		= 2	' 레코드를 변경하기 시작한 시점부터 다른 사용자는 이 레코드를 변경할 수 없다.
	Const adLockOptimistic		= 3	' 레코드를 변경하고 업데이트를 하는 순간만 잠긴다.
	Const adLockBatchOptimistic	= 4	' 여러 레코드의 업데이트 순간에 잠긴다.

	' ObjectStateEnum Values
	Const adStateClosed			= &H00000000
	Const adStateOpen			= &H00000001
	Const adStateCONNing		= &H00000002
	Const adStateExecuting		= &H00000004
	Const adStateFetching		= &H00000008
	Const adCmdText				= &H0001
	Const adCmdStoredProc		= &H0004

	' DataTypeEnum Values
	Const adEmpty				= 0
	Const adTinyInt				= 16
	Const adSmallInt			= 2
	Const adInteger				= 3		 '// 인티저 형
	Const adBigInt				= 20
	Const adUnsignedTinyInt		= 17
	Const adUnsignedSmallInt	= 18
	Const adUnsignedInt			= 19
	Const adUnsignedBigInt		= 21
	Const adSingle				= 4
	Const adDouble				= 5		 '// 더블형
	Const adCurrency			= 6
	Const adDecimal				= 14
	Const adNumeric				= 131
	Const adBoolean				= 11		'// 불리언
	Const adError				= 10
	Const adUserDefined			= 132
	Const adVariant				= 12
	Const adIDispatch			= 9
	Const adIUnknown			= 13
	Const adGUID				= 72
	Const adDate				= 7
	Const adDBDate				= 133
	Const adDBTime				= 134
	Const adDBTimeStamp			= 135
	Const adBSTR				= 8
	Const adChar				= 129		'// 캐릭터
	Const adVarChar				= 200		'// 스트링
	Const adLongVarChar			= 201
	Const adWChar				= 130
	Const adVarWChar			= 202
	Const adLongVarWChar		= 203
	Const adBinary				= 128
	Const adVarBinary			= 204
	Const adLongVarBinary		= 205
	Const adChapter				= 136
	Const adFileTime			= 64
	Const adPropVariant			= 138
	Const adVarNumeric			= 139
	Const adArray				= &H2000

	'///////파일로 열경우 웹 디비 스트링보안에 좀더 신경쓸수 있음///////
	Dim DBSource
	Dim FSO, FileText
	Dim Image_CDN_URL : Image_CDN_URL = "http://mixmaster.krweb.nefficient.com/mixmaster/MixmaWeb/"

	Sub ConnectionDefault

		Set FSO			= Server.CreateObject("Scripting.FileSystemObject")
		Set FileText	= FSO.OpenTextFile("D:\Web\MixMaster2010\db_string.dat",1,0,0)
		DBSource		= FileText.Readline
		Set FSO = Nothing

	End Sub

	Sub ConnectionTracking

		Set FSO			= Server.CreateObject("Scripting.FileSystemObject")
		Set FileText	= FSO.OpenTextFile("D:\Web\db_tracking_string.dat",1,0,0)
		DBSource		= FileText.Readline
		Set FSO = Nothing
	End Sub

	Call ConnectionDefault
	'///////////////////////////////////////////////////////////////////

	'--------------------------------
	'파라메터 쿼리를 사용하기 위하여 Command 객체 사용하여 DB 연결 (MS-SQL)
	'--------------------------------
	Function DBConnCommand (ByRef oDBComm, ByRef oDBConn, SQL)
		Set oDBComm = Server.CreateObject("ADODB.Command")
		Set oDBConn = Server.CreateObject("ADODB.Connection")
		oDBConn.Open DBSource					'// 커넥션 스트링 처리 (MS-SQL,ORACLE)

		oDBComm.CommandText			= SQL
		oDBComm.CommandType			= 1	 'adCmdText
		oDBComm.ActiveConnection	= oDBConn

		On Error Goto 0
	End Function

	Function DBConnCommandMy (ByRef oDBComm, ByRef oDBConn, DSNName, SQL)

		On Error Resume Next

		Set oDBComm = Server.CreateObject("ADODB.Command")
		Set oDBConn = Server.CreateObject("ADODB.Connection")
		oDBConn.Open ("DSN=" & DSNName)

		oDBComm.CommandText = SQL
		oDBComm.CommandType = 1     'adCmdText
		oDBComm.ActiveConnection = oDBConn

		On Error Goto 0
	End Function

	'--------------------------------
	'파라메터 쿼리 (Parameterized Query)를 위한 파라메터 추가 함수
	'--------------------------------
	Function DBSetParam (ByRef oDBComm, paramName, paramType, paramDirection, paramSize, paramValue )
		If paramValue = "" Then paramValue = NULL
			oDBComm.Parameters.Append oDBComm.CreateParameter( paramName, paramType, paramDirection, paramSize, paramValue )
			On Error Goto 0
	End Function

	'--------------------------------
	'파라메터 쿼리를 실행하고 단절된 레코드셋(Disconnected Recordset) 처리하여 배열로 넘김 (SELECT)
	'--------------------------------
	Function DBSelect (ByRef oDBComm, ByRef oDBConn, ByRef arrRS, arrRSCnt)
		Dim oRS
		Dim saRecCnt

		saRecCnt = -1

		Set oRS				= Server.CreateObject("ADODB.Recordset")
		oRS.CursorType		= 0	 ' adOpenForwardOnly
		oRS.LockType		= 1	 ' adLockReadOnly
		oRS.CursorLocation	= 3	 ' adUseClient

		Set oRS = oDBComm.Execute

		On Error Goto 0

		If oRS.EOF Then
			arrRSCnt = -1
		Else
			arrRS		= oRS.GetRows (-1, 0)
			arrRSCnt	= UBound (arrRS, 2)
		End If

		oRS.Close
		Set oRS = Nothing

		oDBConn.Close
		Set oDBConn = Nothing

		Set oDBComm = Nothing
	End Function

	'--------------------------------
	'파라메터 쿼리를 실행하고 단절된 레코드셋(Disconnected Recordset) 처리하여 배열로 넘김
	'--------------------------------
	Function DBSelect2 (ByRef oDBComm, ByRef oDBConn, ByRef arrRS, arrRSCnt)
	    Dim oRS
	    Dim saRecCnt

	    saRecCnt = -1

		On Error Resume Next

	    Set oRS             = Server.CreateObject("ADODB.Recordset")
	    oRS.CursorType      = 0     ' adOpenForwardOnly
	    oRS.LockType        = 1     ' adLockReadOnly
	    oRS.CursorLocation  = 3     ' adUseClient

		Set oRS = oDBComm.Execute

		On Error Goto 0

		If oRS.EOF And oRS.BOF Then
		    arrRSCnt = -1
		Else
			arrRS = oRS.GetRows (-1, 0)
			arrRSCnt = UBound (arrRS, 2)
		End If

	    oRS.Close
	    Set oRS = Nothing

		oDBConn.Close
		Set oDBConn = Nothing

		Set oDBComm = Nothing
	End Function


	Function DBSelect3(SQL)
		Set DBSelect3 = Server.CreateObject("ADODB.Recordset")
		DBSelect3.Open SQL, DBSource, 3, 1 'adOpenStatic, adLockReadOnly
	End Function


	'--------------------------------
	'데이터베이스 SQL 실행(Insert,Update,Delete)
	'--------------------------------
	Function DBExecute (ByRef oDBComm, ByRef oDBConn)
		Dim Result

		Result = 0

		oDBComm.Execute

		If (oDBComm.Errors.Count = 0) Then
			Result = 1
		End If

		On Error Goto 0

		DBExecute = Result

		oDBConn.Close
		Set oDBConn = Nothing

		Set oDBComm = Nothing
	End Function

	Function DBExecuteMy (strDSN, SQL)
		Dim oDBConn

		Set oDBConn = Server.CreateObject("ADODB.Connection")
		oDBConn.Open ("dsn=" & strDSN)

		Dim Result

		Result = 0

		on error resume next

		oDBConn.Execute(SQL)

		If (oDBConn.Errors.Count = 0) Then
			Result = 1
		End If

		on error goto 0

		DBExecuteMy = Result

		oDBConn.Close
		Set oDBConn = Nothing
	End Function

	'Response.Write 단축키
	Function RW(Text)
		Response.Write Text & Chr(13)
	End Function

	'Response.End 단축키
	Function RE()
		Response.End
	End Function

%>