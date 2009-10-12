package
{
	import flash.display.*;
	import flash.media.*;
	import flash.text.*;
	import flash.events.*;
	import flash.utils.*;
	import flash.net.*
	import fl.controls.*;
	import flash.utils.getDefinitionByName;	
	
	public class ClassButton extends MovieClip
	{
		var weekFlap : WeekFlap = new WeekFlap();
		var logoTemp : Logo;
		
		var buttonClassLabel : Array = 	["@","#","^"];		/*["!", "@", "#", "$", "%", "^", "&", "*", "(", "!)"];*/
		var buttonSubjectLabel : Array = ["ul0ft", "g]kFnL", "English"]; 
		
		var buttonClass : Button;
		var buttonSubject : Button;
		
		var buttonClassSelected : String = null;
		var buttonSubjectSelected : String = null;
		
		var buttonClassSelectedPrevious : Button;
		var buttonSubjectSelectedPrevios : Button;
		
		var nepaliFormat : TextFormat = new TextFormat();
		var englishFormat : TextFormat = new TextFormat();
		
		var xmlReader : XMLReader;
					
		function ClassButton(logo : Logo) : void 
		{
			logoTemp = logo;
			addChild(weekFlap);
			
			var my_so:SharedObject = SharedObject.getLocal("history");
			
			var f2:Font = new Kantipur() as Font;
						
			nepaliFormat.font = f2.fontName;
			nepaliFormat.size = 45;
			nepaliFormat.color = 0xFFFFFF;
			nepaliFormat.bold = true;
			
			englishFormat.font = "Arial";
			
			englishFormat.size = 25;
			englishFormat.color = 0xFFFFFF;
			englishFormat.bold = true;
									
			var x_pos : int = 55;
			var y_pos : int = 165;
			var tempArray : Array = String(my_so.data.history).split(" ");
						
			for (var i = 0; i < buttonClassLabel.length ; i++)
			{
				buttonClass = new Button();
				buttonClass.x = x_pos;
				buttonClass.y = y_pos;
				buttonClass.label = buttonClassLabel[i];
				buttonClass.name = buttonClassLabel[i];
				
				buttonClass.setStyle("embedFonts", true);
				buttonClass.setStyle("textFormat", nepaliFormat);
				buttonClass.setStyle("disabledTextFormat", nepaliFormat);				
				
				buttonClass.setSize(80,60);
				
				buttonClass.addEventListener (MouseEvent.CLICK, buttonClickHandler)
				buttonClass.useHandCursor = true;
				
				addChild(buttonClass);
				x_pos = x_pos + 90;
				
				if (buttonClass.label == tempArray[0])
				{
					buttonClass.enabled = false;
					buttonClassSelected = buttonClass.label;
					buttonClassSelectedPrevious = Button(buttonClass);
					buttonset();
				}
				else if (tempArray.length == 1)
				{
					buttonClassSelectedPrevious = Button(buttonClass);					
				}
			}
			
			x_pos = 1000;
			y_pos = 165;
			
			for (i = 0; i < buttonSubjectLabel.length ; i++)
			{
				buttonSubject = new Button();
				buttonSubject.addEventListener (MouseEvent.CLICK, buttonClickHandler)
								
				if (i < 2)
				{
					buttonSubject.setStyle("embedFonts", true);
					buttonSubject.setStyle("textFormat", nepaliFormat);
					buttonSubject.setStyle("disabledTextFormat", nepaliFormat);
				}
				else
				{
					buttonSubject.setStyle("embedFonts", true);
					buttonSubject.setStyle("textFormat", englishFormat);
					buttonSubject.setStyle("disabledTextFormat", englishFormat);
				}
				
				buttonSubject.x = x_pos;
				buttonSubject.y = y_pos;
				buttonSubject.label = buttonSubjectLabel[i];
				buttonSubject.name = buttonSubjectLabel[i];
				
				buttonSubject.setSize(180,60);
				buttonSubject.useHandCursor = true;
				
				addChild (buttonSubject);
				y_pos = y_pos + 70;
				
				if (buttonSubject.label == tempArray[1])
				{
					buttonSubject.enabled = false;
					buttonSubjectSelected = buttonSubject.label;
					buttonSubjectSelectedPrevios = Button(buttonSubject);
					buttonset();
				}
				else if (tempArray.length == 1)
				{
					buttonSubjectSelectedPrevios = Button(buttonSubject);
				}
			}			
		}
		
		private function buttonset() : void
		{
			xmlReader = new XMLReader(logoTemp, weekFlap, buttonClassSelected, buttonSubjectSelected);
			xmlReader.clearLogoForXML();
			addChild(xmlReader);
		}
		
		private function buttonClickHandler(event : MouseEvent) : void
		{
			var tempButton : Button =  event.target as Button;
			var my_so:SharedObject;
			my_so = SharedObject.getLocal("history");			
			
			if (tempButton.label.length <= 2 && tempButton.label.length > 0)
			{
				buttonClassSelectedPrevious.enabled = true;
				buttonClassSelectedPrevious = Button(event.target);
				tempButton.enabled = false;
				
				buttonClassSelected = tempButton.label;
				
				if ( tempButton.label == "^")
				{
					Button(getChildByName("g]kFnL")).buttonMode = false;
					Button(getChildByName("g]kFnL")).enabled = false;
					Button(getChildByName("g]kFnL")).alpha = 0.3;
					
					if (buttonSubjectSelectedPrevios == Button(getChildByName("g]kFnL")))
					{
						buttonSubjectSelectedPrevios = Button(getChildByName(buttonSubjectLabel[0]));
						buttonSubjectSelectedPrevios.enabled = false;
						
						buttonSubjectSelected = buttonSubjectSelectedPrevios.label;
					}
				}
				else if (Button(getChildByName("g]kFnL")).buttonMode == false)
				{
					Button(getChildByName("g]kFnL")).buttonMode = true;
					Button(getChildByName("g]kFnL")).enabled = true;
					Button(getChildByName("g]kFnL")).alpha = 1;
				}
				
				if (buttonSubjectSelected != null)
				{
					xmlReader = new XMLReader(logoTemp, weekFlap, buttonClassSelected, buttonSubjectSelected);
					xmlReader.clearLogoForXML();
					addChild(xmlReader);
					
					my_so.data.history = buttonClassSelected + " " + buttonSubjectSelected;
					my_so.flush();
					var my_soweek : SharedObject = SharedObject.getLocal("historyWeek");
					my_soweek.data.historyWeek = 0;
					my_soweek.flush();
				}
			}
			else if (tempButton.label.length > 2)
			{
				buttonSubjectSelectedPrevios.enabled = true;
				buttonSubjectSelectedPrevios = Button(event.target);
				tempButton.enabled = false;
				
				buttonSubjectSelected = tempButton.label;
				
				if (buttonClassSelected != null)
				{
					xmlReader = new XMLReader(logoTemp, weekFlap, buttonClassSelected, buttonSubjectSelected);
					xmlReader.clearLogoForXML();
					addChild(xmlReader);
					
					my_so.data.history = buttonClassSelected + " " + buttonSubjectSelected;
					//my_so.data.history = "@" + " " + buttonSubjectSelected;
					my_so.flush();
					var my_soweek2 : SharedObject = SharedObject.getLocal("historyWeek");
					my_soweek2.data.historyWeek = 0;
					my_soweek2.flush();
				}
			}
		}
	}
}