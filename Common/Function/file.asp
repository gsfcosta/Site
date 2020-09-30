<%
	Function file_delete(path, filename)

		Dim fso, file

		Set fso = server.CreateObject("Scripting.FileSystemObject")
		If fso.FileExists(path &"\"& filename) Then
			Set file = fso.GetFile(path &"\"& filename)
			file.Delete
			Set file = Nothing
		End If
		Set fso = Nothing

	End Function

	Function folder_create(path)

		Dim fso, folder

		Set fso = Server.CreateObject("Scripting.FileSystemObject")
		If Not(fso.folderExists(path)) Then
			Set folder = fso.CreateFolder(path)
		End If
		Set fso = Nothing

		folder_create = path

	End Function

	Function file_copy(src, dest)

		Dim fso, file
		Set fso = Server.CreateObject("Scripting.FileSystemObject")
		Set file = fso.GetFile(src)
		file.Copy dest

	End Function
%>