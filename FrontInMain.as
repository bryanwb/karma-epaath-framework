package 
{
 	import flash.display.*;
	import flash.events.*;
	import flash.net.*;
	import flash.text.*;
	import flash.external.*;
	import flash.accessibility.*;
	import flash.system.*;
	import flash.media.*;
	import flash.filters.GlowFilter;
	import flash.filters.BitmapFilterQuality;
	
	public class FrontInMain extends MovieClip
	{
		private var conn:LocalConnection ;
		var lFrameContainerL : FrameContainer = new FrameContainer();
		var lFrameContainerT : FrameContainer = new FrameContainer();
		
		var textWithTwoFont : TextWithTwoFont;
		
		var activityId : String = new String(); // activityId gets value from menuScreen
		
		var activityTitleField:TextField = new TextField();
		
		var introScreen : IntroScreen = new IntroScreen();
		var teacherNote : TeacherNote = new TeacherNote(); //btn
		var description : Description = new Description();
		var btnole_logo : ole_logo = new ole_logo();	
		var frameWorkOfficeName : FrameWorkOfficeName = new FrameWorkOfficeName();
		
		var titleBar : TitleBar = new TitleBar();
		var titleBarDrop : TitleBarDrop = new TitleBarDrop();
		var btnClose : BtnClose = new BtnClose();
		var btnGame : BtnGame = new BtnGame();
		var btnbtn_ole : btn_ole = new btn_ole();
		var btnBackintro : btn_back = new btn_back();
		
		var btnActiveLesson: BtnActive = new BtnActive();
		var btnActiveExercise : BtnActiveExercise = new BtnActiveExercise();
		var btnInActiveLesson : BtnInactive = new BtnInactive();
		var btnInActiveExercise : BtnInactiveExercise = new BtnInactiveExercise();
		var myTextLesson:TextField = new TextField();
		var myTextExercise:TextField = new TextField();
		var teacherHelp : TeacherHelp = new TeacherHelp();
		var btnHelp : BtnHelp = new BtnHelp();
		var helpContainer : HelpContainer = new HelpContainer();
		
		var statusBar : StatusBar = new StatusBar();
		var btnNext : BtnNext = new BtnNext();
		var btnBack : BtnNext = new BtnNext();
		var tabNormal : TabNormal;
		var numOfLessonTab : uint;
		var numOfExerciseTab : uint = 1;
		var questionCounter : uint;
		var lessonCounter : int;
		
		var statusBarBottonLesson : Array = new Array();
		var statusBarBottonExercise : Array = new Array();
				
		var dropDown : DropDown = new DropDown();
		var lessonAndExeciseSeperator : Boolean;
		var backgroundAndExeciseSeperator : Boolean;
		var teacherNotesDrop : TeacherNotesDrop = new TeacherNotesDrop();
		var teacherDescriptionDrop : TeacherDescriptionDrop = new TeacherDescriptionDrop();
		
		var scoreBoard : ScoreBoard = new ScoreBoard();
		var scoreContainer : ScoreContainer = new ScoreContainer();
		var scoreIndicatorHolder : ScoreIndicatorHolder;
		var scoreIndicatorHolderArray : Array = new Array();
		var scoreIndicatorHolderTypeArray : Array = new Array();
		var btnPlayagain : BtnPlayagain = new BtnPlayagain();
		var btnStarNew : BtnStarNew = new BtnStarNew();
		var btnSummary : BtnSummary = new BtnSummary();
		var repeatExFlag : Boolean;
		var playAginFlag : Boolean;
		
		var lessonContainer : LessonContainer = new LessonContainer();
		var exerciseContainer : ExerciseContainer = new ExerciseContainer();
		var exerciseField : TextField; 
		
		var summaryContainer : SummaryContainer = new SummaryContainer();
		var tigerAnimation : TigerAnimation = new TigerAnimation();
		var scoreHistory : ScoreHistory = new ScoreHistory();
		var summaryTitle : SummaryTitle = new SummaryTitle();
		var summaryCounter : int;
		var score : int;
		var scoreTextField : TextField = new TextField();
		var btnRepeatLesson : BtnRepeatLesson = new BtnRepeatLesson();
		var btnRepeatExcercise : BtnRepeatExcercise = new BtnRepeatExcercise();
		
		var mLoader:Loader;
		var mRequest:URLRequest;
/// List of variable for level
		var currentLevel : int;
		var levelPreviousSelected : int;
		var levelHolder : LevelHolder = new LevelHolder();
		var levelOne : LevelOne = new LevelOne();
		var levelTwo : LevelTwo = new LevelTwo();
		var levelThree : LevelThree = new LevelThree();
		var levelOneSelected : LevelOneSelected = new LevelOneSelected();
		var levelTwoSelected : LevelTwoSelected = new LevelTwoSelected();
		var levelThreeSelected : LevelThreeSelected = new LevelThreeSelected();
		
		//var xMLReader : XMLReader;
/// end of level variable
		
/// List of information and data needed for display and are take from config file
		var sTextFormat : String = new String();
		var sGrade : String = new String();
		var sSubject : String = new String();
		var sActivityTitle : String = new String();
		var sactivityTitleEnglish : String = new String();
		var nActivityLevel : int;
		var sIntroduction : String = new String();
		
		var sExcerciseIntro : String = new String();
		var sExerciseLevelOne : String = new String();
		var sExerciseLevelTwo : String = new String();
		var sExerciseLevelThree : String = new String();
		
		var sSummary : String = new String();
		var sHelp : String = new String();
		var sLessonHelp : String = new String();
		var sExerciseLevelOneHelp : String = new String();
		var sExerciseLevelTwoHelp : String = new String();
		var sExerciseLevelThreeHelp : String = new String();
		var sHelpIndicator : TextField;
/// XML read for Games
		var sLessonGame : String = new String();
		var sLessonGameHelp : String = new String();
		var sLevelOneGame : String = new String();
		var sLevelOneGameHelp : String = new String();
		var sLevelTwoGame : String = new String();
		var sLevelTwoGameHelp : String = new String();
		var SLevelThreeGame : String = new String();	
		var sLevelThreeGameHelp : String = new String(); 
		
		var helpContainerGame : HelpContainerGame;
		var btnHelpForGame : BtnHelp;
///
		var navData:XML;
		var loader:URLLoader = new URLLoader();
		
		var my_so:SharedObject;
/// For Game	
		var gameHolder : GameHolder;
		var flagExerciseGame : Boolean;
/// Constructor Initialization
		var path : String;
		
		var flagStopSound : Boolean;
		
		var flagLessonPlan : Boolean;

		var ta : TextField = new TextField();
		public function FrontInMain() : void
		{
			var pageURL:String = ExternalInterface.call('window.location.href.toString');
			//this.xMLReader = xMLReader;
			conn = new LocalConnection();
			
            try 
			{
                conn.connect("FRAMEWORK");// for activity
            } 
			catch (error:ArgumentError)
			{
                trace(error);
		    }
			
			conn.addEventListener(AsyncErrorEvent.ASYNC_ERROR, onAsync);
			conn.addEventListener(StatusEvent.STATUS, onStatus);
			conn.client = this;
			
			activityName(pageURL.split("#")[1],"");
		}		
		
		private function onAsync(asevent:AsyncErrorEvent) : void 
		{
			
		}
		
		private function onStatus(event:StatusEvent) : void 
		{
            switch (event.level) 
			{
                case "status":
                 {   
				 	trace("LocalConnection.send() succeeded frame");
					break;
				 }
				case "error":
				{
                    trace("LocalConnection.send() failed frame");
					break;
				}				
            }
	 	}			
/// Constructor End

// For Game Load and Close ************
				public function GameStart (event : MouseEvent) : void 
				{
					gameHolder = new GameHolder();
					var btnCloseForGame : BtnClose = new BtnClose();
					btnCloseForGame.x = 40;
					btnCloseForGame.y = 43;
					btnCloseForGame.addEventListener (MouseEvent.CLICK, btnCloseForGameHandler);
					gameHolder.addChild(btnCloseForGame);
					
					btnHelpForGame = new BtnHelp();
					btnHelpForGame.x = 1160;
					btnHelpForGame.y = 43;
					btnHelpForGame.addEventListener (MouseEvent.CLICK, btnHelpForGameHandler);
					gameHolder.addChild(btnHelpForGame);
					
					addChild(gameHolder);
					
					var context:LoaderContext = new LoaderContext();
					context.applicationDomain = new ApplicationDomain();
					
					mLoader = new Loader();
					mLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, gameonCompleteHandler);
					mLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,gameonIOError);
					
					if (lessonAndExeciseSeperator == false )
					{
						conn.send("LESSON", "stopSound");
						if (navData.OLEgames.lessonGame.@type == "local")
							mLoader.load(new URLRequest(path+"Activities/"+activityId+"/Games/lessonGame/"+sLessonGame+".swf"), context);
						else
							mLoader.load(new URLRequest("Games/"+sLessonGame+"/"+sLessonGame+".swf"), context);						
					}
					else
					{
						if ((currentLevel == 0 || currentLevel == 1) && flagExerciseGame == true)
						{
							flagExerciseGame = false;
							if (navData.OLEgames.levelOneGame.@type == "local")
								mLoader.load(new URLRequest(path+"Activities/"+activityId+"/Games/levelOneGame/"+sLevelOneGame+".swf"), context);
							else
								mLoader.load(new URLRequest("Games/"+sLevelOneGame+"/"+sLevelOneGame+".swf"), context);
						}
						else if (currentLevel == 2 && flagExerciseGame == true)
						{
							flagExerciseGame = false;
							if (navData.OLEgames.levelTwoGame.@type == "local")
								mLoader.load(new URLRequest(path+"Activities/"+activityId+"/Games/levelTwoGame/"+sLevelTwoGame+".swf"), context);
							else
								mLoader.load(new URLRequest("Games/"+sLevelTwoGame+"/"+sLevelTwoGame+".swf"), context);
						}
						else if (currentLevel == 3 && flagExerciseGame == true)
						{
							flagExerciseGame = false;
							if (navData.OLEgames.levelThreeGame.@type == "local")
								mLoader.load(new URLRequest(path+"Activities/"+activityId+"/Games/levelThreeGame/"+SLevelThreeGame+".swf"), context);
							else
								mLoader.load(new URLRequest("Games/"+SLevelThreeGame+"/"+SLevelThreeGame+".swf"), context);							
						}
					}
				}
				
				public function exerciseGameStart (flagExerciseGame : Boolean) : void  /// Remote connection function
				{
					this.flagExerciseGame = flagExerciseGame;					
				}
				
				private function btnHelpForGameHandlerOut(event : MouseEvent) : void
				{
					btnHelpForGame.addEventListener (MouseEvent.CLICK, btnHelpForGameHandler); 
					btnHelpForGame.removeEventListener (MouseEvent.MOUSE_OUT, btnHelpForGameHandlerOut);
					gameHolder.removeChild(helpContainerGame);
				}
				
				private function btnHelpForGameHandler(event : MouseEvent) : void
				{
					btnHelpForGame.removeEventListener (MouseEvent.CLICK, btnHelpForGameHandler); 
					btnHelpForGame.addEventListener (MouseEvent.MOUSE_OUT, btnHelpForGameHandlerOut);
					
					helpContainerGame = new HelpContainerGame();
					helpContainerGame.x = 995;
					helpContainerGame.y = 465;
					
					textWithTwoFont = new TextWithTwoFont();
				
					var helpIndicatorFormat : TextFormat = new TextFormat();
					helpIndicatorFormat.font = "Kantipur";
					helpIndicatorFormat.size = 25;
					helpIndicatorFormat.bold = true;
					helpIndicatorFormat.color = 0x990000;
					helpIndicatorFormat.align = TextFormatAlign.CENTER;
						
					textWithTwoFont.x = -180;
					textWithTwoFont.y = -340;
					
					if (lessonAndExeciseSeperator == false )
					{
						textWithTwoFont.displayText(sLessonGameHelp, 620, 360, 25, null, false);
													
						helpContainerGame.addChild(textWithTwoFont);
						gameHolder.addChild(helpContainerGame);
					}
					else
					{						
						if ((currentLevel == 0 || currentLevel == 1))
						{
							textWithTwoFont.displayText(sLevelOneGameHelp, 620, 360, 25, null, false);
						
							helpContainerGame.addChild(textWithTwoFont);
							gameHolder.addChild(helpContainerGame);
						}
						else if (currentLevel == 2)
						{
							textWithTwoFont.displayText(sLevelTwoGameHelp, 620, 360, 25, null, false);
													
							helpContainerGame.addChild(textWithTwoFont);
							gameHolder.addChild(helpContainerGame);
						}
						else if (currentLevel == 3)
						{
							textWithTwoFont.displayText(sLevelThreeGameHelp, 620, 360, 25, null, false);
													
							helpContainerGame.addChild(textWithTwoFont);
							gameHolder.addChild(helpContainerGame);
						}
					}
				}
				
				private function btnCloseForGameHandler(event : MouseEvent) : void
				{
					conn.addEventListener(StatusEvent.STATUS, onStatus);
					conn.send("GAME","closeConnection");
					if (lessonAndExeciseSeperator == true)
					{
						btnGame.alpha = 0.5;
						btnGame.enabled = false; 
						btnGame.removeEventListener(MouseEvent.CLICK, GameStart);
					}
					removeChild(gameHolder);
					gameHolder = null;
				}
				
				private function gameonIOError(evt:IOErrorEvent) : void 
				{  
					
				}
		
				private function gameonCompleteHandler(loadEvent:Event) : void
				{
					loadEvent.currentTarget.content.scaleX = 2.178;
					loadEvent.currentTarget.content.scaleY =  1.86;
					loadEvent.currentTarget.content.x = 1;
					loadEvent.currentTarget.content.y = 93;
					
					gameHolder.addChild(loadEvent.currentTarget.content);
					
					if (lessonAndExeciseSeperator == false )
					{
						conn.send("GAME","initAssetPath",path + "Activities/" + activityId, "lessonGame");
					}
					else
					{
						if ((currentLevel == 0 || currentLevel == 1))
						{
							conn.send("GAME","initAssetPath",path + "Activities/" + activityId, "levelOneGame");
						}
						else if (currentLevel == 2)
						{
							conn.send("GAME","initAssetPath",path + "Activities/" + activityId, "levelTwoGame");
						}
						else if (currentLevel == 3)
						{
							conn.send("GAME","initAssetPath",path + "Activities/" + activityId, "levelThreeGame");
						}
					}			
				}
			
				
