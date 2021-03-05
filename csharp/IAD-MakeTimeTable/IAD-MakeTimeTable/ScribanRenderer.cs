using System;
using Scriban;
using Scriban.Runtime;

namespace IAD_MakeTimeTable
{
    public static class ScribanRenderer
    {

        // statische Klasse zum Rendern von verschachtelten Dictionaries mit Scriban.
        // Quelltext von: https://github.com/scriban/scriban/issues/115

        public static string Render(string templateBody, Object model)
        {
            var template = Template.Parse(templateBody);
            var vars = new ScriptObject();
            vars.Import(model, renamer: r => r.Name);
            var context = new TemplateContext { MemberRenamer = r => r.Name, MemberFilter = null };
            context.PushGlobal(vars);
            return template.Render(context);
        }
    }
}
