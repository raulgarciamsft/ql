// semmle-extractor-options: /r:System.Runtime.Extensions.dll /r:System.IO.Filesystem.dll
using System.IO;
using System.Web.Script.Serialization;

namespace DeserializersDotNet
{
    class JavascriptSerializer
    {
        public static object DeserializeWithTypeResolver(string text)
        {
            // BAD: use of JacaScriptSerializer with custom type resolver
            JavaScriptSerializer sr = new JavaScriptSerializer(new SimpleTypeResolver());
            return sr.DeserializeObject(text);
        }

        public static object Deserialize(string text)
        {
            // GOOD - no resolver
            JavaScriptSerializer sr = new JavaScriptSerializer();
            return sr.DeserializeObject(text);
        }

        public static void Main ()
        {
            var text = File.ReadAllText(@"\\testpath\testdir\file.txt");
            Deserialize(text);
            DeserializeWithTypeResolver(text);
        }
    }
}
