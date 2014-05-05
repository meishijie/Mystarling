package
{
	import com.nuggeta.NuggetaPlug;
	import com.nuggeta.network.Message;
	import com.nuggeta.ngdl.nobjects.CreateGameResponse;
	import com.nuggeta.ngdl.nobjects.CreateGameStatus;
	import com.nuggeta.ngdl.nobjects.StartResponse;
	import com.nuggeta.ngdl.nobjects.StartStatus;
	import com.nuggeta.ngdl.nobjects.*;
	
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	import lzm.starling.STLConstant;
	import lzm.starling.STLMainClass;
	import lzm.starling.swf.Swf;
	import lzm.starling.swf.SwfAssetManager;
	import lzm.starling.swf.display.SwfMovieClip;
	
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.utils.formatString;
	
	public class TestMainClass extends STLMainClass
	{
		
		
		private var assets:SwfAssetManager;
		private var textfield:starling.text.TextField;
		private var n_t:starling.text.TextField;
		
		private var messages:Vector.<Message>
		private var gameId:String;
		
		//declare the NuggetaPlug
		private var nuggetaPlug:NuggetaPlug;
		
		public function TestMainClass()
		{
			super();
			
			Swf.init(this);
			
			textfield = new starling.text.TextField(200,100,"loading....");
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
				}
			});
		}
		
		private function test1():void{
			n_t = new starling.text.TextField(200,100,"loading....");
			n_t.x = (STLConstant.StageWidth - textfield.width)/2;
			n_t.y = (STLConstant.StageHeight - textfield.height)/2;
			n_t.autoScale = true;
			addChild(n_t);
			
			addEventListener(starling.events.Event.ENTER_FRAME, iterate);		
			//start the NuggetaPlug
			nuggetaPlug = new NuggetaPlug("nuggeta://gametest_513ec105-9f87-4004-b3fd-21101fa7a2a0");
			nuggetaPlug.start();
		

			
		}
		
		private function iterate(event:starling.events.Event):void
		{
			//pump new messages
			messages = nuggetaPlug.pump();	
			for (var i:int = 0; i < messages.length ; i++) {
				
				var message:Message = messages[i];

				//here the connection is ready with nuggeta
				if (message is StartResponse) {	
					var startResponse:StartResponse = message as StartResponse;
					if (startResponse.getStartStatus() == StartStatus.READY) {
						GameGo();//游戏开始
					} else if (startResponse.getStartStatus() == StartStatus.WARNED) {

						n_t.text = "Connection Warned with Nuggeta";
					} else if (startResponse.getStartStatus() == StartStatus.REFUSED) {
						n_t.text = "Connection Refused to Nuggeta";
					} else if (startResponse.getStartStatus() == StartStatus.FAILED) {
						n_t.text = "Connection Failed to Nuggeta";
					}
				}else if (message is CreateGameResponse) //创建游戏
				{
					var createGameResponse:CreateGameResponse = CreateGameResponse(message) ;
					if (createGameResponse.getCreateGameStatus() == CreateGameStatus.SUCCESS) 
					{
						trace("创建完毕，获取gameid = "+ createGameResponse.getGameId());
						n_t.text = "创建完毕，获取gameid = "+ createGameResponse.getGameId() ;
						gameId = createGameResponse.getGameId();
						trace("现在加入游戏");
						n_t.text = "现在将要加入游戏";
						nuggetaPlug.joinGame(gameId);
					}
				}else if (message is JoinGameResponse) //加入游戏
				{
					var joinGameResponse:JoinGameResponse = JoinGameResponse(message) ;
					if (joinGameResponse.getJoinGameStatus() == JoinGameStatus.ACCEPTED) 
					{
						trace("已经加入游戏，游戏正式开始");
						n_t.text = "已经加入游戏，游戏正式开始";
						trace(JoinGameStatus.ACCEPTED);
					}
				}else if (message is GetGamesResponse) //获取游戏房间 如果有 直接进入 没有就创建房间
					{
						var getGamesResponse:GetGamesResponse = GetGamesResponse(message) ;
						if (getGamesResponse.getGetGamesStatus() == GetGamesStatus.SUCCESS) 
						{
							var games:Vector.<NGame> = getGamesResponse.getGames();
							if (games.length > 0) //如果有游戏就加入 没有就创建
							{
								var gameIdToJoin:String = games[0].getId();
								nuggetaPlug.joinGame(gameIdToJoin);//加入游戏
							}
							else
							{
								trace("没有游戏，现在创建游戏");
								n_t.text = "没有游戏，现在创建游戏";
								nuggetaPlug.createGame();//创建游戏
							}
						}
					}
				
				else{
					//other messages
					trace("Received unhandled message" + message.toString());
					n_t.text = "未知的消息：" + message.toString();
				}
			
			
			}
		}

		
		
		private function GameGo():void{
			
		/*	n_t.text = "ready";
			var mc1:SwfMovieClip = assets.createMovieClip("mc_Tain");
			addChild(mc1);
			
			mc1.x = 100;
			mc1.y = 100;
			mc1.gotoAndPlay("walk");
			mc1.loop = false;
			
			n_t.removeFromParent(true);*/
			
			var nuggetaQuery:NuggetaQuery = new NuggetaQuery();
			nuggetaQuery.setStart(0);
			nuggetaQuery.setLimit(10);
			nuggetaPlug.getGames(nuggetaQuery);
			//获取游戏房间
			trace("getgames");
			
		}
		//游戏开始

	}
}