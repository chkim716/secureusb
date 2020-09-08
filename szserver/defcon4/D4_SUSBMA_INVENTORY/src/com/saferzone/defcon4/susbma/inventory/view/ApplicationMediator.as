package com.saferzone.defcon4.susbma.inventory.view
{
	import com.saferzone.defcon4.common.DmosFramework;
	import com.saferzone.defcon4.common.ISZPopupResponder;
	import com.saferzone.defcon4.susbma.inventory.ApplicationFacade;
	import com.saferzone.defcon4.susbma.inventory.consts.LocalConst;
	
	import flash.events.MouseEvent;
	
	import mx.collections.IList;
	import mx.controls.Alert;
	import mx.events.IndexChangedEvent;
	import mx.managers.PopUpManager;
	
	import org.puremvc.as3.multicore.interfaces.IMediator;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;
	
	/**
	 * 애플리케이션 미디에이터 
	 * 메인어플리케이션 관련 중재자 역할
	 * @author lmj
	 */	
	public class ApplicationMediator extends Mediator
	{
		public static const NAME:String = "ApplicationMediator";
		
		public function ApplicationMediator(viewComponent:Object)
		{
			super(NAME,viewComponent);
		}
		
		public function get myWindow():D4_SUSBMA_INVENTORY
		{
			return viewComponent as D4_SUSBMA_INVENTORY;
		}
		
		/**
		 * 탭 클릭 Event Listener
		 */
		private function onTabChangeHandler(event:IndexChangedEvent):void
		{
			switch(event.currentTarget.selectedIndex)
			{
				case 0 :			//USB재고현황탭 클릭 시
				{
					if(myWindow.statusVW)
					{
						if(!facade.retrieveMediator(UsbInventoryStatusViewMediator.NAME))
						{
							facade.removeMediator(UsbInventoryHistoryViewMediator.NAME);
							facade.registerMediator(new UsbInventoryStatusViewMediator(myWindow.statusVW));
						}
					}
					break;
				}
					
				case 1 :		//USB재고이력탭 클릭 시
				{
					if(myWindow.historyVW)
					{
						if(!facade.retrieveMediator(UsbInventoryHistoryViewMediator.NAME))
						{
							facade.removeMediator(UsbInventoryStatusViewMediator.NAME);
							facade.registerMediator(new UsbInventoryHistoryViewMediator(myWindow.historyVW));
						}
					}
					break;
				}	
					
				default : break;
			}
		}
		
		/**
		 * mediator 등록 시
		 */
		override public function onRegister():void
		{
			myWindow.tabNavi.addEventListener(IndexChangedEvent.CHANGE, onTabChangeHandler);
		}
		
		/**
		 * mediator 제거 시
		 */
		override public function onRemove():void
		{
			myWindow.tabNavi.removeEventListener(IndexChangedEvent.CHANGE, onTabChangeHandler);
		}
		
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
				default : break;
			}
		}
	}
}