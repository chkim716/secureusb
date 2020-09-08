//------------------------------------------------------------------------------
//
//   Copyright 2011 
//   Saferzone All rights reserved. 
//
//------------------------------------------------------------------------------

package com.saferzone.defcon4.susbma.usbmanage.view
{
	import com.adobe.serialization.json.JSON;
	import com.adobe.serialization.json.JSONEncoder;
	import com.saferzone.defcon4.common.DmosFramework;
	import com.saferzone.defcon4.susbma.usbmanage.ApplicationFacade;
	import com.saferzone.defcon4.susbma.usbmanage.view.comp.FileExportWindow;
	
	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	import flash.net.navigateToURL;
	
	import mx.collections.IList;
	
	import org.puremvc.as3.multicore.interfaces.IMediator;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;
	
	import spark.components.gridClasses.GridColumn;
	
	/**
	 *
	 * SendMsgSelectWindowMediator
	 *
	 * @version 0.001
	 * @author CyD
	 * @since Aug 6, 2011
	 *
	 * @langversion 3.0
	 * @playerversion Flash 10
	 * @playerversion AIR 2.6
	 * @productversion Flex 4.5
	 *
	 */
	public class FileExportWindowMediator extends Mediator implements IMediator
	{
		
		//------------------------------------------------------------------------------
		//
		// Constants 
		//
		//------------------------------------------------------------------------------
		
		public static const NAME:String = "FileExportWindowMediator";
		
		//------------------------------------------------------------------------------
		//
		// Constructor 
		//
		//------------------------------------------------------------------------------
		
		public function FileExportWindowMediator(viewComponent:FileExportWindow)
		{
			super(NAME, viewComponent);
		}
		
		
		//------------------------------------------------------------------------------
		//
		// Properties #public 
		//
		//------------------------------------------------------------------------------
		
		public function get fileExportWindow():FileExportWindow
		{
			return viewComponent as FileExportWindow;
		}
		
		
		private var parentWindow:D4_SUSBMA_USBMANAGE;
		
		public function set setParentWindow(_parentWindow:D4_SUSBMA_USBMANAGE):void
		{
			parentWindow = _parentWindow;
		}

		
		//------------------------------------------------------------------------------
		//
		// Methods 
		//
		//------------------------------------------------------------------------------
		
		//--------------------------------------
		// Event Handlers 
		//--------------------------------------
		
		protected function exportExcel_clickHandler(event:MouseEvent):void
		{
			exportFileExcel();
			removeFileExportPopup();
		}
		
		protected function exportCSV_clickHandler(event:MouseEvent):void
		{
			exportFileCSV();
			removeFileExportPopup();
		}
		
		private function removeFileExportPopup():void
		{
			parentWindow.fileExportPop.displayPopUp = false;
			parentWindow.fileExportPop.x = 0;
		}
		
		private function exportFileExcel():void
		{
			var request:URLRequest = new URLRequest("/usbMasterExportExcel.htm");
			request.method = URLRequestMethod.POST;
			
			var params:URLVariables = new URLVariables();
			var columns:IList = parentWindow.usbDG.columns;
			var column:GridColumn;
			var titles:Array = [];
			var props:Array = [];
			var length:int = columns.length;
			
			//20130321 김정욱 엑셀저장 - START
			var nowDate:Date = new Date();
			var monthStr:String = ( (nowDate.month+1)<10 ? "0" : "") +  (nowDate.month+1);
			var dayStr:String = (nowDate.date<10 ? "0" : "") + nowDate.date;
			var fileName:String;
			
			for(var i:int = 0; i < length; i++)
			{
				column = columns.getItemAt(i) as GridColumn;
				
				//				if(excelExcludedColumns.indexOf(column.dataField) > -1)
				//					continue;
				//20130305 김정욱 엑셀 출력 시  column중 dummy column으로 인해 저장 시 에러 수정 START
				if(column.dataField == parentWindow.usbDG.FIX_LAST_DATA) continue;
				//20130305 김정욱 엑셀 출력 시  column중 dummy column으로 인해 저장 시 에러 수정 END
				
				titles.push(column.headerText);
				
				//20130318 김정욱 엑셀 출력 시  labkel function이 적용 될 수 있도록 새로운 컬럼을 추가 START
				props.push(column.dataField);
				//20130318 김정욱 엑셀 출력 시  labkel function이 적용 될 수 있도록 새로운 컬럼을 추가 END
			}
			
			params.titleName = titles;
			params.titleProperty = props;
			params.searchVo = com.adobe.serialization.json.JSON.encode(ApplicationFacade(facade).searchVO);
			
			fileName = DmosFramework.getInstance().SNL("PROGRAMTITLE_D4_SUSBMA_USBMANAGE") + "_" + nowDate.fullYear + monthStr + dayStr + ".xls";
			params.fileName = fileName;
			//20130321 김정욱 엑셀저장 - END
			request.data = params;
			navigateToURL(request, "_self");
		}
		
		private function exportFileCSV():void
		{
			var nowDate:Date = new Date();
			var monthStr:String = ( (nowDate.month+1)<10 ? "0" : "") +  (nowDate.month+1);
			var dayStr:String = (nowDate.date<10 ? "0" : "") + nowDate.date;
			var fileName:String;
			fileName = DmosFramework.getInstance().SNL("PROGRAMTITLE_D4_SUSBMA_USBMANAGE") + "_" + nowDate.fullYear + monthStr + dayStr + ".csv";
			
			parentWindow.usbDG.saveToCSV(fileName);
		}
		//--------------------------------------
		// Overriden Methods 
		//--------------------------------------
		
		/**
		 *
		 * @return Mediator가 받을 Notification의 목록.
		 * @private
		 *
		 */
		override public function listNotificationInterests():Array
		{
			return [
			];
		}
		
		/**
		 *
		 * 받은 Notification에 따른 핸들러.
		 * @param notification
		 * @private
		 *
		 */
		override public function handleNotification(notification:INotification):void
		{
			switch(notification.getName())
			{
			}
		}
		
		/**
		 *
		 *
		 */
		override public function onRegister():void
		{
			fileExportWindow.exportExcel.addEventListener(MouseEvent.CLICK, exportExcel_clickHandler);
			fileExportWindow.exportCSV.addEventListener(MouseEvent.CLICK, exportCSV_clickHandler);
			
		}
		
		/**
		 *
		 *
		 */
		override public function onRemove():void
		{
			fileExportWindow.exportExcel.removeEventListener(MouseEvent.CLICK, exportExcel_clickHandler);
			fileExportWindow.exportCSV.removeEventListener(MouseEvent.CLICK, exportCSV_clickHandler);
		}
	}
}
