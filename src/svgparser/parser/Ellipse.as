package svgparser.parser
{
    import flash.display.Graphics;
    import flash.display.Shape;

    import svgparser.parser.abstract.AbstractPaint;
    import svgparser.parser.model.Data;
    import svgparser.parser.style.Style;
    import svgparser.parser.utils.StyleUtil;
       
    public class Ellipse extends AbstractPaint implements IParser
    {
        public static var LOCALNAME:String = "ellipse";
           
        private var _cx:Number;
        private var _cy:Number;
        private var _rx:Number;
        private var _ry:Number;
           
        public function Ellipse() { } 
           
        public function parse( data:Data ):void
        {
            var target:Shape = new Shape();
            var style:Style = new Style( data.currentXml );
            if ( !style.display ) return;
               
            _cx = StyleUtil.toNumber( data.currentXml.@cx );
            _cy = StyleUtil.toNumber( data.currentXml.@cy );
            _rx = StyleUtil.toNumber( data.currentXml.@rx );
            _ry = StyleUtil.toNumber( data.currentXml.@ry );
               
            paint( target, style, data );
            data.currentCanvas.addChild( target );
        }
           
        override protected function draw( graphics:Graphics ):void 
        {
            graphics.drawEllipse( _cx - _rx, _cy -_ry , _rx * 2, _ry * 2 );
        }
    }
}