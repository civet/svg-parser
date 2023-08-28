package svgparser.parser
{
    import svgparser.parser.model.Data;

    public class Pattern implements IParser
    {
        public static var LOCALNAME:String = "pattern";
        
        public function Pattern() {}

        public function parse( data:Data ):void { }
    }
}