// For Game Load and Close End********

/// Remote Funciton Called by Menu screen to pass activity name		
		
		public function activityName(msg : String, path : String) : void 
		{
            ta.text = msg;
			activityId = msg;
			this.path = path;
			ActivityXMLReader();
		}
		
/// Funciton Called by activity to pass no of tab in statusbar		
		public function statusBarTab(tabCounter : int, type : String) : void  // display the no of tab i.e. lesson or exercise
		{
			var x_pos = 95;
									
			while (statusBar.numChildren > 1)
			{
				statusBar.removeChildAt(1);
			}
			
			if (statusBar.numChildren == 1)
			{
				btnNext.addEventListener(MouseEvent.CLICK,btnNextHandler);
				statusBar.addChild(btnNext);
				btnBack.addEventListener(MouseEvent.CLICK,btnBackHandler);
				statusBar.addChild(btnBack);
			}
			
			for (var i = 0; i < tabCounter; i++)
			{
				var myFormat:TextFormat = new TextFormat();
				myFormat.font = "Arial";
				myFormat.size = 32;
				myFormat.bold = true;
				myFormat.color = 0xFFFFFF;
				myFormat.align = TextFormatAlign.CENTER;
				
				var myText:TextField = new TextField();
				myText.height = 40;
				myText.width =  60;
				myText.x = x_pos + 15;
				myText.y = 5;
				myText.defaultTextFormat = myFormat;
				myText.selectable = false;
				myText.text = i+1;
				statusBar.addChild(myText);
								
				if (statusBarBottonLesson[i] == null  && type == "lesson")
				{
					tabNormal = new TabNormal();
					tabNormal.x = x_pos;
					tabNormal.y = 2;
					tabNormal.name =i+1;
					tabNormal.addEventListener(MouseEvent.CLICK,lessonDisplay);
					statusBar.addChild(tabNormal);
					statusBarBottonLesson[i] = tabNormal;
					
					if (i == 0)
					{
						var lessonSelectedTab : SelectionTab = new SelectionTab();
						lessonSelectedTab.x = 7;
						lessonSelectedTab.y = 3;
						statusBarBottonLesson[0].addChild(lessonSelectedTab);
					}
				}
				else if (statusBarBottonExercise[i] == null && type == "exercise")
				{
					tabNormal = new TabNormal();
					tabNormal.x = x_pos;
					tabNormal.y = 2;
					tabNormal.name =i+1;
					tabNormal.addEventListener(MouseEvent.CLICK,questionDisplay);
					statusBar.addChild(tabNormal);
					
					if (i == 0)
					{
						var exerciseSelectedTab : SelectionTab = new SelectionTab();
						exerciseSelectedTab.x = 7;
						exerciseSelectedTab.y = 3;
						tabNormal.addChild(exerciseSelectedTab);
					}
					
					statusBarBottonExercise[i] = tabNormal;
				}
				else if ( type == "lesson")
				{
					statusBar.addChild(statusBarBottonLesson[i]);
				}
				else if (type == "exercise")
				{
					statusBar.addChild(statusBarBottonExercise[i]);
				}					
				x_pos = x_pos + 100;
			}
		}
		
		public function changeScore(questionNo : int, scoreStatus : Boolean) : void
		{
			var x_pos : int;
			var y_pos : int;
			
			if (scoreIndicatorHolderTypeArray[questionNo -1] == "Holder")// for unsolved quesiton i.e. circle 
			{
				var tempscoreIndicatorHolder : ScoreIndicatorHolder = scoreIndicatorHolderArray[questionNo -1];
				x_pos = tempscoreIndicatorHolder.x;
				y_pos = tempscoreIndicatorHolder.y;
				scoreContainer.removeChild(tempscoreIndicatorHolder);
			}
			/*else if (scoreIndicatorHolderTypeArray[questionNo -1] == "Happy")// for correct solved question i.e. happy icon
			{
				var temphappyScore : HappyScore =  scoreIndicatorHolderArray[questionNo -1];
				x_pos = temphappyScore.x;
				y_pos = temphappyScore.y;
				scoreContainer.removeChild(temphappyScore);
			}
			else if (scoreIndicatorHolderTypeArray[questionNo -1] == "Sad")// for wrong queston i.e. sad icon
			{
				var tempsadScore : SadScore =  scoreIndicatorHolderArray[questionNo -1];
				x_pos = tempsadScore.x;
				y_pos = tempsadScore.y;
				scoreContainer.removeChild(tempsadScore);
			}*/
			
			if (scoreStatus == true && scoreIndicatorHolderTypeArray[questionNo -1] == "Holder")// scoreStatus indicate if attemped question is correct or not
			{
				var happyScore : HappyScore = new HappyScore();
				happyScore.x = x_pos;
				happyScore.y = y_pos;
				scoreIndicatorHolderArray[questionNo -1] = happyScore;// scoreIndicatorHolderArray is object array
				scoreIndicatorHolderTypeArray[questionNo -1] = "Happy";// scoreIndicatorHolderTypeArray store the identificaton of scoreIndicatorHolderArray
				
				if (score <= 10)
					score++;
				scoreContainer.addChild(happyScore);
				
				scoreBoard.removeChild(scoreTextField);
				scoreTextField.text = String(score);
				scoreBoard.addChild(scoreTextField);				
				
				if (((statusBar.numChildren - 3)/2) != 1)
				{
					statusBar.removeChild(statusBarBottonExercise[questionNo -1]);
					
					var tempStateHappy : TabCorrect = new TabCorrect();
					tempStateHappy.x = statusBarBottonExercise[questionNo -1].x ;
					tempStateHappy.y = statusBarBottonExercise[questionNo -1].y ;
					tempStateHappy.name = statusBarBottonExercise[questionNo -1].name;
					tempStateHappy.addEventListener(MouseEvent.CLICK,questionDisplay);
					
					var happySelectionTab : SelectionTab = new SelectionTab();
					happySelectionTab.x = 7;
					happySelectionTab.y = 3;
					tempStateHappy.addChild(happySelectionTab);
					
					statusBarBottonExercise[questionNo -1] = tempStateHappy;
					
					statusBar.addChild(statusBarBottonExercise[questionNo -1]);
				}	
				summaryCounter++;
			}
			else if (scoreStatus == false && scoreIndicatorHolderTypeArray[questionNo -1] == "Holder")
			{
				var sadScore : SadScore = new SadScore();
				sadScore.x = x_pos;
				sadScore.y = y_pos;
				scoreIndicatorHolderArray[questionNo -1] = sadScore;
				scoreIndicatorHolderTypeArray[questionNo -1] = "Sad";
				scoreContainer.addChild(sadScore);
				
				if (((statusBar.numChildren - 3)/2) != 1)
				{
					statusBar.removeChild(statusBarBottonExercise[questionNo -1]);
					
					var tempStateSad : TabIncorrect = new TabIncorrect();
					tempStateSad.x = statusBarBottonExercise[questionNo -1].x ;
					tempStateSad.y = statusBarBottonExercise[questionNo -1].y ;
					tempStateSad.name = statusBarBottonExercise[questionNo -1].name;
					tempStateSad.addEventListener(MouseEvent.CLICK,questionDisplay);
					
					var sadSelectionTab : SelectionTab = new SelectionTab();
					sadSelectionTab.x = 7;
					sadSelectionTab.y = 3;
					tempStateSad.addChild(sadSelectionTab);
					
					statusBarBottonExercise[questionNo -1] = tempStateSad;
									
					statusBar.addChild(statusBarBottonExercise[questionNo -1]);
				}
				summaryCounter++;
			}
			
			if (summaryCounter >= 10)
			{
				btnSummary.alpha = 1;
				btnSummary.enabled = true; 
				btnSummary.addEventListener(MouseEvent.CLICK, btnSummaryHandler);
			}
		}
		
		public function getNumLessonTab(num : uint) : void
		{
			numOfLessonTab = num;
			statusBarTab(numOfLessonTab,"lesson");
		}	
		
		public function getNumExerciseTab(num : uint) : void
		{
			numOfExerciseTab = num;
			statusBarTab(numOfExerciseTab,"exercise");
		}
		
		public function getlevel(currentLevel : uint) : void
		{
			this.currentLevel = currentLevel;
					
			if (currentLevel == 1 || currentLevel == 0)
			{
				levelOneHandler()
			}
			else if (currentLevel == 2)
			{
				levelTwoHandler();
			}
			else if (currentLevel == 3)
			{
				levelThreeHandler();
			}
		}
		
		private function levelOneHandler(... rest):void
		{
			if (rest[0] != true)			
			{
				while (exerciseContainer.numChildren > 0)
						exerciseContainer.removeChildAt(exerciseContainer.numChildren - 1);
						
				var myFormat:TextFormat = new TextFormat();
				myFormat.font = "Kantipur";
				myFormat.size = 35;
				myFormat.bold = true;
				myFormat.color = 0x000000;
				myFormat.align = TextFormatAlign.JUSTIFY;
			
				textWithTwoFont = new TextWithTwoFont();
				textWithTwoFont.displayText(sExerciseLevelOne, 200, 880, 25, myFormat, false);
				textWithTwoFont.x = 10;
				textWithTwoFont.y = 20;
				exerciseContainer.addChild(textWithTwoFont);
			}
			
			removeLevelPrevious();
			levelOneSelected.x = levelOne.x;
			levelOneSelected.y = levelOne.y;
			levelHolder.removeChild(levelOne);
			levelHolder.addChild(levelOneSelected);
			levelPreviousSelected = 1;
			currentLevel = 1;
		}
		
		private function levelTwoHandler(... rest):void
		{
			if (rest[0] != true)			
			{
				while (exerciseContainer.numChildren > 0)
						exerciseContainer.removeChildAt(exerciseContainer.numChildren - 1);
						
				var myFormat:TextFormat = new TextFormat();
				myFormat.font = "Kantipur";
				myFormat.size = 35;
				myFormat.bold = true;
				myFormat.color = 0x000000;
				myFormat.align = TextFormatAlign.JUSTIFY;
			
				textWithTwoFont = new TextWithTwoFont();
				textWithTwoFont.displayText(sExerciseLevelTwo, 200, 880, 25, myFormat, false);
				textWithTwoFont.x = 10;
				textWithTwoFont.y = 20;
				exerciseContainer.addChild(textWithTwoFont);
			}
			
			removeLevelPrevious();
			levelTwoSelected.x = levelTwo.x;
			levelTwoSelected.y = levelTwo.y;
			levelHolder.removeChild(levelTwo);
			levelHolder.addChild(levelTwoSelected);
			levelPreviousSelected = 2;
			currentLevel = 2;
		}
		
		private function levelThreeHandler(... rest):void
		{
			if (rest[0] != true)			
			{
				while (exerciseContainer.numChildren > 0)
						exerciseContainer.removeChildAt(exerciseContainer.numChildren - 1);
						
				var myFormat:TextFormat = new TextFormat();
				myFormat.font = "Kantipur";
				myFormat.size = 35;
				myFormat.bold = true;
				myFormat.color = 0x000000;
				myFormat.align = TextFormatAlign.JUSTIFY;
			
				textWithTwoFont = new TextWithTwoFont();
				textWithTwoFont.displayText(sExerciseLevelThree, 200, 880, 25, myFormat, false);
				textWithTwoFont.x = 10;
				textWithTwoFont.y = 20;
				exerciseContainer.addChild(textWithTwoFont);
			}
			
			removeLevelPrevious();
			levelThreeSelected.x = levelThree.x;
			levelThreeSelected.y = levelThree.y;
			levelHolder.removeChild(levelThree);
			levelHolder.addChild(levelThreeSelected);
			levelPreviousSelected = 3;
			currentLevel = 3;
		}
		
		private function removeLevelPrevious() : void
		{
			if (levelPreviousSelected == 1)
			{
				levelHolder.removeChild(levelOneSelected);
				levelHolder.addChild(levelOne);
				
			}
			else if (levelPreviousSelected == 2)
			{
				levelHolder.removeChild(levelTwoSelected);
				levelHolder.addChild(levelTwo);				
			}
			else if (levelPreviousSelected == 3)
			{
				levelHolder.removeChild(levelThreeSelected);
				levelHolder.addChild(levelThree);			
			}			
		}
			
