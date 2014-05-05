package
{
	import com.nuggeta.NuggetaPlug;
	import com.nuggeta.network.Message;
	import com.nuggeta.ngdl.nobjects.StartResponse;
	import com.nuggeta.ngdl.nobjects.StartStatus;
	
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	import lzm.starling.STLStarup;
	
	import starling.text.TextField;
	
	public class Mystarling extends STLStarup
	{
		
		//declare the NuggetaPlug
		private var nuggetaPlug:NuggetaPlug;
		
		public function Mystarling()
		{
			super();
			
			// 支持 autoOrient
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.color = 0xFFFFFF;
			stage.frameRate = 60;
			
			initStarling(TestMainClass,480,true);
			//			initStarling(ComponentTestClass,480,true);
			//register INIT METHOD
			
			
		}
		
		
	}
}