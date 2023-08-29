package svgparser.parser {
       
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.events.EventDispatcher;

    import svgparser.Settings;
    import svgparser.parser.model.Data;
       
    public class SvgFactory extends EventDispatcher
    {
        private static const PARSERS:Array = [  Svg, Group, Defs,  FlowRoot, Path, Polyline, Polygon,
                                                Ellipse, Rect, Text, Image, Line, Circle, ClipPath, Use,
                                                Marker, LinearGradient, RadialGradient, FilterSet, Symbol ];
           
        public function SvgFactory() { }
           
        public function parse( xml:XML , target:Sprite , settings:Settings ):void
        {
            XML.ignoreWhitespace = false;
            
            xml.removeNamespace( Constants.svg );
            xml.removeNamespace( Constants.xlink );
               
            parseData( new Data( xml , target , settings ) );
            
            this.dispatchEvent( new Event( Event.COMPLETE ) );
        }
           
        public static function parseData( data:Data ):void
        {
            getParser( data.currentXml ).parse( data );
        }
           
        private static function getParser( xml:XML ):IParser
        {
            for each( var Ps:Class in PARSERS )
                if ( xml.localName() == Ps["LOCALNAME"] ) return new Ps();
            return new ComplexTree();
        }
    }
}