/// Remote Funciton End

/// displayScreen function display the items need in the stage 		
		private function displayIntroduction() : void
		{
			var myFormat:TextFormat = new TextFormat();
			myFormat.font = "Arial";
			myFormat.size = 75;
			myFormat.bold = true;
			myFormat.color = 0xFFFFFF;
			myFormat.align = TextFormatAlign.CENTER;
			
			introScreen.x = -85;
			introScreen.y = -46;
			addChild(introScreen);
			
			btnBackintro.x = 160;
			btnBackintro.y = 90;
			btnBackintro.addEventListener (MouseEvent.CLICK, btnBackHandlerIntro);
			introScreen.addChild(btnBackintro);
			
			teacherNote.x =150;
			teacherNote.y =715;
			teacherNote.addEventListener (MouseEvent.CLICK, teacherNoteHandler);
			introScreen.addChild(teacherNote);
			
			description.x =915;
			description.y =715;
			description.addEventListener (MouseEvent.CLICK, lessonPlanHandler);
			introScreen.addChild(description);
			
			btnole_logo.x = 675;
			btnole_logo.y = 880;
			
			var glow:GlowFilter = new GlowFilter();
			glow.color = 0xFFFFFF;
			glow.blurX = 5;
			glow.blurY = 5;
			btnole_logo.filters = [glow];
			btnole_logo.buttonMode = true;
			btnole_logo.addEventListener(MouseEvent.CLICK, logoClickHandler);
			introScreen.addChild(btnole_logo);
			
			myFormat.size = 100;
			myFormat.font = "Kantipur";
			var gradeField:TextField = new TextField();
			gradeField.height = 80;
			gradeField.width = 380;
			gradeField.defaultTextFormat = myFormat;
			gradeField.wordWrap=true;
			gradeField.selectable = false;
			gradeField.embedFonts = true;
			
			if (uint(sGrade) == 2)
				sGrade = "@"
			else if (uint(sGrade) == 6)
				sGrade = "^"
			else if (uint(sGrade) == 3)
				sGrade = "#"
				
			gradeField.text = "sÔFM " + sGrade ;
			gradeField.x = 480;
			gradeField.y = 170;
			introScreen.addChild(gradeField);
			
			if (sSubject == "English" )
			{
				myFormat.size = 80;
				myFormat.font = "Arial";
			}
			else if (sSubject == "Math" || sSubject == "Maths")
			{
				sSubject = "ul0ft";
				myFormat.size = 120;
				myFormat.font = "Kantipur";
			}
			else if (sSubject == "Nepali")
			{
				sSubject = "g]kFnL";
				myFormat.size = 120;
				myFormat.font = "Kantipur";
			}
			var subjectField:TextField = new TextField();
			subjectField.height = 100;
			subjectField.width = 400;
			subjectField.defaultTextFormat = myFormat;
			subjectField.wordWrap=true;
			subjectField.selectable = false;
			subjectField.embedFonts = true;
			subjectField.text = sSubject;
			subjectField.x = 460;
			subjectField.y = 280;
			introScreen.addChild(subjectField);
			
			myFormat.size = 60;
			myFormat.font = "Kantipur";
						
			myFormat.font = "Arial";
			myFormat.size = 50;
			myFormat.color = 0xFFFF66;
			activityTitleField.height = 85;
			activityTitleField.width = 700;
			
			if (sTextFormat == "nepali")
			{
				myFormat.size = 80;
				myFormat.font = "Kantipur";
			}
						
			activityTitleField.defaultTextFormat = myFormat;
			activityTitleField.wordWrap = true;
			activityTitleField.embedFonts = true;
			activityTitleField.selectable = false;
			activityTitleField.text = sActivityTitle;
			activityTitleField.mouseEnabled = false;
				
			var tempMovieClip : MovieClip = new MovieClip();
			tempMovieClip.x = 300;
			tempMovieClip.y = 420;
			tempMovieClip.buttonMode = true;
			tempMovieClip.addEventListener (MouseEvent.MOUSE_OVER, activityTitleFieldMOUSE_OVERHandler);
			tempMovieClip.addEventListener (MouseEvent.MOUSE_OUT, activityTitleFieldMOUSE_OUTHandler);
			tempMovieClip.addEventListener (MouseEvent.CLICK, activityTitleFieldHandler);
			tempMovieClip.addChild(activityTitleField);
			introScreen.addChild(tempMovieClip);
			
			myFormat.color = 0xFFFFFF;
			myFormat.size = 45;
			myFormat.align = TextFormatAlign.CENTER;
			myFormat.font = "Kantipur";
						
			textWithTwoFont = new TextWithTwoFont();
			textWithTwoFont.displayText(sIntroduction, 160, 970, 45, myFormat, false);
			textWithTwoFont.x = 200;
			textWithTwoFont.y = 550;
			introScreen.addChild(textWithTwoFont);
		}
		
		private function logoClickHandler(event : MouseEvent) : void
		{
			event.target.removeEventListener(MouseEvent.CLICK, logoClickHandler);
			event.target.addEventListener(MouseEvent.CLICK, endlogoClickHandler);
			
			var btnCloseClose : BtnCloseClose = new BtnCloseClose();
			btnCloseClose.x = 370;
			btnCloseClose.y = -255;
			btnCloseClose.addEventListener(MouseEvent.CLICK, endlogoClickHandler);
			frameWorkOfficeName.addChild(btnCloseClose);
			
			frameWorkOfficeName.x = 670;
			frameWorkOfficeName.y = 560;
			introScreen.addChild(frameWorkOfficeName);			
		}
		
		private function endlogoClickHandler(event : MouseEvent) : void
		{
			btnole_logo.removeEventListener(MouseEvent.CLICK, endlogoClickHandler);
			btnole_logo.addEventListener(MouseEvent.CLICK, logoClickHandler); 
			if (introScreen.contains(frameWorkOfficeName))
				introScreen.removeChild(frameWorkOfficeName);
		}
		
		private function displayScreen() : void
		{
			titleBar = new TitleBar();
			btnClose.x = 40;
			btnClose.y = 43;
			btnClose.addEventListener (MouseEvent.CLICK, btnCloseHandler);
			titleBar.addChild(btnClose);
			
			lessonContainer.y = 89;
			addChild(lessonContainer);
			startLoad(activityId,"_L");
			
			var myFormat:TextFormat = new TextFormat();
			myFormat.font = "Arial";
			myFormat.size = 35;
			myFormat.bold = true;
			myFormat.color = 0xFFFFFF;
			myFormat.align = TextFormatAlign.CENTER;
			
			if (sTextFormat == "nepali")
			{
				myFormat.size = 40;
				myFormat.font = new Kantipur().fontName;
			}
			
			var myText:TextField = new TextField();
			myText.height = 45;
			myText.width = 570;
			myText.x = 90;
			myText.y = 22;
			myText.defaultTextFormat = myFormat;
			myText.wordWrap=true;
			myText.embedFonts = true;
			myText.selectable = false;
			myText.text = sActivityTitle;
						
			titleBar.addChild(myText);
			
			if (sSubject == "ul0ft")
			{
				titleBarDrop.x = 130;
				titleBarDrop.y = 72;
				titleBarDrop.textText.text = sactivityTitleEnglish;
				titleBarDrop.textText.selectable = false;
				myText.addEventListener(MouseEvent.MOUSE_OVER, myTextHandler);
				myText.addEventListener(MouseEvent.MOUSE_OUT, myTextHandler);
			}
			
			var myFormatle:TextFormat = new TextFormat();
			myFormatle.font = "Kantipur";
			myFormatle.size = 40;
			myFormatle.bold = true;
			myFormatle.color = 0xFFFFFF;
			myFormatle.align = TextFormatAlign.CENTER;
						
			myTextLesson.height = 40;
			myTextLesson.width =  150;
			myTextLesson.x = 780;
			myTextLesson.y = 30;
			myTextLesson.embedFonts = true;
			myTextLesson.defaultTextFormat = myFormatle;
			myTextLesson.selectable = false;
			myTextLesson.text = "Kff7";
			titleBar.addChild(myTextLesson);
			
			myTextExercise.height = 40;
			myTextExercise.width =  150;
			myTextExercise.x = 915;
			myTextExercise.y = 30;
			myTextExercise.embedFonts = true;
			myTextExercise.defaultTextFormat = myFormatle;
			myTextExercise.selectable = false;
			myTextExercise.text = "cEof;";
			titleBar.addChild(myTextExercise);
			
			btnActiveLesson.x = 855;
			btnActiveLesson.y = 48;
			btnInActiveLesson.x = 855
			btnInActiveLesson.y = 48;
			btnInActiveLesson.addEventListener(MouseEvent.CLICK, btnLessonDropHandler);
			titleBar.addChild(btnActiveLesson);
			
			btnActiveExercise.x = 990;
			btnActiveExercise.y = 48;
			btnInActiveExercise.x = 990;
			btnInActiveExercise.y = 48;
			btnInActiveExercise.addEventListener(MouseEvent.CLICK, btnExcerciseDropHandler);
			titleBar.addChild(btnInActiveExercise);
			
			teacherHelp.x = 670;
			teacherHelp.y = 45;
			teacherHelp.addEventListener (MouseEvent.CLICK, teacherHelpHandler);
			titleBar.addChild(teacherHelp);
			
			btnbtn_ole.x = 745;
			btnbtn_ole.y = 43;
			titleBar.addChild(btnbtn_ole);
			
			btnGame.x = 1095;
			btnGame.y = 43;
			if (sLessonGame == "")
			{
				btnGame.alpha = 0.5;
				btnGame.enabled = false; 
				titleBar.addChild(btnGame);
			}
			else
			{
				titleBar.addChild(btnGame);
				btnGame.addEventListener(MouseEvent.CLICK, GameStart);
			}
			btnHelp.x = 1160;
			btnHelp.y = 43
			btnHelp.addEventListener(MouseEvent.CLICK, btnHelpClickHandler);
			titleBar.addChild(btnHelp);
			
			addChild(titleBar);
			
			btnBack.x = 30;
			btnBack.y = 34;
			btnBack.rotation = 180;
			statusBar.addChild(btnBack);
			
			btnNext.x = 1160;
			btnNext.y =34;
			statusBar.addChild(btnNext);
			
			statusBar.y = 835;
			addChild(statusBar);
			
		}		
