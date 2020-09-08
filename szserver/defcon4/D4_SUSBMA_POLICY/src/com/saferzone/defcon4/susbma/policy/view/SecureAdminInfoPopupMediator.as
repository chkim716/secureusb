package com.saferzone.defcon4.susbma.policy.view
{
	import com.saferzone.defcon4.common.SZPopupMediator;
	import com.saferzone.defcon4.services.vo.SusbmaCommonPolicyMasterVO;
	import com.saferzone.defcon4.susbma.policy.ApplicationFacade;
	import com.saferzone.defcon4.susbma.policy.consts.LocalConst;
	import com.saferzone.defcon4.susbma.policy.view.comp.SecureAdminInfoPopup;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import mx.collections.ArrayList;
	import mx.collections.IList;
	import mx.controls.Alert;
	import mx.managers.PopUpManager;
	import mx.utils.StringUtil;
	import mx.validators.Validator;
	
	import org.puremvc.as3.multicore.interfaces.IMediator;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;

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
	public class SecureAdminInfoPopupMediator extends SZPopupMediator
	{
		
		//------------------------------------------------------------------------------
		//
		// Constants 
		//
		//------------------------------------------------------------------------------
		
		public static const NAME:String = "SecureAdminInfoPopupMediator";
		
		//------------------------------------------------------------------------------
		//
		// Constructor 
		//
		//------------------------------------------------------------------------------
		
		public function SecureAdminInfoPopupMediator(viewComponent:SecureAdminInfoPopup)
		{
			super(NAME, viewComponent);
		}
		
		
		//------------------------------------------------------------------------------
		//
		// Properties #public 
		//
		//------------------------------------------------------------------------------
		
		public function get myWindow():SecureAdminInfoPopup
		{
			return viewComponent as SecureAdminInfoPopup;
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
			var secureAdminInfoVo:SusbmaCommonPolicyMasterVO = new SusbmaCommonPolicyMasterVO();
			secureAdminInfoVo.secureAdminName = myWindow.secureAdminName.text;
			secureAdminInfoVo.secureAdminDept = myWindow.secureAdminDept.text;
			secureAdminInfoVo.secureAdminTel = myWindow.secureAdminTel.text;
			secureAdminInfoVo.secureAdminMail = myWindow.secureAdminMail.text;
			callPopupOnOk(secureAdminInfoVo);
			closeMyWindow();
		}
		

		


		
		override public function onRegister():void
		{
			myWindow.confirmButton.addEventListener(MouseEvent.CLICK, okClickEventHandler);
			myWindow.cancelButton.addEventListener(MouseEvent.CLICK, cancelClickEventHandler);
			myWindow.addEventListener(Event.CLOSE, closeHandler);
			
			sendNotification(LocalConst.D4LC_CMD_SECURE_ADMIN_INFO_LOAD);
		}
		
		override public function onRemove():void
		{
			myWindow.confirmButton.removeEventListener(MouseEvent.CLICK, okClickEventHandler);
			myWindow.cancelButton.removeEventListener(MouseEvent.CLICK, cancelClickEventHandler);
			myWindow.removeEventListener(Event.CLOSE, closeHandler);
		}
		
		override public function listNotificationInterests():Array
		{
			return [
				LocalConst.D4LC_NOTIFY_SECURE_ADMIN_INFO_LOADSUCCESS,
				LocalConst.D4LC_NOTIFY_SECURE_ADMIN_INFO_LOADFAIL
			];
		}
		
		override public function handleNotification(notification:INotification):void
		{
			switch(notification.getName())
			{
				case LocalConst.D4LC_NOTIFY_SECURE_ADMIN_INFO_LOADSUCCESS:
				{
					var secureAdminInfoVo:SusbmaCommonPolicyMasterVO = notification.getBody() as SusbmaCommonPolicyMasterVO;
					myWindow.secureAdminName.text = secureAdminInfoVo.secureAdminName;
					myWindow.secureAdminDept.text = secureAdminInfoVo.secureAdminDept;
					myWindow.secureAdminTel.text = secureAdminInfoVo.secureAdminTel;
					myWindow.secureAdminMail.text = secureAdminInfoVo.secureAdminMail;
					
					break;
				}
					
				case LocalConst.D4LC_NOTIFY_SECURE_ADMIN_INFO_LOADFAIL:
				{
					break;
				}
			}
		}
		
		
		private function closeHandler(event:Event):void
		{
			closeMyWindow();
		}
		
		protected function cancelClickEventHandler(event:MouseEvent):void
		{
			closeMyWindow();
		}
		
		private function closeMyWindow():void
		{
			PopUpManager.removePopUp(myWindow);
			facade.removeMediator(NAME);
		}
	}
}
