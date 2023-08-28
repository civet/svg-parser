package svgparser.parser
{
    import svgparser.parser.model.Data;
    
    public class Marker implements IParser
    {
        public static var LOCALNAME:String = "marker";
           
        public function Marker() { }

        public function parse( data:Data ):void { }
    }
}