package svgparser.parser
{
    import svgparser.parser.IParser;
    import svgparser.parser.model.Data;
    
    public class Symbol implements IParser
    {
        public static var LOCALNAME:String = "symbol";
        
        public function Symbol() { }

        public function parse( data:Data ):void { }
    }
}