using System;
using System.Collections.Generic;
using System.Text;
using Scriban;
using Scriban.Runtime;
using System.Text.Json;
using System.Dynamic;

namespace IAD_MakeTimeTable
{
    public static class ScribanRenderer
    {
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
