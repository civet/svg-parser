package svgparser.parser
{
    import flash.display.LineScaleMode;
    import flash.filters.BitmapFilterQuality;
    import flash.text.engine.FontLookup;
    import flash.text.engine.FontWeight;
       
    public class Constants
    {
        //namespaces
        public static const svg:Namespace = new Namespace( "svg", "http://www.w3.org/2000/svg" );
        public static const xlink:Namespace = new Namespace( "xlink", "http://www.w3.org/1999/xlink" );
           
        //Default Settings
        public static const FONT_FAMILY:String = "_sans";
        public static const FONT_SIZE:Number = 30;
        public static const FONT_WEIGHT:String = FontWeight.NORMAL;
        public static const FONT_LOOKUP:String = FontLookup.DEVICE;
        public static const FILL_COLOR:uint = 0x000000;
        public static const STROKE_COLOR:uint = 0x000000;
        public static const LINE_PIXEL_HINTING:Boolean = false;
        public static const LINE_SCALE_MODE:String = LineScaleMode.NORMAL;
        public static const BLUR_QUALITY:int = BitmapFilterQuality.HIGH;
        public static const BEZIER_DETAIL:uint = 20;
        public static const ENABLE_FILTER:Boolean = true;

    }

}