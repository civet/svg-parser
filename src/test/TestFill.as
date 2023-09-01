package test
{
    import flash.display.Sprite;
    import flash.events.Event;

    import svgparser.SvgDisplay;

    public class TestFill extends Sprite
    {

        public function TestFill()
        {
            this.addEventListener(Event.ADDED_TO_STAGE, function(event:Event):void {
                setup();
            });
        }

        public function setup():void
        {
            // from: https://developer.mozilla.org/en-US/docs/Web/SVG/Attribute/fill-rule
            testFillRule();

            // from: https://developer.mozilla.org/en-US/docs/Web/SVG/Attribute/fill-opacity
            testFillOpacity();

            layout();
        }

        private function layout():void
        {
            var offsetX:int = 16;
            var offsetY:int = 16;
            for(var i:int = 0, n:int = this.numChildren; i < n; ++i) {
                var child:Sprite = this.getChildAt(i) as Sprite;
                child.x = offsetX;
                child.y = offsetY;
                offsetY += child.height + 16;
                if(offsetY + 256 > this.stage.stageHeight) {
                    offsetY = 16;
                    offsetX += 256;
                }
            }
        }

        private function testFillRule():void
        {
            var xml:XML = 
            <svg viewBox="-10 -10 220 120">
            <polygon
                fill-rule="nonzero"
                stroke="red"
                points="50,0 21,90 98,35 2,35 79,90" />
            <polygon
                fill-rule="evenodd"
                stroke="red"
                points="150,0 121,90 198,35 102,35 179,90" />
            </svg>
            ;
            var svg:SvgDisplay = new SvgDisplay(xml);
            this.addChild(svg);
        }

        private function testFillOpacity():void
        {
            var xml:XML = 
            <svg viewBox="0 0 400 100" xmlns="http://www.w3.org/2000/svg">
                <!-- Default fill opacity: 1 -->
                <circle cx="50" cy="50" r="40" />

                <!-- Fill opacity as a number -->
                <circle cx="150" cy="50" r="40" fill-opacity="0.7" />

                <!-- Fill opacity as a percentage -->
                <circle cx="250" cy="50" r="40" fill-opacity="50%" />

                <!-- Fill opacity as a CSS property -->
                <circle cx="350" cy="50" r="40" style="fill-opacity: .25;" />
            </svg>
            ;
            var svg:SvgDisplay = new SvgDisplay(xml);
            this.addChild(svg);
        }
    }
}