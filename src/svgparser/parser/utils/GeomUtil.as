package svgparser.parser.utils
{
    import flash.geom.Point;
    
    public class GeomUtil
    {  
        public static function getDistance(a:Point, b:Point) : Number
        {
            var dx:Number = b.x - a.x;
            var dy:Number = b.y - a.y;
            return Math.sqrt(dx * dx + dy * dy);
        }
        
        public static function getAngle(a:Point, b:Point) : Number
        {
            var dx:Number = b.x - a.x;
            var dy:Number = b.y - a.y;
            return Math.atan2(dy, dx);
        }
        
        public static function degree2radian(a:Number) : Number
        {
            return a * Math.PI / 180;
        }
    }
}
