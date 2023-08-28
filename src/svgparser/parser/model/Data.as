package svgparser.parser.model
{
    import flash.display.DisplayObject;
    import flash.display.DisplayObjectContainer;

    import svgparser.Settings;
    import svgparser.font.FontConverter;
    import svgparser.parser.FilterSet;
    import svgparser.parser.IGradient;
    import svgparser.parser.style.Style;
    
    public class Data
    {
        private var _persistent:PersistentData;
        private var _currentXML:XML;
        private var _currentCanvas:DisplayObjectContainer;
        private var _settings:Settings;
        private var _styleXML:XML;

        public function Data(xml:XML, canvas:DisplayObjectContainer, settings:Settings = null, persistent:PersistentData = null)
        {
            _persistent = !!persistent ? persistent:new PersistentData();
            _currentXML = _persistent.rootXML = xml;
            _currentCanvas = _persistent.rootCanvas = canvas;
            _settings = settings;
        }
        
        public function overrideStyle(xml:XML):void
        {
            xml.@transform = null;
            _styleXML = xml;
        }

        public function addGradient(gradient:IGradient):void
        {
            _persistent.addGradient(gradient);
        }
        
        public function addClipPath(clipPath:DisplayObject):void
        {
            _persistent.addClipPath(clipPath);
        }
        
        public function addFilter(filter:FilterSet):void
        {
            _persistent.addFilter(filter);
        }
        
        public function getGradientById(id:String):IGradient
        {
            return _persistent.getGradientById(id);
        }
        
        public function getFilterById(id:String):FilterSet
        {
            return _persistent.getFilterById(id);
        }
        
        public function getClipPathById(id:String):DisplayObject
        {
            return _persistent.getClipPathById(id);
        }

        public function get xml():XML
        {
            return _persistent.rootXML;
        }
        
        public function get canvas():DisplayObjectContainer
        {
            return _persistent.rootCanvas;
        }
        
        public function replaceFont(style:Style):void
        {
            if(!_settings.hasFontConversion()) return;

            var converter:FontConverter = _settings.getSwfFont(style.font_family);
            if(!converter) return;

            style.font_family = converter.swfFontName;

            if(converter.fontLookup != null)
            {
                style.fontLookup = converter.fontLookup;
            }
        }
        
        public function get currentCanvas():DisplayObjectContainer
        {
            return _currentCanvas;
        }

        public function get settings():Settings
        {
            return _settings;
        }
        
        public function get hasParentStyle():Boolean
        {
            return Boolean(_styleXML);
        }
        
        public function copy(targetXML:XML = null, targetCanvas:DisplayObjectContainer = null):Data
        {
            if(!targetXML)
            {
                targetXML = _currentXML;
            }
            if(!targetCanvas)
            {
                targetCanvas = _currentCanvas;
            }
            return new Data(targetXML, targetCanvas, _settings, _persistent);
        }
        
        public function get currentXml():XML
        {
            return _currentXML;
        }

        public function set currentXml(value:XML):void
        {
            _currentXML = value;
        }
        
        public function set currentCanvas(canvas:DisplayObjectContainer):void
        {
            _currentCanvas = canvas;
        }
        
        public function getStyleXML():XML
        {
            return _styleXML;
        }
    }
}
