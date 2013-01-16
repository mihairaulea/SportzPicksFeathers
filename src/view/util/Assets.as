package view.util 
{
	import flash.display.Bitmap;
    import flash.media.Sound;
    import flash.utils.ByteArray;
    import flash.utils.Dictionary;
    
    import starling.text.BitmapFont;
    import starling.text.TextField;
    import starling.textures.Texture;
    import starling.textures.TextureAtlas;
	
	// ---
	// Main assets class
	// Handles distribution of assets
	
	import view.util.AssetsEmbedsHD;
	import view.util.AssetsEmbedsSD;
	
	public class Assets 
	{
		
		private static var sContentScaleFactor:int = 1;
        
		private static var sTextures:Dictionary = new Dictionary();
		private static var sTextureAtlasAssets:TextureAtlas;
		private static var sTextureAtlasAssets2:TextureAtlas;
        
		
		public static function getTexture(name:String,batchToLookIn:int=1):Texture
        {
            if (sTextures[name] == undefined)
            {
                var data:Object = create(name,batchToLookIn);
                
                if (data is Bitmap)
                    sTextures[name] = Texture.fromBitmap(data as Bitmap, true, false, sContentScaleFactor);
                else if (data is ByteArray)
                    sTextures[name] = Texture.fromAtfData(data as ByteArray, sContentScaleFactor);
            }
            
            return sTextures[name];
        }
        
        public static function getAssetsTexture(name:String,batchToLookIn:int=1):Texture
        {
            prepareAtlasAssets();
            if (batchToLookIn == 1) return sTextureAtlasAssets.getTexture(name);
			if (batchToLookIn == 2) return sTextureAtlasAssets2.getTexture(name);
			
			return null;
		}
		
        public static function getAssetsTextures(prefix:String):Vector.<Texture>
        {
            prepareAtlasAssets();
            return sTextureAtlasAssets.getTextures(prefix);
        }
		
        private static function prepareAtlasAssets():void
        {
            if (sTextureAtlasAssets == null)
            {
                var textureAssets:Texture = getTexture("AtlasTextureAssets",1);
                var xmlAssets:XML = XML(create("AtlasXmlAssets",1));
                sTextureAtlasAssets = new TextureAtlas(textureAssets, xmlAssets);
            }
			
			if (sTextureAtlasAssets2 == null)
			{				
                var textureAssets2:Texture = getTexture("AtlasTextureAssets2",2);
                var xmlAssets2:XML = XML(create("AtlasXmlAssets2",2));
                sTextureAtlasAssets2 = new TextureAtlas(textureAssets2, xmlAssets2);
			}
        }
		
        private static function create(name:String,batchToLookIn:int):Object
        {
			
            var textureClass:Class;
			if(batchToLookIn==1) textureClass = sContentScaleFactor == 1 ? AssetsEmbedsSD : AssetsEmbedsHD;
			else
			if(batchToLookIn==2) textureClass = sContentScaleFactor == 1 ? AssetsEmbedsSD2 : AssetsEmbedsHD2;
			//trace(textureClass+" texture class i am getting");
            return new textureClass[name];
        }
        
        public static function get contentScaleFactor():Number { return sContentScaleFactor; }
        public static function set contentScaleFactor(value:Number):void 
        {
            for each (var texture:Texture in sTextures)
                texture.dispose();
            
            sTextures = new Dictionary();
			sContentScaleFactor = value < 1.5 ? 1 : 2; // assets are available for factor 1 and 2 
        }
	}

}