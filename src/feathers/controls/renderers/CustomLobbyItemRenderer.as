package feathers.controls.renderers
{
	
	import feathers.controls.Button;
	import feathers.controls.ImageLoader;
	import feathers.controls.Label;
	import feathers.controls.List;
	import feathers.controls.renderers.IListItemRenderer;
	import feathers.controls.text.TextFieldTextRenderer;
	import feathers.core.FeathersControl;
	import flash.text.TextFormat;
	import starling.display.Image;
	import flash.geom.Point;
	import view.util.FontFactory;
 
	import starling.events.*;
	
	import view.util.Assets;
 
	public class CustomLobbyItemRenderer extends FeathersControl implements IListItemRenderer
	{
		public function CustomLobbyItemRenderer()
		{
			this.addEventListener(TouchEvent.TOUCH, touchHandler);
			this.addEventListener(Event.REMOVED_FROM_STAGE, removedFromStageHandler);
		}
 
		protected var backgroundItemRenderer:Button;
		protected var itemLabel:Label;
		
		
		private var namesTextFormat:TextFormat;
		private var pointsTextFormat:TextFormat;
		private var acceptedChallengesTextFormat:TextFormat;
		private var completedChallengesTextFormat:TextFormat;
		
		protected var opponentProfilePic:Image;
		
		protected var opponentName:TextFieldTextRenderer;
		protected var opponentPoints:TextFieldTextRenderer;
		
		protected var me:TextFieldTextRenderer;
		protected var mePoints:TextFieldTextRenderer;
		
		protected var completedChallengesImage:Image;
		protected var completedChallengesOffImage:Image;
		protected var completedChallengesNumber:TextFieldTextRenderer;
		
		protected var acceptedChallengesImage:Image;
		protected var acceptedChallengesOffImage:Image;
		protected var acceptedChallengesNumber:TextFieldTextRenderer;
		
		protected var newChallengeText:TextFieldTextRenderer;
		protected var newChallengeTextFormat:TextFormat;
		
		protected var _index:int = -1;
		
		protected var touchPointID:int = -1;
		private static const HELPER_POINT:Point = new Point();
		
		[Embed(source = "../../../assets/fonts/HelveticaNeueLTCom-Cn.ttf",embedAsCFF="false", fontName="HelveticaNeueLT", advancedAntiAliasing="true", mimeType = "application/x-font")]
		private static const helveticaNeue:Class;
		
		[Embed(source="../../../assets/fonts/HelveticaNeueLTCom-BdCn.ttf",embedAsCFF="false", fontName="HelveticaNeueBold", advancedAntiAliasing="true", mimeType = "application/x-font")]
		private static const helveticaBold:Class;
		
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
				this.backgroundItemRenderer = new Button()
				this.backgroundItemRenderer.defaultSkin = new Image(Assets.getAssetsTexture("lobby_list_bg"));
				this.backgroundItemRenderer.downSkin = new Image(Assets.getAssetsTexture("lobby_list_bg_press"));
				this.addChild(backgroundItemRenderer);
				this.width = backgroundItemRenderer.defaultSkin.width;
				this.height = backgroundItemRenderer.defaultSkin.height;
			}
			// should be dynamic
			if (!this.opponentProfilePic)
			{
				opponentProfilePic = new Image( Assets.getAssetsTexture("profilePic") );
				backgroundItemRenderer.addChild(opponentProfilePic);
				opponentProfilePic.x = 10;
				opponentProfilePic.y = 10;
			}
						
			placeMyPointsAndOpponnentPointsBlock();
			placeAcceptedChallengesBlock();
			placeCompletedChallengesBlock();
			
			if (!this.newChallengeText)
			{
				newChallengeText = new TextFieldTextRenderer();
				newChallengeText.text = "New Challenge";
				newChallengeText.x = opponentName.x;
				newChallengeText.y = opponentName.y + 30;
				newChallengeText.textFormat = newChallengeTextFormat;
				newChallengeText.embedFonts = true;
				backgroundItemRenderer.addChild(newChallengeText);
				newChallengeText.visible = false;
			}
			
			
			var greyArrowImage:Image = new Image( Assets.getAssetsTexture("grey_chevron") );
			backgroundItemRenderer.addChild(greyArrowImage);
			greyArrowImage.x = 288;
			greyArrowImage.y = this.height / 2 - greyArrowImage.height / 2;
		}
		
		private function placeMyPointsAndOpponnentPointsBlock()
		{
			if (!this.opponentName)
			{
				this.opponentName = new TextFieldTextRenderer();
				opponentName.textFormat = namesTextFormat;
				opponentName.embedFonts = true;
				opponentName.text = "Opponent";
				opponentName.x = opponentProfilePic.x + opponentProfilePic.width + 10;
				opponentName.y = 14;
				
				backgroundItemRenderer.addChild(opponentName);
			}
			if (!this.me)
			{
				this.me = new TextFieldTextRenderer();
				me.textFormat = namesTextFormat;
				me.embedFonts = true;
				me.text = "Me";
				me.x = 175;
				me.y = 14;
				
				backgroundItemRenderer.addChild(me);
			}
			if (!this.opponentPoints)
			{
				this.opponentPoints = new TextFieldTextRenderer();
				opponentPoints.textFormat = pointsTextFormat;
				opponentPoints.embedFonts = true;
				opponentPoints.width = 50;
				opponentPoints.text = "999";
				opponentPoints.x = opponentName.x;
				opponentPoints.y = opponentPoints.y + 30;
				
				backgroundItemRenderer.addChild(opponentPoints);
			}
			if (!this.mePoints)
			{
				this.mePoints = new TextFieldTextRenderer();
				mePoints.textFormat = pointsTextFormat;
				mePoints.width = 50;
				mePoints.embedFonts = true;
				mePoints.text = "999";
				mePoints.x = me.x;
				mePoints.y = opponentPoints.y;
				
				backgroundItemRenderer.addChild(mePoints);
			}
			
			var textPoints:TextFieldTextRenderer = new TextFieldTextRenderer();
			backgroundItemRenderer.addChild(textPoints);
			textPoints.text = ":";
			textPoints.x = 131;
			textPoints.y = 26;
			textPoints.textFormat = FontFactory.getTextFormat(2, 28, 0xA1A1A1);
		}
		
		private function placeAcceptedChallengesBlock()
		{
			
			if (!this.acceptedChallengesImage)
			{
				acceptedChallengesImage = new Image(Assets.getAssetsTexture("new_on"));
				acceptedChallengesImage.x = 250;
				acceptedChallengesImage.y = 15;
				
				backgroundItemRenderer.addChild(acceptedChallengesImage);	
			}
			if (!this.acceptedChallengesOffImage)
			{
				acceptedChallengesOffImage = new Image(Assets.getAssetsTexture("new_off"));
				acceptedChallengesOffImage.x = acceptedChallengesImage.x;
				acceptedChallengesOffImage.y = acceptedChallengesImage.y;
				
				backgroundItemRenderer.addChild(acceptedChallengesOffImage);	
			}
			if (!this.acceptedChallengesNumber)
			{
				acceptedChallengesNumber = new TextFieldTextRenderer();
				acceptedChallengesNumber.x = acceptedChallengesImage.x + 17;
				acceptedChallengesNumber.y = acceptedChallengesImage.y + 1;
				acceptedChallengesNumber.textFormat = acceptedChallengesTextFormat;
				acceptedChallengesNumber.embedFonts = true;
				acceptedChallengesNumber.text = "9+";
				
				backgroundItemRenderer.addChild(acceptedChallengesNumber);
			}
		}
		
		private function placeCompletedChallengesBlock()
		{
			if (!this.completedChallengesImage)
			{
				completedChallengesImage = new Image(Assets.getAssetsTexture("cup_on"));
				completedChallengesImage.x = acceptedChallengesImage.x - 1;
				completedChallengesImage.y = 34;
				
				backgroundItemRenderer.addChild(completedChallengesImage);
			}
			if (!this.completedChallengesNumber)
			{
				completedChallengesNumber = new TextFieldTextRenderer();
				completedChallengesNumber.x = acceptedChallengesNumber.x;
				completedChallengesNumber.y = completedChallengesImage.y + 1;
				completedChallengesNumber.textFormat = completedChallengesTextFormat;
				completedChallengesNumber.embedFonts = true;
				completedChallengesNumber.text = "9+";
				
				backgroundItemRenderer.addChild(completedChallengesNumber);
			}
		}
		
		private function initTextFormats():void
		{
			namesTextFormat  = FontFactory.getTextFormat(1, 12, 0x4D4D4D);
			pointsTextFormat =  FontFactory.getTextFormat(1, 25, 0x4D4D4D);
			acceptedChallengesTextFormat = new TextFormat("HelveticaNeueBold", 12, 0x5D9B05);
			completedChallengesTextFormat = new TextFormat("HelveticaNeueBold", 12, 0x4D4D4D);
			newChallengeTextFormat = new TextFormat("HelveticaNeueLT", 12, 0x478804);
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
				if(_data.CountOfNew == 0)
				{
					/*
					this.completedChallengesNumber.text = _data.CountOfResults;
					this.acceptedChallengesNumber.text = _data.CountOfPending;
					this.opponentName.text = _data.OpponentName;
					this.opponentPoints.text = _data.OpponentScore;
					this.mePoints.text = _data.PlayerScore;
					this.me.text = "Me";
					*/
				}
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