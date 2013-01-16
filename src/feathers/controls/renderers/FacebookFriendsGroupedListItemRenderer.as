package feathers.controls.renderers 
{
	/**
	 * ...
	 * @author ...
	 */
	
	import feathers.controls.List;
	import feathers.controls.text.TextFieldTextRenderer;
	import starling.display.Image;
	import starling.events.Event;
	import view.util.*; 
	
	public class FacebookFriendsGroupedListItemRenderer extends DefaultGroupedListItemRenderer
	{
		
		private var backgroundImage:Image;
		private var profilePic:Image;
		private var nameRenderer:TextFieldTextRenderer;
		
		public function FacebookFriendsGroupedListItemRenderer() 
		{
			
		}
		
		override protected function initialize():void
		{
			backgroundImage = new Image( Assets.getAssetsTexture("friend_bg") );
			addChild(backgroundImage);
			
			this.width = backgroundImage.width;
			this.height = backgroundImage.height;
			profilePic = new Image( Assets.getAssetsTexture("profilePic") );
			addChild(profilePic);
			
			nameRenderer = new TextFieldTextRenderer();
			nameRenderer.x = 56.5;
			nameRenderer.y = 10;
			nameRenderer.width = 210;
			nameRenderer.height = 21;
			nameRenderer.textFormat = FontFactory.getTextFormat(1, 15, 0x4D4D4D);
			nameRenderer.embedFonts = true;
			addChild(nameRenderer);
			nameRenderer.text = "Text";
		}
		
		override protected function draw():void
		{
			profilePic.width  = 35;
			profilePic.height = 35;
			profilePic.x = 6;
			profilePic.y = 3;
			
			this.commitData();
		}
		
		override protected function commitData():void
		{
			trace("commit data");
			if(this._data)
			{
				nameRenderer.text = this._data.text;
			}
		}
		
	}

}