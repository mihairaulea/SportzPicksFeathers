package view.screens 
{
	import feathers.controls.Screen;
	import feathers.controls.supportClasses.TextFieldViewPort;
	import feathers.controls.text.*;
	import feathers.core.ITextEditor;
	import flash.text.TextRenderer;
	import starling.events.*;
	import starling.display.Image;
	
	import feathers.controls.Screen;
	import feathers.controls.Button;
	import feathers.controls.TextInput;
	import feathers.controls.text.TextFieldTextRenderer;
	import feathers.system.DeviceCapabilities;
	
	import flash.text.TextFormat;
	import feathers.core.ITextRenderer;
	
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
		
		[Embed(source="../../assets/fonts/HelveticaNeueLTCom-MdCn.ttf", embedAsCFF="false", fontName="HelveticaNeue", advancedAntiAliasing="true", mimeType = "application/x-font")]
		private static const helvetica:Class;
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
		private var textFormatFacebookLabel:TextFormat;
		private var textFormatTitleField:TextFormat;
		private var textFormatInputField:TextFormat;
		private var textFormatError:TextFormat;
		private var textFormatGoBtn:TextFormat;
		
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
			textFormatTitleField = new TextFormat("HelveticaNeue", 14, 0x4D4D4D);
			textFormatFacebookLabel = new TextFormat("HelveticaNeueLTCom-BdCn", 16, 0x4D4D4D, true);
			textFormatInputField = new TextFormat("HelveticaNeueLTCom-BdCn", 15, 0xB3B3B3, true);
			textFormatError = new TextFormat("HelveticaNeueLTCom-BdCn", 11, 0x890B0B);
			textFormatGoBtn = new TextFormat("HelveticaNeueLTCom-BdCn", 18, 0xFFFFFF);
			
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
			facebookButton.label = "With Facebook";
			addChild(facebookButton);
			facebookButton.validate();
			
			emailInput = new feathers.controls.TextInput();
			var inputBackImage:Image = new Image(Assets.getAssetsTexture("form_field"));
			inputBackImage.pivotX = 5;
			inputBackImage.pivotY = 3;
			emailInput.textEditorFactory = getTextInputField;
			emailInput.backgroundSkin = inputBackImage;
			
			addChild(emailInput);	
			
			emailInput.validate();
			
			emailErrorFeedback = new TextFieldTextRenderer();
			emailErrorFeedback.textFormat = textFormatError;
			emailErrorFeedback.embedFonts = true;
			addChild(emailErrorFeedback);
						
			usernameInput = new TextInput();
			var inputBackImage2:Image = new Image(Assets.getAssetsTexture("form_field"));
			inputBackImage2.pivotX = 5;
			inputBackImage2.pivotY = 3;
			usernameInput.backgroundSkin = inputBackImage2;
			usernameInput.textEditorFactory = getTextInputField;
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
			goBtn.labelFactory = getGoBtnTextRenderer;
			goBtn.validate();
			
			emailAddressTitle = new TextFieldTextRenderer();
			emailAddressTitle.text = "Email address*";
			emailAddressTitle.textFormat = textFormatTitleField;
			emailAddressTitle.embedFonts = true;
			addChild(emailAddressTitle);
			
			usernameTitle = new TextFieldTextRenderer();
			usernameTitle.text = "Username";
			usernameTitle.textFormat = textFormatTitleField;
			usernameTitle.embedFonts = true;
			addChild(usernameTitle);
			usernameTitle.validate();
			
			triggerSignalOnButtonRelease(goBtn, EVENTS[0]);
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
			facebookButton.labelFactory = getFacebookTextRenderer;
			
			backgroundPanel.x = facebookButton.x;
			backgroundPanel.y = facebookButton.y + facebookButton.height;
			
			emailAddressTitle.x = backgroundPanel.x + 25;
			emailAddressTitle.y = facebookButton.y + facebookButton.height + 14;
			
			emailInput.x = backgroundPanel.x + 20;
			emailInput.y = emailAddressTitle.y + 25;
			emailInput.addEventListener("focusIn", focusFormHandler);
			emailInput.text = "Type your Email Address here";
			
			emailErrorFeedback.x = emailAddressTitle.x;
			emailErrorFeedback.y = emailInput.y + 24;
			emailErrorFeedback.text = "Please enter a valid email address";
			emailErrorFeedback.visible = false;
			
			usernameTitle.x = emailAddressTitle.x;
			usernameTitle.y = emailInput.y + 38;;
			
			usernameInput.x = emailInput.x;
			usernameInput.y = usernameTitle.y + 25;
			usernameInput.text = "Type your username here(optional)";
			usernameInput.addEventListener("focusIn", focusFormHandler);
			
			usernameErrorFeedback.x = usernameTitle.x;
			usernameErrorFeedback.y = usernameInput.y + 24;
			usernameErrorFeedback.text = "Sorry, this username is already taken try again";
			usernameErrorFeedback.visible = false;
			
			addChild(goBtn);
			
			goBtn.x = backgroundPanel.x + ( (backgroundPanel.width - goBtn.defaultSkin.width) / 2 );
			goBtn.y = usernameErrorFeedback.y + 22;
		}
		
		private function focusFormHandler(e:Event):void
		{
			TextInput(e.target).text = "";
		}
		
		private function triggerSignalOnButtonRelease(button:Button, event:String):void
		{
			button.addEventListener( Event.TRIGGERED,(function(e:Event):void
			{
				if( checkForm() ) dispatchEvent(new Event(event));
			}));

		}
		
		private function checkForm():Boolean
		{			
			trace(emailInput.text + " email input text");
			trace(check(emailInput.text));
			if ( check( emailInput.text ) == false )
			{
				emailErrorFeedback.visible = true;
				return false;
			}
			else emailErrorFeedback.visible = false;
			
			if ( usernameInput.text == "" )
			{
				usernameErrorFeedback.visible = true;
				return false;
			}
			else usernameErrorFeedback.visible = false;
			
			return true;			
		}
		
		private function getFacebookTextRenderer():ITextRenderer
		{
			var facebookLabel:TextFieldTextRenderer = new TextFieldTextRenderer();
			
			facebookLabel.textFormat = textFormatFacebookLabel;
			facebookLabel.embedFonts = true;
			
			return facebookLabel;
		}
		
		private function getGoBtnTextRenderer():ITextRenderer
		{
			var goLabel:TextFieldTextRenderer = new TextFieldTextRenderer();
			
			goLabel.textFormat = textFormatGoBtn;
			goLabel.embedFonts = true;
			
			return goLabel;
		}
		
		private function getTextInputField():ITextEditor
		{
			var label:TextFieldTextEditor = new TextFieldTextEditor();
			
			label.textFormat = textFormatInputField;
			label.embedFonts = true;
			
			return label;
		}
		
		private function check ( mail:String ):Boolean
		{
          var emailExpression:RegExp = /^[\w.-]+@\w[\w.-]+\.[\w.-]*[a-z][a-z]$/i;

          if( mail.match(emailExpression) == null )
          {
               return false;
          }
          else
          {
               return true;
          }
		}
		
	}

}