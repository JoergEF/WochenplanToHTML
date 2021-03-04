using System.Collections.Generic;
using System.Text.Json.Serialization;



namespace IAD_MakeTimeTable
{
    class IADPlan // eine Klasse als Datentyp um den Plan aufzunehmen
    {
        public int KW { get; set; } // erstes Key-Value-Paar
        [JsonConverter(typeof(DictionaryStringObjectJsonConverter))] // Dekorator, um die Überladung zu registrieren, gilt für die nächste Variable
        public Dictionary<string, object> Plan { get; set; }
    }
}
