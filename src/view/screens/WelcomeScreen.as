package view.screens 
{
	/**
	 * ...
	 * @author Mihai Raulea
	 */
	
	import starling.display.Image;
	 
	import feathers.controls.ImageLoader;
	import feathers.controls.Screen;
	import feathers.core.ITextRenderer;
	import feathers.display.Scale3Image;
	//import feathers.display.Image;
	import flash.text.TextRenderer;
	import starling.events.Event;
	import starling.events.TouchEvent;
	
	import feathers.controls.Screen;
	//import feathers.controls.ScreenHeader;
	import feathers.controls.Button;
	import feathers.controls.text.TextFieldTextRenderer;
	import feathers.system.DeviceCapabilities;
	
	import flash.text.TextFormat;
	
	import org.osflash.signals.ISignal;
	import org.osflash.signals.Signal;
			
	import view.util.Assets;
	import view.util.DeviceConstants;
	import view.util.FontFactory;
	 
	public class WelcomeScreen extends Screen
	{
		//assets
		
		private var logoImg:Image;
		
		private var howConnectText:TextFieldTextRenderer = new TextFieldTextRenderer();
		private var facebookButton:Button = new Button();
		private var emailButton:Button ;
		private var shadow:Image;
		
		
		public function WelcomeScreen() 
		{
			super();
			trace("Welcome Screen Constructor");
		}
		
		private static const EVENTS:Vector.<String> = new <String>
		[
			"onFacebook",
			"onEmail"
		];
		
		override protected function initialize():void
		{			
			logoImg = new Image(Assets.getAssetsTexture("logo"));
			addChild(logoImg);
			
			addChild(howConnectText);
			howConnectText.width = 240;
			howConnectText.height = 32;
			howConnectText.textFormat = FontFactory.getTextFormat(0, 18, 0xFFFFFF);
			howConnectText.embedFonts = true;
			howConnectText.validate();
			
			
			facebookButton.defaultSkin = new ImageLoader();
			facebookButton.defaultSkin = new Image(Assets.getAssetsTexture("facebook_btn"));
			facebookButton.downSkin = new Image(Assets.getAssetsTexture("facebook_btn_press"));
			addChild(facebookButton);
			facebookButton.validate();
			
			emailButton = new Button();
			emailButton.defaultSkin = new Image(Assets.getAssetsTexture("first_screen_email_btn"));
			emailButton.downSkin = new Image(Assets.getAssetsTexture("first_screen_email_btn_press"));
			addChild(emailButton);
			triggerSignalOnButtonRelease(emailButton, EVENTS[1]);
			emailButton.validate();
						
			shadow = new Image(Assets.getAssetsTexture("shadow"));
			addChild(shadow);			
		}
		
		
		//override 
		override protected function draw():void
		{						
			//logo
			logoImg.x = (this.actualWidth - logoImg.width >> 1) - 22.5;
			logoImg.y = 74;
			
			howConnectText.x = 35;
			howConnectText.y = 204.5;
			howConnectText.text = "How would you like to connect?";
			
			facebookButton.label = "With Facebook";
			facebookButton.labelFactory = getFacebookTextRenderer;
			
			facebookButton.x = 10;
			facebookButton.y = 234.5;
			facebookButton.labelOffsetX = -8;
			
			// "With your email address",);
			addChild(emailButton);

			emailButton.x = 10;
			emailButton.y = 303.5;
			emailButton.labelFactory = getEmailTextRenderer;
			emailButton.label = "With your Email address";
			emailButton.labelOffsetX = -8;
			
			shadow.x = 0;
			shadow.y = 346;					
		}
		
		override protected function screen_removedFromStageHandler(event:Event):void
		{
			super.screen_removedFromStageHandler(event);
			trace("screen removed from stage handler");
		}
		
		private function getFacebookTextRenderer():ITextRenderer
		{
			var facebookLabel:TextFieldTextRenderer = new TextFieldTextRenderer();
			facebookLabel.width = 140;
			facebookLabel.textFormat = FontFactory.getTextFormat(0,18,0x4d4d4d);
			facebookLabel.textFormat.align = "left";
			facebookLabel.embedFonts = true;
			
			return facebookLabel;
		}
		
		private function getEmailTextRenderer():ITextRenderer
		{
			var facebookLabel:TextFieldTextRenderer = new TextFieldTextRenderer();
			facebookLabel.width = 140;			
			facebookLabel.textFormat = FontFactory.getTextFormat(2,15,0x808080);
			facebookLabel.textFormat.align = "left";
			facebookLabel.embedFonts = true;
			
			return facebookLabel;
		}
		
		private function triggerSignalOnButtonRelease(button:Button, event:String):void
		{
			button.addEventListener( Event.TRIGGERED,(function(e:Event):void
			{
				dispatchEvent(new starling.events.Event(event));
			}));

		}
		
	}

}