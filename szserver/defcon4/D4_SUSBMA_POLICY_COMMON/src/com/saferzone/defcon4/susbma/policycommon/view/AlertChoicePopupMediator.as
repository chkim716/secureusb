package com.saferzone.defcon4.susbma.policycommon.view
{
	import com.saferzone.defcon4.common.SZPopupMediator;
	import com.saferzone.defcon4.common.components.DragGrid;
	import com.saferzone.defcon4.susbma.policycommon.consts.LocalConst;
	import com.saferzone.defcon4.susbma.policycommon.view.comp.AlertChoicePopup;
	import com.saferzone.defcon4.susbma.policycommon.vo.SusbmaPolicyCommonMasterVO;
	
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

	public class AlertChoicePopupMediator extends SZPopupMediator
	{
		public static const NAME:String = "AlertChoicePopupMediator";

		public var $tempArr:ArrayCollection = new ArrayCollection();
		
		public function AlertChoicePopupMediator(viewComponent:AlertChoicePopup)
		{
			super(NAME, viewComponent);
		}

		public function get myWindow():AlertChoicePopup
		{
			return viewComponent as AlertChoicePopup;
		}

		protected function okClickEventHandler(event:MouseEvent):void
		{
			var arInvalid:Array = Validator.validateAll([
			]);
			
			if(arInvalid.length>0)
			{	
				return; 
			}		
			
			var obj:Object = new Object();
			obj.popupList = $tempArr;
			
			callPopupOnOk(obj);
			closeMyWindow();
		}
		
		public function data(obj:ArrayCollection):void
		{
			myWindow.$popupArr.removeAll();
			
			if( obj.length > 0 )
			{
				for( var i:int = 0 ; i < obj.length ; i++ )
				{
					var tempObj:Object = new Object();
					tempObj.checked = obj.getItemAt(i).checked;
					tempObj.popupId = obj.getItemAt(i).popupId;
					tempObj.popupContent = obj.getItemAt(i).popupContent;
					tempObj.popupContentDetail = obj.getItemAt(i).popupContentDetail;
					tempObj.popupFix = obj.getItemAt(i).popupFix;
					
					$tempArr.addItemAt(tempObj, i);
				}
			}
			
			myWindow.$popupArr = $tempArr;
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
