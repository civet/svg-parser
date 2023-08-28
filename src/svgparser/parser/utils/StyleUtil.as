package svgparser.parser.utils
{
    public class StyleUtil
    {
        public static function toColor(code:String) : uint
        {
            if(code.lastIndexOf("rgb") != -1)
            {
                var rgb:Array = code.replace(/rgb\((.+)\)/,"$1").split(",");
                var hex:String = "";
                for each(var value:String in rgb)
                {
                    var v:String = int(value).toString(16);
                    hex += code.length > 1 ? v : "0" + v;
                }
                return uint("0x" + hex);
            }
            return uint(code.replace(/#/,"0x"));
        }
        
        public static function toURL(value:String) : String
        {
            return value.replace(/url\(#(.+)\)/,"$1");
        }
        
        public static function toNumber(value:String) : Number
        {
            if(value.indexOf("%") != -1)
            {
                return Number(value.replace(/%/,"")) / 100;
            }
            return Number(value.replace(/%|mm|px/,""));
        }
        
        public static function removeNameSpace(value:String) : String
        {
            return value.replace(/http(.+)::(.+)/,"$2");
        }
    }
}
