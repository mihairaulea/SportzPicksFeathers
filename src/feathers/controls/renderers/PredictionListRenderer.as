package feathers.controls.renderers 
{
	
	import feathers.controls.Button;
	import feathers.controls.List;
	import feathers.controls.text.TextFieldTextRenderer;
	import starling.display.Image;
	import starling.events.Event;
	import view.util.*; 
	import model.AnswerVA;
	
	public class PredictionListRenderer extends DefaultListItemRenderer
	{
		
		var button:Button;
		var answerRenderer:TextFieldTextRenderer;
		var pointsRenderer:TextFieldTextRenderer;
		
		public function PredictionListRenderer() 
		{
			
		}
		
		override protected function initialize():void
		{
			button = new Button();
			button.defaultSkin = new Image( Assets.getAssetsTexture("answer_bg_mid", 2) );
			button.downSkin = new Image( Assets.getAssetsTexture("answer_bg_mid_press", 2) );				
				
			answerRenderer = new TextFieldTextRenderer();
			answerRenderer.width = 350;
			answerRenderer.height = 44;
			answerRenderer.x = 20;
			answerRenderer.y = 15;
			answerRenderer.textFormat = FontFactory.getTextFormat(1,20,0x333333);;
			answerRenderer.textFormat.align = "left";
			answerRenderer.embedFonts = true;
			button.addChild(answerRenderer);
			
			pointsRenderer = new TextFieldTextRenderer();
			pointsRenderer.width = 100;
			pointsRenderer.height = 44;
			pointsRenderer.x = 253;
			pointsRenderer.y = 16.5;
			pointsRenderer.textFormat = FontFactory.getTextFormat(1,13,0x515162);;
			pointsRenderer.textFormat.align = "left";
			pointsRenderer.embedFonts = true;
			button.addChild(pointsRenderer);
			
			addChild(button);
			
			this.width  = button.defaultSkin.width;
			this.height = button.defaultSkin.height;
		}
				
		override protected function draw():void
		{			
			this.commitData();
		}
		
		override protected function commitData():void
		{
			trace("commit data");
			if(this._data)
			{
				//trace(this._data);
				answerRenderer.text = AnswerVA(_data).answer;
				pointsRenderer.text = AnswerVA(_data).points +"pts";
			}
		}
		
	}

}