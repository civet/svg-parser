package svgparser.parser
{
    import flash.display.GradientType;
    import flash.geom.Point;

    import svgparser.parser.IGradient;
    import svgparser.parser.IParser;
    import svgparser.parser.model.Data;
    import svgparser.parser.style.Style;
    import svgparser.parser.utils.GeomUtil;
       
    public class RadialGradient extends LinearGradient implements IParser, IGradient
    {
        public static var LOCALNAME:String = "radialGradient";
           
        protected var _cx:Number;
        protected var _cy:Number;
        protected var _r:Number;
        protected var _fx:Number;
        protected var _fy:Number;

        public function RadialGradient() 
        {
            _type = GradientType.RADIAL;
        }
           
        override public function parse( data:Data ):void
        {
            var style:Style = new Style( data.currentXml );
            this.id = style.id;
               
            _cx = getValue( data.currentXml.@cx );
            _cy = getValue( data.currentXml.@cy );
            _r =  getValue( data.currentXml.@r  );
            _fx = !!data.currentXml.@fx ? getValue( data.currentXml.@fx ) : _cx ;
            _fy = !!data.currentXml.@fy ? getValue( data.currentXml.@fy ) : _cy ;

            _linked = style.href;
            _transform = style.gradientTransform;
            _unit = style.gradientUnits;
               
            _matrix.createGradientBox( _r * 2, _r * 2, 
                                    GeomUtil.getAngle( new Point(_cx, _cy), new Point(_fx, _fy) ),
                                    _cx - _r, _cy - _r );
            if ( _transform ) _matrix.concat( _transform.getMatrix() );
               
            var svg:Namespace = Constants.svg;
            var stops:XMLList = data.currentXml.svg::stop;
            for each( var stop:XML in stops ) {
                parseStop( stop );
            }
               
            if ( _linked != null ) setData( data );
            data.addGradient( this );
        }
    }
}