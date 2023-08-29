package svgparser.parser
{
    import flash.display.*;
    import flash.text.engine.*;

    import svgparser.parser.model.Data;
    import svgparser.parser.style.Style;
    import flash.text.engine.RenderingMode;

    public class Text implements IParser
    {
        public static var LOCALNAME:String = "text";
           
        private var sprite:Sprite;
        private var textElements:Vector.<ContentElement>;
        private var _data:Data;
           
        private var _x:Number = 0;
        private var _y:Number = 0;
        private var _localX:Number = 0;
        private var _localY:Number = 0;
           
        public function Text() { }
           
        public function parse( data:Data ):void
        {
            _data = data;
            textElements = new Vector.<ContentElement>();
            sprite = new Sprite();
            sprite.name = data.currentXml.@id.toString();
            var style:Style = new Style( data.currentXml );
            if ( !style.display ) return;
            
            parseSpan( data.currentXml , style );
            drawTextElements();
            style.applyStyle( sprite );
            data.currentCanvas.addChild( sprite );
               
            textElements = null;
            sprite = null;
            _data = null;
        }
           
        private function parseSpan( xml:XML , style:Style ):void
        {
            setPosition( Number( xml.@x.toString() ), Number( xml.@y.toString() ) );

            if ( xml.hasSimpleContent() ) setText( xml.text(), style );
            else
            {
                var list:XMLList = xml.children();
                for each( var span:XML in list )
                {
                    var ls:Style = style.copy();
                    ls.addStyle( span );
                    if ( span.hasComplexContent() ) parseSpan ( span , ls );
                    else
                    {
                        setPosition( Number( span.@x.toString() ), Number( span.@y.toString() ) );
                        setText( span , ls );
                    }
                }
            }
        }
           
        private function setPosition( x:Number, y:Number ):void {
            if ( x != 0 && y != 0 ) {
                _x = x;
                _y = y;
            }
            _localX = x;
            _localY = y;
        }

        private function setText(  txt:String , style:Style ):void
        {
            _data.replaceFont( style );
            txt = txt.replace(/[\t|\n|\r]+/g , "" );
            var fd:FontDescription = new FontDescription( style.font_family, style.font_weight );
            // fd.fontLookup = Constants.FONT_LOOKUP;
            // --- Bugfix for fontLookup ----
            fd.fontLookup = style.fontLookup ? style.fontLookup : Constants.FONT_LOOKUP;
            // ------
            var format:ElementFormat = new ElementFormat( fd , style.font_size , style.fill , style.fill_opacity  );
            format.trackingRight = style.letter_spacing;
            format.breakOpportunity = BreakOpportunity.NONE;
            var tElement:TextElement = new TextElement( txt , format );
            if ( _localX == 0 && _localY == 0 ) {
                tElement.userData = {x:_x, y:_y , style:style };
                textElements.push( tElement );
            }else {
                var block:TextBlock = new TextBlock( tElement );
                var textLine:TextLine = block.createTextLine ();
                if ( textLine ) layoutTextLine(textLine, _localX, _localY, style );
            }
        }
           
        private function drawTextElements():void
        {
            if ( textElements.length <= 0 ) return;
            var groupElement:GroupElement = new GroupElement( textElements );
            var firstElement:ContentElement = textElements[0];

            var ex:Number = firstElement.userData.x;
            var ey:Number = firstElement.userData.y;
            var estyle:Style = firstElement.userData.style;
            firstElement.userData = null;
               
            var block:TextBlock = new TextBlock( ( textElements.length > 0 ) ? groupElement : firstElement );
            var textLine:TextLine = block.createTextLine () ;
            if ( textLine )
                layoutTextLine( textLine, ex , ey , estyle );
        }
           
        private function layoutTextLine( textLine:TextLine , x:Number, y:Number, style:Style  ):void {
            if ( style.text_align == "center" ) x -= textLine.width / 2 ;
            else if ( style.text_align == "end" ) x -= textLine.width;
            textLine.x = x;
            textLine.y = y;
            textLine.rotation = style.rotate;
            textLine.alpha = style.opacity;
            sprite.addChild( textLine );
        }
    }
}