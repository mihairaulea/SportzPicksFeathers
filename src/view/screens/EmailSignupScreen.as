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
	import flash.text.engine.FontWeight;
	import feathers.core.ITextRenderer;
	
	import org.osflash.signals.ISignal;
	import org.osflash.signals.Signal;
			
	import view.util.*;
	
	import feathers.events.FeathersEventType;
	/**
	 * ...
	 * @author Mihai Raulea
	 */
	public class EmailSignupScreen extends Screen
	{		
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
				
		private var backgroundPanel:Image;
		private var goBtn:Button;
		private var shadow:Image;
		
		private var commonAssets:CommonAssetsScreen = CommonAssetsScreen.getInstance();
		
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
						
			createYourAccount = new TextFieldTextRenderer();
			createYourAccount.text = "Create your account";
			addChild(createYourAccount);
			createYourAccount.textFormat = FontFactory.getTextFormat(0,18,0xFFFFFF);
			createYourAccount.embedFonts = true;
			createYourAccount.validate();
						
			backgroundPanel = new Image(Assets.getAssetsTexture("panel_bottom"));
			addChild(backgroundPanel);
			
			facebookButton = new Button();
			facebookButton.defaultSkin = new Image(Assets.getAssetsTexture("facebook_btn"));
			facebookButton.downSkin = new Image(Assets.getAssetsTexture("facebook_btn_press"));
			facebookButton.label = "With Facebook";
			facebookButton.labelOffsetX = -14;
			addChild(facebookButton);
			facebookButton.validate();
			
			emailInput = new feathers.controls.TextInput();
			var inputBackImage:Image = new Image(Assets.getAssetsTexture("form_field"));
			inputBackImage.pivotX = 15;
			inputBackImage.pivotY = 6;
			emailInput.width = 265;
			emailInput.height = 27;
			emailInput.textEditorFactory = getTextInputField;
			emailInput.backgroundSkin = inputBackImage;
			
			addChild(emailInput);	
			
			//emailInput.validate();
			
			emailErrorFeedback = new TextFieldTextRenderer();
			emailErrorFeedback.textFormat = FontFactory.getTextFormat(2,12,0x890B0B);
			emailErrorFeedback.embedFonts = true;
			addChild(emailErrorFeedback);
						
			usernameInput = new TextInput();
			var inputBackImage2:Image = new Image(Assets.getAssetsTexture("form_field"));
			inputBackImage2.pivotX = 15;
			inputBackImage2.pivotY = 6;
			usernameInput.width = 265;
			usernameInput.height = 27;
			usernameInput.backgroundSkin = inputBackImage2;
			usernameInput.textEditorFactory = getTextInputField;
			addChild(usernameInput);
			usernameInput.validate();
		
			usernameErrorFeedback = new TextFieldTextRenderer();
			usernameErrorFeedback.textFormat = FontFactory.getTextFormat(2,12,0x890B0B);
			usernameErrorFeedback.embedFonts = true;
			
			addChild(usernameErrorFeedback);
						
			goBtn = commonAssets.getGoBtn("Go", goBtnHandler);
			
			emailAddressTitle = new TextFieldTextRenderer();
			emailAddressTitle.text = "Email address*";
			emailAddressTitle.textFormat = FontFactory.getTextFormat(0,15,0x4D4D4D);
			emailAddressTitle.embedFonts = true;
			addChild(emailAddressTitle);
			
			usernameTitle = new TextFieldTextRenderer();
			usernameTitle.text = "Username";
			usernameTitle.textFormat = FontFactory.getTextFormat(0,15,0x4D4D4D);
			usernameTitle.embedFonts = true;
			addChild(usernameTitle);
			usernameTitle.validate();
			
			shadow = new Image(Assets.getAssetsTexture("shadow"));
			addChild(shadow);	
		}
		
		override protected function draw():void
		{							
			//logo
			smallLogo.x = this.actualWidth - smallLogo.width >> 1;
			//logoBackground.x = logoBackground.y = 0;
			navBarShadow.y = logoBackground.y + logoBackground.height;
			
			createYourAccount.x = 26;
			createYourAccount.y = 67;
			
			facebookButton.x = 10//(this.actualWidth - facebookButton.width)/2;
			facebookButton.y = 218 / 2;//createYourAccount.y + createYourAccount.height + 20;
			facebookButton.labelFactory = getFacebookTextRenderer;
			
			backgroundPanel.x = facebookButton.x;
			backgroundPanel.y = facebookButton.y + facebookButton.height;
			
			emailAddressTitle.x = backgroundPanel.x + 25;
			emailAddressTitle.y = facebookButton.y + facebookButton.height + 14;
			
			emailInput.x = backgroundPanel.x + 26;
			emailInput.y = emailAddressTitle.y + 25;
			emailInput.text = "Type your Email Address here";
			emailInput.addEventListener("focusIn", inputFocusHandler);
			
			emailErrorFeedback.x = emailAddressTitle.x;
			emailErrorFeedback.y = emailInput.y + 24;
			emailErrorFeedback.text = "Please enter a valid email address";
			emailErrorFeedback.visible = false;
			
			usernameTitle.x = emailAddressTitle.x;
			usernameTitle.y = emailInput.y + 38;;
			
			usernameInput.x = emailInput.x;
			usernameInput.y = usernameTitle.y + 25;
			usernameInput.text = "Type your username here(optional)";
			usernameInput.addEventListener("focusIn", inputFocusHandler);
			
			usernameErrorFeedback.x = usernameTitle.x;
			usernameErrorFeedback.y = usernameInput.y + 24;
			usernameErrorFeedback.text = "Sorry, this username is already taken try again";
			usernameErrorFeedback.visible = false;
			
			addChild(goBtn);
			
			goBtn.x = backgroundPanel.x + ( (backgroundPanel.width - goBtn.defaultSkin.width) / 2 );
			goBtn.y = usernameErrorFeedback.y + 23;
						
			shadow.x = 0;
			shadow.y = 346;	
		}
		
		private function goBtnHandler()
		{
			dispatchEvent(new Event(EVENTS[0]));
		}
				
		private function inputFocusHandler(e:Event):void
		{
			TextInput(e.target).text = "";
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
			
			facebookLabel.textFormat = FontFactory.getTextFormat(0,18,0x4D4D4D);
			facebookLabel.embedFonts = true;
			
			return facebookLabel;
		}
		
		private function getGoBtnTextRenderer():ITextRenderer
		{
			var goLabel:TextFieldTextRenderer = new TextFieldTextRenderer();
			
			goLabel.textFormat = FontFactory.getTextFormat(0,18,0x4D4D4D);
			goLabel.embedFonts = true;
			
			return goLabel;
		}
		
		private function getTextInputField():StageTextTextEditor
		{
			var label:StageTextTextEditor = new StageTextTextEditor();
			
			label.color = 0xB3B3B3;
			label.fontFamily = "Helvetica";
			label.fontSize = 11 * DeviceConstants.SCALE;
			label.fontWeight = FontWeight.BOLD;
			
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