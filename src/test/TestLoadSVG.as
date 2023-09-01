package test
{
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.net.URLLoader;
    import flash.net.URLLoaderDataFormat;
    import flash.net.URLRequest;

    import svgparser.SvgDisplay;

    public class TestLoadSVG extends Sprite
    {
        public function TestLoadSVG()
        {
            this.addEventListener(Event.ADDED_TO_STAGE, function(event:Event):void {
                setup();
            });
        }

        public function setup():void
        {
            loadSVG("../images/adobe_flash.svg");
        }

        private function loadSVG(url:String):void
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