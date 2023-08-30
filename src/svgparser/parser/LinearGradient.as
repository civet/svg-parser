package svgparser.parser
{
    import flash.display.GradientType;
    import flash.display.SpreadMethod;
    import flash.geom.Matrix;
    import flash.geom.Point;
    import flash.geom.Rectangle;

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
        protected var _method:String = SpreadMethod.PAD;
        protected var _unit:String = "objectBoundingBox";
        protected var _matrix:Matrix = new Matrix();
        protected var _transform:Transform;
        protected var _linked:String;
           
        private var _x1:Number;
        private var _x2:Number;
        private var _y1:Number;
        private var _y2:Number;
           
        protected var pt1:Point = new Point();
        protected var pt2:Point = new Point();
           
        public function LinearGradient() { }
           
        public function getId():String
        {
            return id;
        }

        public function updateMatrix(objectBoundingBox:Rectangle = null):void
        {
            if(_unit == "userSpaceOnUse") {
                pt1.x = _x1;
                pt1.y = _y1;
                pt2.x = _x2;
                pt2.y = _y2;
            }
            else if(objectBoundingBox) {
                pt1.x = _x1 * objectBoundingBox.width;
                pt1.y = _y1 * objectBoundingBox.height;
                pt2.x = _x2 * objectBoundingBox.width;
                pt2.y = _y2 * objectBoundingBox.height;
            }
            else {
                _matrix.identity();
                if (_transform) _matrix.concat( _transform.getMatrix() );
                return;
            }

            var distance:Number = GeomUtil.getDistance( pt1, pt2 );
            var boxheight:Number = Math.max( Math.abs(pt1.x - pt2.x ), Math.abs(pt1.y - pt2.y ));
            var angle:Number = GeomUtil.getAngle(pt1, pt2);
            var topleft:Point = new Point( pt1.x , pt1.y );

            _matrix.identity();
            _matrix.createGradientBox( distance , boxheight , 0, topleft.x, topleft.y );
            _matrix.translate( - topleft.x , - topleft.y );
            _matrix.rotate( angle );
            _matrix.translate( topleft.x, topleft.y );
            
            if (_transform) _matrix.concat( _transform.getMatrix() );
        }
           
        public function parse( data:Data ):void
        {
            var style:Style = new Style( data.currentXml );
            this.id = style.id;
               
            _transform = style.gradientTransform;
            _unit = style.gradientUnits;
            _linked = style.href;
            
            // starting point and ending point of the vector gradient
            _x1 = getValue( data.currentXml.@x1 );
            _y1 = getValue( data.currentXml.@y1 );
            _x2 = getValue( data.currentXml.@x2 );
            _y2 = getValue( data.currentXml.@y2 );
               
            var svg:Namespace = Constants.svg;
            var stops:XMLList = data.currentXml.svg::stop;
            // --- bugfix: <stop> node without namespace should also support ---
            if(stops.length() == 0) {
                stops = data.currentXml.stop;
            }
            // ------
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
            // TODO: other props?
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
        public function get method():String { return _method; }
        public function get unit():String { return _unit; }
        public function get matrix():Matrix { return _matrix; }
        public function get transform():Transform { return _transform; }
        public function get linked():String { return _linked; }
    }
}