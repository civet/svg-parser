package svgparser.parser.filters
{
    import flash.display.DisplayObject;
    import flash.filters.BitmapFilter;
    
    public interface IFilter
    {
        function parse( xml:XML ):void;

        function setSourceGraphic( target:DisplayObject ):void;
        
        function getFlashFilter():BitmapFilter;
    }
}
