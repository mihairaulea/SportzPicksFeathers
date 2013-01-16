package view.util 
{
	import flash.text.TextFormat;
	/**
	 * ...
	 * @author Mihai Raulea
	 */
	public class FontFactory 
	{
			
		[Embed(source="../../assets/fonts/HELVETICA NEUE CONDENSED BOLD.TTF",embedAsCFF="false", fontName="helvetica", advancedAntiAliasing="true", mimeType = "application/x-font")]		
		private static const helvetica:Class;
		
		[Embed(source = "../../assets/fonts/HelveticaNeueLTCom-BdCn.ttf",embedAsCFF="false", fontName="HNBdCn", advancedAntiAliasing="true", mimeType = "application/x-font")]
		private static const helveticaNeue1:Class;
		
		[Embed(source="../../assets/fonts/HelveticaNeueLTCom-MdCn.ttf",embedAsCFF="false", fontName="HNMdCn", advancedAntiAliasing="true", mimeType = "application/x-font")]
		private static const helveticaNeue2:Class;
				
		[Embed(source = "../../assets/fonts/HelveticaNeueLTCom-Cn.ttf",embedAsCFF="false", fontName="HNCn", advancedAntiAliasing="true", mimeType = "application/x-font")]
		private static const helveticaNeue3:Class;
		
		[Embed(source = "../../assets/fonts/HelveticaNeueLTCom-HvCn.ttf",embedAsCFF="false", fontName="HNHvCn", advancedAntiAliasing="true", mimeType = "application/x-font")]
		private static const helveticaNeue4:Class;
		
		[Embed(source = "../../assets/fonts/DS-DIGIB.TTF",embedAsCFF="false", fontName="DSDIG", advancedAntiAliasing="true", mimeType = "application/x-font")]
		private static const helveticaNeue5:Class;
				
		private static var fontNames:Array = ["helvetica","HNBdCn","HNMdCn","HNHvCn","HNCn","DSDIG"];
		
		public function FontFactory() 
		{
			
		}
		
		public static function getTextFormat( fontId:int, fontSize:int, fontColor:int):TextFormat
		{
			return new TextFormat(fontNames[fontId], fontSize, fontColor);
		}
		
	}

}