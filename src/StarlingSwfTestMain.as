package
{
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	
	import lzm.starling.STLStarup;
	
	public class StarlingSwfTestMain extends STLStarup
	{
		public function StarlingSwfTestMain()
		{
			super();
			
			// 支持 autoOrient
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.color = 0x333333;
			stage.frameRate = 60;
			
			initStarling(TestMainClass,480,true);
//			initStarling(ComponentTestClass,480,true);
		}
	}
}