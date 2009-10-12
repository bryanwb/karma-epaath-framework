package
{
	import flash.display.*;
	import flash.events.*;
	import flash.net.*;
	import fl.events.*;
	import flash.ui.*;
	import flash.text.*;
	import flash.printing.*;
	import flash.geom.*;
	
	public dynamic class PDFLoader extends MovieClip
	{
		public var pdfUrl:String; 
		private var pdf = null;
		var conn : LocalConnection;
		private var mcHelpWindow = null;
		
		public function PDFLoader()
		{
			conn = new LocalConnection();
			
            try 
			{
                conn.connect("PDFCONNECTION");// for activity
            } 
			catch (error:ArgumentError)
			{
                trace(error);
		    }
			
			conn.addEventListener(AsyncErrorEvent.ASYNC_ERROR, onAsync);
			conn.addEventListener(StatusEvent.STATUS, onStatus);
			conn.client = this;
			
			this.spPdfContainer.addEventListener(KeyboardEvent.KEY_UP,this.spPdfContainerKEY_UP);
		}
		
		private function onAsync(asevent:AsyncErrorEvent):void 
		{
			
		}
		
		private function onStatus(event:StatusEvent):void 
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
		
		public function loadPDF(fileName:String)
		{
			//this.pdfUrl = "Activities/ActivityName/" + fileName;
			this.pdfUrl = fileName;
			
			var urlReq:URLRequest = new URLRequest(this.pdfUrl);
			var ldr:Loader = new Loader();
			ldr.contentLoaderInfo.addEventListener(Event.COMPLETE,this.pdfLoaded);
			ldr.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR ,this.pdfIO_ERROR);
			ldr.load(urlReq);
		}
		
		private function pdfLoaded(evt:Event)
		{
			this.pdf = evt.target.content;

			this.pdf.gotoAndStop(1);
			this.mcToolBar.txtPageNumber.text = "1";

			this.mcToolBar.txtTotalPages.text = "/ " + this.pdf.totalFrames.toString();
			
			this.pdf.scaleX = 3;
			this.pdf.scaleY = 3;
			
			this.spPdfContainer.source = this.pdf;
			this.stage.focus = this.spPdfContainer;
		}
		
		private function pdfIO_ERROR(evt:IOErrorEvent)
		{
			var format:TextFormat = new TextFormat();
            format.color = 0xFF0000;
            format.size = 60;

			var txtMessage = new TextField();
			txtMessage.defaultTextFormat = format;
			txtMessage.text = "File not found";
			txtMessage.autoSize = TextFieldAutoSize.CENTER;
			txtMessage.selectable = false;
			txtMessage.x = (this.width/2) - (txtMessage.width/2);
			txtMessage.y = 300;
			this.addChild(txtMessage);
		}
		
		private function spPdfContainerKEY_UP(evt:KeyboardEvent)
		{
			if(evt.keyCode == Keyboard.DOWN)
				this.spPdfContainer.verticalScrollPosition += 200;
			else if(evt.keyCode == Keyboard.UP)
				this.spPdfContainer.verticalScrollPosition -= 200;
			else if(evt.keyCode == Keyboard.RIGHT)
				this.spPdfContainer.horizontalScrollPosition += 200;
			else if(evt.keyCode == Keyboard.LEFT)
				this.spPdfContainer.horizontalScrollPosition -= 200;
		}
		
		private function initToolBar()
		{
			this.mcToolBar.btnNextPage.addEventListener(MouseEvent.CLICK,btnNextPageCLICK);
			this.mcToolBar.btnPrevoiusPage.addEventListener(MouseEvent.CLICK,btnPreviousPageCLICK);
			this.mcToolBar.txtPageNumber.addEventListener(KeyboardEvent.KEY_UP,txtPageNumberKEY_UP);
			this.mcToolBar.btnClose.addEventListener(MouseEvent.CLICK,btnCloseCLICK);
			this.mcToolBar.btnZoomIn.addEventListener(MouseEvent.CLICK,btnZoomInCLICK);
			this.mcToolBar.btnZoomOut.addEventListener(MouseEvent.CLICK,btnZoomOutCLICK);
			this.mcToolBar.btnHelp.addEventListener(MouseEvent.CLICK,btnHelpCLICK);
			this.mcToolBar.btnPrint.addEventListener(MouseEvent.CLICK,btnPrintCLICK);
		}
		
		private function btnPrintCLICK(evt:MouseEvent)
		{
			if(this.pdf != null)
			{
				var printJob = new PrintJob();
	            if(printJob.start()) 
				{                
					if(printJob.orientation == PrintJobOrientation.LANDSCAPE) 
					{    
						throw new Error("Without embedding fonts you must print one sheet per page with an orientation of portrait.");
					}
					
					var w = this.pdf.width;
					var h = this.pdf.height;
					
					this.pdf.height = printJob.pageHeight;
					this.pdf.width = printJob.pageWidth;
					
					try 
					{
						for(var i=1;i<=this.pdf.totalFrames;i++)
						{
							printJob.addPage(this.pdf,new Rectangle(0,0,this.pdf.width,this.pdf.height),new PrintJobOptions(false),i);
						}
						
						printJob.send();
					}
					catch(e:Error) 
					{
						trace("Printing Error: ",e.toString());
					}
				
					this.pdf.width = w;
					this.pdf.height = h;
				}
			}
		}
		
		private function btnHelpCLICK(evt:MouseEvent)
		{
			if(this.mcHelpWindow == null)
			{
				this.mcHelpWindow = new HelpWindow();
				this.mcHelpWindow.btnHelpClose.addEventListener(MouseEvent.CLICK,btnHelpCloseCLICK);
	
				this.mcHelpWindow.x = 1200 - 20;
				this.mcHelpWindow.y = 95;
				
				this.addChild(this.mcHelpWindow);
			}
		}

		private function btnHelpCloseCLICK(evt:MouseEvent)
		{
			if(this.mcHelpWindow != null)
			{
				this.mcHelpWindow.btnHelpClose.removeEventListener(MouseEvent.CLICK,btnHelpCloseCLICK);
				this.removeChild(this.mcHelpWindow);
				this.mcHelpWindow = null;
			}
		}
		
		private function btnNextPageCLICK(evt:MouseEvent)
		{
			this.pdf.nextFrame();
			this.mcToolBar.txtPageNumber.text = this.pdf.currentFrame.toString();
		}

		private function btnPreviousPageCLICK(evt:MouseEvent)
		{
			this.pdf.prevFrame();
			this.mcToolBar.txtPageNumber.text = this.pdf.currentFrame.toString();
		}
		
		private function txtPageNumberKEY_UP(evt:KeyboardEvent)
		{
			if(evt.keyCode == Keyboard.ENTER)
			{
				var pageNumber:int = parseInt(this.mcToolBar.txtPageNumber.text);
				
				if(pageNumber > 0)
				{
					if(this.pdf != null)
						this.pdf.gotoAndStop(pageNumber);
				}
			}
		}
		
		private function btnCloseCLICK(evt:MouseEvent)
		{
			//this.mcToolBar.btnClose.removeEventListener(MouseEvent.CLICK,btnCloseCLICK);
			//this.spPdfContainer.source = null;
			//this.pdf = null;
			conn.send("FRAMEWORK", "removepdf");
			conn.close();
		}
		
			
		private function btnZoomInCLICK(evt:MouseEvent)
		{
			if(this.pdf.scaleY + 0.5 < 10)
			{
				this.pdf.scaleX = this.pdf.scaleX + 0.5;
				this.pdf.scaleY = this.pdf.scaleY + 0.5;
				this.spPdfContainer.update();
			}
		}

		private function btnZoomOutCLICK(evt:MouseEvent)
		{
			if(this.pdf.scaleY - 0.5 > 0)
			{
				this.pdf.scaleX = this.pdf.scaleX - 0.5;
				this.pdf.scaleY = this.pdf.scaleY - 0.5;
				this.spPdfContainer.update();
			}
		}
	}
}