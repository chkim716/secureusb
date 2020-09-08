//------------------------------------------------------------------------------
//
//   Copyright 2011 
//   Saferzone All rights reserved. 
//
//------------------------------------------------------------------------------

package com.saferzone.defcon4.susbma.policy.view
{
	import com.saferzone.defcon4.susbma.policy.view.comp.SnoUpdatePopup;
	import com.saferzone.defcon4.common.DmosFramework;
	import com.saferzone.defcon4.common.SZPopupMediator;
	import com.saferzone.defcon4.common.consts.GlobalConst;
	import com.saferzone.defcon4.common.utils.SZUtil;
	import com.saferzone.defcon4.services.vo.SusbmaPolicyGroupUsbVO;
	
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	
	import mx.collections.ArrayList;
	import mx.controls.Alert;
	import mx.managers.PopUpManager;
	import mx.validators.Validator;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	
	public class SnoUpdatePopupMediator extends SZPopupMediator
	{
		
		//------------------------------------------------------------------------------
		//
		// Constants 
		//
		//------------------------------------------------------------------------------
		
		public static const NAME:String = 'SnoUpdatePopupMediator';
		
		//------------------------------------------------------------------------------
		//
		// Constructor 
		//
		//------------------------------------------------------------------------------
		
		public function SnoUpdatePopupMediator(viewComponent:Object)
		{
			super(NAME, viewComponent);
		}
		
		
		//------------------------------------------------------------------------------
		//
		// Properties #public 
		//
		//------------------------------------------------------------------------------
		
		//--------------------------------------
		// myWindow 
		//--------------------------------------
		
		public function get myWindow():SnoUpdatePopup
		{
			return viewComponent as SnoUpdatePopup;
		}
		
		//--------------------------------------
		// groupName 
		//--------------------------------------
		
		public function set groupName(val:String):void
		{
			myWindow.txtEmpName.text = val;
		}
		
		public function get groupName():String
		{
			return myWindow.txtEmpName.text;
		}
		
		//------------------------------------------------------------------------------
		//
		// Methods 
		//
		//------------------------------------------------------------------------------
		
		//--------------------------------------
		// Event Handlers 
		//--------------------------------------

		protected function okClickEventHandler(event:MouseEvent):void
		{
			var arInvalid:Array = Validator.validateAll(
				[
//					myWindow.groupNameValidator
				]
			);
			
			
			if(arInvalid.length>0)
			{
				return;
			}
			
			var vo:SusbmaPolicyGroupUsbVO = new SusbmaPolicyGroupUsbVO();
			
			vo.sno = myWindow.txtSno.text;
			vo.startPolDate = SZUtil.replaceAll(myWindow.startPolicyDate.text,'-','');
			vo.endPolDate = SZUtil.replaceAll(myWindow.endPolicyDate.text,'-','');
			
			vo.startPolHours = setTimeData(String(myWindow.startHour.textDisplay.text));
			vo.startPolMinutes = setTimeData(String(myWindow.startMinute.textDisplay.text));
			vo.endPolHours = setTimeData(String(myWindow.endHour.textDisplay.text));
			vo.endPolMinutes = setTimeData(String(myWindow.endMinute.textDisplay.text));
			
			vo.chkUnlimited = int(myWindow.chkUnlimitDate.selected);
			
			var startDate:String = vo.startPolDate + vo.startPolHours + vo.startPolMinutes;
			var endDate:String= vo.endPolDate + vo.endPolHours + vo.endPolMinutes;
			
			if(Number(startDate) > Number(endDate))
			{
				Alert.show(DmosFramework.getInstance().SNL("SC_PROMPT_INVALID_PERIOD"), 
					DmosFramework.getInstance().SNL("SC_MODIFY"));
				return;
			}
			
			Alert.show(DmosFramework.getInstance().SNL('SC_MODIFY_COMP_D4'),DmosFramework.getInstance().SNL('PROGRAMTITLE_D4_SUSBMA_POLICY'));
			
			callPopupOnOk(vo);
			closeMyWindow();
		}
		
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
		
		//--------------------------------------
		// Overriden Methods 
		//--------------------------------------
		
		/**
		 * 관심있는 notification
		 */
		override public function listNotificationInterests():Array
		{
			return [
				GlobalConst.CMD_NET_REQUEST_LOGOUT
			];
		}
		
		/**
		 * 처리할 notification
		 */
		override public function handleNotification(notification:INotification):void
		{
			switch(notification.getName())
			{
				case GlobalConst.CMD_NET_REQUEST_LOGOUT:
					closeMyWindow();
					break;
			}
		}
		override public function onRegister():void
		{
			//컨트롤 초기화 루틴은 여기서
			myWindow.okBtn.addEventListener(MouseEvent.MOUSE_DOWN, okClickEventHandler);
			myWindow.cancelBtn.addEventListener(MouseEvent.MOUSE_DOWN, cancelClickEventHandler);
			myWindow.addEventListener(Event.CLOSE, closeHandler);
			
			if(myWindow.startPolicyDate.selectedDate == null)	myWindow.startPolicyDate.selectedDate = SZUtil.dateAdd("YYYY");
			if(myWindow.endPolicyDate.selectedDate == null)		myWindow.endPolicyDate.selectedDate = SZUtil.dateAdd("YYYY", 1);
		}
		
		override public function onRemove():void
		{
			myWindow.okBtn.removeEventListener(MouseEvent.MOUSE_DOWN, okClickEventHandler);
			myWindow.cancelBtn.removeEventListener(MouseEvent.MOUSE_DOWN, cancelClickEventHandler);
			myWindow.removeEventListener(Event.CLOSE, closeHandler);
		}
		
		
		public function setTimeData(strTimeData:String):String
		{
			if(strTimeData.length == 1)
				strTimeData = "0" + strTimeData;
			
			return strTimeData;
		}
		
		//--------------------------------------
		// private 
		//--------------------------------------
		
		private function closeMyWindow():void
		{
			PopUpManager.removePopUp(myWindow);
			facade.removeMediator(NAME);
		}
		
		public function setGroupList(list:ArrayList):void
		{
			myWindow.groupList = list;
		}
	}
}
