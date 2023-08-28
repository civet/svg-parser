package svgparser.parser
{
    import svgparser.parser.model.Data;
       
    public interface IParser
    {
        function parse( data:Data ):void;
    }
}