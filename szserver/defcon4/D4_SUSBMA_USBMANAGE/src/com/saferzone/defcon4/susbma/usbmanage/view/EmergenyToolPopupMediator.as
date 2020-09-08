package com.saferzone.defcon4.susbma.usbmanage.view
{
	import com.saferzone.defcon4.susbma.usbmanage.consts.LocalConst;
	import com.saferzone.defcon4.susbma.usbmanage.view.comp.EmergenyToolPopup;
	import com.saferzone.defcon4.common.DmosFramework;
	import com.saferzone.defcon4.services.vo.AgntmaEmergencyKeyLogVO;
	
	import org.puremvc.as3.multicore.interfaces.IMediator;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;
	
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.ui.Keyboard;
	
	import mx.collections.ArrayCollection;
	import mx.collections.ArrayList;
	import mx.events.CloseEvent;
	
	import spark.events.TextOperationEvent;
	
	public class EmergenyToolPopupMediator extends Mediator implements IMediator
	{
		public static const NAME:String = "EmergenyToolPopupMediator";
		
		public function EmergenyToolPopupMediator(viewComponent:EmergenyToolPopup)
		{
			super(NAME, viewComponent);
		}
		
		public function get myWindow():EmergenyToolPopup
		{
			return viewComponent as EmergenyToolPopup;
		}
		
		protected function createButton_clickHandler(event:MouseEvent):void
		{
			var logVO:AgntmaEmergencyKeyLogVO = new AgntmaEmergencyKeyLogVO();
			logVO.keyType = myWindow.ddrKeyType.selectedItem.value;
			logVO.authCode = myWindow.authCode;
			logVO.reasonDesc = myWindow.txtReason.text;
			
			sendNotification(LocalConst.D4LC_CMD_MAKE_EMERGENCY_KEY, logVO);
		}
		
		protected function closeHandler(event:CloseEvent):void
		{
			myWindow.authCodeInput.text = "";
			myWindow.txtReason.text = "";
			myWindow.emergencyKeyLabel.text = "";
			facade.removeMediator(NAME);
		}
		
		protected function createButton_keyHandler(event:KeyboardEvent):void
		{
			// var authCode:String = myWindow.authCode;
			
			var logVO:AgntmaEmergencyKeyLogVO = new AgntmaEmergencyKeyLogVO();
			logVO.keyType = myWindow.ddrKeyType.selectedItem.value;
			logVO.authCode = myWindow.authCode;
			logVO.reasonDesc = myWindow.txtReason.text;
			
			if(event.keyCode == Keyboard.ENTER){
				sendNotification(LocalConst.D4LC_CMD_MAKE_EMERGENCY_KEY, logVO);
			}
		}
		
		override public function onRegister():void
		{
			myWindow.addEventListener(CloseEvent.CLOSE, closeHandler);
			myWindow.createButton.addEventListener(MouseEvent.CLICK, createButton_clickHandler);
			myWindow.createButton.addEventListener(KeyboardEvent.KEY_DOWN, createButton_keyHandler);
		}
		
		override public function onRemove():void
		{
			myWindow.removeEventListener(CloseEvent.CLOSE, closeHandler);
			myWindow.createButton.removeEventListener(MouseEvent.CLICK, createButton_clickHandler);
			myWindow.createButton.removeEventListener(KeyboardEvent.KEY_DOWN, createButton_keyHandler);
		}
		
		override public function listNotificationInterests():Array
		{
			return [
				LocalConst.D4LC_NOTIFY_MAKE_EMERGENCY_KEY_RESULT,
			];
		}

		override public function handleNotification(notification:INotification):void
		{
			switch(notification.getName())
			{
				case LocalConst.D4LC_NOTIFY_MAKE_EMERGENCY_KEY_RESULT:
				{
					var result:String = notification.getBody().toString();
					if(result.length > 0)
					{
						myWindow.emergencyKeyLabel.text = result;
					}
					else
					{
						myWindow.emergencyKeyLabel.text =
							DmosFramework.getInstance().SNL("AGNTMA_AGENTINFO_MESSAGE_INVALID_AUTHCODE");
					}
					break;
				}
			}
		}
	}
}