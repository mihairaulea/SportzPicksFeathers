package view.util 
{
	/**
	 * ...
	 * @author ...
	 */
	public class AssetsEmbedsSD2 
	{
		
		[Embed(source = "../../assets/assetsLD2.png")]
		public static const AtlasTextureAssets2:Class;
		
		[Embed(source = "../../assets/assetsLD2.xml", mimeType = "application/octet-stream")]
		public static const AtlasXmlAssets2:Class;		
		
		public function AssetsEmbedsSD2() 
		{
			
		}
		
	}

}