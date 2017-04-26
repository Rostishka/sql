SetLocale("en-us")
set oConn = CreateObject("ADODB.Connection")
set oRst = CreateObject("ADODB.Recordset")

oConn.Open "Provider=SQLOLEDB.1;Integrated Security=SSPI;Persist Security Info=False;Initial Catalog=Test_CUP;Data Source=TRIGGER"

oRst.Open "select c.club_name, w.cnt from (select [club_id], count(1) cnt from [dbo].[fb_winners] group by [club_id]) w inner join (select top 1 [club_id], count(1) cnt from [dbo].[fb_winners] group by [club_id] order by cnt DESC) m on m.cnt = w.cnt inner join [dbo].[fb_clubs] c on c.club_id = w.club_id", oConn

Set fso = CreateObject("Scripting.FileSystemObject")
Set t_File = fso.CreateTextFile("res1.txt")
Set t_File = nothing

Const ForAppending = 8
Set t_File = fso.OpenTextFile ("res1.txt", ForAppending, True)
t_File.WriteLine("Select Result:")
t_File.WriteLine("==============")
Do While Not oRst.EOF
    t_File.WriteLine(oRst.Fields("club_name").Value & " " & oRst.Fields("cnt").Value)
    oRst.MoveNext
Loop
t_File.Close
oRst.Close
Set oRst = Nothing
Set t_File = Nothing
oConn.Close

MsgBox "Done!"
