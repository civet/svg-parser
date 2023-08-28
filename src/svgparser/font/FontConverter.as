package svgparser.font
{
    public class FontConverter
    {
        public var svgFontName:String;
        public var swfFontName:String;
        public var fontLookup:String;

        public function FontConverter( svgFontName:String , swfFontName:String , fontLookup:String = null )
        {
            this.svgFontName = svgFontName;
            this.swfFontName = swfFontName;
            this.fontLookup = fontLookup;
        }
    }
}