package svgparser.parser
{
    import flash.display.Graphics;
    import flash.display.Shape;

    import svgparser.parser.IParser;
    import svgparser.parser.abstract.AbstractPaint;
    import svgparser.parser.model.Data;
    import svgparser.parser.style.Style;
    import svgparser.parser.utils.StyleUtil;

    public class Circle extends AbstractPaint implements IParser
    {
        public static var LOCALNAME:String = "circle";
           
        private var _cx:Number;
        private var _cy:Number;
        private var _r:Number;
           
        public function Circle() { }

        public function parse( data:Data ):void
        {
            var target:Shape = new Shape();
            var style:Style = new Style( data.currentXml );
            if ( !style.display ) return;

            _cx = StyleUtil.toNumber ( data.currentXml.@cx );
            _cy = StyleUtil.toNumber ( data.currentXml.@cy );
            _r =  StyleUtil.toNumber ( data.currentXml.@r );
               
            paint( target, style, data );
            data.currentCanvas.addChild( target );
        }
           
        override protected function draw( graphics:Graphics ):void 
        {
            graphics.drawCircle( _cx, _cy, _r );
        }
    }

}