package svgparser.parser
{
    import flash.display.Graphics;
    import flash.display.GraphicsPathCommand;
    import flash.display.Shape;

    import svgparser.parser.IParser;
    import svgparser.parser.abstract.AbstractPaint;
    import svgparser.parser.model.Data;
    import svgparser.parser.style.Style;
       
    public class Polygon extends AbstractPaint implements IParser
    {
        public static var LOCALNAME:String = "polygon";
           
        private var _commands:Vector.<int>;
        private var _vertices:Vector.<Number>;
           
        public function Polygon() { }
           
        public function parse( data:Data ):void
        {
            var target:Shape = new Shape();
            var style:Style = new Style( data.currentXml );
               
            var points:Array = data.currentXml.@points.toString().replace(/\s+$/, "")
                                                                .replace(/\s+/g , ",")
                                                                .split(",");
            _vertices = Vector.<Number>( points );
            _vertices.push( _vertices[0], _vertices[1] );
               
            var comLength:int = (_vertices.length / 2 ) -1;
            _commands  = Vector.<int>([GraphicsPathCommand.MOVE_TO]);
            for ( var i:int = 0 ; i < comLength   ; i++ )
                _commands.push( GraphicsPathCommand.LINE_TO );

            paint( target, style, data );
            data.currentCanvas.addChild( target );
        }
           
        override protected function draw( graphics:Graphics ):void 
        {
            graphics.drawPath( _commands, _vertices );
        }
    }
}