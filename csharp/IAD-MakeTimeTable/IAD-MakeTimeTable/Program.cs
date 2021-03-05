using System;
using System.Text.Json;

namespace IAD_MakeTimeTable
{
    class Program
    {
        static void Main(string[] args)
        {

            // IAD-MakeTimeTable
            // empfängt ein aus einem IAD-Wochenplan exportiertes JSON-Objekt
            // und gibt es als HTML-Stundenplan aus...

            string contents = System.IO.File.ReadAllText("C:\\Users\\lokaleradmin\\Documents\\stundenplan.json",System.Text.Encoding.UTF8);
            contents = contents.Replace("[", ""); // remove Dict-Start in Line 0
            contents = contents.Replace("]", ""); // remove Dict-End at the End of File
            IADPlan DerPlan = JsonSerializer.Deserialize<IADPlan>(contents);
            string templateFile = System.IO.File.ReadAllText("C:\\Users\\lokaleradmin\\Documents\\template.tmpl", System.Text.Encoding.UTF8);
            string result = ScribanRenderer.Render(templateFile, DerPlan);
            Console.Write(result);
        }
    }
}
