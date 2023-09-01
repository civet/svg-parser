package test
{
    import flash.display.Sprite;
    import flash.events.Event;

    import svgparser.SvgDisplay;

    public class TestPaths extends Sprite
    {
        public function TestPaths()
        {
            this.addEventListener(Event.ADDED_TO_STAGE, function(event:Event):void {
                setup();
            });
        }

        public function setup():void
        {
            // from: https://svgpocketguide.com/#section-2
            testPath();
            testCubicBezierCurve();
            testQuadraticBezierCurve();
            testEllipticalArc();
            testComplexPaths();

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

        private function testPath():void
        {
            var xml:XML = 
            <svg width="258px" height="184px">
                <path fill="#7AA20D" stroke="#7AA20D" stroke-width="9" stroke-linejoin="round" d="M248.761,92c0,9.801-7.93,17.731-17.71,17.731c-0.319,0-0.617,0-0.935-0.021c-10.035,37.291-51.174,65.206-100.414,65.206 c-49.261,0-90.443-27.979-100.435-65.334c-0.765,0.106-1.531,0.149-2.317,0.149c-9.78,0-17.71-7.93-17.71-17.731 c0-9.78,7.93-17.71,17.71-17.71c0.787,0,1.552,0.042,2.317,0.149C39.238,37.084,80.419,9.083,129.702,9.083    c49.24,0,90.379,27.937,100.414,65.228h0.021c0.298-0.021,0.617-0.021,0.914-0.021C240.831,74.29,248.761,82.22,248.761,92z" />
            </svg>
            ;
            var svg:SvgDisplay = new SvgDisplay(xml);
            this.addChild(svg);
        }

        private function testCubicBezierCurve():void
        {
            var xml:XML = 
            <svg>
                <path fill="none" stroke="#333333" stroke-width="3" d="M10,55 C15,5 100,5 100,55" />
            </svg>
            ;
            var svg:SvgDisplay = new SvgDisplay(xml);
            this.addChild(svg);
        }

        private function testQuadraticBezierCurve():void
        {
            var xml:XML = 
            <svg>
                <path fill="none" stroke="#333333" stroke-width="3" d="M20,50 Q40,5 100,50" />
            </svg>
            ;
            var svg:SvgDisplay = new SvgDisplay(xml);
            this.addChild(svg);
        }

        private function testEllipticalArc():void
        {
            var xml:XML = 
            <svg>
                <path fill="none" stroke="#333333" stroke-width="3" d="M65,10 a50,25 0 1,0 50,25" />
            </svg>
            ;
            var svg:SvgDisplay = new SvgDisplay(xml);
            this.addChild(svg);
        }

        private function testComplexPaths():void
        {
            var xml:XML = 
            <svg width="215px" height="274px" viewBox="0 0 215 274">
                <g>
                    <path class="stems" fill="none" stroke="#7AA20D" stroke-width="8" stroke-linecap="round" stroke-linejoin="round" d="M54.817,169.848c0,0,77.943-73.477,82.528-104.043c4.585-30.566,46.364,91.186,27.512,121.498" />
                    <path class="leaf" fill="#7AA20D" stroke="#7AA20D" stroke-width="4" stroke-linecap="round" stroke-linejoin="round" d="M134.747,62.926c-1.342-6.078,0.404-12.924,5.762-19.681c11.179-14.098,23.582-17.539,40.795-17.846 c0.007,0,22.115-0.396,26.714-20.031c-2.859,12.205-5.58,24.168-9.774,36.045c-6.817,19.301-22.399,48.527-47.631,38.028 C141.823,75.784,136.277,69.855,134.747,62.926z" />
                </g>
                <g>
                    <path class="r-cherry" fill="#ED6E46" stroke="#ED6E46" stroke-width="12" d="M164.836,193.136 c1.754-0.12,3.609-0.485,5.649-1.148c8.512-2.768,21.185-6.985,28.181,3.152c15.076,21.845,5.764,55.876-18.387,66.523 c-27.61,12.172-58.962-16.947-56.383-45.005c1.266-13.779,8.163-35.95,26.136-27.478   C155.46,191.738,159.715,193.485,164.836,193.136z" />
                    <path class="l-cherry" fill="#ED6E46" stroke="#ED6E46" stroke-width="12" d="M55.99,176.859 c1.736,0.273,3.626,0.328,5.763,0.135c8.914-0.809,22.207-2.108,26.778,9.329c9.851,24.647-6.784,55.761-32.696,60.78 c-29.623,5.739-53.728-29.614-44.985-56.399c4.294-13.154,15.94-33.241,31.584-20.99C47.158,173.415,50.919,176.062,55.99,176.859z" />
                </g>
            </svg>
            ;
            var svg:SvgDisplay = new SvgDisplay(xml);
            this.addChild(svg);
        }
    }
}