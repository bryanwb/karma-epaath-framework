package
{
	import flash.display.*;
	import flash.media.*;
	import flash.text.*;
	import flash.events.*;
	import flash.utils.*;
	import flash.net.*
	import fl.controls.*;
	
	public class ErrorBoxHandler extends MovieClip
	{
		var errorBox : ErrorBox = new ErrorBox();
		
		public function ErrorBoxHandler(stringMessage : String) : void 
		{
			var errorMessagebox : TextField = new TextField();
			
			var messageFormat:TextFormat = new TextFormat();
			var messageButtonFormat:TextFormat = new TextFormat();
			
			var buttonOK : Button = new Button();
			
			messageFormat.font = "Arial";
			messageFormat.size = 20;
			messageFormat.color = 0xFFFFFF;
			messageFormat.bold = true;
			
			messageButtonFormat.font = "Arial";
			messageButtonFormat.size = 15;
			messageButtonFormat.color = 0xFFFFFF;
			messageButtonFormat.bold = true;	
			
			errorMessagebox.x = 345;
			errorMessagebox.y = 400
			errorMessagebox.defaultTextFormat = messageFormat;
			errorMessagebox.width = 270;
			errorMessagebox.height = 30;
			errorMessagebox.text = stringMessage;
			
			buttonOK.x =430;
			buttonOK.y=460;
			buttonOK.alpha = 0.75;
			buttonOK.useHandCursor = true;
			buttonOK.height = 35;
			buttonOK.setStyle("textFormat", messageButtonFormat);
			buttonOK.label = "OK"
			buttonOK.addEventListener (MouseEvent.CLICK, buttonClickHandler)
			
			errorBox.addChild(buttonOK);
			errorBox.addChild(errorMessagebox);
			addChild(errorBox);
		}	
		private function buttonClickHandler(event : MouseEvent) : void
		{
			removeChild(errorBox);
		}
	}
}