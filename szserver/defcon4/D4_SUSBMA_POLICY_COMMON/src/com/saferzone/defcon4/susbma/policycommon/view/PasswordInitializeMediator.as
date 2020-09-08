package com.saferzone.defcon4.susbma.policycommon.view
{
	import com.saferzone.defcon4.common.SZPopupMediator;
	import com.saferzone.defcon4.susbma.policycommon.consts.LocalConst;
	import com.saferzone.defcon4.susbma.policycommon.view.comp.PasswordInitializePopup;
	import com.saferzone.defcon4.susbma.policycommon.vo.SusbmaPolicyCommonMasterVO;
	
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
	public class PasswordInitializeMediator extends SZPopupMediator
	{
		
		public static const NAME:String = "PasswordInitializeMediator";
		
		public function PasswordInitializeMediator(viewComponent:PasswordInitializePopup)
		{
			super(NAME, viewComponent);
		}
		
		public function get myWindow():PasswordInitializePopup
		{
			return viewComponent as PasswordInitializePopup;
		}
		
		public var popupType:int; 
		
		protected function okClickEventHandler(event:MouseEvent):void
		{	
			
			var initPassword:String = myWindow.passwordInput.text;
			var obj:Object = new Object();
			obj.initPassword = initPassword;
			obj.popupType = popupType;
			
			callPopupOnOk(obj);
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
