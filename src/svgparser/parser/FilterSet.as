package svgparser.parser
{
    import flash.display.DisplayObject;
    import svgparser.parser.IParser;
    import svgparser.parser.model.Data;
    import svgparser.parser.filters.*;
    import svgparser.parser.utils.StyleUtil;
       
    public class FilterSet implements IParser
    {
        public static var LOCALNAME:String = "filter";
           
        private static const FPARSERS:Array = [ GaussianBlur , ColorMatrix, DisplacementMap ];
           
        public var id:String;
        public var _x:Number;
        public var _y:Number;
        public var _width:Number;
        public var _height:Number;
           
        public var filters:Vector.<IFilter> = new Vector.<IFilter>();
           
        public function parse( data:Data ):void
        {
            id = data.currentXml.@id.toString();
            _x = StyleUtil.toNumber( data.currentXml.@x );
            _y = StyleUtil.toNumber( data.currentXml.@y );
            _width = StyleUtil.toNumber( data.currentXml.@width );
            _height = StyleUtil.toNumber( data.currentXml.@height );
               
            var fs:XMLList = data.currentXml.children();
            for each( var f:XML in fs ) {
                var current:IFilter =  getFilter( f );
                if( current ) filters.push( current );
            }
            data.addFilter( this );
        }
           
        public function setSourceGraphic( d:DisplayObject ):void {
            for each( var f:IFilter in filters )
                f.setSourceGraphic( d);
        }
           
        public function getAllFilters():Array
        {
            var sets:Array = [];
            for each( var f:IFilter in filters )
                sets.push( f.getFlashFilter() );
            return sets;
        }
           
        public function hasFilter():Boolean
        {
            return ( filters.length > 0 );
        }
           
        public static function getFilter( xml:XML ):IFilter
        {
            for each( var Fl:Class in FPARSERS )
                if ( xml.localName() == Fl["LOCALNAME"] ) return new Fl( xml );
            return null;
        }
    }
}