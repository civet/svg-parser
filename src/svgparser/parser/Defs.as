package svgparser.parser
{
    import flash.display.Sprite;

    import svgparser.parser.IParser;
    import svgparser.parser.model.Data;
    import svgparser.parser.style.Style;

    public class Defs implements IParser
    {
        public static var LOCALNAME:String = "defs";
           
        public function Defs() { }
           
        public function parse( data:Data ):void {
            var style:Style = new Style( data.currentXml );
            
            var group:Sprite = new Sprite();
            group.name = style.id;
            style.applyStyle( group );

            var groupXML:XML = data.currentXml.copy();
            groupXML.setLocalName( "_defs" );

            // --- bugfix: Nodes with linked references should be placed after the definition ---
            var afters:XMLList = new XMLList();
            var xlink:Namespace = Constants.xlink;
            var defs:XMLList = groupXML.children();
            var i:int = defs.length();
            while (i--) {
                var href:String = defs[i].@xlink::href;
                if (href != "") {
                    afters += defs[i].copy();
                    delete defs[i];
                }
            }
            groupXML.appendChild(afters);
            // ------

            SvgFactory.parseData( data.copy( groupXML, group ) );
            group = null;
        }
    }

}