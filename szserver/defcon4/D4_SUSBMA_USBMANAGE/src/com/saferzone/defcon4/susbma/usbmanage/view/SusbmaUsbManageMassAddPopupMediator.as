//------------------------------------------------------------------------------
//
//   Copyright 2011 
//   Saferzone All rights reserved. 
//
//------------------------------------------------------------------------------

package com.saferzone.defcon4.susbma.usbmanage.view
{
	import com.saferzone.defcon4.common.DmosFramework;
	import com.saferzone.defcon4.common.SZPopupMediator;
	import com.saferzone.defcon4.susbma.usbmanage.consts.LocalConst;
	import com.saferzone.defcon4.susbma.usbmanage.view.comp.SusbmaUsbManageMassAddPopup;
	
	import flash.display.Sprite;
	import flash.events.DataEvent;
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.events.MouseEvent;
	import flash.events.SecurityErrorEvent;
	import flash.external.ExternalInterface;
	import flash.net.FileFilter;
	import flash.net.FileReference;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	import flash.net.navigateToURL;
	
	import mx.collections.IList;
	import mx.controls.Alert;
	import mx.core.Application;
	import mx.events.CloseEvent;
	import mx.managers.PopUpManager;
	
	import org.alivepdf.visibility.Visibility;
	import org.puremvc.as3.multicore.interfaces.INotification;

	
	public class SusbmaUsbManageMassAddPopupMediator extends SZPopupMediator
	{
		
		public static const NAME:String = 'SusbmaUsbManageMassAddPopupMediator';
		private var fileRef:FileReference;
		private var tempFileName:String = '';
		private var isClose:Boolean = false;
		
		public function SusbmaUsbManageMassAddPopupMediator(viewComponent:Object)
		{
			super(NAME, viewComponent);
		}
		
		public function get myWindow():SusbmaUsbManageMassAddPopup
		{
			return viewComponent as SusbmaUsbManageMassAddPopup;
		}
		
		protected function okClickEventHandler(event:MouseEvent):void
		{
			if(myWindow.fileName.text == '' || myWindow.fileName.text.length == 0)
			{
				Alert.show(DmosFramework.getInstance().SNL('SC_FILE_NOT_SELECTED'), DmosFramework.getInstance().SNL("PROGRAMTITLE_D4_SUSBMA_USBMANAGE"));
				return;
			}
			
			
			sendNotification(LocalConst.SUSBMA_USBMANAGE_MASS_REGISTER, tempFileName);
			
		}

		protected function cancelClickEventHandler(event:MouseEvent):void
		{
			closeMyWindow();
		}
		
		private function closeHandler(event:Event):void
		{
			closeMyWindow();
		}

		override public function listNotificationInterests():Array
		{
			return [
				LocalConst.SUSBMA_USBMANAGE_MASS_REGISTER_SUCCESS,
				LocalConst.SUSBMA_USBMANAGE_MASS_REGISTER_FAIL
			];
		}

		override public function handleNotification(notification:INotification):void
		{
			switch(notification.getName()){
				case LocalConst.SUSBMA_USBMANAGE_MASS_REGISTER_SUCCESS:
				{
					var errorMsg:String = notification.getBody().ERRORMSG as String;
					var errorCode:int = notification.getBody().ERRORCODE as int;
					var errorLine:int = notification.getBody().ERRORLINE as int;
					var successMsg:String = notification.getBody().SUCCESSMSG as String;
					
					//Alert.show("Error MSG : " + errorMsg + "\nError Code : " + String(errorCode));
					if(errorCode == 1){
							Alert.show("[Line " + errorLine + "] " + DmosFramework.getInstance().SNL(errorMsg), 
								DmosFramework.getInstance().SNL("PROGRAMTITLE_D4_SUSBMA_USBMANAGE"))
					}else if(errorCode == 2){
						Alert.show(DmosFramework.getInstance().SNL(errorMsg), 
							DmosFramework.getInstance().SNL("PROGRAMTITLE_D4_SUSBMA_USBMANAGE"))
					}else{
						isClose = true;
						
						if(isClose) {
							Alert.show(DmosFramework.getInstance().SNL(successMsg), DmosFramework.getInstance().SNL("PROGRAMTITLE_D4_SUSBMA_USBMANAGE"),
								Alert.OK, myWindow.parentApplication as Sprite,
								closeEventHandler, null, Alert.OK);
						}
							
					}
					break;
				}
					
				case LocalConst.SUSBMA_USBMANAGE_MASS_REGISTER_FAIL:
				{
					break;
				}
					
				default:
					break;
			}
		}
		
		private function closeEventHandler(event:CloseEvent):void
		{
			callPopupOnOk();
			closeMyWindow();
		}
		
		protected function formDownload_clickEventHandler(event:MouseEvent):void
		{
			var request:URLRequest = new URLRequest("/UsbMassRegisterFormDownload.htm");
			request.method = URLRequestMethod.POST;
			
			var params:URLVariables = new URLVariables();
			
			var fileName:String = DmosFramework.getInstance().SNL("SC_REGISTER_MASS_FORM") + ".csv";
			
			var titles:Array = [ 
				DmosFramework.getInstance().SNL("SC_SERIAL_NO"), 
				DmosFramework.getInstance().SNL("SC_USER_ID"),
				DmosFramework.getInstance().SNL("SC_CLASS"), 
				DmosFramework.getInstance().SNL("SC_MANAGER_ID"), 
				DmosFramework.getInstance().SNL("SC_START_PERIOD"), 
				DmosFramework.getInstance().SNL("SC_END_PERIOD"),
				DmosFramework.getInstance().SNL("SC_USE_PERIOD_RESTRICTION")
			];
			
			
			var props:Array = [
				'sno',
				'userEmpId',
				'strClassId',
				'mngEmpId',
				'permStartDate',
				'permEndDate',
				'strIsTimeCheck'
			];
			
			params.titleName = titles;
			params.titleProperty = props;
			params.fileName = fileName;
			
			request.data = params;
			navigateToURL(request, "_self");
		}
		
		public function upload(event:Event):void {
			
			if(!fileRef)
			{
				fileRef = new FileReference();	
			}
			
			configureListeners(fileRef);
			
			try {
				var success:Boolean = fileRef.browse(getTypes());				
			} catch (error:Error) {
				Alert.show("Unable to browse for files.");
			}
		}
		
		private function getTypes():Array {
			var allTypes:Array = new Array(getCsvTypeFilter());
			return allTypes;
		}
		
		private function getCsvTypeFilter():FileFilter {
			return new FileFilter("Text(*.txt;*.csv)","*.txt;*.csv");
		}
		
		private function configureListeners(dispatcher:IEventDispatcher):void {
			dispatcher.addEventListener(Event.COMPLETE, onUploadCompleteDownload);
			dispatcher.addEventListener(Event.SELECT, onUploadSelectFile);
			dispatcher.addEventListener(SecurityErrorEvent.SECURITY_ERROR, error);
			dispatcher.addEventListener(DataEvent.UPLOAD_COMPLETE_DATA,error);
			function error(event:*):void{
				Alert.show(event.toString(), "Error");		
			}
		}
		
		public function onUploadCompleteDownload(event:Event):void {
			Alert.show("File Upload Success.");
		}
		
		public function onUploadSelectFile(event:Event):void {			
			myWindow.fileName.visible = myWindow.fileName.includeInLayout = true;
			myWindow.fileName.text = fileRef.name.toString();
			var request:URLRequest = new URLRequest();
			
			try {
				var nowDate:Date = new Date();
				var currentDate:String = String(nowDate.fullYear) + String(nowDate.month+1) + String(nowDate.date) + String(nowDate.hours) + String(nowDate.minutes) + String(nowDate.seconds);
				var params:URLVariables = new URLVariables();
				tempFileName = currentDate + fileRef.type.toLocaleLowerCase();
				params.fileString = currentDate + fileRef.type.toLocaleLowerCase();
				
				request.url = "/massRegisterUpload.htm";
				request.method = URLRequestMethod.POST;
				request.contentType = "multipart/form-data";
				request.data = params;
				fileRef.upload(request);
				
			} catch (e:SecurityError){
				Alert.show(e.toString(), DmosFramework.getInstance().SNL("PROGRAMTITLE_D4_SUSBMA_USBMANAGE"));
			}   
		}
		
		override public function onRegister():void
		{
			myWindow.confirmButton.addEventListener(MouseEvent.MOUSE_DOWN, okClickEventHandler);
			myWindow.cancelButton.addEventListener(MouseEvent.MOUSE_DOWN, cancelClickEventHandler);
			myWindow.addEventListener(Event.CLOSE, closeHandler);
			
			myWindow.formDownload.addEventListener(MouseEvent.CLICK, formDownload_clickEventHandler);
			myWindow.formUpload.addEventListener(MouseEvent.CLICK, upload);
		}
		
		override public function onRemove():void
		{
			myWindow.confirmButton.removeEventListener(MouseEvent.MOUSE_DOWN, okClickEventHandler);
			myWindow.cancelButton.removeEventListener(MouseEvent.MOUSE_DOWN, cancelClickEventHandler);
			myWindow.removeEventListener(Event.CLOSE, closeHandler);

			myWindow.formDownload.removeEventListener(MouseEvent.CLICK, formDownload_clickEventHandler);
			myWindow.formUpload.removeEventListener(MouseEvent.CLICK, upload);
		}
		
		private function closeMyWindow():void
		{
			PopUpManager.removePopUp(myWindow);
			facade.removeMediator(NAME);
		}
	}
}
