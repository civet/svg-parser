package svgparser.parser
{
    import flash.geom.Matrix;
    import flash.geom.Rectangle;

    import svgparser.parser.model.Data;
    import svgparser.parser.style.Transform;

    public interface IGradient
    {
        function getId():String;
        function setData( data:Data ):void;
        function updateMatrix( objectBoundingBox:Rectangle = null ):void;
        function get type():String;
        function get colors():Array;
        function get alphas():Array;
        function get ratios():Array;
        function get matrix():Matrix;
        function get method():String;
        function get linked():String;
        function get transform():Transform;
        function get unit():String;
    }
}