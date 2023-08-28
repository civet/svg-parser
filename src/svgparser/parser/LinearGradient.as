package svgparser.parser
{
    import flash.display.GradientType;
    import flash.display.SpreadMethod;
    import flash.geom.Matrix;
    import flash.geom.Point;

    import svgparser.parser.IGradient;
    import svgparser.parser.IParser;
    import svgparser.parser.model.Data;
    import svgparser.parser.style.Style;
    import svgparser.parser.style.Transform;
    import svgparser.parser.utils.GeomUtil;
    import svgparser.parser.utils.StyleUtil;
       
    public class LinearGradient implements IParser, IGradient
    {
        public static var LOCALNAME:String = "linearGradient";
           
        public var id:String;
           
        protected var _type:String = GradientType.LINEAR;
        protected var _colors:Array = [];
        protected var _alphas:Array = [];
        protected var _ratios:Array = [];
        protected var _matrix:Matrix = new Matrix();
        protected var _method:String = SpreadMethod.PAD;
           
        protected var _linked:String;
        protected var _transform:Transform;
        protected var _unit:String;
           
        private var _x1:Number;
        private var _x2:Number;
        private var _y1:Number;
        private var _y2:Number;
           
        protected var pts:Vector.<Point>;
           
        public function LinearGradient() { }
           
        public function getId():String
        {
            return id;
        }
           
        public function parse( data:Data ):void
        {
            var style:Style = new Style( data.currentXml );
            this.id = style.id;
               
            _transform = style.gradientTransform;
            _unit = style.gradientUnits;
            _linked = style.href;
               
            _x1 = getValue( data.currentXml.@x1 );
            _x2 = getValue( data.currentXml.@x2 );
            _y1 = getValue( data.currentXml.@y1 );
            _y2 = getValue( data.currentXml.@y2 );
               
            pts = new Vector.<Point>();
            pts.push( new Point( _x1, _y1 ) );
            pts.push( new Point( _x2, _y2 ) );
               
            var distance:Number = GeomUtil.getDistance( pts[0], pts[1] );
            var boxheight:Number = Math.max( Math.abs(pts[0].x - pts[1].x ), Math.abs(pts[0].y - pts[1].y ));
            var angle:Number = GeomUtil.getAngle(pts[0], pts[1]);
            var topleft:Point = new Point( pts[0].x , pts[0].y  );

            _matrix.createGradientBox( distance , boxheight , 0, topleft.x, topleft.y );
            _matrix.translate( - topleft.x , - topleft.y  );
            _matrix.rotate( angle );
            _matrix.translate( topleft.x, topleft.y  );
               
            if ( _transform ) _matrix.concat( _transform.getMatrix() );
               
            var svg:Namespace = Constants.svg;
            var stops:XMLList = data.currentXml.svg::stop;
            for each( var stop:XML in stops ) {
                parseStop( stop );
            }
               
            if ( _linked != null ) setData( data );
            data.addGradient( this );
        }
           
        public function setData( data:Data ):void
        {
            var linkedGrad:IGradient = data.getGradientById( _linked );
            if ( !linkedGrad ) return;
            _colors = linkedGrad.colors.concat();
            _alphas = linkedGrad.alphas.concat();
            _ratios = linkedGrad.ratios.concat();
        }
           
        protected function parseStop( stop:XML ):void
        {
            var style:Style = new Style( stop );
            _colors.push( style.stop_color );
            _alphas.push( style.stop_opacity );
            _ratios.push( style.offset * 255 );
        }
           
        protected function getValue( val:String ):Number {
            return StyleUtil.toNumber( val );
        }
           
        public function get type():String { return _type; }
        public function get colors():Array { return _colors; }
        public function get alphas():Array { return _alphas; }
        public function get ratios():Array { return _ratios; }
        public function get matrix():Matrix { return _matrix; }
        public function get method():String { return _method; }
        public function get linked():String { return _linked; }
        public function get transform():Transform { return _transform; }
        public function get unit():String { return _unit; }
    }
}