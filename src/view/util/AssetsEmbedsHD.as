package view.util 
{
	/**
	 * ...
	 * @author Mihai Raulea
	 */
	public class AssetsEmbedsHD 
	{
		
		[Embed(source = "../../assets/assetsLD.png")]
		public static const AtlasTextureAssets:Class;
		
		[Embed(source = "../../assets/assetsLD.xml", mimeType = "application/octet-stream")]
		public static const AtlasXmlAssets:Class;
		
		public function AssetsEmbedsHD() 
		{
			
		}
		
	}

}