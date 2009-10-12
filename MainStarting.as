package
{
	import flash.display.*;
	import flash.media.*;
	import flash.text.*;
	import flash.events.*;
	import flash.utils.*;
	import flash.net.*
	import flash.filters.GlowFilter;
		
	public class MainStarting extends MovieClip
	{
		var menuStageOfficeName : MenuStageOfficeName;
		var oleLogo : ole_logo_symbol = new ole_logo_symbol();
		var firstObject : FirstObject = new FirstObject();
		
		public function MainStarting() : void
		{
			var closeFireFox : CloseFireFox = new CloseFireFox();
			var logo : Logo = new Logo();
			var classButton : ClassButton = new ClassButton(logo);
			
						
			addChild(firstObject);
			addChild(logo);
			addChild(classButton);
			
			closeFireFox.y = 15;
			closeFireFox.x = 1125;
			addChild(closeFireFox);
			
			oleLogo.x = 60;
			oleLogo.y = 45;
			
			var glow:GlowFilter = new GlowFilter();
			glow.color = 0xFFFFFF;
			glow.blurX = 5;
			glow.blurY = 5;
			
			oleLogo.filters = [glow];
			oleLogo.buttonMode = true;
			oleLogo.addEventListener(MouseEvent.CLICK, clickHandler);
			addChild(oleLogo);			
			
		}	
		
		private function clickHandler(event : MouseEvent) : void
		{
			event.target.removeEventListener(MouseEvent.CLICK, clickHandler);
			event.target.addEventListener(MouseEvent.CLICK, removeClickHandler);
			//firstObject.addEventListener(MouseEvent.CLICK, removeClickHandler);
			menuStageOfficeName = new MenuStageOfficeName();
						
			var btnClose : BtnCloseClose = new BtnCloseClose();
			btnClose.x = 370;
			btnClose.y = -130;
			btnClose.addEventListener(MouseEvent.CLICK, removeClickHandler);
			menuStageOfficeName.addChild(btnClose);
			
			menuStageOfficeName.x = 460;
			menuStageOfficeName.y = 330;
			addChild(menuStageOfficeName);			
		}
		
		private function removeClickHandler(event : MouseEvent) : void
		{
			oleLogo.addEventListener(MouseEvent.CLICK, clickHandler);
			if(contains(menuStageOfficeName))
			 	removeChild(menuStageOfficeName);
		}
	}
}