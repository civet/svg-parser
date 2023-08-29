package svgparser.parser
{
    import flash.display.*;

    import svgparser.parser.abstract.AbstractPaint;
    import svgparser.parser.model.Data;
    import svgparser.parser.style.Style;
    import svgparser.parser.utils.StyleUtil;
    
    public class Rect extends AbstractPaint implements IParser
    {
        public static var LOCALNAME:String = "rect";
        
        public function Rect() { }
        
        private var _x:Number;
        private var _y:Number;
        private var _width:Number;
        private var _height:Number;
        
        public function parse( data:Data ):void
        {
            var target:Shape = new Shape();
            var xml:XML = data.currentXml;
            var style:Style = new Style( xml );
            if ( !style.display ) return;
            
            _x = StyleUtil.toNumber( xml.@x );
            _y = StyleUtil.toNumber( xml.@y );
            _width = StyleUtil.toNumber( xml.@width.toString() );
            _height = StyleUtil.toNumber( xml.@height.toString() );

            paint( target , style, data );
            data.currentCanvas.addChild( target );
        }
        
        override protected function draw( graphics:Graphics ):void
        {
            graphics.drawRect( _x, _y, _width, _height );
        }
    }
}