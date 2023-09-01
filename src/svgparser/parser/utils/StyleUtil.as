package svgparser.parser.utils
{
    public class StyleUtil
    {
        public static function hsl2rgb(h:Number, s:Number, l:Number):Array 
        {
            s /= 100;
            l /= 100;
            var k:Function = function(n:Number):Number { 
                return (n + h / 30) % 12;
            }
            var a:Number = s * Math.min(l, 1 - l);
            var f:Function = function(n:Number):Number {
                return l - a * Math.max(-1, Math.min(k(n) - 3, Math.min(9 - k(n), 1)));
            }
            return [
                Math.round(255 * f(0)), 
                Math.round(255 * f(8)), 
                Math.round(255 * f(4))
            ];
        };

        public static function numbersToHex(numbers:Array):String
        {
            return numbers.map(function(n:Number, i:int, a:Array):String {
                var d:String = n.toString(16);
                return d.length > 1 ? d : "0" + d;
            }).join("");
        }

        public static function toColor(code:String) : uint
        {
            if(code.match(/^([a-zA-Z]+)$/) != null)
            {
                code = NamedColors.toCode( code );
            }
            
            // rgb notation
            if(code.indexOf("rgb(") != -1)
            {
                var rgb:Array = code.replace(/rgb\((.*)\)/, "$1")
                    .split(",")
                    .map(function(value:String, i:int, a:Array):Number {
                        return (value.indexOf("%") != -1) ? 
                            Math.round(parseInt(value.replace("%", ""), 10) / 100 * 255) :
                            parseInt(value, 10);
                    });
                return parseInt( numbersToHex(rgb), 16 );
            }

            // rgba notation
            if(code.indexOf("rgba(") != -1)
            {
                var rgba:Array = code.replace(/rgba\((.*)\)/, "$1").split(",");
                var argb:Array = [rgba[3], rgba[0], rgba[1], rgba[2]]
                    .map(function(value:String, i:int, a:Array):Number {
                        if (value.indexOf("%") != -1) {
                            return Math.round(parseInt(value.replace("%", ""), 10) / 100 * 255);
                        }
                        else if (value.indexOf(".") != -1) {
                            return Math.round(parseFloat(value) * 255);
                        }
                        return parseInt(value, 10);
                    });
                return parseInt( numbersToHex(argb), 16 );
            }

            // hsl notation
            if(code.indexOf("hsl(") != -1)
            {
                var hsl:Array = code.replace(/hsl\((.*)\)/, "$1").split(",");
                var h:Number = parseInt(hsl[0], 10);
                var s:Number = parseInt(hsl[1].replace("%", ""), 10);
                var l:Number = parseInt(hsl[2].replace("%", ""), 10);
                return parseInt( numbersToHex( hsl2rgb(h, s, l) ), 16 );
            }
            
            // shorthand hex notation
            var shorthand:Object = /^#([0-9a-fA-F])([0-9a-fA-F])([0-9a-fA-F])$/.exec(code);
            if(shorthand != null)
            {
                var r:String = shorthand[1];
                var g:String = shorthand[2];
                var b:String = shorthand[3];
                return uint("0x" + r + r + g + g + b + b);
            }

            // hex notation
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
