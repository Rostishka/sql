set oConn = CreateObject("ADODB.Connection")
oConn.Open "Provider=SQLOLEDB.1;Integrated Security=SSPI;Persist Security Info=False;Initial Catalog=Test_CUP;Data Source=TRIGGER"

'dim DBSERVER, DBUSER, DBPASSWORD
'DBSERVER = InputBox("Enter database name", "Please Enter", "OracleDB") 
'DBUSER   = InputBox("Enter username", "Please Enter", "oracle_user") 
'DBPASSWORD = InputBox("Enter " & DBUSER & " password", "Please Enter", "oracle_password") 

'set oSQLServer = CreateObject("ADODB.Connection")
'oSQLServer.Provider = "OraOLEDB.Oracle"
'oSQLServer.Properties("Data Source").Value = DBSERVER
'oSQLServer.Properties("User Id").Value = DBUSER
'oSQLServer.Properties("Password").Value = DBPASSWORD
'oSQLServer.Open
'oSQLServer.Close

'c_FileName = InputBox("Enter filename", "Please Enter", "") 
c_FileName = "modul_add-data.txt"
Set fso = CreateObject("Scripting.FileSystemObject")
If (fso.FileExists(c_FileName)) Then

   ' Switch DB
   set rsComm = oConn.Execute ("USE Test_CUP")

   ' Check exists table
   set rsComm = oConn.Execute ("if not exists(select 1 from sysobjects s where s.name = 'fb_temp' and s.type = 'U') CREATE TABLE fb_temp(str_data nvarchar(max))")

   ' Clear previous data
   set rsComm = oConn.Execute ("TRUNCATE TABLE fb_temp")

   ' Open the file for input.
   Set t_File = fso.OpenTextFile(c_FileName, 1)

   ' Read from the file and insert into DB
   n_row = 0
   set rsComm = oConn.Execute ("begin tran")
   Do While t_File.AtEndOfStream <> True
       c_str = t_File.ReadLine
       n_row = n_row + 1
       set rsComm = oConn.Execute ("INSERT INTO fb_temp(str_data) VALUES('" & c_str & "')")
   Loop
   t_File.Close
   set rsComm = oConn.Execute ("commit tran")
   MsgBox "Uploaded " & n_row & " rows"
Else
   c_str = c_FileName & " doesn't exist."
   MsgBox c_str
End If
oConn.Close
MsgBox "Done!"
