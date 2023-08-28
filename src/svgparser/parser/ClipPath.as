package svgparser.parser
{
    import flash.display.DisplayObject;
    import flash.display.Sprite;

    import svgparser.parser.IParser;
    import svgparser.parser.model.Data;
    import svgparser.parser.style.Style;
    
    public class ClipPath implements IParser
    {
        public static var LOCALNAME:String = "clipPath";
           
        public function ClipPath() { }
           
        public function parse( data:Data ):void 
        {
            var style:Style = new Style( data.currentXml );
            if ( !style.display ) return;

            var _xml:XML = data.currentXml;
            _xml.setLocalName( "_clipPath" );
               
            var pathObject:Sprite = new Sprite();
            pathObject.name = style.id;
            SvgFactory.parseData( data.copy( _xml, pathObject ));
            style.applyStyle( pathObject );
            data.addClipPath( pathObject as DisplayObject );
        }
    }

}