/// dispalyScreen End

		private function myTextHandler(evt:MouseEvent):void
		{
			if (!titleBar.contains(titleBarDrop))
				titleBar.addChild(titleBarDrop);
			else
				titleBar.removeChild(titleBarDrop);
		}

/// ActivityXMLReader loads the config file of activity 
		private function ActivityXMLReader() : void
		{
			loader.addEventListener(Event.COMPLETE, onComplete, false, 0, true);
			loader.load(new URLRequest(path+"Activities/"+activityId+"/config.xml"));
		}
		
/// teacherNoteHandler loads the pdf file 
		private function teacherNoteHandler(evt:MouseEvent):void
		{
			/*if (titleBar.contains(dropDown))
			{
				titleBar.removeChild(dropDown);
			}
			
			addChild(lFrameContainerT);
			if (lFrameContainerT.numChildren <= 1)
			{
				var context:LoaderContext = new LoaderContext();
				context.applicationDomain = new ApplicationDomain();
				
				mLoader = new Loader();
				mLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, onCompleteHandlerPdfTeacherNotes);
				mLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,onIOError);
	
				mLoader.load(new URLRequest("PDFLoader.swf"), context);
			}*/
			navigateToURL(new URLRequest(path + "TeacherNotesLoader.html#" + activityId), "_self");
		}
				
		private function lessonPlanHandler(evt:MouseEvent):void
		{
			/*if (titleBar.contains(dropDown))
			{
				titleBar.removeChild(dropDown);
			}
			
			addChild(lFrameContainerL);
			if (lFrameContainerL.numChildren <= 1)
			{
			
				var context:LoaderContext = new LoaderContext();
				context.applicationDomain = new ApplicationDomain();
				
				mLoader = new Loader();
				mLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, onCompleteHandlerPdfLessonPlan);
				mLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,onIOError);
	
				mLoader.load(new URLRequest("PDFLoader.swf"), context);
			}*/
			navigateToURL(new URLRequest(path + "LessonPlanLoader.html#" + activityId), "_self");
		}
		
		private function teacherHelpHandler(evt:MouseEvent):void
		{
			if (titleBar.contains(dropDown))
			{
				titleBar.removeChild(dropDown);				
			}
			else
			{
				teacherNotesDrop.x = -125;
				teacherNotesDrop.y = -70;
				//teacherNotesDrop.addEventListener(MouseEvent.CLICK, teacherNoteHandler);
				dropDown.addChild(teacherNotesDrop);
				
				teacherDescriptionDrop.x = -125;
				teacherDescriptionDrop.y = - 40;
				//teacherDescriptionDrop.addEventListener(MouseEvent.CLICK, lessonPlanHandler);
				dropDown.addChild(teacherDescriptionDrop);
				
				dropDown.x = 670;
				dropDown.y = 150;
				//titleBar.addChild(dropDown);
			}
		}
		
		private function lessonDisplay(evt:MouseEvent):void
		{
			for (var i = 0; i < statusBarBottonLesson.length; i++)
			{
				if (statusBarBottonLesson[i].numChildren > 1)
				{
					statusBarBottonLesson[i].removeChildAt(1);
				}
			}
			lessonCounter = (evt.currentTarget.name - 1);
						
			var selectionTab : SelectionTab = new SelectionTab();
			
			conn.addEventListener(StatusEvent.STATUS, onStatus);
			conn.send("LESSON", "showLesson",lessonCounter + 1, path)
			
			selectionTab.x = 7;
			selectionTab.y = 3;
			
			evt.currentTarget.addChild(selectionTab);			
		}
				
