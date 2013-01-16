package view.util 
{
	/**
	 * ...
	 * @author Mihai Raulea
	 */
	public class AssetsEmbedsHD 
	{
		
		[Embed(source = "../../assets/assetsHD.png")]
		public static const AtlasTextureAssets:Class;
		
		[Embed(source = "../../assets/assetsHD.xml", mimeType = "application/octet-stream")]
		public static const AtlasXmlAssets:Class;
				
		public function AssetsEmbedsHD() 
		{
			
		}
		
	}

}