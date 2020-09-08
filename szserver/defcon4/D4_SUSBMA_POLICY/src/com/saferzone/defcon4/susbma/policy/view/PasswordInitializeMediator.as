package com.saferzone.defcon4.susbma.policy.view
{
	import com.saferzone.defcon4.services.vo.SusbmaCommonPolicyMasterVO;
	import com.saferzone.defcon4.susbma.policy.ApplicationFacade;
	import com.saferzone.defcon4.susbma.policy.consts.LocalConst;
	import com.saferzone.defcon4.susbma.policy.view.comp.PasswordInitializePopup;
	import com.saferzone.defcon4.common.SZPopupMediator;
	
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
		
		public function get myWindow():PasswordInitializePopup
		{
			return viewComponent as PasswordInitializePopup;
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
			
			var initPassword:String = myWindow.passwordInput.text;
			callPopupOnOk(initPassword);
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
