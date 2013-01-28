package view.screens 
{
	/**
	 * ...
	 * @author Mihai Raulea
	 */
	import feathers.controls.List;
	import feathers.data.ListCollection;
	import feathers.controls.Screen;
	import feathers.layout.VerticalLayout;
	//import flash.events.Event;
	import starling.display.Sprite;
	import starling.display.Image;
	import flash.text.TextRenderer;
	import starling.events.*;
	import starling.events.Event;
	
	import feathers.controls.Screen;
	import feathers.controls.Button;
	import feathers.controls.TextInput;
	import feathers.controls.text.*;
	import feathers.system.DeviceCapabilities;
	import feathers.controls.renderers.*;
	
	import flash.text.TextFormat;
	import feathers.core.*;
	
	import org.osflash.signals.ISignal;
	import org.osflash.signals.Signal;
			
	import view.util.*; 
	 
	public class NewGameScreen extends Screen
	{
		
		private var commonAssetsScreen:CommonAssetsScreen;
		
		private var header:Sprite;
		private var findOpponentText:TextFieldTextRenderer;
		
		private var emailPanel:Image;
		private var emailInput:TextInput;
		
		private var withFacebookButton:Button;
		private var withFacebookTitleText:TextFieldTextRenderer;
		private var withFacebookSubtitleText:TextFieldTextRenderer;
		
		private var randomOpponentButton:Button;
		private var randomOpponentTitleText:TextFieldTextRenderer;
		private var randomOpponentSubtitleText:TextFieldTextRenderer;
	
		private var withEmailAddressButton:Button;
		private var withEmailAddressTitleText:TextFieldTextRenderer;
		private var withEmailAddressSubtitleText:TextFieldTextRenderer;
			
		private var shadow:Image;
		
		public function NewGameScreen() 
		{
			commonAssetsScreen = CommonAssetsScreen.getInstance();
		}
		
		override protected function initialize():void
		{
			header = commonAssetsScreen.getHeader("New Game",true, headerBackButtonHandler, false);
			addChild( header );
						
			shadow = new Image(Assets.getAssetsTexture("shadow"));
			addChild(shadow);
			shadow.x = 0;
			shadow.y = 330;
			
			findOpponentText = new TextFieldTextRenderer();
			findOpponentText.text = "How do you want to find \nyour opponent";
			findOpponentText.width = 400;
			findOpponentText.height = 70;
			findOpponentText.x = 37;
			findOpponentText.y = 74;
			findOpponentText.textFormat = FontFactory.getTextFormat(0, 18, 0xFFFFFF);
			findOpponentText.embedFonts = true;
			addChild(findOpponentText);		
						
			withFacebookButton = new Button();
			withFacebookButton.defaultSkin = new Image( Assets.getAssetsTexture("facebook_btn") );
			withFacebookButton.downSkin = new Image( Assets.getAssetsTexture("facebook_btn_press") );
			withFacebookButton.label = "";
			withFacebookButton.x = 10;
			withFacebookButton.y = 141;
			
			withFacebookTitleText = new TextFieldTextRenderer();
			withFacebookTitleText.text = "With Facebook";
			withFacebookTitleText.width = 400;
			withFacebookTitleText.textFormat = FontFactory.getTextFormat(1, 18, 0x4D4D4D);
			withFacebookTitleText.embedFonts = true;
			withFacebookTitleText.x = 71;
			withFacebookTitleText.y = 15.4;
			
			withFacebookSubtitleText = new TextFieldTextRenderer();
			withFacebookSubtitleText.text = "Play with your Facebook friends";
			withFacebookSubtitleText.width = 400;
			withFacebookSubtitleText.textFormat = FontFactory.getTextFormat(2, 11, 0x808080);
			withFacebookSubtitleText.embedFonts = true;
			withFacebookSubtitleText.x = 71;
			withFacebookSubtitleText.y = 35;
			
			withFacebookButton.addChild(withFacebookTitleText);
			withFacebookButton.addChild(withFacebookSubtitleText);
			
			addChild(withFacebookButton);
			
			//====================================================================
			
			randomOpponentButton = new Button();
			randomOpponentButton.defaultSkin = new Image( Assets.getAssetsTexture("random_btn") );
			randomOpponentButton.downSkin = new Image( Assets.getAssetsTexture("random_btn_press") );
			randomOpponentButton.label = "";
			randomOpponentButton.x = 10;
			randomOpponentButton.y = 200;
			
			randomOpponentTitleText = new TextFieldTextRenderer();
			randomOpponentTitleText.text = "Random Opponent";
			randomOpponentTitleText.textFormat = FontFactory.getTextFormat(1, 18, 0x4D4D4D);
			randomOpponentTitleText.embedFonts = true;
			randomOpponentTitleText.x = 71;
			randomOpponentTitleText.y = 15.4;
			randomOpponentTitleText.width = 400;
			
			randomOpponentSubtitleText = new TextFieldTextRenderer();
			randomOpponentSubtitleText.text = "Let us find your opponent for you";
			randomOpponentSubtitleText.textFormat = FontFactory.getTextFormat(2, 11, 0x808080);
			randomOpponentSubtitleText.embedFonts = true;
			randomOpponentSubtitleText.x = 71;
			randomOpponentSubtitleText.y = 35;
			randomOpponentSubtitleText.width = 400;
			
			randomOpponentButton.addChild(randomOpponentTitleText);
			randomOpponentButton.addChild(randomOpponentSubtitleText);
			
			addChild(randomOpponentButton);
			
			//====================================================================
			
			withEmailAddressButton = new Button();
			withEmailAddressButton.defaultSkin = new Image( Assets.getAssetsTexture("email_btn") );
			withEmailAddressButton.downSkin = new Image( Assets.getAssetsTexture("email_btn_press") );
			withEmailAddressButton.label = "";
			withEmailAddressButton.x = 10;
			withEmailAddressButton.y = 260;
			
			withEmailAddressTitleText = new TextFieldTextRenderer();
			withEmailAddressTitleText.text = "With your Email address";
			withEmailAddressTitleText.textFormat = FontFactory.getTextFormat(1, 18, 0x4D4D4D);
			withEmailAddressTitleText.embedFonts = true;
			withEmailAddressTitleText.x = 71;
			withEmailAddressTitleText.y = 15.4;
			withEmailAddressTitleText.width = 400;
			
			withEmailAddressSubtitleText = new TextFieldTextRenderer();
			withEmailAddressSubtitleText.text = "Search for an opponent by email";
			withEmailAddressSubtitleText.textFormat = FontFactory.getTextFormat(2, 11, 0x808080);
			withEmailAddressSubtitleText.embedFonts = true;
			withEmailAddressSubtitleText.x = 71;
			withEmailAddressSubtitleText.y = 35;
			withEmailAddressSubtitleText.width = 400;
			
			withEmailAddressButton.addChild(withEmailAddressTitleText);
			withEmailAddressButton.addChild(withEmailAddressSubtitleText);
			
			addChild(withEmailAddressButton);
			
			//====================================================================
			
		}
		
		private function headerBackButtonHandler()
		{
			dispatchEvent(new starling.events.Event("onBack"));
		}
		
		override protected function draw():void
		{
			withEmailAddressButton.addEventListener(Event.TRIGGERED, emailHandler);
			withFacebookButton.addEventListener(Event.TRIGGERED, facebookHandler);
		}
		
		private function emailHandler(e:Event)
		{
			dispatchEvent(new Event("onEmail"));
		}
		
		private function facebookHandler(e:Event)
		{
			dispatchEvent(new Event("onFacebook"));
		}
					
		override protected function screen_addedToStageHandler(event:Event):void
		{
			commonAssetsScreen.refreshBackCallback( headerBackButtonHandler );
		}
		
	}

}