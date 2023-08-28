package
{
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.net.*;
    import flash.text.engine.FontLookup;
    
    import svgparser.SvgDisplay;
    

    public class SampleFontReplace extends Sprite
    {
        public var svgurl:String = "svg/svgparser.svg";
        public var svgSprite:SvgDisplay;
        
        public function SampleFontReplace():void
        {
            XML.ignoreWhitespace = false;   //to preserve spaces inside texts
            var loader:URLLoader = new URLLoader( new URLRequest( svgurl ) );
            loader.addEventListener( Event.COMPLETE , displayData );
        }
                
        private function displayData( e:Event ):void {
            var svgxml:XML = XML( e.currentTarget.data );
            
            svgSprite = new SvgDisplay();
            
            //replace font ( svg font name, swf font name , font lookup (  device or embedded )
            svgSprite.addFontConversion( "Bitstream Vera Sans", "Time New Roman" , FontLookup.EMBEDDED_CFF );
            svgSprite.parse( svgxml );      //parse SVG
            
            addChild( svgSprite );         
        }
    }
       
}