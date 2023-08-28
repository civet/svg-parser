package {

    import flash.display.Sprite;
    import flash.display.StageAlign;
    import flash.display.StageScaleMode;
    import flash.events.Event;
    import flash.net.URLLoader;
    import flash.net.URLLoaderDataFormat;
    import flash.net.URLRequest;

    import svgparser.SvgDisplay;

    [SWF(width="640", height="480", backgroundColor="0xFFFFFF", frameRate="60")]

    public class Test extends Sprite
    {
        public var url:String = "../images/adobe_flash.svg";

        public function Test()
        {
            stage.scaleMode = StageScaleMode.NO_SCALE;
            stage.align = StageAlign.TOP_LEFT;
            
            loadSVG();
        }

        private function loadSVG():void
        {
            var loader:URLLoader = new URLLoader();
            loader.addEventListener(Event.COMPLETE , onSVGLoaded);
            loader.dataFormat = URLLoaderDataFormat.TEXT;
            loader.load( new URLRequest(url) );
        }

        private function onSVGLoaded(event:Event):void 
        {
            // XML.ignoreWhitespace = false;
            var xml:XML = new XML( event.currentTarget.data );
            
            var svg:SvgDisplay = new SvgDisplay(xml);
            svg.width = 256;
            svg.height = 256;
            svg.x = stage.stageWidth - svg.width >> 1;
            svg.y = stage.stageHeight - svg.height >> 1;
            this.addChild( svg );
        }
    }
}