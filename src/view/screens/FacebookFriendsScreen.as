package view.screens 
{
	/**
	 * ...
	 * @author Mihai Raulea
	 */
	import feathers.controls.GroupedList;
	import feathers.controls.List;
	import feathers.controls.MyToggleButton;
	import feathers.controls.ToggleButtonGroup;
	import feathers.controls.ToggleSwitch;
	import feathers.data.HierarchicalCollection;
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
	 
	public class FacebookFriendsScreen extends Screen
	{
		
		private var commonAssetsScreen:CommonAssetsScreen;
		
		private var header:Sprite;
		
		private var blackStrip:Image;
		
		private var toggleButtonGroup:ToggleButtonGroup = new ToggleButtonGroup();
		
		private var showAllButtonActive:Button;
		private var showAllButtonInactive:Button;

		private var showPlayingButtonActive:Button;
		private var showPlayingButtonInactive:Button;
		
		private var selected:int = 0;
		
		private var menuShadow:Image;
		
		private var facebookFriendsGroupedList:GroupedList;
		
		private var abcVerticalPanelBackground:Image;
		private var abcTextRenderer:TextFieldTextRenderer;
		
		private var scrollShadow:Image;
		
		public function FacebookFriendsScreen() 
		{
			commonAssetsScreen = CommonAssetsScreen.getInstance();
		}
		
		override protected function initialize():void
		{
			
			blackStrip = new Image(Assets.getAssetsTexture("black_strip"));
			addChild(blackStrip);
			blackStrip.y = 44;
			
			showAllButtonActive = new Button();
			showAllButtonActive.label = "Show All";
			
			showAllButtonActive.defaultSkin = new Image( Assets.getAssetsTexture("radio_l_on"));
			showAllButtonActive.downSkin = new Image( Assets.getAssetsTexture("radio_l_on"));
			showAllButtonActive.labelFactory = getToggleTextRenderer;
						
			showAllButtonInactive = new Button();
			showAllButtonInactive.label = "Show All";
			showAllButtonInactive.defaultSkin = new Image( Assets.getAssetsTexture("radio_l_off"));
			showAllButtonInactive.downSkin = new Image( Assets.getAssetsTexture("radio_l_off"));
			showAllButtonInactive.labelFactory = getToggleTextRendererNotSelected;
			
			showAllButtonInactive.x = showAllButtonActive.x = 5;
			showAllButtonInactive.y = showAllButtonActive.y = 43.8;
						
			toggleButtonGroup.addNewToggleButton( new MyToggleButton(showAllButtonActive, showAllButtonInactive, "1") );
			
			showPlayingButtonActive = new Button();
			showPlayingButtonActive.label = "Show Playing";
			
			showPlayingButtonActive.defaultSkin = new Image( Assets.getAssetsTexture("radio_r_on"));
			showPlayingButtonActive.downSkin = new Image( Assets.getAssetsTexture("radio_r_on"));
			showPlayingButtonActive.labelFactory = getToggleTextRenderer;
						
			showPlayingButtonInactive = new Button();
			showPlayingButtonInactive.label = "Show Playing";
			showPlayingButtonInactive.defaultSkin = new Image( Assets.getAssetsTexture("radio_r_off"));
			showPlayingButtonInactive.downSkin = new Image( Assets.getAssetsTexture("radio_r_off"));
			showPlayingButtonInactive.labelFactory = getToggleTextRendererNotSelected;
			
			showPlayingButtonInactive.x = showPlayingButtonActive.x = 108.8;
			showPlayingButtonInactive.y = showPlayingButtonActive.y = 43.8;
						
			toggleButtonGroup.addNewToggleButton( new MyToggleButton(showPlayingButtonActive, showPlayingButtonInactive, "2") );
			
			toggleButtonGroup.setSelectedButton("1");
			
			addChild(toggleButtonGroup);
						
			menuShadow = new Image(Assets.getAssetsTexture("nav_bar_shadow"));
			addChild(menuShadow);
			menuShadow.y = 88;
						
			setUpList();
			
			abcVerticalPanelBackground = new Image( Assets.getAssetsTexture("az_sel_bg") );
			//addChild(abcVerticalPanelBackground);
						
			
			scrollShadow = new Image(Assets.getAssetsTexture("scroll_shadow"));
			addChild(scrollShadow);
		}
		
		override protected function draw():void
		{   			
			header = commonAssetsScreen.getHeader("Facebook Friends",true, headerBackButtonHandler, false);
			addChild( header );
			
			facebookFriendsGroupedList.x = 10;
			facebookFriendsGroupedList.y = 100;
					
			facebookFriendsGroupedList.width = 300;
			facebookFriendsGroupedList.height = this.actualHeight - facebookFriendsGroupedList.y
			
			abcVerticalPanelBackground.x = 283.5;
			abcVerticalPanelBackground.y = facebookFriendsGroupedList.y + 5;
			
			scrollShadow.y = this.actualHeight - scrollShadow.height;
		}
		
		private function setUpList()
		{
			var groups:Array =
			[
				{
					header: "A",
					children:
					[
						{ text: "Aardvark" },
						{ text: "Alligator" },
						{ text: "Alpaca" },
						{ text: "Anteater" },
					]
				},
				{
					header: "B",
					children:
					[
						{ text: "Baboon" },
						{ text: "Bear" },
						{ text: "Beaver" },
					]
				},
				{
					header: "C",
					children:
					[
						{ text: "Canary" },
						{ text: "Cat" },
					]
				},
				{
					header: "D",
					children:
					[
						{ text: "Deer" },
						{ text: "Dingo" },
						{ text: "Dog" },
						{ text: "Dolphin" },
						{ text: "Donkey" },
						{ text: "Dragonfly" },
						{ text: "Duck" },
						{ text: "Dung Beetle" },
					]
				},
				{
					header: "E",
					children:
					[
					
						{ text: "Eagle" },
						{ text: "Earthworm" },
						{ text: "Eel" },
						{ text: "Elk" },
					]
				}
			];
			groups.fixed = true;
			
			facebookFriendsGroupedList = new GroupedList();
			//facebookFriendsGroupedList
			facebookFriendsGroupedList.dataProvider = new HierarchicalCollection(groups);
			
			facebookFriendsGroupedList.headerRendererType = FacebookFriendsGroupedListHeaderRenderer;
			facebookFriendsGroupedList.itemRendererType =   FacebookFriendsGroupedListItemRenderer;
			facebookFriendsGroupedList.addEventListener(Event.CHANGE, facebookFriendChanged);
			
			addChild(facebookFriendsGroupedList);
		}
		
		private function facebookFriendChanged(e:Event)
		{
			dispatchEvent(new Event("onFriendSelected"));
		}
		
		private function headerBackButtonHandler()
		{
			dispatchEvent(new Event("onBack"));
		}
		
		private function buttonGroupChange(e:Event):void
		{
			
		}
		
		private function getToggleTextRenderer():TextFieldTextRenderer
		{
			var t:TextFieldTextRenderer = new TextFieldTextRenderer();
			t.textFormat = FontFactory.getTextFormat(0, 15,0xFFFFFF);
			t.embedFonts = true;
			return t;
		}
		private function getToggleTextRendererNotSelected():TextFieldTextRenderer
		{
			var t:TextFieldTextRenderer = new TextFieldTextRenderer();
			t.textFormat = FontFactory.getTextFormat(0, 15,0x525252);
			t.embedFonts = true;
			return t;
		}
		
		private function getLetterButton(letter:String):Button
		{
			var button:Button = new Button();
			button.width  = 20;
			button.height = 14;
			abcTextRenderer = new TextFieldTextRenderer();
			abcTextRenderer.width  = 20;
			abcTextRenderer.height = 14;
			abcTextRenderer.wordWrap = false; 
			abcTextRenderer.text = letter;
			abcTextRenderer.textFormat = FontFactory.getTextFormat(2, 11, 0x808080);
			abcTextRenderer.textFormat.leading = 2;
			abcTextRenderer.textFormat.align = "center";
			abcTextRenderer.embedFonts = true;
			addChild(abcTextRenderer);
			button.addChild(abcTextRenderer);
			button.addEventListener(Event.TRIGGERED, letterButtonTriggered);
			return button;			
		}
				
		override protected function screen_addedToStageHandler(event:Event):void
		{
			commonAssetsScreen.refreshBackCallback( headerBackButtonHandler );
		}
		
		private function letterButtonTriggered(e:Event)
		{
			trace("letter button triggered");
		}
		
	}

}