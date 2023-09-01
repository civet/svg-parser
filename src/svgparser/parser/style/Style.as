package svgparser.parser.style
{
    import flash.display.CapsStyle;
    import flash.display.DisplayObject;
    import flash.display.GraphicsPathWinding;
    import flash.display.JointStyle;
    import flash.geom.Matrix;
    import flash.geom.Rectangle;
    import flash.text.engine.FontWeight;

    import svgparser.parser.Constants;
    import svgparser.parser.FilterSet;
    import svgparser.parser.model.Data;
    import svgparser.parser.utils.StyleUtil;
    
    public class Style
    {
        public var id:String = "item";

        public var href:String;

        public var viewBox:Rectangle;
        
        public var opacity:Number = 1;
        public var rotate:Number;
        public var transform:svgparser.parser.style.Transform;
        public var visibility:String;
        public var display:Boolean = true;
        
        public var fill:uint = 0;
        public var fill_rule:String = GraphicsPathWinding.NON_ZERO;
        public var fill_opacity:Number = 1;

        public var stroke:uint = 0;
        public var stroke_width:Number = 1;
        public var stroke_opacity:Number = 1;
        public var stroke_linecap:String = CapsStyle.NONE; // butt
        public var stroke_linejoin:String = JointStyle.MITER; // miter
        public var stroke_miterlimit:Number = 4;
        
        public var font_family:String = "_sans";
        public var font_size:Number = 30;
        public var font_weight:String;
        public var fontLookup:String;
        public var font_stretch:String;
        public var font_variant:String;
        public var font_size_adjust:Number;
        public var font_style:String;
        public var text_align:String;
        public var text_decoration:String;
        public var word_spacing:Number;
        public var letter_spacing:Number;
        public var line_height:Number;
        public var kerning:Number;
        public var baseline_shift:Number;
        public var writing_mode:String;
        public var direction:String;
        public var alignment_baseline:String;
        public var dominant_baseline:String;
        public var glyph_orientation_horizontal:int;
        public var glyph_orientation_vertical:int;

        public var gradientTransform:svgparser.parser.style.Transform;
        public var gradientUnits:String = "objectBoundingBox";
        public var stop_color:uint = 0;
        public var stop_opacity:Number = 1;
        public var offset:Number = 0;

        public var marker:String;
        
        public var fill_id:String;
        public var stroke_id:String;
        public var mask_id:String;
        public var filter_id:String;
        public var clipPath_id:String;

        private var _xmls:XMLList;
        private var _hasFill:Boolean = true;
        private var _hasFill32:Boolean = false;
        private var _hasStroke:Boolean = false;
        private var _hasGradientFill:Boolean = false;
        private var _hasGradientStroke:Boolean = false;
        private var _hasClipPath:Boolean = false;
        
        public function Style(xml:XML = null)
        {
            this.font_weight = Constants.FONT_WEIGHT;
            this.fontLookup = Constants.FONT_LOOKUP;

            _xmls = new XMLList();
            
            if (xml) this.parse(xml);
        }

        public function addStyle(xml:XML):void
        {
            this.parse(xml);
        }
        
        public function parse(xml:XML):void
        {
            _xmls += xml;

            var nodes:XMLList = xml.@*;
            for each (var node:XML in nodes)
            {
                this.setStyle(node.name(), node.toString());
            }
        }
        
        private function setStyle(name:String, value:String):void
        {
            name = name.replace(/-/g,"_");
            if (name.indexOf("http://") != -1)
            {
                name = StyleUtil.removeNameSpace(name);
            }

            switch(name)
            {
                case "stroke":
                    if (value.indexOf("url") == -1) {
                        this.stroke = StyleUtil.toColor(value);
                    } 
                    else {
                        this.stroke_id = StyleUtil.toURL(value);
                        _hasGradientStroke = true;
                    }
                    _hasStroke = value != "none";
                    break;

                case "fill":
                    if (value == "none") {
                        _hasFill = false;
                    } 
                    else if (value.indexOf("url") != -1) {
                        this.fill_id = StyleUtil.toURL(value);
                        _hasGradientFill = true;
                    }
                    else {
                        this.fill = StyleUtil.toColor(value);
                        _hasFill = true;

                        if(value.indexOf("rgba(") != -1) {
                            _hasFill32 = true;
                        }
                    }
                    break;

                case "fill_rule":
                    this.fill_rule = value.toLowerCase() == "evenodd" ? GraphicsPathWinding.EVEN_ODD : GraphicsPathWinding.NON_ZERO;
                    break;

                case "stroke_width":
                    this.stroke_width = StyleUtil.toNumber(value);
                    break;

                case "stroke_linecap":
                    this.stroke_linecap = value == CapsStyle.SQUARE || value == CapsStyle.ROUND ? value : CapsStyle.NONE;
                    break;

                case "stroke_linejoin":
                    this.stroke_linejoin = value == JointStyle.BEVEL || value == JointStyle.ROUND ? value : JointStyle.MITER;
                    break;

                case "font_family":
                    this.font_family = value.replace(/\'/g,"");
                    break;

                case "font_size":
                    this.font_size = StyleUtil.toNumber(value);
                    break;

                case "font_weight":
                    this.font_weight = value != FontWeight.NORMAL && value != FontWeight.BOLD ? FontWeight.NORMAL : value;
                    break;

                case "display":
                    this.display = value.toString() != "none";
                    break;

                case "transform":
                    this.transform = new svgparser.parser.style.Transform(value);
                    break;

                case "style":
                    this.parseStyles(value);
                    break;

                case "filter":
                    this.filter_id = StyleUtil.toURL(value);
                    break;

                case "clip_path":
                    this.clipPath_id = StyleUtil.toURL(value);
                    _hasClipPath = true;
                    break;

                case "viewBox":
                    var vals:Array = value.split(" ");
                    this.viewBox = new Rectangle(vals[0], vals[1], vals[2], vals[3]);
                    break;

                case "text_align":
                    this.text_align = value;
                    break;

                case "stop_color":
                    this.stop_color = StyleUtil.toColor(value);
                    break;

                case "href":
                    this.href = value.replace(/^#/,"");
                    break;

                case "gradientTransform":
                    this.gradientTransform = new svgparser.parser.style.Transform(value);
                    break;

                default:
                    if (this.hasOwnProperty(name)) {
                        switch(typeof this[name])
                        {
                            case "object": // warning: var str:String = null; typeof str == object
                            case "string":
                                this[name] = value;
                                break;
                            case "number":
                                this[name] = StyleUtil.toNumber(value);
                        }
                    }
                    break;
            }
        }
        
        private function parseStyles(value:String):void
        {
            var styles:Array = value.split(";");
            for each(var kv:String in styles)
            {
                var vals:Array = kv.split(":");
                this.setStyle( vals[0], vals[1] );
            }
        }
        
        public function applyStyle(target:DisplayObject, data:Data = null,  useDefaultName:Boolean = true):void
        {
            var mtx:Matrix;

            if (useDefaultName) 
            {
                target.name = this.id;
            }

            target.alpha = this.opacity;

            if (this.viewBox) 
            {
                target.scrollRect = this.viewBox;
            }
            
            if (this.hasTransform)
            {
                mtx = target.transform.matrix.clone();
                mtx.concat(this.transform.getMatrix());
                target.transform.matrix = mtx;
            }

            if (this.hasFilter && data != null && Constants.ENABLE_FILTER)
            {
                var filterSet:FilterSet = data.getFilterById(this.filter_id);
                if (filterSet.hasFilter())
                {
                    filterSet.setSourceGraphic(target);
                    target.filters = filterSet.getAllFilters();
                }
            }

            if (this.hasClipPath && data != null)
            {
                var clipPath:DisplayObject = data.getClipPathById(this.clipPath_id);
                if (clipPath)
                {
                    mtx = clipPath.transform.matrix.clone();
                    mtx.concat(this.getMatrix());
                    clipPath.transform.matrix = mtx;
                    data.currentCanvas.addChild(clipPath);
                    target.mask = clipPath;
                }
            }
        }

        public function getMatrix():Matrix
        {
            if (this.hasTransform) {
                return this.transform.getMatrix();
            }
            return new Matrix();
        }

        public function copy():Style
        {
            var style:Style = new Style();
            for each(var xml:XML in _xmls)
            {
                style.addStyle(xml);
            }
            return style;
        }
        
        public function get hasTransform():Boolean {
            return this.transform != null;
        }
        
        public function get hasStroke():Boolean {
            return _hasStroke && this.stroke_width != 0;
        }
        
        public function get hasFill():Boolean {
            return _hasFill;
        }

        public function get hasFill32():Boolean {
            return _hasFill32;
        }
        
        public function get hasGradientStroke():Boolean {
            return _hasGradientStroke;
        }
        
        public function get hasGradientFill():Boolean {
            return _hasGradientFill;
        }
        
        public function get hasFilter():Boolean {
            return this.filter_id != null;
        }

        public function get hasClipPath():Boolean {
            return _hasClipPath;
        }
    }
}
