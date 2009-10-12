package
{
	import flash.display.*;
	import flash.media.*;
	import flash.text.*;
	import flash.events.*;
	import flash.utils.*;
	import flash.net.*
	import fl.transitions.Tween;
	import fl.transitions.easing.*;
	import fl.transitions.TweenEvent;
	import fl.controls.*;
	
	public class WeekFlap extends MovieClip
	{
		var weekFlap : week_flap = new week_flap();
		
		var weekcount : Array;
		var weekbutton : Array = new Array();
		
		var buttonClassLabel : Array = ["!", "@", "#", "$", "%", "^", "&", "*", "(", "!)", "!!", "!@", "!#", "!$", "!%", "!^", "!&", "!*", "!(", "@)", "@!", "@@", "@#", "@$", "@%", "@^", "@&", "@*", "@(", "#)", "#!", "#@"];
		var nepaliFormat : TextFormat = new TextFormat();
		
		var buttonWeekSelectedPrevious : Button;
		var flagForSelection : int = 100;
		
		var xmlReaderTemp : XMLReader;
		
		function WeekFlap(): void
		{
			weekFlap.x = 680;
			weekFlap.y = 220;
						
			addChild(weekFlap);			
		}
				
		public function weekAddition(xmlReader : XMLReader, weekno : Array)
		{
			xmlReaderTemp = xmlReader;			
			
			var tempButton : Button = new Button();
			var my_so:SharedObject = SharedObject.getLocal("historyWeek");
			
			var f2:Font = new Kantipur() as Font;
			nepaliFormat.font = f2.fontName;			
			
			nepaliFormat.size = 30;
			nepaliFormat.color = 0xFFFF60;
			nepaliFormat.bold = true;
			
			if ( weekFlap.numChildren > 1)
			{
				weekdeletion();
				flagForSelection = 100;
			}			
			
			weekcount = weekno;
			
			var x_pos : int = 10;
			var y_pos : int = 82;
			var counter : int;
			
			for (var i = 0; i < weekcount.length ; i++)
			{
				if (weekcount[i] == true)
				{
					var buttonWeek : Button = new Button();
									
					buttonWeek.x = x_pos;
					buttonWeek.y = y_pos;
					buttonWeek.height = 35;
					buttonWeek.width = 60;
					buttonWeek.setStyle("embedFonts", true);
					buttonWeek.setStyle("textFormat", nepaliFormat);
					buttonWeek.setStyle("disabledTextFormat", nepaliFormat);
					buttonWeek.label = buttonClassLabel[i];
					buttonWeek.addEventListener (MouseEvent.CLICK, buttonClickHandler)
					
					if (counter == 0 && flagForSelection == 100)
						buttonWeekSelectedPrevious = buttonWeek;
					else if (flagForSelection == counter)
					{
						buttonWeekSelectedPrevious = buttonWeek;
						buttonWeek.enabled = false;
					}
					
					weekFlap.addChild(buttonWeek);
					
					weekbutton[counter] = buttonWeek;					
										
					if (counter == my_so.data.historyWeek)
					{
						buttonWeek.enabled = false;
						buttonWeekSelectedPrevious = buttonWeek;
						xmlReaderTemp.weekActivitySelector(counter);
					}
					counter++;
				}
				if (((i+1) % 4) == 0 && i > 1)
				{
					y_pos = y_pos + 70;
					x_pos = 10;
				}
				else
					x_pos = x_pos + 72;
			}
		}
		
		public function weekdeletion() : void
		{
			var buttonWeek : Button;
			var tempChildren : int = weekFlap.numChildren;
			for (var i = 0; i < tempChildren-1; i++)
			{
				buttonWeek = weekbutton[i];
				weekFlap.removeChild(buttonWeek);
			}		
		}
		
		private function buttonClickHandler(event : MouseEvent) : void
		{
			var tempButton : Button =  event.target as Button;
			var my_so:SharedObject = SharedObject.getLocal("historyWeek");
			
			buttonWeekSelectedPrevious.enabled = true;
			tempButton.enabled = false;
			for (var i = 0; i < weekbutton.length; i++)
			{
				if (weekbutton[i] == tempButton)
				{
					flagForSelection = i;
					my_so.data.historyWeek = i;
					my_so.flush();
				}
			}
			buttonWeekSelectedPrevious = tempButton;
			
			xmlReaderTemp.weekActivitySelector(flagForSelection);
		}
	}
}