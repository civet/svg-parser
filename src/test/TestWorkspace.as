package test
{
    import flash.display.Sprite;
    import flash.events.Event;

    import svgparser.SvgDisplay;

    public class TestWorkspace extends Sprite
    {

        public function TestWorkspace()
        {
            this.addEventListener(Event.ADDED_TO_STAGE, function(event:Event):void {
                setup();
            });
        }

        public function setup():void
        {
            // from: https://svgpocketguide.com/#section-3
            testViewBox();
            testViewBox2();
            testTransform();

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

        private function testViewBox():void
        {
            var xml:XML = 
            <svg width="115px" height="190px" viewBox="0 0 65 140">
                <desc>Green pear to show effects of reduced viewBox.</desc>
                <g>
                <path class="pear-body" fill="#BBC42A" d="M4.976,126.451c-0.571,1.76-1.067,3.551-1.475,5.377c-6.62,29.681,7.465,54.363,43.244,56.718
                c56.994,3.751,77.653-25.65,60.462-67.25C90.017,79.697,82.063,89.688,80.366,57.764c-0.764-14.367-11.098-27.167-26.203-24.576
                c-17.378,2.982-19.794,19.916-22.192,34.44C28.36,89.508,11.623,105.957,4.976,126.451z"/>
                <path class="stem" fill="none" stroke="#59351C" stroke-width="7" stroke-linecap="round"  d="M56.427,40.406
                c0,0-7.375-15.376,8.06-35.837"/>
                <path fill="#7AA20D" stroke="#7AA20D" stroke-width="3" stroke-linecap="round" stroke-linejoin="round" d="
                M54.247,35.412c0.787-3.843,3.55-7.335,8.368-9.848c10.053-5.244,18.075-4.042,28.061,0.2c0.004,0.002,12.83,5.449,20.517-4.672
                c-4.778,6.291-9.415,12.478-14.878,18.237c-8.878,9.359-25.348,22.181-37.176,9.661C55.019,44.629,53.349,39.793,54.247,35.412z"/>
                </g>
            </svg>
            ;
            var svg:SvgDisplay = new SvgDisplay(xml);
            this.addChild(svg);
        }

        private function testViewBox2():void
        {
            var xml:XML = 
            <svg width="115" height="190" viewBox="50 30 115 190">
                <desc>Green pear to show effects of altering min values.</desc>
                <g>
                <path fill="#BBC42A" d="M4.976,126.451c-0.571,1.76-1.067,3.551-1.475,5.377c-6.62,29.681,7.465,54.363,43.244,56.718 c56.994,3.751,77.653-25.65,60.462-67.25C90.017,79.697,82.063,89.688,80.366,57.764c-0.764-14.367-11.098-27.167-26.203-24.576
                c-17.378,2.982-19.794,19.916-22.192,34.44C28.36,89.508,11.623,105.957,4.976,126.451z"/>
                <path fill="none" stroke="#59351C" stroke-width="7" stroke-linecap="round" d="M56.427,40.406
                c0,0-7.375-15.376,8.06-35.837"/>
                <path fill="#7AA20D" stroke="#7AA20D" stroke-width="3" stroke-linecap="round" stroke-linejoin="round" d="
                M54.247,35.412c0.787-3.843,3.55-7.335,8.368-9.848c10.053-5.244,18.075-4.042,28.061,0.2c0.004,0.002,12.83,5.449,20.517-4.672
                c-4.778,6.291-9.415,12.478-14.878,18.237c-8.878,9.359-25.348,22.181-37.176,9.661C55.019,44.629,53.349,39.793,54.247,35.412z"/>
                </g>
            </svg>
            ;
            var svg:SvgDisplay = new SvgDisplay(xml);
            this.addChild(svg);
        }

        private function testTransform():void
        {
            var xml:XML = 
            <svg width="115" height="190" viewBox="0 0 115 190" transform="rotate(30) scale(0.5)">
                <g>
                <path fill="#BBC42A" d="M4.976,126.451c-0.571,1.76-1.067,3.551-1.475,5.377c-6.62,29.681,7.465,54.363,43.244,56.718 c56.994,3.751,77.653-25.65,60.462-67.25C90.017,79.697,82.063,89.688,80.366,57.764c-0.764-14.367-11.098-27.167-26.203-24.576
                c-17.378,2.982-19.794,19.916-22.192,34.44C28.36,89.508,11.623,105.957,4.976,126.451z"/>
                <path fill="none" stroke="#59351C" stroke-width="7" stroke-linecap="round" d="M56.427,40.406
                c0,0-7.375-15.376,8.06-35.837"/>
                <path fill="#7AA20D" stroke="#7AA20D" stroke-width="3" stroke-linecap="round" stroke-linejoin="round" d="
                M54.247,35.412c0.787-3.843,3.55-7.335,8.368-9.848c10.053-5.244,18.075-4.042,28.061,0.2c0.004,0.002,12.83,5.449,20.517-4.672
                c-4.778,6.291-9.415,12.478-14.878,18.237c-8.878,9.359-25.348,22.181-37.176,9.661C55.019,44.629,53.349,39.793,54.247,35.412z"/>
                </g>
            </svg>
            ;
            var svg:SvgDisplay = new SvgDisplay(xml);
            this.addChild(svg);
        }
    }
}