package svgparser.parser.style
{
    import flash.geom.Matrix;

    import svgparser.parser.utils.GeomUtil;
    
    public class Transform
    {
        public var type:String;

        private var _matrix:Matrix;
        private var _vals:Array;
        
        public function Transform(value:String = null)
        {
            _matrix = new Matrix();

            if (value != null) this.parse( value );
        }
        
        public function parse(value:String):void
        {
            // trim
            value = value ? value.replace(/^\s+|\s+$/gs, '') : "";

            this.type = value.replace(/(.+)\(.+\)/,"$1");

            if (value.indexOf(",") != -1 || value.indexOf(" ") != -1)
            {
                _vals = value.replace(/.+\((.+)\)/,"$1").split(/[\s\,]/);
            }
            else
            {
                _vals = [ Number(value.replace(/.+\((.+)\)/,"$1")) ];
            }

            switch(this.type)
            {
                case "matrix":
                    _matrix = new Matrix( _vals[0],_vals[1],_vals[2],_vals[3],_vals[4],_vals[5] );
                    break;

                case "translate":
                    _matrix.translate( _vals[0],_vals[1] );
                    break;

                case "scale":
                    if (_vals.length < 2)
                    {
                        _vals.push( _vals[0] );
                    }
                    _matrix.scale( _vals[0],_vals[1] );
                    break;

                case "rotate":
                    if(_vals.length >= 3)
                    {
                        _matrix.translate( -_vals[1],-_vals[2] );
                        _matrix.rotate( GeomUtil.degree2radian(_vals[0]) );
                        _matrix.translate( _vals[1],_vals[2] );
                    }
                    else {
                        _matrix.rotate( GeomUtil.degree2radian(_vals[0]) );
                    }
                    break;

                case "skewX":
                    _matrix.c = Math.tan( GeomUtil.degree2radian(_vals[0]) );
                    break;

                case "skewY":
                    _matrix.b = Math.tan( GeomUtil.degree2radian(_vals[0]) );
                    break;

                default:
                    break;
            }
        }
        
        public function getMatrix():Matrix {
            return _matrix;
        }
    }
}
