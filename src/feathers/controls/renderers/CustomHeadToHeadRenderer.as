package feathers.controls.renderers
{
	
	import feathers.controls.Button;
	import feathers.controls.Label;
	import feathers.controls.List;
	import feathers.controls.renderers.IListItemRenderer;
	import feathers.controls.text.TextFieldTextEditor;
	import feathers.controls.text.TextFieldTextRenderer;
	import feathers.core.FeathersControl;
	import flash.text.TextFormat;
	import starling.display.Image;
	import flash.geom.Point;
	import view.util.FontFactory;
 
	import starling.events.*;
	
	import view.util.Assets;
 
	public class CustomHeadToHeadRenderer extends FeathersControl implements IListItemRenderer
	{
		public function CustomHeadToHeadRenderer()
		{
			this.addEventListener(TouchEvent.TOUCH, touchHandler);
			this.addEventListener(Event.REMOVED_FROM_STAGE, removedFromStageHandler);
		}
 
		protected var backgroundItemRenderer:Button;
		protected var itemLabel:Label;
		
		// custom assets
		private var sizeDayText:int = 12;
		private var dayText:TextFieldTextRenderer;
		private var hourText:TextFieldTextRenderer;
		private var sportImage:Image;
		private var team1Text:TextFieldTextRenderer;
		private var team2Text:TextFieldTextRenderer;
		// to check
		private var acceptButton:Button;
		private var resultsButton:Button;
		private var inPlayButton:Button;
		private var waitingButton:Button;
		
		protected var _index:int = -1;
		
		protected var touchPointID:int = -1;
		private static const HELPER_POINT:Point = new Point();
		
		
		protected function touchHandler(event:TouchEvent):void
		{
				const touches:Vector.<Touch> = event.getTouches(this);
				if(touches.length == 0)
				{
				//hover has ended
				return;
				}
				if(this.touchPointID >= 0)
				{
				var touch:Touch;
				for each(var currentTouch:Touch in touches)
				{
					if(currentTouch.id == this.touchPointID)
					{
					touch = currentTouch;
					break;
					}
				}
				if(!touch)
				{
					return;
				}
				if(touch.phase == TouchPhase.ENDED)
				{
				this.touchPointID = -1;
 
				touch.getLocation(this, HELPER_POINT);
				//check if the touch is still over the target
				//also, only change it if we're not selected. we're not a toggle.
				if(this.hitTest(HELPER_POINT, true) != null && !this._isSelected)
				{
					this.isSelected = true;
				}
				return;
				}
			}
			else
			{
				for each(touch in touches)
				{
					if(touch.phase == TouchPhase.BEGAN)
					{
						this.touchPointID = touch.id;
						return;
					}
				}
			}
		}
	
		protected function removedFromStageHandler(event:Event):void
		{
			this.touchPointID = -1;
		}

		public function get index():int
		{
			return this._index;
		}
 
		public function set index(value:int):void
		{
			if(this._index == value)
			{
				return;
			}
			this._index = value;
			this.invalidate(INVALIDATION_FLAG_DATA);
		}
 
		protected var _owner:List;
 
		public function get owner():List
		{
			return List(this._owner);
		}
 
		public function set owner(value:List):void
		{
			if(this._owner == value)
			{
				return;
			}
			this._owner = value;
			this.invalidate(INVALIDATION_FLAG_DATA);
		}
 
		protected var _data:Object;
 
		public function get data():Object
		{
			return this._data;
		}
 
		public function set data(value:Object):void
		{
			if(this._data == value)
			{
				return;
			}
			this._data = value;
			this.invalidate(INVALIDATION_FLAG_DATA);
		}
 
		
		protected var _isSelected:Boolean;
 
		public function get isSelected():Boolean
		{
			return this._isSelected;
		}
 
		public function set isSelected(value:Boolean):void
		{
			if(this._isSelected == value)
			{
				return;
			}
			this._isSelected = value;
			this.invalidate(INVALIDATION_FLAG_SELECTED);
			this.dispatchEventWith(Event.CHANGE);
		}
		
 
		override protected function initialize():void
		{
			initTextFormats();
			if(!this.itemLabel)
			{
				this.itemLabel = new Label();
				this.addChild(this.itemLabel);
			}
			if (!this.backgroundItemRenderer)
			{
				this.backgroundItemRenderer = new Button();
				this.backgroundItemRenderer.defaultSkin =  new Image(Assets.getAssetsTexture("h2h_list_bg"));
				this.backgroundItemRenderer.downSkin = new Image(Assets.getAssetsTexture("h2h_list_bg_press"));
				this.addChild(backgroundItemRenderer);
				this.width = backgroundItemRenderer.defaultSkin.width;
				this.height = backgroundItemRenderer.defaultSkin.height;
			}
			if (!this.dayText)
			{
				this.dayText = new TextFieldTextRenderer();
				backgroundItemRenderer.addChild(this.dayText);
				dayText.text = "Today";
				dayText.height = 20;
				dayText.width = 200;
				this.dayText.textFormat = FontFactory.getTextFormat(1, 15, 0x808080);
				this.dayText.embedFonts = true;
				dayText.x = 10;
				dayText.y = backgroundItemRenderer.defaultSkin.height/2 - 22;
			}
			if (!this.hourText)
			{
				this.hourText = new TextFieldTextRenderer();
				backgroundItemRenderer.addChild(this.hourText);
				hourText.text = "16:00";
				hourText.width = 200;
				hourText.x = dayText.x;
				hourText.y = dayText.y + 22;
				this.hourText.textFormat = FontFactory.getTextFormat(1, 15, 0x808080);
				this.hourText.embedFonts = true;
			}
			if (!this.sportImage)
			{
				this.sportImage = new Image(Assets.getAssetsTexture("h2h_soccer_icon"));
				backgroundItemRenderer.addChild(sportImage);
				sportImage.x = 59;
				sportImage.y = 22;
			}
			if (!this.team1Text)
			{
				this.team1Text = new TextFieldTextRenderer();
				backgroundItemRenderer.addChild(this.team1Text);
				team1Text.x = 102;
				team1Text.y = this.dayText.y;
				team1Text.textFormat = FontFactory.getTextFormat(3, 15, 0x4D4D4D);
				team1Text.embedFonts = true;
				team1Text.text = "Norwich City";
			}
			if (!this.team2Text)
			{
				this.team2Text = new TextFieldTextRenderer();
				backgroundItemRenderer.addChild(this.team2Text);
				team2Text.x = 102;
				team2Text.y = this.hourText.y;
				team2Text.textFormat = FontFactory.getTextFormat(3, 15, 0x4D4D4D);
				team2Text.embedFonts = true;
				team2Text.text = "Norwich City";
			}
			if (!this.acceptButton)
			{
				this.acceptButton = new Button();
				acceptButton.defaultSkin = new Image(Assets.getAssetsTexture("accept_btn"));
				acceptButton.downSkin = new Image(Assets.getAssetsTexture("accept_btn_press"));
				acceptButton.labelFactory = getLabelRenderer;
				acceptButton.labelOffsetX = 9;
				acceptButton.label = "Accept";
				addChild(acceptButton);
				acceptButton.x = 222;
				acceptButton.y = 14;
			}
			if (!this.resultsButton)
			{
				this.resultsButton = new Button();
				resultsButton.defaultSkin = new Image(Assets.getAssetsTexture("results_btn"));
				resultsButton.downSkin = new Image(Assets.getAssetsTexture("results_btn_press"));
				resultsButton.labelFactory = getLabelRenderer;
				resultsButton.label = "Results";
				resultsButton.labelOffsetX = 9;
				//addChild(resultsButton);
				resultsButton.x = backgroundItemRenderer.defaultSkin.width - 10 - resultsButton.defaultSkin.width;
				resultsButton.y = backgroundItemRenderer.defaultSkin.height - resultsButton.defaultSkin.height >> 1;
			}
			if (!this.inPlayButton)
			{
				this.inPlayButton = new Button();
				inPlayButton.defaultSkin = new Image(Assets.getAssetsTexture("in_play_icon"));
				inPlayButton.downSkin = new Image(Assets.getAssetsTexture("in_play_icon"));
				inPlayButton.label = "In-Play";
				inPlayButton.labelOffsetX = 9;
				//addChild(inPlayButton);
				inPlayButton.x = backgroundItemRenderer.defaultSkin.width / 1.5;
				inPlayButton.y = backgroundItemRenderer.defaultSkin.height - inPlayButton.defaultSkin.height >> 1;
			}
			if (!this.waitingButton)
			{
				this.waitingButton = new Button();
				waitingButton.defaultSkin = new Image(Assets.getAssetsTexture("waiting_icon"));
				waitingButton.downSkin = new Image(Assets.getAssetsTexture("waiting_icon"));
				waitingButton.label = "Waiting";
				waitingButton.labelOffsetX = 9;
				//addChild(waitingButton);
				waitingButton.x = backgroundItemRenderer.defaultSkin.width / 1.5;
				waitingButton.y = backgroundItemRenderer.defaultSkin.height - waitingButton.defaultSkin.height >> 1;
			}
		}
		
		private function getLabelRenderer():TextFieldTextRenderer
		{ 
			var textRenderer:TextFieldTextRenderer = new TextFieldTextRenderer(); 
			textRenderer.textFormat = FontFactory.getTextFormat(0, 15, 0xFFFFFF); 
			textRenderer.embedFonts = true; 
			return textRenderer;
		}
		
		private function initTextFormats():void
		{
			/*
			namesTextFormat  = new TextFormat("HelveticaNeueLT", 12, 0x4D4D4D);
			pointsTextFormat = new TextFormat("HelveticaNeueLT", 30, 0x4D4D4D);
			acceptedChallengesTextFormat = new TextFormat("HelveticaNeueBold", 12, 0x5D9B05);
			completedChallengesTextFormat = new TextFormat("HelveticaNeueBold", 12, 0x4D4D4D);
			newChallengeTextFormat = new TextFormat("HelveticaNeueLT", 12, 0x478804);
			*/
		}
		
		
		override protected function draw():void
		{
			const dataInvalid:Boolean = this.isInvalid(INVALIDATION_FLAG_DATA);
			const selectionInvalid:Boolean = this.isInvalid(INVALIDATION_FLAG_SELECTED);
			var sizeInvalid:Boolean = this.isInvalid(INVALIDATION_FLAG_SIZE);
 
			if(dataInvalid)
			{
				this.commitData();
			}
						
			sizeInvalid = this.autoSizeIfNeeded() || sizeInvalid;
 
			if(dataInvalid || sizeInvalid)
			{
				this.layout();
			}
		}
 
		
		protected function autoSizeIfNeeded():Boolean
		{
			const needsWidth:Boolean = isNaN(this.explicitWidth);
			const needsHeight:Boolean = isNaN(this.explicitHeight);
			if(!needsWidth && !needsHeight)
			{
				return false;
			}
			this.itemLabel.width = NaN;
			this.itemLabel.height = NaN;
			this.itemLabel.validate();
			var newWidth:Number = this.explicitWidth;
			if(needsWidth)
			{
				newWidth = this.itemLabel.width;
			}
			var newHeight:Number = this.explicitHeight;
			if(needsHeight)
			{
				newHeight = this.itemLabel.height;
			}
			return this.setSizeInternal(newWidth, newHeight, false);
		}
		
		
		protected function commitData():void
		{
			if(this._data)
			{
				//this.itemLabel.text = this._data.toString();
			}
			else
			{
				//this.itemLabel.text = "";
			}
		}
 
		protected function layout():void
		{
			this.itemLabel.width = this.actualWidth;
			this.itemLabel.height = this.actualHeight;
		}
	}
}