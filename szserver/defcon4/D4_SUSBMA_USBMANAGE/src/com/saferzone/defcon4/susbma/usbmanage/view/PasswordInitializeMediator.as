//------------------------------------------------------------------------------
//
//   Copyright 2011 
//   Saferzone All rights reserved. 
//
//------------------------------------------------------------------------------

package com.saferzone.defcon4.susbma.usbmanage.view
{
	import com.saferzone.defcon4.common.DmosFramework;
	import com.saferzone.defcon4.services.vo.CmdClientTargetVO;
	import com.saferzone.defcon4.services.vo.SusbUsbMasterVO;
	import com.saferzone.defcon4.susbma.usbmanage.ApplicationFacade;
	import com.saferzone.defcon4.susbma.usbmanage.consts.LocalConst;
	import com.saferzone.defcon4.susbma.usbmanage.view.comp.PasswordInitializePopup;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import mx.collections.ArrayList;
	import mx.collections.IList;
	import mx.controls.Alert;
	import mx.core.Application;
	import mx.managers.PopUpManager;
	import mx.utils.StringUtil;
	import mx.validators.Validator;
	
	import org.puremvc.as3.multicore.interfaces.IMediator;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;
	import com.saferzone.defcon4.common.SZPopupMediator;
	
	/**
	 *
	 * enclosing_type
	 *
	 * @version 0.001
	 * @author CyD
	 * @since Oct 12, 2011
	 *
	 * @langversion 3.0
	 * @playerversion Flash 10
	 * @playerversion AIR 2.6
	 * @productversion Flex 4.5
	 *
	 */
	public class PasswordInitializeMediator extends SZPopupMediator implements IMediator
	{
		
		//------------------------------------------------------------------------------
		//
		// Constants 
		//
		//------------------------------------------------------------------------------
		
		public static const NAME:String = "PasswordInitializeMediator";
		
		//------------------------------------------------------------------------------
		//
		// Constructor 
		//
		//------------------------------------------------------------------------------
		
		public function PasswordInitializeMediator(viewComponent:PasswordInitializePopup)
		{
			super(NAME, viewComponent);
		}
		
		
		//------------------------------------------------------------------------------
		//
		// Properties #public 
		//
		//------------------------------------------------------------------------------
		
		public function get view():PasswordInitializePopup
		{
			return viewComponent as PasswordInitializePopup;
		}
		public  var tmTimer  : Timer;
		public  var time:int = 0;
		
		//------------------------------------------------------------------------------
		//
		// Methods 
		//
		//------------------------------------------------------------------------------
		
		//--------------------------------------
		// Event Handlers 
		//--------------------------------------
		
		private var usbVO:SusbUsbMasterVO;
		
		public function set setData(vo:SusbUsbMasterVO):void
		{
			usbVO = vo;
		}
		
		protected function clickHandler(event:MouseEvent):void
		{
			
			var val:Array;
			
			
			if(view.isPwdVlidateDelete){
				val = [];		
			}else{
				val= [
					view.accountPwdValidator,
					view.accountPwdValidator2,
					view.pwdConfirmValidator,
					view.pwdConfirmValidator2
				];
			}
			
			
			
			
			var arInvalid:Array = Validator.validateAll(val);
			
			switch(event.target)
			{
				case view.confirmButton:
					
					if(DmosFramework.getInstance().CUSTOMERID == 406){
						arInvalid.length = 0;
					}
					
					if(arInvalid.length>0)
					{
						return;	
					}
					callPopupOnOk(1);
					request();
					break;
				case view.cancelButton:
					callPopupOnOk(0);
					closeMyWindow();
					break;
				default:
					break;
			}
		}
		
		private function closeHandler(event:Event):void
		{
//			closeMyWindow();
			//			destroy();
		}
		
		//--------------------------------------
		// Overriden Methods 
		//--------------------------------------
		
		override public function getMediatorName():String
		{
			return NAME;
		}
		
		override public function onRegister():void
		{
			addEventHandlers();
			popup();
		}
		
		override public function onRemove():void
		{
			removeEventHandlers();
			popdown();
		}
		
		override public function listNotificationInterests():Array
		{
			return [
				LocalConst.D4LC_NOTIFY_PASSWORD_INITIALIZE_RESULT,
				LocalConst.D4LC_NOTIFY_PASSWORD_INITIALIZE_FAULT,
				LocalConst.D4LC_NOTIFY_PASSWORD_INITIALIZE_CHECK_SUCCESS
			];
		}
		
		override public function handleNotification(notification:INotification):void
		{
			switch(notification.getName())
			{
					
				case LocalConst.D4LC_NOTIFY_PASSWORD_INITIALIZE_FAULT:
				{
					closeMyWindow();
					break;
				}
					
				default:
					break;
			}
		}
		
		
		//--------------------------------------
		// private 
		//--------------------------------------
	
		private function request():void
		{
			var selectedUSB:SusbUsbMasterVO = ApplicationFacade(facade).selectedUSB;
			var targets:IList = new ArrayList();
			var target:CmdClientTargetVO = new CmdClientTargetVO();
			target.assetId = selectedUSB.assetId;
			target.orgId = selectedUSB.pcOrgId;
			target.companyId = "2";
			target.range = 3;
			targets.addItem(target);

//			var sno:String = selectedUSB.sno;
			var sno:String = usbVO.sno;
			var pwd:String = view.password;
			var isDataDelete:int = view.dataDelete.selected == true?1:0;
			
			
			var params:Object = {};
			params.targets = targets;
			//params.target = target;
			params.sno = sno;
			params.pwd = pwd;
			params.isDataDelete = isDataDelete;
			params.isFirst = 1;
			ApplicationFacade(facade).selectedInitSNO = sno;
			sendNotification(LocalConst.D4LC_CMD_PASSWORD_INITIALIZE, params);
			closeMyWindow();
			//popdown();
		}
		
		private function popup():void
		{
			if(!view.isPopUp)
			{
				PopUpManager.addPopUp(view, ApplicationFacade(facade).application,
					true);
				PopUpManager.centerPopUp(view);
			}
		}
		
		private function popdown():void
		{
			if(view.isPopUp)
				PopUpManager.removePopUp(view);
		}
		
		private function addEventHandlers():void
		{
			view.confirmButton.addEventListener(MouseEvent.CLICK, clickHandler);
			view.cancelButton.addEventListener(MouseEvent.CLICK, clickHandler);
			view.addEventListener(Event.CLOSE, closeHandler);
		}
		
		private function removeEventHandlers():void
		{
			view.confirmButton.removeEventListener(MouseEvent.CLICK, clickHandler);
			view.cancelButton.removeEventListener(MouseEvent.CLICK, clickHandler);
			view.removeEventListener(Event.CLOSE, closeHandler);
		}
		
		//		private function destroy():void
		//		{
		//			facade.removeMediator(NAME);
		//		}
		private function closeMyWindow():void
		{
			PopUpManager.removePopUp(view);
			facade.removeMediator(NAME);
		}
	}
}
