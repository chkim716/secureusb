package com.saferzone.defcon4.susbma.usbmanage.view
{
	import com.saferzone.defcon4.common.DmosFramework;
	import com.saferzone.defcon4.common.SZPopupMediator;
	import com.saferzone.defcon4.susbma.usbmanage.view.comp.SusbmaUsbManageDelPopup
	import com.saferzone.defcon4.services.vo.SusbUsbMasterVO;
	import com.saferzone.defcon4.services.vo.SusbmaUsbVO;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.external.ExternalInterface;
	
	import mx.managers.PopUpManager;
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	
	public class SusbmaUsbManageDelPopupMediator extends SZPopupMediator
	{
		public static const NAME:String = 'SusbmaUsbManageDelPopupMediator';
		
		public function SusbmaUsbManageDelPopupMediator(viewComponent:Object)
		{
			super(NAME, viewComponent);
		}

		public function get myWindow():SusbmaUsbManageDelPopup
		{
			return viewComponent as SusbmaUsbManageDelPopup;
		}
		
		public var selectedSno:String;
		
		protected function cancelClickEventHandler(event:MouseEvent):void
		{
			callPopupOnCancel("test-cancel");
			closeMyWindow();
		}
		
		private function closeHandler(event:Event):void
		{
			callPopupOnCancel("test-cancel");
			closeMyWindow();
		}
		
		private function closeMyWindow():void
		{
			PopUpManager.removePopUp(myWindow);
			facade.removeMediator(NAME);
		}
		
		public function set data(vo:SusbUsbMasterVO):void
		{
			selectedSno = vo.sno;
		}
		
		protected function okClickEventHandler(event:MouseEvent):void
		{
			if(myWindow.drive.enabled == true)
			{
				if(selectedSno != myWindow.serialNo.text)
				{
					Alert.show(DmosFramework.getInstance().SNL('SC_SELECT_USB_NOT_CONNECT'), DmosFramework.getInstance().SNL('PROGRAMTITLE_D4_SUSBMA_USBMANAGE'))
					return;
				}	
			}
			
			if(selectedSno == myWindow.serialNo.text)
			{
				if(myWindow.dataDelete.selected)
				{
					ExternalInterface.call("DataDelete", myWindow.instanceId.text);
				}
				
				if(myWindow.isInitPasswod.selected)
				{
					ExternalInterface.call("InitPassword", myWindow.instanceId.text, myWindow.initPassword.text);
				}
			}
			
			var masterVo:SusbUsbMasterVO = new SusbUsbMasterVO();
			masterVo.sno = selectedSno;
			masterVo.reason = myWindow.reason.text;
			
			callPopupOnOk(masterVo);
			closeMyWindow();
		}
		
		protected function getSerialNo(event:MouseEvent):void
		{	
			myWindow.usbArr.removeAll();
			if(ExternalInterface.available)
			{
				var snoList:String = ExternalInterface.call("GetSNO", DmosFramework.getInstance().CONFIG("SURECOGCODE","SMI:000000"), 1, DmosFramework.getInstance().CONFIG("SAFERZONE_DAO_VERSION"));
				//var snoList:String = ExternalInterface.call("GetSNO", "SM:000000|SMI:000072", 1);
				//snoList = "Y:\\,SZSUEB000030000012,3";
				
				if(snoList == null || snoList == "")
					return;
				
				//snoList 에는 장착된 USB개수 만큼의 USB정보가 들어옴
				//각 USB별 정보는 | 로 구분되어 있음
				//단일USB정보는   "드라이브,시리얼번호,type" 형식임
				
				//처리루틴 : 
				//결과로 수신한 목록을 | 로 split하여 자른후 각각을  , 로 split 하여 자른다
				//수신한 USB목록이 한개이면 
				//		ComboBox에 드라이브 정보를 넣는다.
				//		SerialNo : 에   시리얼번호를 넣는다.
				//		type은 서버로 전송시 코드값으로 사용한다.
				//수신한 목록이 여러개이면
				//		ComboBox에 "::SELECT:: + 드라이브목록을 넣는다.
				//		ComboBOx에서 선택을 하면 해당드라이브의 시리얼번호를 SerialNo에 넣는다.
				//		type은 서버전송시에 사용한다.
				
				var usbVO:SusbmaUsbVO
				var useArray:Array = snoList.split("|");
				if(useArray.length > 1)
				{
					usbVO = new SusbmaUsbVO();
					//::SELECT::
					usbVO.drive = DmosFramework.getInstance().SNL('SC_PROMPT_SELECT');
					
					myWindow.usbArr.addItem(usbVO);
				}
				for(var i:int = 0; i < useArray.length; i++)
				{
					var useArray_:Array = String(useArray[i]).split(",");
					usbVO = new SusbmaUsbVO();
					usbVO.drive = String(useArray_[0]);
					usbVO.serialNo = String(useArray_[1]);
					usbVO.type = int(useArray_[2]);
					usbVO.instanceId = String(useArray_[3]);
					
					myWindow.usbArr.addItem(usbVO);
				}
				myWindow.drive.selectedIndex = 0;
				myWindow.getSnoForm.visible = true;
				myWindow.getSnoForm.includeInLayout = true;
				
				myWindow.drive.enabled = true;
				myWindow.dataDelete.enabled = true;
				myWindow.isInitPasswod.enabled = true;
				
				myWindow.isInitPasswod.dispatchEvent(new Event(Event.CHANGE));
			}
			else
			{
				Alert.show("!disable externalInterface");
			}
		}
		
		override public function onRegister():void
		{
			//컨트롤 초기화 루틴은 여기서
			myWindow.okBtn.addEventListener(MouseEvent.MOUSE_DOWN, okClickEventHandler);
			myWindow.cancelBtn.addEventListener(MouseEvent.MOUSE_DOWN, cancelClickEventHandler);
			myWindow.addEventListener(Event.CLOSE, closeHandler);
			
			myWindow.driveSearchBtn.addEventListener(MouseEvent.MOUSE_DOWN, getSerialNo);
		}	
		
		override public function onRemove():void
		{
			myWindow.okBtn.removeEventListener(MouseEvent.MOUSE_DOWN, okClickEventHandler);
			myWindow.cancelBtn.removeEventListener(MouseEvent.MOUSE_DOWN, cancelClickEventHandler);
			myWindow.removeEventListener(Event.CLOSE, closeHandler);
			
			myWindow.driveSearchBtn.removeEventListener(MouseEvent.MOUSE_DOWN, getSerialNo);
		}
		
		override public function listNotificationInterests():Array
		{
			return [

			];
		}
		
		/**
		 * 처리할 notification
		 */
		override public function handleNotification(notification:INotification):void
		{
			
		}
	}
}