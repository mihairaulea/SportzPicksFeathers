package view.screens 
{
	/**
	 * ...
	 * @author Mihai Raulea
	 */
	
	import feathers.controls.Screen;
	import feathers.display.Image;
	import starling.events.Event;
	import starling.events.TouchEvent;
	
	import feathers.controls.Screen;
	import feathers.controls.ScreenHeader;
	import feathers.controls.Button;
	import feathers.controls.text.TextFieldTextRenderer;
	import feathers.system.DeviceCapabilities;
	
	import flash.text.TextFormat;
	
	import org.osflash.signals.ISignal;
	import org.osflash.signals.Signal;
			
	import view.util.Assets;
	 
	public class WelcomeScreen extends Screen
	{
		
		[Embed(source="../../assets/fonts/HelveticaNeueLTCom-BdCn.ttf", embedAsCFF="false", fontName="HelveticaNeueLTCom-BdCn", advancedAntiAliasing="true", mimeType = "application/x-font")]
		private static const helveticaNeue:Class;
		
		//assets
		private var logoImg:Image;
		private var textFormatHowConnect:TextFormat;
		private var textFormatFacebookLabel:TextFormat;
		private var textFormatEmailLabel:TextFormat;
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
			logoImg = new Image( Assets.getAssetsTexture("logo"));
			addChild(logoImg);			
			
			textFormatHowConnect = new TextFormat("HelveticaNeueLTCom-BdCn" , 16 , 0xFFFFFF, true);
			textFormatFacebookLabel = new TextFormat("HelveticaNeueLTCom-BdCn", 16, 0x4D4D4D, true);
			textFormatEmailLabel = new TextFormat("HelveticaNeueLTCom-BdCn", 12, 0x808080, true);
			
			addChild(howConnectText);
			howConnectText.textFormat = textFormatHowConnect;
			howConnectText.embedFonts = true;
			howConnectText.validate();
			
			facebookButton.defaultSkin = new Image(Assets.getAssetsTexture("facebook_btn"));
			facebookButton.downSkin = new Image(Assets.getAssetsTexture("facebook_btn_press"));
			//facebookButton.label = "With facebook";
			addChild(facebookButton);
			triggerSignalOnButtonRelease(facebookButton, EVENTS[0]);
			facebookButton.validate();
			
			emailButton = new Button();
			emailButton.defaultSkin = new Image(Assets.getAssetsTexture("email_btn"));
			emailButton.downSkin = new Image(Assets.getAssetsTexture("email_btn_press"));
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
			logoImg.x = this.actualWidth - logoImg.width >> 1;
			
			howConnectText.x = logoImg.x;
			howConnectText.y = logoImg.height + logoImg.y + 80;
			howConnectText.text = "How would you like to connect?";
			
			facebookButton.label = "With facebook";
			
			facebookButton.x = (this.actualWidth - facebookButton.width)/2;
			facebookButton.y = 190;//howConnectText.y + howConnectText.height;
			
			// "With your email address",);
			addChild(emailButton);

			emailButton.x = this.actualWidth - emailButton.width >> 1;
			emailButton.y = facebookButton.y + facebookButton.height;
			emailButton.label = "With your Email address";
			
			shadow.x = this.actualWidth - shadow.width >> 1;
			shadow.y = emailButton.y + emailButton.height + 10;			
		}
		
		private function triggerSignalOnButtonRelease(button:Button, event:String):void
		{
			button.onRelease.add(function(button:Button):void
			{
				dispatchEvent(new Event(event));
			});

		}
		
	}

}