/// questionDisplay display the quesiton of exercise 
		private function questionDisplay(evt:MouseEvent):void
		{
			if (questionCounter != 0)
			{
				for (var i = 0; i < statusBarBottonExercise.length; i++)
				{
					if (statusBarBottonExercise[i].numChildren > 1)
					{
						statusBarBottonExercise[i].removeChildAt(1);						
					}
				}				
				questionCounter = evt.currentTarget.name;
				
				var selectionTab : SelectionTab = new SelectionTab();
				
				conn.addEventListener(StatusEvent.STATUS, onStatus);
				conn.send("Main","listenQuestion",uint(evt.currentTarget.name), path);//connection to activity for question in exercise
				
				selectionTab.x = 7;
				selectionTab.y = 3;
				
				evt.currentTarget.addChild(selectionTab);
			}
		}
		
/// Read all the data from xml file and store in different variable
		private function onComplete(evt:Event) : void 
		{
			try 
			{
				navData = new XML(evt.target.data);
				sTextFormat = navData.textfont;
				sGrade = navData.grade;
				sSubject = navData.subject;
				sActivityTitle = navData.activityTitle;
				sactivityTitleEnglish =  navData.activityTitleEnglish;
				nActivityLevel = navData.levelActivity;
				sIntroduction = navData.introduction;
				sExcerciseIntro = navData.excerciseIntro;
				sSummary = navData.summary;
				sHelp = navData.help;
				
				/// For Game
				sLessonGame = navData.OLEgames.lessonGame;
				sLevelOneGame = navData.OLEgames.levelOneGame;
				sLevelTwoGame = navData.OLEgames.levelTwoGame;
				SLevelThreeGame = navData.OLEgames.levelThreeGame;
				
				sLessonGameHelp = navData.OLEgames.lessonGameHelp;
				sLevelOneGameHelp = navData.OLEgames.levelOneGameHelp;
				sLevelTwoGameHelp = navData.OLEgames.levelTwoGameHelp;
				sLevelThreeGameHelp = navData.OLEgames.levelThreeGameHelp;
				// For Game End
				
				displayIntroduction();// dispaly the introduction i.e first page of framework
				
				if (navData.help.*.length() > 1)
				{
					sLessonHelp = navData.help.lessonHelp;
					sExerciseLevelOneHelp = navData.help.exerciseLevelOneHelp;
					sExerciseLevelTwoHelp = navData.help.exerciseLevelTwoHelp;
					sExerciseLevelThreeHelp =  navData.help.exerciseLevelThreeHelp;
				}				
				else
				{
					sLessonHelp = navData.help;
					sExerciseLevelOneHelp = navData.help;
					sExerciseLevelTwoHelp = navData.help;
					sExerciseLevelThreeHelp = navData.help;					
				}				
				
				if (navData.excerciseIntro.*.length() > 1)
				{
					sExerciseLevelOne = navData.excerciseIntro.levelOne;
					sExerciseLevelTwo = navData.excerciseIntro.levelTwo; 
					sExerciseLevelThree = navData.excerciseIntro.levelThree;
				}
				else
				{
					sExerciseLevelOne =  navData.excerciseIntro;
					sExerciseLevelTwo =  navData.excerciseIntro;
					sExerciseLevelThree =  navData.excerciseIntro;
				}					
				loader.removeEventListener(Event.COMPLETE, onComplete);				
			} 
			catch (err:Error) 
			{
				trace("Could not Load Config File");
			}
		}

/// btnNextHandler change the status bar tab position i.e move to next tab a head
		private function btnNextHandler(event:MouseEvent):void
        {
			var NoOfTabNext : int = (statusBar.numChildren - 3)/2;			
			
			if (questionCounter != 0 && NoOfTabNext == numOfExerciseTab && NoOfTabNext!= 0 )
			{
				for (var i = 0; i < statusBarBottonExercise.length; i++)
				{
					if (statusBarBottonExercise[i].numChildren > 1)
					{
						statusBarBottonExercise[i].removeChildAt(1);						
					}
				}
				questionCounter++;
				if (questionCounter > NoOfTabNext)
					questionCounter = 1;
													
				var selectionTab : SelectionTab = new SelectionTab();
				selectionTab.x = 7;
				selectionTab.y = 3;				
				
				statusBarBottonExercise[questionCounter - 1].addChild(selectionTab);
				
				conn.send("Main","listenQuestion",uint(questionCounter), path);
			}
			else if (NoOfTabNext == numOfLessonTab)
			{
				for (i = 0; i < statusBarBottonLesson.length; i++)
				{
					if (statusBarBottonLesson[i].numChildren > 1)
					{
						statusBarBottonLesson[i].removeChildAt(1);						
					}
				}
				
				lessonCounter ++;				
				if (lessonCounter >= numOfLessonTab)
					lessonCounter = 0;
					
				var selectionTabLesson : SelectionTab = new SelectionTab();
				selectionTabLesson.x = 7;
				selectionTabLesson.y = 3;
					
				statusBarBottonLesson[lessonCounter].addChild(selectionTabLesson);
				
				conn.addEventListener(StatusEvent.STATUS, onStatus);
				conn.send("LESSON", "showLesson",lessonCounter+1, path);// connection for lesson 
			}
		}

/// btnBackHandler change the status bar tab position i.e move to tab a behind		
		private function btnBackHandler(event:MouseEvent):void
        {
			var NoOfTabBack : int = (statusBar.numChildren - 3)/2;
			
			if (questionCounter != 0 && NoOfTabBack == numOfExerciseTab && NoOfTabBack != 0)
			{
				for (var i = 0; i < statusBarBottonExercise.length; i++)
				{
					if (statusBarBottonExercise[i].numChildren > 1)
					{
						statusBarBottonExercise[i].removeChildAt(1);						
					}
				}
				questionCounter--;
				if (questionCounter < 1)
					questionCounter = NoOfTabBack;
													
				var selectionTab : SelectionTab = new SelectionTab();
				selectionTab.x = 7;
				selectionTab.y = 3;
				
				statusBarBottonExercise[questionCounter - 1].addChild(selectionTab);
				
				conn.send("Main","listenQuestion",uint(questionCounter), path);
			}
			else if (NoOfTabBack == numOfLessonTab)// for lesson tab 
			{
				for (i = 0; i < statusBarBottonLesson.length; i++)
				{
					if (statusBarBottonLesson[i].numChildren > 1)
					{
						statusBarBottonLesson[i].removeChildAt(1);						
					}
				}
				
				lessonCounter --;				
				if (lessonCounter < 0)
					lessonCounter = numOfLessonTab - 1 ;
					
				var selectionTabLesson : SelectionTab = new SelectionTab();
				selectionTabLesson.x = 7;
				selectionTabLesson.y = 3;				
				
				statusBarBottonLesson[lessonCounter].addChild(selectionTabLesson);
				
				conn.addEventListener(StatusEvent.STATUS, onStatus);
				conn.send("LESSON", "showLesson",lessonCounter+1, path);// connection for lesson 
			}			
		}
/// close first screen of activity display next

		private function activityTitleFieldMOUSE_OUTHandler(event:MouseEvent):void
        {
			activityTitleField.scaleX = 1;
			activityTitleField.scaleY = 1;
			activityTitleField.background = false;
		}

		private function activityTitleFieldMOUSE_OVERHandler(event:MouseEvent):void
        {
			activityTitleField.scaleX = 1.009;
			activityTitleField.scaleY = 1.009;
			activityTitleField.background = true;
			activityTitleField.backgroundColor = 0x8870C3;
		}
		
		private function activityTitleFieldHandler(event:MouseEvent):void
        {
			removeChild(introScreen);
			displayScreen();
		}
		
		private function btnBackHandlerIntro(event : MouseEvent) : void
		{
			//ExternalInterface.call("window.location.reload( true )");
			navigateToURL(new URLRequest("MenuStage.html"), "_self");
		}

