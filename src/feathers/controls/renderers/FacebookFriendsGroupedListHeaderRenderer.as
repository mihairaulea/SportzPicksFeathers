package feathers.controls.renderers 
{
	/**
	 * ...
	 * @author Mihai Raulea
	 */
	
	import feathers.controls.GroupedList;
	import feathers.controls.ImageLoader;
	import feathers.controls.text.TextFieldTextRenderer;
	import feathers.core.FeathersControl;
	import feathers.core.ITextRenderer;
	import feathers.core.PropertyProxy;

	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.textures.Texture;
	
	import view.util.*;
	 
	public class FacebookFriendsGroupedListHeaderRenderer extends DefaultGroupedListHeaderOrFooterRenderer
	{
		
		private var backgroundImage1:Image;
		private var backgroundImage2:Image;
		private var letterDisplay:TextFieldTextRenderer;
		
		private static var isFirst:Boolean = true;
		
		public function FacebookFriendsGroupedListHeaderRenderer() 
		{
			
		}
		
		override protected function initialize():void
		{
			backgroundImage1 = new Image( Assets.getAssetsTexture( "a_bar" ) );
			backgroundImage2 = new Image( Assets.getAssetsTexture( "b-z_bar" ) );
						
			addChild(backgroundImage1);
			addChild(backgroundImage2);
			backgroundImage1.visible = backgroundImage2.visible = false;
					
			letterDisplay = new TextFieldTextRenderer();
			letterDisplay.textFormat = FontFactory.getTextFormat(1, 15, 0x4D4D4D);
			letterDisplay.embedFonts = true;
			addChild(letterDisplay);
			this.width = backgroundImage2.width;
			this.height = backgroundImage2.height;
		}
		
		override protected function draw():void
		{			
			letterDisplay.text = this.data.toString();
			if (data.toString() == "A") this.currentBackgroundSkin = backgroundImage1;
			else						this.currentBackgroundSkin = backgroundImage2;
			
			currentBackgroundSkin.visible = true;
		}
		
	}

}