package 
{
    import flash.display.*;
	import flash.media.*;
	import flash.text.*;
	import flash.utils.*;	
	import flash.events.MouseEvent;

	public class TextWithTwoFont extends flash.display.MovieClip
    {
		var myFormat : TextFormat = new TextFormat();
		var myText : TextField = new TextField();
			
		public function TextWithTwoFont() : void
		{
			
		}
		
		public function displayText(texttoAdd : String,textBoxHeight : int, textBoxWidth : int, fontSize : int,myFormat1 : TextFormat, scroll : Boolean)
		{
			if (myFormat1 != null)
				myFormat = myFormat1;			
			
			if (texttoAdd.length == 0)
				return;
			var FormatOne : Array = new Array();
			var FormatTwo : Array = new Array();
			var characterCounter : int;
			var temp : Array = new Array();
			
			if (myFormat1 == null)
			{
				myFormat.bold = true;				
				myFormat.align = TextFormatAlign.JUSTIFY;
			}
					
			myText.height = textBoxHeight;
			myText.width = textBoxWidth;
			myText.wordWrap = true;
			myText.embedFonts = true;
			myText.defaultTextFormat = myFormat;
			myText.selectable = false;	
						
			FormatOne = texttoAdd.split("*e*");			
			
			for (var i = 0; i < FormatOne.length ; i++)
			{
				FormatTwo = FormatOne[i].split("*n*");				
				
				for (var j = 0; j < FormatTwo.length; j++)
				{					
					if ((j%2) == 0 && FormatTwo.length > 1)
					{						
						myFormat.font = "Arial";
						myFormat.size = fontSize - 10;
						myText.appendText(FormatTwo[j]);
						
						if (FormatTwo[j].length > 0)
							myText.setTextFormat(myFormat,characterCounter,characterCounter+FormatTwo[j].length);						
						characterCounter = characterCounter + FormatTwo[j].length ;
					}
					else
					{
						myFormat.font = "Kantipur";
						myFormat.size = fontSize;
						
						myText.appendText(FormatTwo[j]);
						if (FormatTwo[j].length > 0)
							myText.setTextFormat(myFormat,characterCounter,characterCounter + FormatTwo[j].length);
						
						characterCounter = characterCounter + FormatTwo[j].length;						
					}
					
					temp = FormatTwo[j].split("\n")
					trace(temp.length);
					if (temp.length > 1)
						characterCounter = characterCounter - (temp.length -1);
				}											   
			}
			addChild(myText);
			
			if (scroll)
			{
				var btnScrollUp : BtnScrollUp = new BtnScrollUp();
				btnScrollUp.x = textBoxWidth + 2;
				btnScrollUp.y = 10;
				btnScrollUp.addEventListener(MouseEvent.CLICK, scrollUpHandler);
				
				var btnScrollDown : BtnScrollDown = new BtnScrollDown();
				btnScrollDown.x = textBoxWidth + 2;
				btnScrollDown.y = textBoxHeight - 25;
				btnScrollDown.addEventListener(MouseEvent.CLICK, scrollDownHandler);
				
				addChild(btnScrollUp);
				addChild(btnScrollDown);
			}
		}
		
		function scrollUpHandler(Event : MouseEvent) : void 
		{  
			 myText.scrollV --;  
		}  
		   
		function scrollDownHandler(Event : MouseEvent) : void 
		{  
			myText.scrollV ++;  
		}  
	}
}