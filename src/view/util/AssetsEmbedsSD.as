package view.util 
{
	
	public class AssetsEmbedsSD 
	{
		// Texture Atlas
		[Embed(source = "../../assets/assetsLD.png")]
		public static const AtlasTextureAssets:Class;
		
		[Embed(source = "../../assets/assetsLD.xml", mimeType = "application/octet-stream")]
		public static const AtlasXmlAssets:Class;
		
	}

}