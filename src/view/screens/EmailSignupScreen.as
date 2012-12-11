package view.screens 
{
	import feathers.controls.Screen;
	import feathers.display.Image;
	import flash.text.TextRenderer;
	import starling.events.Event;
	
	import feathers.controls.Screen;
	import feathers.controls.ScreenHeader;
	import feathers.controls.Button;
	import feathers.controls.TextInput;
	import feathers.controls.text.TextFieldTextRenderer;
	import feathers.system.DeviceCapabilities;
	
	import flash.text.TextFormat;
	
	import org.osflash.signals.ISignal;
	import org.osflash.signals.Signal;
			
	import view.util.Assets;
	/**
	 * ...
	 * @author Mihai Raulea
	 */
	public class EmailSignupScreen extends Screen
	{
		
		[Embed(source="../../assets/fonts/HelveticaNeueLTCom-BdCn.ttf", embedAsCFF="false", fontName="HelveticaNeueLTCom-BdCn", advancedAntiAliasing="true", mimeType = "application/x-font")]
		private static const helveticaNeue:Class;
		
		//assets
		private var smallLogo:Image;
		private var logoBackground:Image;
		private var navBarShadow:Image;
		private var facebookButton:Button;
		
		private var createYourAccount:TextFieldTextRenderer;
		
		private var emailAddressTitle:TextFieldTextRenderer;
		private var emailInput:TextInput;
		private var emailErrorFeedback:TextFieldTextRenderer;
		
		private var usernameTitle:TextFieldTextRenderer;
		private var usernameInput:TextInput;
		private var usernameErrorFeedback:TextFieldTextRenderer;
		
		private var textFormatCreateYourAccount:TextFormat;
		private var textFormatWithFacebook:TextFormat;
		private var textFormatTitleField:TextFormat;
		private var textFormatInputField:TextFormat;
		private var textFormatError:TextFormat;
		
		private var backgroundPanel:Image;
		private var goBtn:Button;
		
		private static const EVENTS:Vector.<String> = new <String>
		[
		 "EmailValidated",
		];
		
		public function EmailSignupScreen() 
		{
			
		}
		
		override protected function initialize():void
		{
			logoBackground = new Image( Assets.getAssetsTexture("nav_bar") );
			addChild(logoBackground);
					
			smallLogo = new Image(Assets.getAssetsTexture("logo_small"));
			addChild(smallLogo);
			
			navBarShadow = new Image(Assets.getAssetsTexture("nav_bar_shadow"));
			addChild(navBarShadow);
			
			textFormatCreateYourAccount = new TextFormat("HelveticaNeueLTCom-BdCn", 16, 0xFFFFFF);
			textFormatTitleField = new TextFormat("HelveticaNeueLTCom", 14, 0x4D4D4D);
			textFormatError = new TextFormat("HelveticaNeueLTCom-BdCn", 9, 0x890B0B);
			
			createYourAccount = new TextFieldTextRenderer();
			createYourAccount.text = "Create your account";
			addChild(createYourAccount);
			createYourAccount.textFormat = textFormatCreateYourAccount;
			createYourAccount.embedFonts = true;
			createYourAccount.validate();
						
			backgroundPanel = new Image(Assets.getAssetsTexture("panel_bottom"));
			addChild(backgroundPanel);
			
			facebookButton = new Button();
			facebookButton.defaultSkin = new Image(Assets.getAssetsTexture("facebook_btn"));
			facebookButton.downSkin = new Image(Assets.getAssetsTexture("facebook_btn_press"));
			facebookButton.label = "With facebook";
			addChild(facebookButton);
			facebookButton.validate();
			
			emailAddressTitle = new TextFieldTextRenderer();
			emailAddressTitle.text = "Email address*";
			emailAddressTitle.textFormat = textFormatTitleField;
			emailAddressTitle.embedFonts = true;
			addChild(emailAddressTitle);
			
			emailInput = new feathers.controls.TextInput();
			var inputBackImage:Image = new Image(Assets.getAssetsTexture("form_field"));
			inputBackImage.pivotX = 5;
			inputBackImage.pivotY = 3;
			emailInput.backgroundSkin = inputBackImage;
			addChild(emailInput);	
			emailInput.validate();
			
			emailErrorFeedback = new TextFieldTextRenderer();
			emailErrorFeedback.textFormat = textFormatError;
			emailErrorFeedback.embedFonts = true;
			addChild(emailErrorFeedback);
			
			usernameTitle = new TextFieldTextRenderer();
			usernameTitle.text = "Username";
			usernameTitle.textFormat = textFormatTitleField;
			usernameTitle.embedFonts = true;
			addChild(usernameTitle);
			usernameTitle.validate();
			
			usernameInput = new TextInput();
			var inputBackImage2:Image = new Image(Assets.getAssetsTexture("form_field"));
			inputBackImage2.pivotX = 5;
			inputBackImage2.pivotY = 3;
			usernameInput.backgroundSkin = inputBackImage2;
			addChild(usernameInput);
			usernameInput.validate();
		
			usernameErrorFeedback = new TextFieldTextRenderer();
			usernameErrorFeedback.textFormat = textFormatError;
			usernameErrorFeedback.embedFonts = true;
			
			addChild(usernameErrorFeedback);
			
			goBtn = new Button();
			goBtn.defaultSkin = new Image( Assets.getAssetsTexture("go_btn"));
			goBtn.downSkin = new Image( Assets.getAssetsTexture("go_btn_press"));
			goBtn.label = "Go";
			//goBtn.validate();
		}
		
		override protected function draw():void
		{							
			//logo
			smallLogo.x = this.actualWidth - smallLogo.width >> 1;
			//logoBackground.x = logoBackground.y = 0;
			navBarShadow.y = logoBackground.y + logoBackground.height;
			
			createYourAccount.x = 25;
			createYourAccount.y = navBarShadow.y + navBarShadow.height + 20;
			
			facebookButton.x = (this.actualWidth - facebookButton.width)/2;
			facebookButton.y = createYourAccount.y + createYourAccount.height + 20;
			
			backgroundPanel.x = facebookButton.x;
			backgroundPanel.y = facebookButton.y + facebookButton.height;
			
			emailAddressTitle.x = backgroundPanel.x + 20;
			emailAddressTitle.y = facebookButton.y + facebookButton.height + 10;
			
			emailInput.x = backgroundPanel.x + 10;
			emailInput.y = emailAddressTitle.y + emailAddressTitle.height + 20;
			emailInput.text = "Type your Email Address here";
			
			emailErrorFeedback.x = emailAddressTitle.x;
			emailErrorFeedback.y = emailInput.y + 28;
			emailErrorFeedback.text = "Please enter a valid email address.";
			
			usernameTitle.x = backgroundPanel.x + 20;
			usernameTitle.y = emailErrorFeedback.y + emailErrorFeedback.height + 10;
			
			usernameInput.x = backgroundPanel.x + 10;
			usernameInput.y = usernameTitle.y + usernameTitle.height+10 ;
			usernameInput.text = "Type your username here(optional)";
			
			usernameErrorFeedback.x = usernameTitle.x;
			usernameErrorFeedback.y = usernameInput.y + 28;
			usernameErrorFeedback.text = "Sorry, this username is already taken try again";
			
			addChild(goBtn);
			
			trace(backgroundPanel.width);
			trace(goBtn.width);
			trace((backgroundPanel.width - goBtn.width) / 2);
			
			goBtn.x = backgroundPanel.x + ( (backgroundPanel.width - goBtn.defaultSkin.width) / 2 );
			goBtn.y = usernameErrorFeedback.y + 20;
		}
		
	}

}