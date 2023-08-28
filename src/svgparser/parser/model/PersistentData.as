package svgparser.parser.model
{
    import flash.display.DisplayObject;
    import flash.display.DisplayObjectContainer;

    import svgparser.parser.FilterSet;
    import svgparser.parser.IGradient;
    
    public class PersistentData
    {
        private var _gradients:Array = [];
        private var _filters:Array = [];
        private var _clippaths:Array = [];
        private var _graphics:Array = [];
        private var _symbols:XMLList = new XMLList();
        private var _rootXML:XML;
        private var _rootCanvas:DisplayObjectContainer;
        
        public function PersistentData() { }
        
        public function addGradient( gradient:IGradient ):void
        {
            for each ( var g:IGradient in _gradients )
            {
                if ( g.getId() == gradient.getId() ) return;
            }
            _gradients.push(gradient);
        }
        
        public function addFilter( filter:FilterSet ):void
        {
            for each ( var f:FilterSet in _filters )
            {
                if ( f.id == filter.id ) return; 
            }
            _filters.push(filter);
        }
        
        public function addClipPath( clipPath:DisplayObject ):void
        {
            for each(var c:DisplayObject in _clippaths)
            {
                if ( c.name == clipPath.name ) return;
            }
            _clippaths.push(clipPath);
        }

        public function getGradientById( id:String ):IGradient
        {
            for each ( var g:IGradient in _gradients )
            {
                if ( g.getId() == id ) return g;
            }
            return null;
        }
        
        public function getFilterById( id:String ):FilterSet
        {
           for each ( var f:FilterSet in _filters )
            {
                if ( f.id == id ) return f;
            }
            return null;
        }

        public function getClipPathById( name:String ):DisplayObject
        {
            for each(var c:DisplayObject in _clippaths)
            {
                if ( c.name == name ) return c;
            }
            return null;
        }

        public function get rootXML():XML {
            return _rootXML;
        }
        
        public function set rootXML(value:XML):void {
            if (!_rootXML) {
                _rootXML = value;
            }
        }
        
        public function get rootCanvas():DisplayObjectContainer {
            return _rootCanvas;
        }
        
        public function set rootCanvas(value:DisplayObjectContainer):void {
            if (!_rootCanvas) {
                _rootCanvas = value;
            }
        }
    }
}
