package com.saferzone.defcon4.susbma.policy.view
{
	import com.saferzone.defcon4.common.SZPopupMediator;
	import com.saferzone.defcon4.services.vo.SusbmaCommonPolicyMasterVO;
	import com.saferzone.defcon4.susbma.policy.ApplicationFacade;
	import com.saferzone.defcon4.susbma.policy.consts.LocalConst;
	import com.saferzone.defcon4.susbma.policy.view.comp.AlertChoicePopup;
	import com.saferzone.defcon4.common.components.DragGrid;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import mx.collections.ArrayCollection;
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
	public class AlertChoicePopupMediator extends SZPopupMediator
	{
		
		//------------------------------------------------------------------------------
		//
		// Constants 
		//
		//------------------------------------------------------------------------------
		
		public static const NAME:String = "AlertChoicePopupMediator";
		
		//------------------------------------------------------------------------------
		//
		// Constructor 
		//
		//------------------------------------------------------------------------------
		
		public function AlertChoicePopupMediator(viewComponent:AlertChoicePopup)
		{
			super(NAME, viewComponent);
		}
		
		
		//------------------------------------------------------------------------------
		//
		// Properties #public 
		//
		//------------------------------------------------------------------------------
		
		public function get myWindow():AlertChoicePopup
		{
			return viewComponent as AlertChoicePopup;
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
			var arInvalid:Array = Validator.validateAll([
			]);
			
			if(arInvalid.length>0)
			{	
				return; 
			}		
			
			var popupList:ArrayCollection = new ArrayCollection();
			popupList = getPopupList(myWindow.popupArr);
			callPopupOnOk(popupList);
			closeMyWindow();
		}
		
		private function getPopupList(popupArr:ArrayCollection):ArrayCollection
		{
			var list:ArrayCollection = new ArrayCollection();
			
			var dataGrid:DragGrid = myWindow.popupDG;
			
			var idx:int = 0;
			var size:int = popupArr.length;
			
			for(idx=0;idx<size;idx++)
			{
				var data:SusbmaCommonPolicyMasterVO = popupArr.getItemAt(idx) as SusbmaCommonPolicyMasterVO;
				list.addItem(data);
			}
			
			return list;
		}
		


		
		override public function onRegister():void
		{
			myWindow.confirmButton.addEventListener(MouseEvent.CLICK, okClickEventHandler);
			myWindow.cancelButton.addEventListener(MouseEvent.CLICK, cancelClickEventHandler);
			myWindow.addEventListener(Event.CLOSE, closeHandler);
			
			sendNotification(LocalConst.D4LC_CMD_POPUP_LIST_LOAD);
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
				LocalConst.D4LC_NOTIFY_POPUP_LIST_LOADSUCCESS,
				LocalConst.D4LC_NOTIFY_POPUP_LIST_LOADFAIL
			];
		}
		
		override public function handleNotification(notification:INotification):void
		{
			switch(notification.getName())
			{
				case LocalConst.D4LC_NOTIFY_POPUP_LIST_LOADSUCCESS:
				{
					myWindow.popupArr = notification.getBody() as ArrayCollection;
					break;
				}
					
				case LocalConst.D4LC_NOTIFY_POPUP_LIST_LOADFAIL:
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
