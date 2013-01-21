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
	 
	public class EmailOpponentScreen extends Screen
	{
		
		private var commonAssetsScreen:CommonAssetsScreen;
		
		private var header:Sprite;
		private var enterOpponentEmailAddress:TextFieldTextRenderer;
		
		private var emailPanel:Image;
		private var emailInput:TextInput;
		
		private var goBtn:Button;
		
		private var shadow:Image;
		
		public function EmailOpponentScreen() 
		{
			commonAssetsScreen = CommonAssetsScreen.getInstance();
		}
		
		override protected function initialize():void
		{
			header = commonAssetsScreen.getHeader("Email Friends",true, headerBackButtonHandler, false);
			addChild( header );
			
			enterOpponentEmailAddress = new TextFieldTextRenderer();
			enterOpponentEmailAddress.text = "Enter your opponent's \nemail address";
			enterOpponentEmailAddress.width = 274;
			enterOpponentEmailAddress.height = 70;
			enterOpponentEmailAddress.x = 37;
			enterOpponentEmailAddress.y = 74;
			enterOpponentEmailAddress.textFormat = FontFactory.getTextFormat(0, 18, 0xFFFFFF);
			enterOpponentEmailAddress.embedFonts = true;
			addChild(enterOpponentEmailAddress);		
			
			emailPanel = new Image( Assets.getAssetsTexture("email_friends_panel") );
			addChild(emailPanel);
			emailPanel.x = 10;
			emailPanel.y = 154;
			
			emailInput = commonAssetsScreen.getInputField("Type your opponents email address here", 17, 4, true);
			addChild(emailInput);
						
			emailInput.x = 20;
			emailInput.y = 169;
			
			goBtn = commonAssetsScreen.getGoBtn("Go", goCallback);
			addChild(goBtn);
			goBtn.x = 12;
			goBtn.y = 233;
			
			shadow = new Image(Assets.getAssetsTexture("shadow"));
			addChild(shadow);
			shadow.x = 0;
			shadow.y = 330;
		}
		
		private function headerBackButtonHandler()
		{
			dispatchEvent(new Event("onBack"));
		}
		
		private function goCallback()
		{
			dispatchEvent(new Event("onEmailOk"));
		}
		
		override protected function draw():void
		{
			
		}
		
	}

}