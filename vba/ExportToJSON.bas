Attribute VB_Name = "ExportToJSON"
Sub ExcelToJsonFile()

    Dim excelRange As Range
    Dim jsonItems As New Collection
    Dim jsonDictionary As Scripting.Dictionary
    Dim jsonFileExport As TextStream
    Dim jsonFileObject As New FileSystemObject
    Dim Wochentag(6) As String
    Dim Tageszeit(1) As String
    Dim plan, kurs, days, timeofday, content As Scripting.Dictionary
    Dim i, j, k, Offset As Integer

    'Variablen
    Wochentag(0) = "Sonntag"
    Wochentag(1) = "Montag"
    Wochentag(2) = "Dienstag"
    Wochentag(3) = "Mittwoch"
    Wochentag(4) = "Donnerstag"
    Wochentag(5) = "Freitag"
    Wochentag(6) = "Samstag"
    Tageszeit(0) = "vormittags"
    Tageszeit(1) = "nachmittags"
    Offset = 0

    Set excelRange = Selection

    Set jsonDictionary = New Scripting.Dictionary
    Set plan = New Scripting.Dictionary
    jsonDictionary.Add "KW", Cells(1, 1)

    For i = 1 To excelRange.Columns.Count
        If (excelRange.Columns.Cells(1, i) = "") Then GoTo NextIteration
        Set kurs = New Scripting.Dictionary
        Set days = New Scripting.Dictionary 'f�r die Wochentage
        
        For j = 1 To 5
            Set timeofday = New Scripting.Dictionary 'f�r vormittag/nachmittag
            
            For k = 0 To 1
                Set content = New Scripting.Dictionary 'Inhalte
                content.Add "Fach", excelRange.Columns.Cells(2 + Offset, i)
                content.Add "Trainer", excelRange.Columns.Cells(3 + Offset, i)
                content.Add "Raum", excelRange.Columns.Cells(4 + Offset, i)
                Offset = Offset + 3
                timeofday.Add Tageszeit(k), content
                Set content = Nothing
            Next k
            
            Offset = Offset + 4
            days.Add Wochentag(j), timeofday
            Set timeofday = Nothing
        Next j
        
        Offset = 0
        kurs.Add "Inhalte", days
        Set days = Nothing
        plan.Add excelRange.Columns.Cells(1, i), kurs
    NextIteration:
    Next i

    jsonDictionary.Add "Plan", plan
    Set plan = Nothing
    jsonItems.Add jsonDictionary
    Set jsonDictionary = Nothing
    Set jsonFileExport = jsonFileObject.CreateTextFile("stundenplan.json", True)
    jsonFileExport.WriteLine (JsonConverter.ConvertToJson(jsonItems, Whitespace:=3))

End Sub

