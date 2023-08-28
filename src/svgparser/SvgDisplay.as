package  svgparser
{
    import flash.display.Sprite;
    import flash.events.Event;

    import svgparser.font.FontConverter;
    import svgparser.parser.SvgFactory;
    
    public class SvgDisplay extends Sprite
    {        
        protected var svg:XML;
        protected var settings:Settings;
        
        public function SvgDisplay( xml:XML = null )
        {
            settings = new Settings();
            if( xml ) parse( xml );
        }
        
        public function parse( xml:XML ):void
        {
            this.svg = XML( xml );
            var factory:SvgFactory = new SvgFactory();
            factory.addEventListener( Event.COMPLETE, onParseComplete );
            factory.parse( xml, this, settings );
        }

        private function onParseComplete( event:Event ):void
        {
            event.currentTarget.removeEventListener( Event.COMPLETE, onParseComplete );
            this.dispatchEvent( event );
        }
        
        public function addFontConversion( svgFontName:String, swfFontName:String, fontLookup:String = null ):void 
        {
            settings.addFontConversion( new FontConverter( svgFontName, swfFontName, fontLookup ) );
        }
    }
}