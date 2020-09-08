//------------------------------------------------------------------------------
//
//   Copyright 2011 
//   Saferzone All rights reserved. 
//
//------------------------------------------------------------------------------

package com.saferzone.defcon4.susbma.policy.view
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import mx.managers.PopUpManager;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import com.saferzone.defcon4.susbma.policy.ApplicationFacade;
	import com.saferzone.defcon4.common.SZPopupMediator;
	import com.saferzone.defcon4.susbma.policy.view.comp.SusbmaPolicyGroupPopup;
	import com.saferzone.defcon4.services.vo.SusbmaPolicyMasterVO;
	
	import mx.validators.Validator;
	
	public class SusbmaPolicyGroupPopupMediator extends SZPopupMediator
	{
		
		//------------------------------------------------------------------------------
		//
		// Constants 
		//
		//------------------------------------------------------------------------------
		
		public static const NAME:String = 'SusbmaPolicyGroupPopupMediator';
		
		//------------------------------------------------------------------------------
		//
		// Constructor 
		//
		//------------------------------------------------------------------------------
		
		public function SusbmaPolicyGroupPopupMediator(viewComponent:Object)
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
		
		public function get myWindow():SusbmaPolicyGroupPopup
		{
			return viewComponent as SusbmaPolicyGroupPopup;
		}
		
		//--------------------------------------
		// groupName 
		//--------------------------------------
		
		public function set groupName(val:String):void
		{
			myWindow.groupName.text = val;
		}
		
		public function get groupName():String
		{
			return myWindow.groupName.text;
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
				myWindow.groupNameValidator
				]
			);
			if(arInvalid.length>0)
			{
				return;
			}
			groupName = myWindow.groupName.text;
			callPopupOnOk(groupName);
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
