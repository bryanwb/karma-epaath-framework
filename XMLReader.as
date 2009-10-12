package 
{
 	import flash.xml.XMLDocument;
    import flash.xml.XMLNode;
    import flash.xml.XMLNodeType;
	import flash.display.*;
	import flash.events.*;
	import flash.net.*;
	import flash.xml.*;
	import flash.text.*;
	import flash.external.*;
	import flash.system.Capabilities;
	import flash.filters.GlowFilter;
	import flash.filters.BitmapFilterQuality;
	
	public class XMLReader extends MovieClip
	{
		static var navData:XML;
		var loader:URLLoader = new URLLoader();
		var errorBoxHandler : ErrorBoxHandler;
		var resultList:XMLList = new XMLList( );
		
		static var xmlClassID : String;
		static var xmlSubjectID : String;
		
		var weeklength : int ;
		var weekArray : Array = new Array(32);
		
		var weekFlapxml : WeekFlap;
		var LogoForXML : Logo;
		var imageLoader:Loader;
		
		var activityContainerArray : Array;
		var imageURL : String;
		var htmlURL : Array;
		static var tempWeekNo : int;
		
		private var conn:LocalConnection;
		static var activityNameforConnection : String = new String();
		
		//var frontInMain : FrontInMain;
		var frameContainer : FrameContainer = new FrameContainer();
		
		var counter : int;
		
		var imageLoadera :imageLoaderA = new imageLoaderA();
		var imageLoaderb :imageLoaderB = new imageLoaderB();
		var imageLoaderc :imageLoaderC = new imageLoaderC();
		var imageLoaderd :imageLoaderD = new imageLoaderD();
				
		public function XMLReader(logo : Logo, weekFlap : WeekFlap, buttonClassSelected : String, buttonSubjectSelected : String):void 
		{
			LogoForXML = logo;
			xmlClassID = buttonClassSelected;
			xmlSubjectID = buttonSubjectSelected;
			weekFlapxml = weekFlap;
			
			loader.addEventListener(Event.COMPLETE, onComplete, false, 0, true);
			loader.addEventListener(IOErrorEvent.IO_ERROR, onIOError, false, 0,true);
			loader.load(new URLRequest("FileLink/config.xml"));						
		}
		
		private function onComplete(evt:Event) : void 
		{
			navData = new XML(evt.target.data);
					
			for each  (var  gradeValue:XML  in navData.*)
			{
				if (gradeValue.@gradeID == xmlClassID && gradeValue.@subjectID == xmlSubjectID) 
				{
					for (var k = 0; k < gradeValue.week.length(); k++)
					{
						if (gradeValue.week[k] != "")
						{
							weekArray[k] = true;
						}
						else
						{
							weekArray[k] = false;
						}						
					}
				}
			}
			weekSelector();
		}
		private function onIOError(evt:IOErrorEvent) : void 
		{
			errorBoxHandler = new ErrorBoxHandler(" Could not Load Config File");
			addChild(errorBoxHandler);
		}
		
		private function weekSelector() : void
		{
			weekFlapxml.weekAddition(this, weekArray);
		}
		
		public function weekActivitySelector(weekNO : int)
		{
			clearLogoForXML();
			
			var counter : int;
			for(var i = 0; i < 32; i++)
			{
				if (weekArray[i] == true)
				{
					if (counter == weekNO)
						break;
					counter++;
				}
			}
			
			tempWeekNo = i;
			
			loader = new URLLoader();
			loader.addEventListener(Event.COMPLETE, onCompleteT, false, 0, true);
			loader.addEventListener(IOErrorEvent.IO_ERROR, onIOErrorT, false, 0,true);
			loader.load(new URLRequest("FileLink/config.xml"));					
		}
		
		private function loadThumbnail() : void 
		{
			activityContainerArray = new Array();
			var XMLListtemp : XMLList;
			var x_pos : int = 70;
			var y_pos : int = 330;
			var activities : Array = new Array();
			htmlURL = new Array();		 
			
			XMLListtemp = navData.*;
			
			for each  (var  gradeValue:XML  in XMLListtemp)
			{
				if (gradeValue.@gradeID == xmlClassID && gradeValue.@subjectID == xmlSubjectID) 
				{
					activities = gradeValue.week[tempWeekNo].split(", ");
					
					for (var k = 0; (k < activities.length && activities[0] != ""); k++)
					{
						imageLoader = new Loader();
						var tempMovieClip : MovieClip = new MovieClip();
						tempMovieClip.buttonMode = true;					
						
						tempMovieClip.addEventListener(MouseEvent.MOUSE_OVER, overHandler);
						tempMovieClip.addEventListener(MouseEvent.MOUSE_OUT, outHandler);						
						
						if ( k == 1)
						{
							y_pos = y_pos + 270;
							
							imageLoaderb.x  = x_pos + 35;
							imageLoaderb.y = y_pos + 35;
							imageLoaderb.mouseEnabled = false; 
							tempMovieClip.addChild(imageLoaderb);
						}
						else if (k == 2)
						{
							x_pos = x_pos + 300;
							y_pos = 330;
							
							imageLoaderc.x  = x_pos + 35;
							imageLoaderc.y = y_pos + 35;
							imageLoaderc.mouseEnabled = false;
							tempMovieClip.addChild(imageLoaderc);
						}
						else if ( k == 3) 
						{
							y_pos = y_pos + 270;
							
							imageLoaderd.x  = x_pos + 35;
							imageLoaderd.y = y_pos + 35;
							imageLoaderd.mouseEnabled = false;
							tempMovieClip.addChild(imageLoaderd);
						}
						else if (k == 0)
						{
							imageLoadera.x  = x_pos + 38;
							imageLoadera.y = y_pos + 35;
							imageLoadera.mouseEnabled = false;
							tempMovieClip.addChild(imageLoadera);
						}
						
						imageLoader.x = x_pos;
						imageLoader.y = y_pos;						
						
						var tempforEtoysActivity : String = activities[k];
						var tempActivityName : Array = activities[k].split("_"); 
						
						if (tempActivityName[tempActivityName.length - 1] == "pr")
						{
							var nameconveter : String = new String();
							
							for (var t = 0; t < (tempActivityName.length - 1); t++)
							{
								if (t < (tempActivityName.length - 2))
								{
									if (t == (tempActivityName.length - 3))
									{
										nameconveter = nameconveter + tempActivityName[t];
									}
									else
									{
										nameconveter = nameconveter +  tempActivityName[t]+ "_";
									}
								}
								else 
								{
									imageURL = "SqueakActivities/" + nameconveter +".jpg";
									htmlURL[k] ="etoysIn.html#" + nameconveter + "." +tempActivityName[tempActivityName.length - 2]+".pr";
								}
							}
							
							imageLoader.load(new URLRequest(imageURL));
							tempMovieClip.addEventListener (MouseEvent.CLICK, buttonClickForEtoysHandler);
							
							activityContainerArray[k] = tempMovieClip;
							
							imageLoader.scaleX = 0.8;
							imageLoader.scaleY = 0.8;
							imageLoader.mouseEnabled = false;
							
							tempMovieClip.addChildAt(imageLoader, 0);
							LogoForXML.addChild(tempMovieClip);			
						}
						else
						{
							imageURL = "Activities/"+activities[k]+"/"+activities[k]+".jpg";
							htmlURL[k] = activities[k];
							imageLoader.load(new URLRequest(imageURL));
						
							tempMovieClip.addEventListener (MouseEvent.CLICK, buttonClickHandler);
													
							activityContainerArray[k] = tempMovieClip;
							
							imageLoader.scaleX = 0.8;
							imageLoader.scaleY = 0.8;
							imageLoader.mouseEnabled = false;
							
							
							tempMovieClip.addChildAt(imageLoader, 0);
							LogoForXML.addChild(tempMovieClip);							
						}
					}
				}
			}
		}		
		
		private function overHandler(event : MouseEvent) : void
		{
			var glow:GlowFilter = new GlowFilter();
			glow.color = 0xFFFF00;
			glow.blurX = 2;
			glow.blurY = 2;
			glow.quality = BitmapFilterQuality.HIGH;
			
			event.target.getChildAt(1).filters = [glow];
		}
		
		private function outHandler(event : MouseEvent) : void
		{
			event.target.getChildAt(1).filters = [];
		}
		
		private function onCompleteT(evt:Event) : void 
		{
			try 
			{
				navData = new XML(evt.target.data);
				loadThumbnail();
				
				loader.removeEventListener(Event.COMPLETE, onCompleteT);
				loader.removeEventListener(IOErrorEvent.IO_ERROR,onIOErrorT);				
			} 
			catch (err:Error) 
			{
				errorBoxHandler = new ErrorBoxHandler("Could not Load Config File");
				addChild(errorBoxHandler);
			}
		}
		private function onIOErrorT(evt:IOErrorEvent) : void 
		{
			errorBoxHandler = new ErrorBoxHandler(" Could not Load Config File");
			addChild(errorBoxHandler);
		}
		
		private function buttonClickForEtoysHandler(event : MouseEvent) : void
		{
			event.target.removeEventListener(MouseEvent.CLICK, buttonClickForEtoysHandler);
									
			for ( var i = 0; i < activityContainerArray.length ; i++)
			{
				if (activityContainerArray[i] == event.target)
				{
					activityNameforConnection = htmlURL[i];
					
					navigateToURL(new URLRequest(activityNameforConnection), "_self");
				}
			}
		}
		
		private function buttonClickHandler(event : MouseEvent) : void
		{
			event.target.removeEventListener(MouseEvent.CLICK, buttonClickHandler);
				
			for ( var i = 0; i < activityContainerArray.length ; i++)
			{
				if (activityContainerArray[i] == event.target)
				{
					activityNameforConnection = "FrameWork.html#" + htmlURL[i];
															
					//var loading : Loading = new Loading();
					navigateToURL(new URLRequest(activityNameforConnection), "_self");
					//MovieClip(root).addChild(loading)
					
					//frontInMain = new FrontInMain(this);
					//frontInMain = new FrontInMain();
					//frameContainer.addChild(frontInMain)
					
					//frontInMain.activityName(activityNameforConnection, "");
					MovieClip(root).addChild(frameContainer)
				}
			}			
		}
		
		private function onStatus(event:StatusEvent) : void 
		{
            switch (event.level) {
                case "status":
                 {   
				 	trace("LocalConnection.send() succeeded");
					break;
				 }
				case "error":
				{
                    trace("LocalConnection.send() failed");
					break;
				}
            }
	 	}
		
		public function clearLogoForXML() : void
		{
			var tempChildern = LogoForXML.numChildren;
			if (tempChildern > 1)
			{
				for ( var i = tempChildern-1; i > 0; i--)
				{
					LogoForXML.removeChildAt(i);
				}
			}
		}
	}
}