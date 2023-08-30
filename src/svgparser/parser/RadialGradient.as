package svgparser.parser
{
    import flash.display.GradientType;
    import flash.geom.Point;

    import svgparser.parser.IGradient;
    import svgparser.parser.IParser;
    import svgparser.parser.model.Data;
    import svgparser.parser.style.Style;
    import svgparser.parser.utils.GeomUtil;
    import flash.geom.Rectangle;
       
    public class RadialGradient extends LinearGradient implements IParser, IGradient
    {
        public static var LOCALNAME:String = "radialGradient";
           
        protected var _cx:Number;
        protected var _cy:Number;
        protected var _r:Number;
        protected var _fx:Number;
        protected var _fy:Number;
        protected var _fr:Number;

        public function RadialGradient() 
        {
            super();
            _type = GradientType.RADIAL;
        }

        override public function updateMatrix(objectBoundingBox:Rectangle = null):void
        {
            var centerX:Number = 0.5;
            var centerY:Number = 0.5;

            // var radius:Number = 0.5;
            var radiusX:Number = 0.5;
            var radiusY:Number = 0.5;
            
            var focalX:Number = 0.5;
            var focalY:Number = 0.5;
            
            var focalRadius:Number = 0.0;

            if(_unit == "userSpaceOnUse") {
                centerX = _cx;
                centerY = _cy;
                // radius = _r;
                radiusX = _r;
                radiusY = _r;
                focalX = _fx;
                focalY = _fy;
                focalRadius = _fr;
            }
            else if(objectBoundingBox) {
                centerX = _cx * objectBoundingBox.width;
                centerY = _cy * objectBoundingBox.height;
                // radius = _r * objectBoundingBox.width;
                radiusX = _r * objectBoundingBox.width;
                radiusY = _r * objectBoundingBox.height;
                focalX = _fx * objectBoundingBox.width;
                focalY = _fy * objectBoundingBox.height;
                // TODO
                // focalRadius = _fr * objectBoundingBox.width;
            }

            _matrix.identity();
            _matrix.createGradientBox(
                radiusX * 2, radiusY * 2, 
                GeomUtil.getAngle( new Point(centerX, centerY), new Point(focalX, focalY) ),
                centerX - radiusX, centerY - radiusY
            );
            
            if ( _transform ) _matrix.concat( _transform.getMatrix() );
        }
           
        override public function parse( data:Data ):void
        {
            var style:Style = new Style( data.currentXml );
            this.id = style.id;

            var currentXml:XML = data.currentXml;
            _cx = currentXml.hasOwnProperty("cx") ? getValue( currentXml.@cx ) : 0.5;
            _cy = currentXml.hasOwnProperty("cy") ? getValue( currentXml.@cy ) : 0.5;
            _r =  currentXml.hasOwnProperty("r")  ? getValue( currentXml.@r ) : 0.5;
            _fx = currentXml.hasOwnProperty("fx") ? getValue( currentXml.@fx ) : _cx ;
            _fy = currentXml.hasOwnProperty("fy") ? getValue( currentXml.@fy ) : _cy ;
            _fr = currentXml.hasOwnProperty("fr") ? getValue( currentXml.@fr ) : 0;

            _transform = style.gradientTransform;
            _unit = style.gradientUnits;
            _linked = style.href;

            var svg:Namespace = Constants.svg;
            var stops:XMLList = currentXml.svg::stop;
            // --- bugfix: <stop> node without namespace should also support ---
            if(stops.length() == 0) {
                stops = currentXml.stop;
            }
            // ------
            for each( var stop:XML in stops ) {
                parseStop( stop );
            }
               
            if ( _linked != null ) setData( data );
            data.addGradient( this );
        }
    }
}