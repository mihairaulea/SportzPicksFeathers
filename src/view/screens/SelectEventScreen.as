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
	 
	public class SelectEventScreen extends Screen
	{
		
		private var commonAssetsScreen:CommonAssetsScreen;
		
		private var header:Sprite;
		private var selectGameText:TextFieldTextRenderer;
		
		private var miniHeader:Sprite;
		
		private var list:List;
		private var shadow:Image;
		
		public function SelectEventScreen() 
		{
			commonAssetsScreen = CommonAssetsScreen.getInstance();
		}
		
		override protected function initialize():void
		{
			header = commonAssetsScreen.getHeader("Select Game",true, headerBackButtonHandler, true, coinsCallbackHandler);
			addChild( header );
						
			selectGameText = new TextFieldTextRenderer();
			selectGameText.x = 16.5;
			selectGameText.y = 59;
			selectGameText.textFormat = FontFactory.getTextFormat(0, 18, 0xFFFFFF);
			selectGameText.embedFonts = true;
			
			addChild(selectGameText);
			selectGameText.text = "Select your Soccer game";
			
			miniHeader = new Sprite();
			miniHeader.x = 10;
			miniHeader.y = 100;
			
			var backImage:Image = new Image(Assets.getAssetsTexture( "league_bg_top" ) );
			miniHeader.addChild(backImage);
			
			var flagImage:Image = new Image(Assets.getAssetsTexture( "flag" ) );
			flagImage.x = 10;
			flagImage.y = 6;
			addChild(flagImage);
			miniHeader.addChild(flagImage);
			
			var textLeague:TextFieldTextRenderer = new TextFieldTextRenderer();
			textLeague.x = 51.2;
			textLeague.y = 0;
			textLeague.textFormat = FontFactory.getTextFormat(1, 15, 0xFFFFFF);
			textLeague.embedFonts = true;
			textLeague.text = "Premier League";
			miniHeader.addChild(textLeague);
			
			addChild(miniHeader);
		
			list = new List();
			
			list.dataProvider = new ListCollection(
			[
				{ text: "Milk" },
				{ text: "Eggs"},
				{ text: "Bread"},
				{ text: "Chicken"},
				{ text: "Milk" },
				{ text: "Eggs"},
				{ text: "Bread"},
				{ text: "Chicken"},
				{ text: "Milk" },
				{ text: "Eggs"},
				{ text: "Bread"},
				{ text: "Chicken"},
				{ text: "Milk" },
				{ text: "Eggs"},
				{ text: "Bread"},
				{ text: "Chicken"},
			]);
				
			list.itemRendererType = SelectGameRenderer;
			
			addChild(list);
			
			shadow = new Image(Assets.getAssetsTexture("scroll_shadow"));
			addChild(shadow);
		}
		
		private function eventSelected(eventId:int):void
		{
			trace("selected event with id :" + eventId);
		}
		
		private function headerBackButtonHandler()
		{
			dispatchEvent(new Event("onBack"));
		}
		
		private function coinsCallbackHandler(e:starling.events.Event)
		{
			trace("coins callback");
		}
		
		override protected function draw():void
		{		
			list.x = 10;
			list.y = 125;
						
			list.width = 300;
			list.height = stage.stageHeight - list.y;
			
			shadow.y = stage.stageHeight - shadow.height;
		}
		
	}

}