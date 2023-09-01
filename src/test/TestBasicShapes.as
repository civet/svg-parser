package test
{
    import flash.display.Sprite;
    import flash.events.Event;

    import svgparser.SvgDisplay;

    public class TestBasicShapes extends Sprite
    {
        public function TestBasicShapes()
        {
            this.addEventListener(Event.ADDED_TO_STAGE, function(event:Event):void {
                setup();
            });
        }

        public function setup():void
        {
            // from: https://svgpocketguide.com/#section-2
            testRect();
            testCircle();
            testEllipse();
            testLine();
            testPolyline();
            testPolygon();

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

        private function testRect():void
        {
            var xml:XML = 
            <svg>
                <rect width="200" height="100" fill="#BBC42A" />
            </svg>
            ;
            var svg:SvgDisplay = new SvgDisplay(xml);
            svg.x = 16;
            svg.y = 16;
            this.addChild(svg);
        }

        private function testCircle():void 
        {
            var xml:XML = 
            <svg>
                <circle cx="75" cy="75" r="75" fill="#ED6E46" />
            </svg>
            ;
            var svg:SvgDisplay = new SvgDisplay(xml);
            this.addChild(svg);
        }

        private function testEllipse():void 
        {
            var xml:XML = 
            <svg>
                <ellipse cx="100" cy="100" rx="100" ry="50" fill="#7AA20D" transform="translate(0,-50)" />
            </svg>
            ;
            var svg:SvgDisplay = new SvgDisplay(xml);
            this.addChild(svg);
        }

        private function testLine():void 
        {
            var xml:XML = 
            <svg>
                <line x1="5" y1="5" x2="100" y2="100" stroke="#765373" stroke-width="8" />
            </svg>
            ;
            var svg:SvgDisplay = new SvgDisplay(xml);
            this.addChild(svg);
        }

        private function testPolyline():void
        {
            var xml:XML = 
            <svg>
                <polyline points="0,40 40,40 40,80 80,80 80,120 120,120 120,160" fill="white" stroke="#BBC42A" stroke-width="6" />
            </svg>
            ;
            var svg:SvgDisplay = new SvgDisplay(xml);
            this.addChild(svg);
        }

        private function testPolygon():void
        {
            var xml:XML = 
            <svg>
                <polygon points="50,5 100,5 125,30 125,80 100,105 50,105 25,80 25,30" fill="#ED6E46" />
            </svg>
            ;
            var svg:SvgDisplay = new SvgDisplay(xml);
            this.addChild(svg);
        }
    }
}