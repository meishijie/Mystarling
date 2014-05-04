package
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import starling.core.Starling;
	import state.Game;
	public class Mystarling extends Sprite
	{
		public function Mystarling()
		{
			super();
			
			// 支持 autoOrient
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			var mystarling:Starling = new Starling(Game,stage);
			mystarling.start();
		}
	}
}