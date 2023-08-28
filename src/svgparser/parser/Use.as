package svgparser.parser
{
    import flash.display.Sprite;

    import svgparser.parser.IParser;
    import svgparser.parser.model.Data;
    import svgparser.parser.style.Style;
    import svgparser.parser.utils.StyleUtil;
       
    public class Use implements IParser
    {
        public static var LOCALNAME:String = "use";
           
        private var _x:Number;
        private var _y:Number;
        private var _width:Number;
        private var _height:Number;
        private var _href:String;
           
        public function Use() { }
           
        public function parse( data:Data ):void
        {
            var style:Style = new Style( data.currentXml );
            _href = style.href;
            _x = StyleUtil.toNumber( data.currentXml.@x );
            _y = StyleUtil.toNumber( data.currentXml.@y );
            _width = StyleUtil.toNumber( data.currentXml.@width );
            _height = StyleUtil.toNumber( data.currentXml.@height );
               
            var currentXML:XML = data.currentXml.copy();
            var appendXML:XML = data.xml..*.(  attribute("id") == _href  )[0].copy();
            if( appendXML.localName() == "symbol" ) appendXML.setLocalName( "g" );
            currentXML.appendChild( appendXML );
            currentXML.setLocalName(  "_use" );
               
            var symbol:Sprite = new Sprite();
            var localData:Data = data.copy( currentXML, symbol );
            localData.overrideStyle( currentXML );
            SvgFactory.parseData( localData );
            symbol.x = _x;
            symbol.y = _y;
            if( _width != 0 ) symbol.width = _width;
            if( _height != 0 ) symbol.height = _height;
            style.applyStyle( symbol, data );
            data.currentCanvas.addChild( symbol );
        }
    }
}