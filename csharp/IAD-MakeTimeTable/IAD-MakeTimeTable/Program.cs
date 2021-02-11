using System;
using System.Text.Json;

namespace IAD_MakeTimeTable
{
    class Program
    {
        static void Main(string[] args)
        {
            string contents = System.IO.File.ReadAllText("C:\\Users\\lokaleradmin\\Documents\\stundenplan.json",System.Text.Encoding.UTF8);
            contents = contents.Replace("[", "");
            contents = contents.Replace("]", "");
            IADPlan DerPlan = JsonSerializer.Deserialize<IADPlan>(contents);
            Console.WriteLine(contents);
        }
    }
}
