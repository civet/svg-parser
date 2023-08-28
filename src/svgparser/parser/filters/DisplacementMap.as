package svgparser.parser.filters
{
    import flash.display.BitmapData;
    import flash.display.BitmapDataChannel;
    import flash.display.DisplayObject;
    import flash.filters.BitmapFilter;
    import flash.filters.DisplacementMapFilter;
    import flash.geom.Point;
    
    public class DisplacementMap implements IFilter
    {
        
        public static var LOCALNAME:String = "feDisplacementMap";
         
        
        public var id:String;

        public var scale:Number;
        
        private var sourceGraphic:DisplayObject;
        private var xChannelSelector:uint;
        private var yChannelSelector:uint;
        
        private var _in:String;
        private var _in2:String;
        private var _result:String;
        
        public function DisplacementMap(xml:XML)
        {
            this.parse(xml);
        }
        
        private function getChannel(channel:String):uint
        {
            switch(channel)
            {
                case "a":
                    return BitmapDataChannel.ALPHA;
                case "b":
                    return BitmapDataChannel.BLUE;
                case "g":
                    return BitmapDataChannel.GREEN;
                case "r":
                    return BitmapDataChannel.RED;
                default:
                    return BitmapDataChannel.ALPHA;
            }
        }
        
        public function parse(xml:XML):void
        {
            this.id = xml.@id;
            this.scale = Number(xml.@scale.toString());
            this.xChannelSelector = this.getChannel(xml.@xChannelSelector.toString());
            this.yChannelSelector = this.getChannel(xml.@yChannelSelector.toString());
        }

        public function setSourceGraphic(target:DisplayObject):void
        {
            this.sourceGraphic = target;
        }
        
        public function getFlashFilter():BitmapFilter
        {
            var source:BitmapData = new BitmapData(this.sourceGraphic.width, this.sourceGraphic.height, false);
            source.draw(this.sourceGraphic);

            var filter:DisplacementMapFilter = new DisplacementMapFilter(source, new Point(), this.xChannelSelector, this.yChannelSelector, this.scale, this.scale);
            
            this.sourceGraphic = null;
            
            return filter as BitmapFilter;
        }
    }
}
