package feathers.controls.renderers 
{
	/**
	 * ...
	 * @author ...
	 */
	
	import feathers.controls.*;
	import feathers.controls.text.TextFieldTextEditor;
	import feathers.controls.text.TextFieldTextRenderer;
	import starling.display.Image;
	import starling.events.Event;
	import view.util.*; 
	
	public class SelectGameRenderer extends DefaultListItemRenderer
	{
		
		private var backgroundButton:Button;
		private var dateTimeText:TextFieldTextRenderer;
		private var teamText:TextFieldTextRenderer;
		private var coinsText:TextFieldTextRenderer;
		
		public function SelectGameRenderer() 
		{
			
		}
		
		override protected function initialize():void
		{
			backgroundButton = new Button();
			backgroundButton.defaultSkin = new Image( Assets.getAssetsTexture("game_listing_bg") );
			backgroundButton.downSkin = new Image( Assets.getAssetsTexture("game_listing_bg_press") );
			addChild(backgroundButton);
			
			dateTimeText = new TextFieldTextRenderer();
			dateTimeText.text = "Today \n18:00";
			dateTimeText.textFormat = FontFactory.getTextFormat(2, 15, 0x808080);
			dateTimeText.embedFonts = true;
			dateTimeText.width = 120;
			dateTimeText.height = 42;
			backgroundButton.addChild(dateTimeText);
			dateTimeText.x = 10;
			dateTimeText.y = 5;
			
			teamText = new TextFieldTextRenderer();
			teamText.text = "Man Utd \nChelsea";
			teamText.textFormat = FontFactory.getTextFormat(1, 15, 0x4d4d4d);
			teamText.embedFonts = true;
			teamText.width = 150;
			teamText.height = 42;
			backgroundButton.addChild(teamText);
			teamText.x = 68;
			teamText.y = 5;
			
			coinsText = new TextFieldTextRenderer();
			coinsText.text = "999";
			coinsText.textFormat = FontFactory.getTextFormat(2, 15, 0x49413A);
			coinsText.embedFonts = true;
			coinsText.width = 150;
			coinsText.height = 42;
			backgroundButton.addChild(coinsText);
			coinsText.x = 255;
			coinsText.y = 17;
						
			this.width = backgroundButton.defaultSkin.width;
			this.height = backgroundButton.defaultSkin.height;			
		}
		
		override protected function draw():void
		{
			this.commitData();
		}
		
		override protected function commitData():void
		{
			trace("commit data");
			if(this._data)
			{
				trace("commit data");
			}
		}
		
	}

}