/// btnCloseHandler close the popup window
		private function btnCloseHandler(event : MouseEvent) : void
		{
			conn.send("Main", "stopSound");
			conn.send("Main","destroyActivity");	
			
			try
			{
				Object(lessonContainer.getChildAt(1)).stopSound();
			}
			catch (err:Error) 
			{
				trace("stopSound Error");
			}
			
			Object(lessonContainer.getChildAt(1)).conn.close();
			
			//MovieClip(root).removeChild(xMLReader.frameContainer);
			conn.close();
			ExternalInterface.call("window.location.reload( true )")
		}
/// action event for help on click
		private function btnHelpClickHandler(event : MouseEvent) : void
		{
			if (!titleBar.contains(helpContainer))
			{				
				helpContainer = new HelpContainer();
				helpContainer.x = 990;
				helpContainer.y = 463;
												
				var btnHelpLesson : BtnHelpLesson = new BtnHelpLesson();
				btnHelpLesson.x = -190;
				btnHelpLesson.y = -378;
				btnHelpLesson.addEventListener(MouseEvent.CLICK, BtnHelpLessonHandler);
				helpContainer.addChild(btnHelpLesson);
				
				var btnhelpClose : btn_help_close = new btn_help_close();
				btnhelpClose.x = 160;
				btnhelpClose.y = -366;
				btnhelpClose.addEventListener(MouseEvent.CLICK, btnHelpOutHandler);
				helpContainer.addChild(btnhelpClose);
				
				var btnHelpLevelOne : BtnHelpLevelOne = new BtnHelpLevelOne();
				btnHelpLevelOne.x = -10;
				btnHelpLevelOne.y = -373;
				btnHelpLevelOne.addEventListener(MouseEvent.CLICK, btnHelpLevelOneHandler);
				helpContainer.addChild(btnHelpLevelOne);
				
				var btnHelpLevelTwo : BtnHelpLevelTwo = new BtnHelpLevelTwo();
				btnHelpLevelTwo.x = 40;
				btnHelpLevelTwo.y = -373;
				btnHelpLevelTwo.addEventListener(MouseEvent.CLICK, btnHelpLevelTwoHandler);
				helpContainer.addChild(btnHelpLevelTwo);
				
				var btnHelpLevelThree : BtnHelpLevelThree = new BtnHelpLevelThree();
				btnHelpLevelThree.x = 90;
				btnHelpLevelThree.y = -373;
				btnHelpLevelThree.addEventListener(MouseEvent.CLICK, btnHelpLevelThreeHandler);
				helpContainer.addChild(btnHelpLevelThree);
				
				textWithTwoFont = new TextWithTwoFont();
				
				var helpIndicatorFormat : TextFormat = new TextFormat();
				helpIndicatorFormat.font = "Kantipur";
				helpIndicatorFormat.size = 25;
				helpIndicatorFormat.bold = true;
				helpIndicatorFormat.color = 0x990000;
				helpIndicatorFormat.align = TextFormatAlign.CENTER;
				
				sHelpIndicator = new TextField();
				sHelpIndicator.x = -90;
				sHelpIndicator.y = -310;
				sHelpIndicator.width = 200;
				sHelpIndicator.height = 30;
				sHelpIndicator.embedFonts = true;
				sHelpIndicator.selectable = false;
				sHelpIndicator.defaultTextFormat = helpIndicatorFormat;				
				
				if (lessonAndExeciseSeperator == false)
				{
					sHelpIndicator.text = "kf7 lgb]{zg\\ ";
					textWithTwoFont.displayText(sLessonHelp, 620, 345, 25, null, true);
				}
				else
				{
					if (currentLevel == 0 || currentLevel == 1)
					{
						sHelpIndicator.text = "cEof; lgb]{zg\\ -tx !_";
						textWithTwoFont.displayText(sExerciseLevelOneHelp, 620, 345, 25, null, true);
					}
					else if (currentLevel == 2)
					{
						sHelpIndicator.text = "cEof; lgb]{zg\\ -tx @_";
						textWithTwoFont.displayText(sExerciseLevelTwoHelp, 620, 345, 25, null, true);
					}
					else if (currentLevel == 3)
					{
						sHelpIndicator.text = "cEof; lgb]{zg\\ -tx #_";
						textWithTwoFont.displayText(sExerciseLevelThreeHelp, 620, 345, 25, null, true);
					}
				}
				
				helpContainer.addChild(sHelpIndicator);
				
				textWithTwoFont.x = -180;
				textWithTwoFont.y = -275;
				helpContainer.addChild(textWithTwoFont);
					
				titleBar.addChild(helpContainer);
			}
		}
		
