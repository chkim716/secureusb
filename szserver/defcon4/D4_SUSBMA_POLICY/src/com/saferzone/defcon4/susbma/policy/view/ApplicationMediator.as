//------------------------------------------------------------------------------
//
//   Copyright 2011 
//   Saferzone All rights reserved. 
//
//------------------------------------------------------------------------------

package com.saferzone.defcon4.susbma.policy.view
{
	import com.saferzone.defcon4.common.DmosFramework;
	import com.saferzone.defcon4.susbma.policy.consts.LocalConst;
	
	import mx.containers.TabNavigator;
	import mx.events.IndexChangedEvent;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;
	
	public class ApplicationMediator extends Mediator
	{
		
		//------------------------------------------------------------------------------
		//
		// Constants 
		//
		//------------------------------------------------------------------------------
		
		/**
		 * Name
		 */
		public static const NAME:String = 'ApplicationMediator';
		
		//------------------------------------------------------------------------------
		//
		// Constructor 
		//
		//------------------------------------------------------------------------------
		
		/**
		 * Constructor
		 */
		public function ApplicationMediator(viewComponent:Object)
		{
			super(NAME, viewComponent);
		}
		
		
		//------------------------------------------------------------------------------
		//
		// Properties #public 
		//
		//------------------------------------------------------------------------------
		
		/**
		 * 이 Mediator의 제어대상 윈도우
		 */
		public function get myWindow():D4_SUSBMA_POLICY
		{
			return viewComponent as D4_SUSBMA_POLICY;
		}
		
		//------------------------------------------------------------------------------
		//
		// Methods 
		//
		//------------------------------------------------------------------------------
		
		//--------------------------------------
		// Event Handlers 
		//--------------------------------------
		
		private function onTabChangeHandler(event:IndexChangedEvent):void
		{

			switch(event.currentTarget.selectedChild.id)
			{
				case "classTab":
				{
					if(myWindow.classView)
					{
						if(!facade.retrieveMediator(SusbmaPolicyClassMediator.NAME))
							facade.registerMediator(new SusbmaPolicyClassMediator(myWindow.classView));
						sendNotification(LocalConst.SUSBMA_POLIICY_CLASS_LIST, 1);
					}
					break;
				}
				
				case "deptTab":
				{
					if(myWindow.deptView)
					{
						if(!facade.retrieveMediator(SusbmaPolicyDeptMediator.NAME))
							facade.registerMediator(new SusbmaPolicyDeptMediator(myWindow.deptView));
						sendNotification(LocalConst.SUSBMA_POLIICY_DEPT_LIST, 2);
					}
					break;
				}
				
				case "exceptTab":
				{
					if(myWindow.policyView)
					{
						if(!facade.retrieveMediator(SusbmaPolicyPolicyMediator.NAME))
							facade.registerMediator(new SusbmaPolicyPolicyMediator(myWindow.policyView));
						sendNotification(LocalConst.SUSBMA_POLIICY_POLICY_GROUP_LIST, 3);
					}
				}
				
				default:
					break;
			}
		}
		
		//--------------------------------------
		// Overriden Methods 
		//--------------------------------------
		
		/**
		 * mediator 등록시
		 */
		override public function onRegister():void
		{
			myWindow.tabNavi.addEventListener(IndexChangedEvent.CHANGE, onTabChangeHandler);
		}
		
		/**
		 * mediator 제거시
		 */
		override public function onRemove():void
		{
			myWindow.tabNavi.addEventListener(IndexChangedEvent.CHANGE, onTabChangeHandler);
		}
		
		/**
		 * 관심있는 notification
		 */
		override public function listNotificationInterests():Array
		{
			return [
					LocalConst.D4LC_NOTIFY_GROUPTYPE_SELECTSUCCESS,
					LocalConst.D4LC_NOTIFY_GROUPTYPE_SELECTFAIL
				];
		}
		
		/**
		 * 처리할 notification
		 */
		override public function handleNotification(notification:INotification):void
		{
			switch(notification.getName())
			{

				case LocalConst.D4LC_NOTIFY_GROUPTYPE_SELECTSUCCESS :
				{
					var isAspService:Boolean = DmosFramework.getInstance().CONFIG('SAFERZONE_ASP_SERVICE_USE')=="1"?true:false
					var groupType:int = notification.getBody() as int;
					if(!isAspService){
						
						if(groupType == 2)
						{
							myWindow.tabNavi.getTabAt(0).visible = myWindow.tabNavi.getTabAt(0).includeInLayout = false;
							//myWindow.tabNavi.removeChildAt(0);
							myWindow.tabNavi.selectedIndex = 1;
							
							myWindow.tabNavi.dispatchEvent(new IndexChangedEvent(IndexChangedEvent.CHANGE));
						}

						else
						{
							sendNotification(LocalConst.SUSBMA_POLIICY_CLASS_LIST, 1)
						}
					}
					else{
						sendNotification(LocalConst.SUSBMA_POLIICY_CLASS_LIST, 1)	
					}
					
					
					break;
				}
				
				case LocalConst.D4LC_NOTIFY_GROUPTYPE_SELECTFAIL :
				{
					break;
				}
					
				default :
					break;
			}
					
		}
	}
}

