package svgparser.parser.filters
{
    import flash.display.DisplayObject;
    import flash.filters.BitmapFilter;
    import flash.filters.ColorMatrixFilter;

    import svgparser.parser.utils.GeomUtil;
    
    public class ColorMatrix implements IFilter
    {
        public static var LOCALNAME:String = "feColorMatrix";
         
        public var id:String;
        
        private var _matrix:Array;
        
        private var _in:String;
        private var _in2:String;
        private var _result:String;
        
        public function ColorMatrix(xml:XML)
        {
            this.parse(xml);
        }
        
        public function setSourceGraphic(target:DisplayObject):void
        {
            
        }
        
        private function getMatrixByType(type:String, value:String):Array
        {
            // ref: https://drafts.fxtf.org/filter-effects/#feColorMatrixElement

            switch(type)
            {
                case "luminanceToAlpha":
                    return [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.2125,0.7154,0.0721,0,0];

                case "saturate":
                    var s:Number = Number(value);
                    var sr:Number = 1 - s;
                    var a:Number = sr * 0.3086;
                    var b:Number = sr * 0.6094;
                    var c:Number = sr * 0.082;
                    return [
                        a+s, b, c, 0, 0, 
                        a, b+s, c, 0, 0,
                        a, b, c+s, 0, 0, 
                        0, 0, 0,   1, 0
                    ];
                
                case "hueRotate":
                    var angle:Number = GeomUtil.degree2radian(Number(value));
                    var cosA:Number = Math.cos(angle);
                    var sinA:Number = Math.sin(angle);
                    var a0:Number = 0.213;
                    var a1:Number = 0.715;
                    var a2:Number = 0.072;
                    return [
                        a0 + cosA * (1 - a0) + sinA * -a0, 
                        a1 + cosA * -a1 + sinA * -a1, 
                        a2 + cosA * -a2 + sinA * (1 - a2),
                        0,
                        0,
                        a0 + cosA * -a0 + sinA * 0.143,
                        a1 + cosA * (1 - a1) + sinA * 0.14,
                        a2 + cosA * -a2 + sinA * -0.283,
                        0,
                        0,
                        a0 + cosA * -a0 + sinA * -(1 - a0),
                        a1 + cosA * -a1 + sinA * a1,
                        a2 + cosA * (1 - a2) + sinA * a2,
                        0,
                        0,
                        0,0,0,1,0,
                        0,0,0,0,1
                    ];
                
                default:
                    return value.replace(/\s$/,"").split(" ");
            }
        }
        
        public function parse(xml:XML):void
        {
            var vals:Array;

            this.id = xml.@id;

            if(xml.@values)
            {
                var value:String = xml.@values.toString();
                if(value.indexOf(" ") != -1)
                {
                    vals = value.split(" ");
                }
                else if(value.indexOf(",") != -1)
                {
                    vals = value.split(",");
                }
                _matrix = vals;
            }
            if(xml.@type)
            {
                _matrix = this.getMatrixByType(xml.@type.toString(), xml.@values.toString());
            }
        }
        
        public function getFlashFilter():BitmapFilter
        {
            return new ColorMatrixFilter(_matrix) as BitmapFilter;
        }
    }
}
