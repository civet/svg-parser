package svgparser.parser
{
    import svgparser.parser.IParser;
    import svgparser.parser.model.Data;
           
    public class FlowRoot implements IParser
    {
        public static var LOCALNAME:String = "flowRoot";
           
        public function FlowRoot() {}
           
        public function parse( data:Data ):void {}
    }
}