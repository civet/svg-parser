package svgparser.parser.filters
{
    import flash.display.DisplayObject;
    import flash.filters.BitmapFilter;
    import flash.filters.BlurFilter;

    import svgparser.parser.Constants;
    
    public class GaussianBlur implements IFilter
    {
        public static var LOCALNAME:String = "feGaussianBlur";

        public var id:String;
        
        public var amount:Number;
        
        private var quality:int;

        private var _in:String;
        private var _in2:String;
        private var _result:String;
        
        public function GaussianBlur(xml:XML)
        {
            this.quality = Constants.BLUR_QUALITY;
            this.parse(xml);
        }
        
        public function parse(xml:XML):void
        {
            this.id = xml.@id;
            this.amount = Number(xml.@stdDeviation) * 2.55;
        }
        
        public function setSourceGraphic(target:DisplayObject):void
        {

        }
        
        public function getFlashFilter():BitmapFilter
        {
            return new BlurFilter(this.amount, this.amount, this.quality) as BitmapFilter;
        }
    }
}
