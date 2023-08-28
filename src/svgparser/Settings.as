package svgparser
{
    import svgparser.font.FontConverter;
    
    public class Settings
    {
        public var fontConverters:Array = [];
        
        public function Settings() { }
        
        public function addFontConversion( converter:FontConverter ):void
        {
            fontConverters.push( converter );
        }
        
        public function getSwfFont( svgFontName:String ):FontConverter 
        {
            for each( var f:FontConverter in fontConverters ) {
                if ( f.svgFontName == svgFontName ) return f;
            }
            return null;
        }
        
        public function hasFontConversion():Boolean 
        {
            return ( fontConverters.length > 0 );
        }
    }
}