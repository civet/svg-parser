package svgparser.parser.abstract
{
    import flash.display.Graphics;
    import flash.display.Shape;

    import svgparser.parser.Constants;
    import svgparser.parser.IGradient;
    import svgparser.parser.model.Data;
    import svgparser.parser.style.Style;
    
    public class AbstractPaint
    {
        public function AbstractPaint() { }
        
        protected function draw(g:Graphics) : void
        {
            throw new Error("AbstractPaint draw method");
        }
        
        protected function paint(target:Shape, style:Style, data:Data) : void
        {
            var gradient:IGradient;

            if (data.hasParentStyle) {
                style.addStyle(data.getStyleXML());
            }

            if (style.hasStroke) {
                target.graphics.lineStyle(style.stroke_width,style.stroke,style.stroke_opacity,Constants.LINE_PIXEL_HINTING,Constants.LINE_SCALE_MODE,style.stroke_linecap,style.stroke_linejoin,style.stroke_miterlimit);
            }

            if (style.hasGradientStroke) {
                gradient = data.getGradientById(style.stroke_id);
                if (gradient) {
                    target.graphics.lineGradientStyle(gradient.type,gradient.colors,gradient.alphas,gradient.ratios,gradient.matrix,gradient.method);
                }
            }
            
            if (style.hasFill) {
                if (style.hasFill32) {
                    var fillAlpha:Number = (style.fill >> 24 & 0xFF) / 0xFF;
                    var fillColor:uint = style.fill & 0xFFFFFF;
                    target.graphics.beginFill(fillColor, style.fill_opacity * fillAlpha);
                } else {
                    target.graphics.beginFill(style.fill,style.fill_opacity);
                }
            }

            if (style.hasGradientFill) {
                gradient = data.getGradientById(style.fill_id);
                if (gradient) {
                    target.graphics.beginGradientFill(gradient.type,gradient.colors,gradient.alphas,gradient.ratios,gradient.matrix,gradient.method);
                }
            }
            
            this.draw(target.graphics);

            if (style.hasFill || style.hasGradientFill || style.hasStroke) {
                target.graphics.endFill();
            }
            style.applyStyle(target,data);
        }
    }
}