/// action event for help on mouse out
		private function BtnHelpLessonHandler(event : MouseEvent) : void
		{
			helpContainer.removeChild(sHelpIndicator);
			helpContainer.removeChild(textWithTwoFont);
			textWithTwoFont = new TextWithTwoFont();
			textWithTwoFont.x = -180;
			textWithTwoFont.y = -275;
			textWithTwoFont.displayText(sLessonHelp, 620, 345, 25, null, true);
			
			sHelpIndicator.text = "kf7 lgb]{zg\\ ";
			helpContainer.addChild(sHelpIndicator);
			helpContainer.addChild(textWithTwoFont);
		}
		
		private function btnHelpLevelOneHandler(event : MouseEvent) : void
		{
			helpContainer.removeChild(sHelpIndicator);
			helpContainer.removeChild(textWithTwoFont);
			textWithTwoFont = new TextWithTwoFont();
			textWithTwoFont.x = -180;
			textWithTwoFont.y = -275;
			textWithTwoFont.displayText(sExerciseLevelOneHelp, 620, 345, 25, null, true);
			
			sHelpIndicator.text = "cEof; lgb]{zg\\ -tx !_";
			helpContainer.addChild(sHelpIndicator);
			helpContainer.addChild(textWithTwoFont);
		}
		
		private function btnHelpLevelTwoHandler(event : MouseEvent) : void
		{
			helpContainer.removeChild(sHelpIndicator);
			helpContainer.removeChild(textWithTwoFont);
			textWithTwoFont = new TextWithTwoFont();
			textWithTwoFont.x = -180;
			textWithTwoFont.y = -275;
			textWithTwoFont.displayText(sExerciseLevelTwoHelp, 620, 345, 25, null, true);
			
			sHelpIndicator.text = "cEof; lgb]{zg\\ -tx @_";
			helpContainer.addChild(sHelpIndicator);
			helpContainer.addChild(textWithTwoFont);
		}
		
		private function btnHelpLevelThreeHandler(event : MouseEvent) : void
		{
			helpContainer.removeChild(sHelpIndicator);
			helpContainer.removeChild(textWithTwoFont);
			textWithTwoFont = new TextWithTwoFont();
			textWithTwoFont.x = -180;
			textWithTwoFont.y = -275;
			textWithTwoFont.displayText(sExerciseLevelThreeHelp, 620, 345, 25, null, true);
			
			sHelpIndicator.text = "cEof; lgb]{zg\\ -tx #_";
			helpContainer.addChild(sHelpIndicator);
			helpContainer.addChild(textWithTwoFont);
		}
		
		private function btnHelpOutHandler(event : MouseEvent) : void
		{
			if (titleBar.contains(helpContainer))
				titleBar.removeChild(helpContainer);
		}
		
		private function btnLessonDropHandler(event:MouseEvent):void
        {
			conn.send("Main", "stopSound");			
			
			if (lessonAndExeciseSeperator == true)
			{
				if (sLessonGame != "")
				{
					btnGame.alpha = 1;
					btnGame.enabled = true; 
					btnGame.addEventListener(MouseEvent.CLICK, GameStart);
				}				
			
				titleBar.removeChild(btnActiveExercise);
				titleBar.removeChild(btnInActiveLesson);
				removeChild(scoreBoard);
				removeChild(exerciseContainer);
			}
			
			titleBar.addChild(btnActiveLesson);
			titleBar.addChild(btnInActiveExercise);
			statusBarTab(numOfLessonTab,"lesson");
			
			if (!contains(lessonContainer))
				addChildAt(lessonContainer,0);
				
			lessonAndExeciseSeperator = false;		
		}
		
		public function btnRepeatLessonHandler(... rest):void
        {
			if (titleBar.contains(dropDown))
			{
				titleBar.removeChild(dropDown);				
			}
			
			lessonAndExeciseSeperator = false;
										
			if (titleBar.contains(summaryTitle))
			{
				titleBar.removeChild(summaryTitle);
				if (sLessonGame != "")
				{
					btnGame.alpha = 1;
					btnGame.enabled = true; 
					btnGame.addEventListener(MouseEvent.CLICK, GameStart);
				}
				clearSummary();
			}
			
			titleBar.addChild(myTextLesson);
			titleBar.addChild(myTextExercise);
			titleBar.addChild(btnActiveLesson);
			titleBar.addChild(btnInActiveExercise);
			
			statusBarBottonLesson = new Array();
			lessonCounter = 0;
					
			statusBarTab(numOfLessonTab,"lesson");
			
			if (!contains(lessonContainer))
				addChildAt(lessonContainer,0);
			
			conn.addEventListener(StatusEvent.STATUS, onStatus);
			conn.send("LESSON", "showLesson",lessonCounter+1, path);// connection for lesson 		
		}
		
		public function btnExcerciseDropHandler(... rest):void
        {			
			// for Game
			btnGame.alpha = 0.5;
			btnGame.enabled = false; 
			btnGame.removeEventListener(MouseEvent.CLICK, GameStart);
			// For Game end
				
			if (titleBar.contains(dropDown))
			{
				titleBar.removeChild(dropDown);				
			}
			
			lessonAndExeciseSeperator = true;
			conn.send("LESSON", "stopSound");

			if (currentLevel == 0)
				currentLevel = 1;
			levelHolder.x = 10;
			levelHolder.y = 685;
			
			if (!levelHolder.contains(levelOne))
			{
				levelOne.x = 110;
				levelOne.y = 10;
				levelOne.addEventListener (MouseEvent.CLICK, levelOneHandler);
				levelHolder.addChild(levelOne);
			}
			if (!levelHolder.contains(levelTwo))
			{
				levelTwo.x = 165;
				levelTwo.y = 10;
				levelTwo.addEventListener (MouseEvent.CLICK, levelTwoHandler);
				levelHolder.addChild(levelTwo);
			}
			
			if (!levelHolder.contains(levelThree))
			{
				levelThree.x = 220;
				levelThree.y = 10;
				levelThree.addEventListener (MouseEvent.CLICK, levelThreeHandler);
				levelHolder.addChild(levelThree);
			}
			if (nActivityLevel == 0 || nActivityLevel == 1)
			{
				levelHolder.removeChild(levelTwo);
				levelHolder.removeChild(levelThree);
			}
			else if (nActivityLevel == 2)
			{
				levelHolder.removeChild(levelThree);				
			}
			
			scoreBoard.addChild(levelHolder);

			if (titleBar.contains(summaryTitle))
			{
				titleBar.removeChild(summaryTitle);
				clearSummary();
			}
					
			if (titleBar.contains(btnActiveLesson))
			{
				titleBar.removeChild(btnActiveLesson);
				titleBar.removeChild(btnInActiveExercise);
				
				removeChild(lessonContainer);
			}
			else
			{
				titleBar.addChild(myTextLesson);
				titleBar.addChild(myTextExercise);
			}
						
			titleBar.addChild(btnInActiveLesson);
			titleBar.addChild(btnActiveExercise);
						
			exerciseContainer.y = 89;
			addChildAt(exerciseContainer,0);
			
			statusBarTab(numOfExerciseTab,"exercise");
			
			if (!contains(scoreBoard))
			{
				scoreContainer.x = 25;
				scoreContainer.y = 45;
				if(!scoreBoard.contains(scoreContainer))
				{
					scoreBoard.addChild(scoreContainer);
					scoreHolderAdder();					
				}
				
				var scoreFormat:TextFormat = new TextFormat();
				scoreFormat.font = "Arial";
				scoreFormat.size = 30;
				scoreFormat.bold = true;
				scoreFormat.color = 0xFFFF00;
				scoreFormat.align = TextFormatAlign.CENTER;
				
				scoreTextField.height = 35;
				scoreTextField.width =  60;
				scoreTextField.border = true;
				scoreTextField.x = 160;
				scoreTextField.y = 305;
				scoreTextField.defaultTextFormat = scoreFormat;
				scoreTextField.selectable = false;
				scoreTextField.text = String(score);
				scoreBoard.addChild(scoreTextField);
				
				btnStarNew.x = 150;
				btnStarNew.y = 500;
				btnStarNew.addEventListener(MouseEvent.CLICK, btnStarNewHandler);
				if (!scoreBoard.contains(btnStarNew))
					scoreBoard.addChild(btnStarNew);
					
				btnPlayagain.x = 150;
				btnPlayagain.y = 570;
				
				if (playAginFlag == false)
				{
					btnPlayagain.alpha = 0.3;
					btnPlayagain.enabled = false; 
				}
				else
				{
					btnPlayagain.alpha = 1;
					btnPlayagain.enabled = true; 
					btnPlayagain.addEventListener(MouseEvent.CLICK, btnPlayagainHandler);
				}
				if (!scoreBoard.contains(btnPlayagain))
					scoreBoard.addChild(btnPlayagain);
					
				btnSummary.x = 150;
				btnSummary.y = 640;
				btnSummary.alpha = 0.3;
				btnSummary.enabled = false; 				
				
				btnSummary.addEventListener(MouseEvent.MOUSE_OVER, overHandler);
				btnSummary.addEventListener(KeyboardEvent.KEY_DOWN, summaryCode);
				
				if (!scoreBoard.contains(btnSummary))
					scoreBoard.addChild(btnSummary);
				
				scoreBoard.x = 900;
				scoreBoard.y = 85;
				addChildAt(scoreBoard,0);
			}
			
			if (exerciseContainer.numChildren == 1 && backgroundAndExeciseSeperator == false)
			{				
				getlevel(currentLevel);				
				startLoad(activityId,"_B");
			}
			else if (summaryCounter == 10)
			{
				repeatExFlag = true;
				btnPlayagain.alpha = 1;
				btnPlayagain.enabled = true; 
				btnPlayagain.addEventListener(MouseEvent.CLICK, btnPlayagainHandler);
								
				btnPlayagainHandler();
			}
			else if (exerciseContainer.numChildren == 1 && backgroundAndExeciseSeperator == true)
			{
				if (currentLevel == 1 || currentLevel == 0)
				{
					levelOneHandler(true)
				}
				else if (currentLevel == 2)
				{
					levelTwoHandler(true);
				}
				else if (currentLevel == 3)
				{
					levelThreeHandler(true);
				}
			}
		}
		
// add the scoreholder may be of any kind to scoreboard

		private function overHandler(event : MouseEvent) : void
		{
			stage.focus = btnSummary;
		}
		
		private function summaryCode(keyEvent:KeyboardEvent) : void
		{
			if (keyEvent.keyCode == 88)
				btnSummaryHandler();
		}
		private function scoreHolderAdder() : void
		{
			var x_pos : int = 130;
			var y_pos : int = 50;
					
			for (var i = 0; i < 10; i++)
			{
				scoreIndicatorHolder = new ScoreIndicatorHolder();
				scoreIndicatorHolder.x = x_pos;
				scoreIndicatorHolder.y = y_pos;
				
				var myFormat:TextFormat = new TextFormat();
				myFormat.font = "Arial";
				myFormat.size = 25;
				myFormat.bold = true;
				myFormat.color = 0x000000;
				myFormat.align = TextFormatAlign.CENTER;
				
				var questionNo:TextField = new TextField();
				questionNo.height = 30;
				questionNo.width = 50;
				questionNo.defaultTextFormat = myFormat;
				questionNo.wordWrap=true;
				questionNo.selectable = false;
				questionNo.text = (i+1);
				questionNo.x = -25;
				questionNo.y = -15;
				scoreIndicatorHolder.addChild(questionNo);
					
				scoreIndicatorHolderArray[i] = scoreIndicatorHolder;
				scoreIndicatorHolderTypeArray[i] = "Holder";
				scoreContainer.addChild(scoreIndicatorHolder);
				if(i == 0)
				{
					y_pos = y_pos + 50;
					x_pos = x_pos - 30;
				}
				else if (i == 2)
				{
					y_pos = y_pos + 50;
					x_pos = 70;
				}
				else if (i == 5)
				{
					y_pos = y_pos + 50;
					x_pos = 40;
				}
				else
				{
					x_pos = x_pos + 60	
				}
			}
		}
		
// btnStarNewHandler start the exercise
		private function btnStarNewHandler(event:MouseEvent):void
        {
			getlevel(currentLevel);
			
			if (questionCounter == 0)
			{
				playAginFlag = true;
				
				while (exerciseContainer.numChildren > 0)
					exerciseContainer.removeChildAt(exerciseContainer.numChildren - 1);
				backgroundAndExeciseSeperator = true;
				startLoad(activityId,"_E");
				
				btnStarNew.alpha = 0.3;
				btnStarNew.enabled = false; 
				btnStarNew.removeEventListener(MouseEvent.CLICK, btnStarNewHandler);
				
				btnPlayagain.alpha = 1;
				btnPlayagain.enabled = true; 
				btnPlayagain.addEventListener(MouseEvent.CLICK, btnPlayagainHandler);
				
				if (levelPreviousSelected == 1)
				{
					levelTwo.removeEventListener (MouseEvent.CLICK, levelTwoHandler);
					levelThree.removeEventListener (MouseEvent.CLICK, levelThreeHandler);
				}
				else if (levelPreviousSelected == 2)
				{
					levelOne.removeEventListener (MouseEvent.CLICK, levelOneHandler);
					levelThree.removeEventListener (MouseEvent.CLICK, levelThreeHandler);
				}
				else if (levelPreviousSelected == 3)
				{
					levelOne.removeEventListener (MouseEvent.CLICK, levelOneHandler);
					levelTwo.removeEventListener (MouseEvent.CLICK, levelTwoHandler);
				}				
			}			
		}
