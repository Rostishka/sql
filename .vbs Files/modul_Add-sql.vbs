SetLocale("en-us")
set oConn = CreateObject("ADODB.Connection")
set oRst = CreateObject("ADODB.Recordset")

oConn.Open "Provider=SQLOLEDB.1;Integrated Security=SSPI;Persist Security Info=False;Initial Catalog=TEST;Data Source=TRIGGER"

c_Prod_Name = InputBox("Enter Product Name", "Please Enter", "") 

oRst.Open "SELECT [pInstance] ID,[pName] Name,[pBarCode] BarCode,[pPrice] Price FROM [dbo].[tProducts] WHERE [pName] LIKE '" + c_Prod_Name + "%'", oConn

Set fso = CreateObject("Scripting.FileSystemObject")
'Set t_File = fso.CreateTextFile("res1.txt")
'Set t_File = nothing
Const ForAppending = 8
Set t_File = fso.OpenTextFile ("res2.txt", ForAppending, True)
t_File.WriteLine("Select Result:")
t_File.WriteLine("==============")
Do While Not oRst.EOF
    t_File.WriteLine(oRst.Fields("Name").Value & " " & oRst.Fields("BarCode").Value)
    oRst.MoveNext
Loop
t_File.Close
oRst.Close
Set oRst = Nothing
Set t_File = Nothing
oConn.Close

MsgBox "Done!"
