package feathers.controls.renderers
{
	import feathers.controls.Label;
	import feathers.controls.List;
	import feathers.controls.renderers.IListItemRenderer;
	import feathers.controls.text.TextFieldTextRenderer;
	import feathers.core.FeathersControl;
	import flash.text.TextFormat;
	import starling.display.Image;
 
	import starling.events.Event;
	
	import view.util.Assets;
 
	public class CustomHeadToHeadRenderer extends FeathersControl implements IListItemRenderer
	{
		public function CustomHeadToHeadRenderer()
		{
			
		}
 
		protected var backgroundItemRenderer:Image;
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
		protected var completedChallengesNumber:TextFieldTextRenderer;
		
		protected var acceptedChallengesImage:Image;
		protected var acceptedChallengesNumber:TextFieldTextRenderer;
		
		protected var _index:int = -1;
 
		[Embed(source = "../../../assets/fonts/HelveticaNeueLTCom-Cn.ttf",embedAsCFF="false", fontName="HelveticaNeueLT", advancedAntiAliasing="true", mimeType = "application/x-font")]
		private static const helveticaNeue:Class;
		
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
				this.backgroundItemRenderer = new Image(Assets.getAssetsTexture("lobby_list_bg"));
				this.addChild(backgroundItemRenderer);
				this.width = backgroundItemRenderer.width;
				this.height = backgroundItemRenderer.height;
			}
			// should be dynamic
			if (!this.opponentProfilePic)
			{
				opponentProfilePic = new Image( Assets.getAssetsTexture("profilePic") );
				this.addChild(opponentProfilePic);
			}
			if (!this.opponentName)
			{
				this.opponentName = new TextFieldTextRenderer();
				opponentName.textFormat = namesTextFormat;
				opponentName.embedFonts = true;
				opponentName.text = "Opponent Name";
				opponentName.x = opponentProfilePic.x + opponentProfilePic.width + 10;
				opponentName.y = 10;
				
				this.addChild(opponentName);
			}
			if (!this.me)
			{
				this.me = new TextFieldTextRenderer();
				me.textFormat = namesTextFormat;
				me.embedFonts = true;
				me.text = "Me";
				me.x = opponentProfilePic.x + 2.5 * opponentProfilePic.width + 10;
				me.y = 10;
				
				this.addChild(me);
			}
			if (!this.opponentPoints)
			{
				this.opponentPoints = new TextFieldTextRenderer();
				opponentPoints.textFormat = pointsTextFormat;
				opponentPoints.embedFonts = true;
				opponentPoints.text = "999";
				opponentPoints.x = opponentName.x;
				opponentPoints.y = opponentPoints.y + 30;
				
				this.addChild(opponentPoints);
			}
			if (!this.mePoints)
			{
				this.mePoints = new TextFieldTextRenderer();
				mePoints.textFormat = pointsTextFormat;
				mePoints.embedFonts = true;
				mePoints.text = "999";
				mePoints.x = me.x;
				mePoints.y = opponentPoints.y;
				
				this.addChild(mePoints);
			}
			if (!this.completedChallengesImage)
			{
				completedChallengesImage = new Image(Assets.getAssetsTexture("cup_on"));
				completedChallengesImage.x = backgroundItemRenderer.width - completedChallengesImage.width * 3;
				completedChallengesImage.y = mePoints.y + 10;
				
				this.addChild(completedChallengesImage);
			}
			if (!this.acceptedChallengesImage)
			{
				acceptedChallengesImage = new Image(Assets.getAssetsTexture("new_on"));
				acceptedChallengesImage.x = backgroundItemRenderer.width - completedChallengesImage.width * 3;
				acceptedChallengesImage.y = me.y + 10;
				
				this.addChild(acceptedChallengesImage);	
			}
		}
		
		private function initTextFormats():void
		{
			namesTextFormat  = new TextFormat("HelveticaNeueLT", 12, 0x4D4D4D);
			pointsTextFormat = new TextFormat("HelveticaNeueLT", 30, 0x4D4D4D);
			acceptedChallengesTextFormat = new TextFormat("HelveticaNeueLT", 8, 0x5D9B05);
			completedChallengesTextFormat = new TextFormat("HelveticaNeueLT", 8, 0x4D4D4D);
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
				this.itemLabel.text = this._data.toString();
			}
			else
			{
				this.itemLabel.text = "";
			}
		}
 
		protected function layout():void
		{
			this.itemLabel.width = this.actualWidth;
			this.itemLabel.height = this.actualHeight;
		}
	}
}