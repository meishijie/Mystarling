package state
{
	import starling.display.Sprite;
	import starling.text.TextField;
	
	public class Game extends Sprite
	{
		public function Game()
		{
			super();
			var textField:TextField = new TextField(400, 300, "Welcome to Starling!");
			addChild(textField);
		}
	}
}