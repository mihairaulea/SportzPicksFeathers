package view.screens 
{
	/**
	 * ...
	 * @author Mihai Raulea
	 */
	
	import feathers.controls.Screen;
	import starling.display.Quad;
	import starling.events.*;
	import feathers.controls.Button;
	import feathers.controls.text.TextFieldTextRenderer;
	import starling.display.Sprite;
	import starling.display.Image;
	import feathers.controls.ImageLoader;
	import view.util.CommonAssetsScreen;
	import view.util.Assets;
	import view.util.FontFactory;
	 
	public class ChallengeSentScreen extends Screen
	{
		//assets
		
		private var commonAssets:CommonAssetsScreen;
		
		private var header:Sprite;
		
		private var miniTitle:Sprite;
		
		private var vsScreen:Sprite;
		
		
		private var scoreStrip:Sprite;
		
		private var challengeSentPanel:Sprite;
		
		private var sendToMoreFriendsButton:Button;
		private var sendToMoreFriendsTextField:TextFieldTextRenderer;
		
		private var backToLobbyButton:Button;
		private var backToLobbyTextField:TextFieldTextRenderer;
		
		private var shuffleButton:Button;
		private var shuffleText:TextFieldTextRenderer;
		
		private var seeAllEventsButton:Button;
		private var seeAllEventsText:TextFieldTextRenderer;	
		
		public function ChallengeSentScreen() 
		{
			super();
			commonAssets = CommonAssetsScreen.getInstance();
						
			shuffleText = new TextFieldTextRenderer();
			shuffleText.textFormat = FontFactory.getTextFormat(0, 18, 0xFFFFFF);
			shuffleText.embedFonts = true;
			shuffleText.width = 180;
			
			seeAllEventsText = new TextFieldTextRenderer();
			seeAllEventsText.textFormat = FontFactory.getTextFormat(0, 18, 0x4D4D4D);
			seeAllEventsText.embedFonts = true;
			seeAllEventsText.width = 150;
		}
		
		override protected function initialize():void
		{			
			header = commonAssets.getHeader("Man Utd vs Chelsea", false, null, true,coinsCallbackFunction);
			addChild(header);
			
			miniTitle = commonAssets.getMiniTitle();
			addChild(miniTitle);
			miniTitle.y = 45;
			
			vsScreen = commonAssets.getVsHeader();
			addChild(vsScreen);
			vsScreen.y = 64;
			
			scoreStrip = commonAssets.getScoreStrip("WEEKLY", "HEAD TO HEAD", "588", "700");
			addChild(scoreStrip);
			scoreStrip.y = vsScreen.y + vsScreen.height + 2;
			
			challengeSentPanel = commonAssets.getChallengeSentPanel("Challenge Sent", "+", "25");
			addChild(challengeSentPanel);
			challengeSentPanel.x = 9;
			challengeSentPanel.y = 178;
			
			shuffleButton = new Button();
			shuffleButton.defaultSkin = new Image(Assets.getAssetsTexture("send_to_more"));
			shuffleButton.downSkin = new Image(Assets.getAssetsTexture("send_to_more_press"));
			addChild(shuffleButton);
			shuffleButton.x = 6;
			shuffleButton.y = 335;
			shuffleText.text = "Send to More Friends";
			shuffleButton.addChild( shuffleText );
			shuffleText.x = 53.5;
			shuffleText.y = 16.5;
			
			seeAllEventsButton = new Button();
			seeAllEventsButton.defaultSkin = new Image(Assets.getAssetsTexture("events_btn"));
			seeAllEventsButton.downSkin = new Image(Assets.getAssetsTexture("events_btn_press"));
			addChild(seeAllEventsButton);
			seeAllEventsButton.x = 10;
			seeAllEventsButton.y = 400;
			seeAllEventsText.text = "Back to Lobby";
			seeAllEventsButton.addChild(seeAllEventsText);
			seeAllEventsText.x = 47.5;
			seeAllEventsText.y = 13;
			//seeAllEventsButton.addEventListener(Event.TRIGGERED, seeAllEventsRequest);
		}
		
		private function coinsCallbackFunction()
		{
			trace("coins callback");
		}
		
		override protected function draw():void
		{						
			
		}
		
		override protected function screen_removedFromStageHandler(event:Event):void
		{
			super.screen_removedFromStageHandler(event);
			trace("screen removed from stage handler");
		}
		
		
	}

}