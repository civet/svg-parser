package svgparser.parser
{
    import flash.display.Graphics;
    import flash.display.GraphicsPathCommand;
    import flash.display.Shape;

    import svgparser.parser.IParser;
    import svgparser.parser.abstract.AbstractPaint;
    import svgparser.parser.model.Data;
    import svgparser.parser.style.Style;
    import svgparser.parser.utils.StyleUtil;
       
    public class Line extends AbstractPaint implements IParser
    {
        public function Line() { }
           
        public static var LOCALNAME:String = "line";
           
        private var _x1:Number;
        private var _y1:Number;
        private var _x2:Number;
        private var _y2:Number;
           
        private var _commands:Vector.<int>;
        private var _vertices:Vector.<Number>;
           
        public function parse( data:Data ):void
        {
            var target:Shape = new Shape();
            var style:Style = new Style( data.currentXml );
            if ( !style.display ) return;
               
            _x1 = StyleUtil.toNumber( data.currentXml.@x1 );
            _x2 = StyleUtil.toNumber( data.currentXml.@x2 );
            _y1 = StyleUtil.toNumber( data.currentXml.@y1 );
            _y2 = StyleUtil.toNumber( data.currentXml.@y2 );
               
            _vertices = Vector.<Number>([ _x1, _y1 , _x2 , _y2 ]);
            _commands  = Vector.<int>([ GraphicsPathCommand.MOVE_TO, GraphicsPathCommand.LINE_TO ]);
               
            paint( target, style, data );
            data.currentCanvas.addChild( target );
        }
           
        override protected function draw( graphics:Graphics ):void 
        {
            graphics.drawPath( _commands, _vertices );
        }
    }
}