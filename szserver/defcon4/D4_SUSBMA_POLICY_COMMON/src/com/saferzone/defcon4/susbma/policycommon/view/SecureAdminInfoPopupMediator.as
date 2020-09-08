package com.saferzone.defcon4.susbma.policycommon.view
{
	import com.saferzone.defcon4.common.SZPopupMediator;
	import com.saferzone.defcon4.susbma.policycommon.vo.SusbmaPolicyCommonMasterVO;
	import com.saferzone.defcon4.susbma.policycommon.consts.LocalConst;
	import com.saferzone.defcon4.susbma.policycommon.view.comp.SecureAdminInfoPopup;
	
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

	public class SecureAdminInfoPopupMediator extends SZPopupMediator
	{
		
		public static const NAME:String = "SecureAdminInfoPopupMediator";

		public function SecureAdminInfoPopupMediator(viewComponent:SecureAdminInfoPopup)
		{
			super(NAME, viewComponent);
		}

		public function get myWindow():SecureAdminInfoPopup
		{
			return viewComponent as SecureAdminInfoPopup;
		}

		protected function okClickEventHandler(event:MouseEvent):void
		{
			var secureAdminInfoVo:SusbmaPolicyCommonMasterVO = new SusbmaPolicyCommonMasterVO();
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
			];
		}
		
		override public function handleNotification(notification:INotification):void
		{
			switch(notification.getName())
			{
				default :
					break;
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