// btnPlayagainHandler handle the playAgain status
		private function btnPlayagainHandler(... rest):void
        {
			numOfExerciseTab = 1;
			
			playAginFlag = false;
			questionCounter = 0;
			summaryCounter = 0;
			btnSummary.alpha = 0.3;
			btnSummary.enabled = false; 
			backgroundAndExeciseSeperator = false;
			statusBarBottonExercise = new Array();
			
			while (scoreContainer.numChildren > 1)
					scoreContainer.removeChildAt(1);
								
			scoreHolderAdder();
				
			conn.send("Main", "stopSound");
			conn.send("Main","destroyActivity");			
			
			while (exerciseContainer.numChildren > 0)
				exerciseContainer.removeChildAt(exerciseContainer.numChildren - 1);
			
			var myFormat:TextFormat = new TextFormat();
			myFormat.font = "Kantipur";
			myFormat.size = 35;
			myFormat.bold = true;
			myFormat.color = 0x000000;
			myFormat.align = TextFormatAlign.JUSTIFY;
			
			if (currentLevel == 1 || currentLevel == 0)
			{
				levelOneHandler();
			}
			else if (currentLevel == 2)
			{
				levelTwoHandler();
			}
			else if (currentLevel == 3)
			{
				levelThreeHandler();
			}
						
			startLoad(activityId,"_B");
			
			btnStarNew.alpha = 1;
			btnStarNew.enabled = true; 
			btnStarNew.addEventListener(MouseEvent.CLICK, btnStarNewHandler);
			
			btnPlayagain.alpha = 0.3;
			btnPlayagain.enabled = false; 
			btnPlayagain.removeEventListener(MouseEvent.CLICK, btnPlayagainHandler);
			btnSummary.removeEventListener(MouseEvent.CLICK, btnSummaryHandler);
			
			statusBarTab(numOfExerciseTab,"exercise");
			
			levelOne.addEventListener (MouseEvent.CLICK, levelOneHandler);
			levelTwo.addEventListener (MouseEvent.CLICK, levelTwoHandler);
			levelThree.addEventListener (MouseEvent.CLICK, levelThreeHandler);
			
			if (repeatExFlag == false)
			{
				var str:String="";
				var my_so:SharedObject;
				var date:Date=new Date();
				
				my_so=SharedObject.getLocal("score");
				str=my_so.data.score;
				
				str+="*"+activityId+"   "+currentLevel+"              "+score+"        "+date.toDateString()+"    "+date.toLocaleTimeString();
				my_so.data.score = str;
				my_so.flush();
				repeatExFlag = false;
			}
			else
			{
				repeatExFlag = false;
			}
			
			score = 0;
			scoreBoard.removeChild(scoreTextField);
			scoreTextField.text = String(score);
			scoreBoard.addChild(scoreTextField);
		}

// btnSummaryHandler handle the summary screen 
		private function btnSummaryHandler(... rest):void
        {
			removeChild(scoreBoard);
			removeChild(exerciseContainer);
			titleBar.removeChild(btnInActiveLesson);
			titleBar.removeChild(btnActiveExercise);
			titleBar.removeChild(myTextLesson);
			titleBar.removeChild(myTextExercise);
						
			if (flagExerciseGame == true)
			{
				btnGame.alpha = 1;
				btnGame.enabled = true; 
				btnGame.addEventListener(MouseEvent.CLICK, GameStart);
			}
			
			while (statusBar.numChildren > 1)
			{
				statusBar.removeChildAt(1);
			}
			
			btnRepeatLesson.x = 350;
			btnRepeatLesson.y = 32;
			btnRepeatLesson.addEventListener(MouseEvent.CLICK, btnRepeatLessonHandler);
			statusBar.addChild(btnRepeatLesson);
			btnRepeatExcercise.x = 850;
			btnRepeatExcercise.y = 32;
			btnRepeatExcercise.addEventListener(MouseEvent.CLICK, btnExcerciseDropHandler);
			statusBar.addChild(btnRepeatExcercise);
			
			summaryTitle.x = 960;
			summaryTitle.y = 43;
			summaryTitle.selectable = false;
			titleBar.addChildAt(summaryTitle,1);
									
			textWithTwoFont = new TextWithTwoFont();
			textWithTwoFont.displayText(sSummary, 150, 1120, 30, null, true);
			textWithTwoFont.x = 5;
			textWithTwoFont.y = 50;
			summaryContainer.addChild(textWithTwoFont)
			
			summaryContainer.x = 15;
			summaryContainer.y = 100;
			addChildAt(summaryContainer,0);
			
			tigerAnimation.x = 660;
			tigerAnimation.y = 400;
			addChildAt(tigerAnimation,0);
			
			scoreHistory.x = 15;
			scoreHistory.y = 380;
			addChildAt(scoreHistory,0);
			
			saveScore(); // store score in shared object
		}
// clearSummary clear the summary screen
		private function clearSummary() : void
		{
			removeChild(summaryContainer);
			removeChild(tigerAnimation);
			removeChild(scoreHistory);
		}
		
/// load the swf for lesson or exercis or exercise introduction
		private function startLoad(swfPath : String,type:String) : void
		{			
			var context:LoaderContext = new LoaderContext();
			context.applicationDomain = new ApplicationDomain();
			
			mLoader = new Loader();
			mLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, onCompleteHandler);
			mLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,onIOError);

			mLoader.load(new URLRequest(path+"Activities/"+swfPath+"/"+swfPath+type+".swf"), context);
		}
		private function onIOError(evt:IOErrorEvent) : void 
		{  
			
        }
		
		public function removepdf() : void 
		{
			if (contains(lFrameContainerL))
			{
				removeChild(lFrameContainerL);
				//lFrameContainerL = null;
			}
			else if (contains(lFrameContainerT))
			{
				removeChild(lFrameContainerT);
				//lFrameContainerT = null;
			}
		}
		
		private function onCompleteHandlerPdfTeacherNotes(loadEvent:Event) : void
		{
			//lFrameContainer = new FrameContainer();
			
			conn.send("PDFCONNECTION", "loadPDF", path+"Activities/"+ activityId + "/TeacherNotes.swf");
						
			lFrameContainerT.addChild(loadEvent.currentTarget.content);
			
			
		}
		
		private function onCompleteHandlerPdfLessonPlan(loadEvent:Event) : void
		{
			//lFrameContainerL = new FrameContainer();
			//addChild(lFrameContainerL);
						
			
			conn.send("PDFCONNECTION", "loadPDF", path+"Activities/"+ activityId + "/LessonPlan.swf");
						
			lFrameContainerL.addChild(loadEvent.currentTarget.content);
			
			
		}		
		
		private function onCompleteHandler(loadEvent:Event) : void
		{			
			if (lessonAndExeciseSeperator == false)// lessonAndExeciseSeperator differentiate lesson and exercie swf
			{
				// for lesson swf
				loadEvent.currentTarget.content.scaleX = 2.178;
				loadEvent.currentTarget.content.scaleY =  1.86;
				loadEvent.currentTarget.content.x = 1;
				loadEvent.currentTarget.content.y = 1;
				loadEvent.currentTarget.content.conn.addEventListener(AsyncErrorEvent.ASYNC_ERROR, function(asevent:AsyncErrorEvent){});// event for conn in lessonStarting
				
				lessonContainer.addChild(loadEvent.currentTarget.content);
				conn.addEventListener(StatusEvent.STATUS, onStatus);
				conn.send("LESSON", "showLesson",1, path);				
			}
			else if (lessonAndExeciseSeperator == true && backgroundAndExeciseSeperator == true )// backgroundAndExeciseSeperator differentiate exercise background with exercise
			{
				// for exercise swf
				loadEvent.currentTarget.content.scaleX = 2.245;
				loadEvent.currentTarget.content.scaleY =  1.862;
				loadEvent.currentTarget.content.conn.addEventListener(AsyncErrorEvent.ASYNC_ERROR, function(asevent:AsyncErrorEvent){});// event for conn in exerciseStarting
				exerciseContainer.addChild(loadEvent.currentTarget.content);
				questionCounter = 1;
				conn.send("Main","listenLevel",currentLevel, path);				
			}
			else 
			{
				// for exercise background
				loadEvent.currentTarget.content.scaleX = 2.2;
				loadEvent.currentTarget.content.scaleY =  2.6;
				loadEvent.currentTarget.content.x = 10;
				loadEvent.currentTarget.content.y = 223;
				exerciseContainer.addChildAt(loadEvent.currentTarget.content,1);
			}
		}
		
/// saveScore save the score in shared object
		public function saveScore():void
		{
			var str:String="";
			var my_so:SharedObject;
			var date:Date=new Date();
			
			var myFormat:TextFormat = new TextFormat();
			myFormat.font = "Arial";
			myFormat.size = 27;
			myFormat.bold = true;
			myFormat.color = 0x000000;
			myFormat.align = TextFormatAlign.JUSTIFY;
			
			my_so=SharedObject.getLocal("score");
			str=my_so.data.score;
			
			str+="*"+activityId+"   "+currentLevel+"              "+score+"        "+date.toDateString()+"    "+date.toLocaleTimeString();
			my_so.data.score=str;
			my_so.flush();// store score			
			
			if (scoreHistory.numChildren > 1)
			{
				var tempChild =scoreHistory.numChildren;
				for (var k = 1 ; k < tempChild; k++)
					scoreHistory.removeChildAt(1);
			}
			
			var lbl : TextField;
			var txt:String=my_so.data.score;					
			var myPattern:RegExp = RegExp(activityId); 				
			var txtArr = txt.split("*"); 				
			var finalArr:Array=new Array();
			
			for(var i=0;i<txtArr.length;i++)
			{					
				if(txtArr[i].match(myPattern))					
					finalArr.push(String(txtArr[i].substr(activityId.length+1,txtArr[i].length)));						
			}
			
			finalArr.reverse();			
			
			if(finalArr.length!=0)
			{
				for(var j=0;j<finalArr.length;j++)
				{
					lbl=new TextField();
					lbl.x = 20;
					lbl.y = 75 + 72*j;
					lbl.defaultTextFormat = myFormat;
					lbl.selectable = false;
					lbl.autoSize=TextFieldAutoSize.LEFT;	
					lbl.text=finalArr[j];
					scoreHistory.addChild(lbl);
					if(j==4)
						break;
				}
			}
			else
			{
				lbl=new TextField();
				lbl.x = 10;
				lbl.y = 20;
				lbl.defaultTextFormat = myFormat;
				lbl.selectable = false;
				lbl.autoSize=TextFieldAutoSize.LEFT;	
				lbl.text="No Record Found";
				addChild(lbl);
			}
		}		
	}
}