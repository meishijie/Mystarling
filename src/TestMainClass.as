package
{
	import flash.filesystem.File;
	
	import lzm.starling.STLConstant;
	import lzm.starling.STLMainClass;
	import lzm.starling.swf.Swf;
	import lzm.starling.swf.SwfAssetManager;
	import lzm.starling.swf.display.SwfMovieClip;
	
	import starling.display.Sprite;
	import starling.text.TextField;
	import starling.utils.formatString;
	
	public class TestMainClass extends STLMainClass
	{
		
		private var textfield:TextField;
		private var assets:SwfAssetManager;
		
		public function TestMainClass()
		{
			super();
			
			Swf.init(this);
			
			textfield = new TextField(200,100,"loading....");
			textfield.x = (STLConstant.StageWidth - textfield.width)/2;
			textfield.y = (STLConstant.StageHeight - textfield.height)/2;
			addChild(textfield);
			
			assets = new SwfAssetManager(STLConstant.scale,STLConstant.useMipMaps);
			assets.verbose = true;
			var file:File = File.applicationDirectory;
			
			assets.enqueue("test",[file.resolvePath(formatString("assets/{0}x/test/",STLConstant.scale))],60);
			assets.loadQueue(function(ratio:Number):void{
				textfield.text = "loading...." + int(ratio*100)+"%";
				if(ratio == 1){
					textfield.removeFromParent(true);
					
					test1();
//					test2();
				}
			});
		}
		
		private function test1():void{
			/*var sprite:Sprite = assets.createSprite("spr_1");
			addChild(sprite);*/
			var mc1:SwfMovieClip = assets.createMovieClip("mc_Tain");
			addChild(mc1);
			
			mc1.x = 100;
			mc1.y = 100;
			mc1.gotoAndPlay("walk");
			mc1.loop = false;
			//trace(mc1.gotoAndPlay());
			
		}
		
		private function test2():void{
			var sprite:Sprite = assets.createSprite("spr_particle");
			addChild(sprite);
		}
	}
}