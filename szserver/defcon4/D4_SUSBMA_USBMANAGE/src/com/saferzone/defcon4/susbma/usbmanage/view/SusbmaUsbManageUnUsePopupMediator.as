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
	import com.saferzone.defcon4.common.consts.CustomerId;
	import com.saferzone.defcon4.services.vo.SusbChangeHistoryVO;
	import com.saferzone.defcon4.services.vo.SusbUsbMasterVO;
	import com.saferzone.defcon4.susbma.usbmanage.ApplicationFacade;
	import com.saferzone.defcon4.susbma.usbmanage.view.comp.SusbmaUsbManageUnUsePopup;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import mx.core.Application;
	import mx.managers.PopUpManager;
	import mx.validators.Validator;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	
	public class SusbmaUsbManageUnUsePopupMediator extends SZPopupMediator
	{
		
		//------------------------------------------------------------------------------
		//
		// Constants 
		//
		//------------------------------------------------------------------------------
		
		public static const NAME:String = 'SusbmaUsbManageUnUsePopupMediator';
		
		//------------------------------------------------------------------------------
		//
		// Constructor 
		//
		//------------------------------------------------------------------------------
		
		public function SusbmaUsbManageUnUsePopupMediator(viewComponent:Object)
		{
			super(NAME, viewComponent);
		}
		
		
		//------------------------------------------------------------------------------
		//
		// Properties #public 
		//
		//------------------------------------------------------------------------------
		
		public function get myWindow():SusbmaUsbManageUnUsePopup
		{
			return viewComponent as SusbmaUsbManageUnUsePopup;
		}
		
		public function set usbData(vo:SusbUsbMasterVO):void
		{
			usbVO = vo;
			if(vo.stateId == 1)//0:정상, 1:분실, 2:파기
				myWindow.lose.selected = true;				
			else if(vo.stateId == 2)
				myWindow.destroy.selected = true;
			else
				myWindow.normal.selected = true;
			
			if(DmosFramework.getInstance().CUSTOMERID == CustomerId.CC_V5){ vo.policyFormat == 1}
			else{myWindow.deleteData.selected = vo.policyFormat == 1 ? true : false;}	//0:삭제안함, 1:삭제
			
			if(DmosFramework.getInstance().CUSTOMERID == CustomerId.CC_V5){ vo.policyDeny == 1}
			else{myWindow.unUsed.selected = vo.policyDeny == 1 ? true : false;}	//0:삭제안함, 1:삭제
			
			myWindow.message.selected = vo.policyMessageOut == 1 ? true : false;	//0:출력안함, 1:출력함
			myWindow.messageStr.text = vo.policyMessage;
			myWindow.charCount.text = vo.policyMessage!=null?String(vo.policyMessage.length):"0";
			myWindow.txtAssetId.text = vo.assetId;
			myWindow.txtPcOrgId.text = vo.pcOrgId;
		}
		
		//------------------------------------------------------------------------------
		//
		// Properties #private 
		//
		//------------------------------------------------------------------------------
		
		private var changeVO:SusbChangeHistoryVO = new SusbChangeHistoryVO();
		
		private var usbVO:SusbUsbMasterVO;
		
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
					myWindow.unUseDescValidator
				]
			);
			if(arInvalid.length>0)
			{
				return;
			}
			
			
			var historyVo:SusbChangeHistoryVO = new SusbChangeHistoryVO();
			if(myWindow.lose.selected)
			{
				historyVo.stateId = 1;
			}
			else if(myWindow.destroy.selected)
			{
				historyVo.stateId = 2;
			}
			else
			{
				historyVo.stateId = 0;
			}
			
			if(DmosFramework.getInstance().CUSTOMERID == CustomerId.CC_V5)
			{
				if(myWindow.lose.selected)
				{
					historyVo.policyFormat = 1;
				}
				else if(myWindow.destroy.selected)
				{
					historyVo.policyFormat = 1;
				}
				else
				{
					historyVo.policyFormat = 0;
				}
			}
			else
			{
				if(myWindow.deleteData.selected)
					historyVo.policyFormat = 1;
				else
					historyVo.policyFormat = 0;
			}
			
			if(DmosFramework.getInstance().CUSTOMERID == CustomerId.CC_V5)
			{
				if(myWindow.lose.selected)
				{
					historyVo.policyDeny = 1;
				}
				else if(myWindow.destroy.selected)
				{
					historyVo.policyDeny = 1;
				}
				else
				{
					historyVo.policyDeny = 0;
				}
			}
			else
			{
				if(myWindow.unUsed.selected)
					historyVo.policyDeny = 1;
				else
					historyVo.policyDeny = 0;
			}

			if(myWindow.message.selected)
			{
				historyVo.policyMessageOut = 1;
				historyVo.policyMessage = myWindow.messageStr.text;
			}
			else
			{
				historyVo.policyMessageOut = 0;
				historyVo.policyMessage = "";
			}
			
			historyVo.sno = usbVO.sno;
			historyVo.updateType = 1; // 등록정보변경 :0, 불용처리:1;
			
			if(myWindow.lose.selected)
				historyVo.reasonId = 1;
			else if(myWindow.destroy.selected)
				historyVo.reasonId = 2;
			else
				historyVo.reasonId = 0;
			// historyVo.reasonId = 1;
			ApplicationFacade(facade).unUseState = 1;
			historyVo.unUseDesc = myWindow.txtUnUseDesc.text;
			historyVo.assetId = myWindow.txtAssetId.text;
			historyVo.pcOrgId = myWindow.txtPcOrgId.text;
			callPopupOnOk(historyVo);
			closeMyWindow();
		}
		
		protected function cancelClickEventHandler(event:MouseEvent):void
		{
			closeMyWindow();
		}
		
		private function closeHandler(event:Event):void
		{
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
				
				];
		}
		
		/**
		 * 처리할 notification
		 */
		override public function handleNotification(notification:INotification):void
		{
			switch(notification.getName())
			{
				
			}
		}
		
		override public function onRegister():void
		{
			//컨트롤 초기화 루틴은 여기서
			myWindow.okBtn.addEventListener(MouseEvent.MOUSE_DOWN, okClickEventHandler);
			myWindow.cancelBtn.addEventListener(MouseEvent.MOUSE_DOWN, cancelClickEventHandler);
			myWindow.addEventListener(Event.CLOSE, closeHandler);
		}
		
		override public function onRemove():void
		{
			myWindow.okBtn.removeEventListener(MouseEvent.MOUSE_DOWN, okClickEventHandler);
			myWindow.cancelBtn.removeEventListener(MouseEvent.MOUSE_DOWN, cancelClickEventHandler);
			myWindow.removeEventListener(Event.CLOSE, closeHandler);
		}
		
		
		//--------------------------------------
		// private 
		//--------------------------------------
		
		private function closeMyWindow():void
		{
			PopUpManager.removePopUp(myWindow);
			facade.removeMediator(NAME);
		}
	}
}
