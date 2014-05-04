package state
{
	import starling.display.Sprite;
	
	public class TitleScreen extends Sprite
	{
		public function TitleScreen()
		{
			//TODO: implement function
			super();
			this.visible = false;
			initialize();
		}
		public function initialize():void
		{
			this.visible = true;
		}
	}
}