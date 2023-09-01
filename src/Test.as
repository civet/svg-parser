package {

    import flash.display.Sprite;
    import flash.display.StageAlign;
    import flash.display.StageScaleMode;

    import test.TestLoadSVG;
    import test.TestBasicShapes;
    import test.TestPaths;
    import test.TestWorkspace;
    import test.TestFill;

    [SWF(width="800", height="600", backgroundColor="0xFFFFFF", frameRate="60")]

    public class Test extends Sprite
    {
        public function Test()
        {
            stage.scaleMode = StageScaleMode.NO_SCALE;
            stage.align = StageAlign.TOP_LEFT;
            
            this.addChild(new TestLoadSVG());
            // this.addChild(new TestBasicShapes());
            // this.addChild(new TestPaths());
            // this.addChild(new TestWorkspace());
            // this.addChild(new TestFill());
        }
    }
}