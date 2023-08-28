package
{
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.net.*;
    
    import svgparser.SvgDisplay;
    

    public class Sample extends Sprite
    {
        public var svgurl:String = "svg/svgparser.svg";
        public var svgSprite:SvgDisplay;
        
        public function Sample():void
        {
            XML.ignoreWhitespace = false;   //to preserve spaces inside texts
            var loader:URLLoader = new URLLoader( new URLRequest( svgurl ) );
            loader.addEventListener( Event.COMPLETE , displayData );
        }
                
        private function displayData( e:Event ):void {
            var svgxml:XML = XML( e.currentTarget.data );
            
            svgSprite = new SvgDisplay( svgxml );   //parse SVG
            
            addChild( svgSprite ); 
        }
    }
       
}