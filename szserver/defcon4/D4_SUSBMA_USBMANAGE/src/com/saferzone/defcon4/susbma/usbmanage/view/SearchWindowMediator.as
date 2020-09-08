
//------------------------------------------------------------------------------
//
//   Copyright 2011 
//   Saferzone All rights reserved. 
//
//------------------------------------------------------------------------------

package com.saferzone.defcon4.susbma.usbmanage.view
{
	import com.saferzone.defcon4.common.DmosFramework;
	import com.saferzone.defcon4.common.SZPopupMediator;
	import com.saferzone.defcon4.common.consts.GlobalConst;
	import com.saferzone.defcon4.common.utils.SZUtil;
	import com.saferzone.defcon4.services.vo.SearchSusbMasterVO;
	import com.saferzone.defcon4.services.vo.SusbmaMediaVO;
	import com.saferzone.defcon4.services.vo.SusbmaStateVO;
	import com.saferzone.defcon4.susbma.usbmanage.ApplicationFacade;
	import com.saferzone.defcon4.susbma.usbmanage.consts.LocalConst;
	import com.saferzone.defcon4.susbma.usbmanage.view.comp.SusbmaUsbSearchWindow;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import mx.collections.ArrayCollection;
	import mx.collections.IList;
	import mx.events.CloseEvent;
	import mx.managers.PopUpManager;
	
	import org.puremvc.as3.multicore.core.View;
	import org.puremvc.as3.multicore.interfaces.IMediator;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;
	
	/**
	 *
	 * enclosing_type
	 *
	 * @version 0.001
	 * @author CyD
	 * @since Nov 10, 2011
	 *
	 * @langversion 3.0
	 * @playerversion Flash 10
	 * @playerversion AIR 2.6
	 * @productversion Flex 4.5
	 *
	 */
	public class SearchWindowMediator extends SZPopupMediator
	{
		
		//------------------------------------------------------------------------------
		//
		// Constants 
		//
		//------------------------------------------------------------------------------
		
		public static const NAME:String = "SearchWindowMediator";
		
		//------------------------------------------------------------------------------
		//
		// Constructor 
		//
		//------------------------------------------------------------------------------
		
		public function SearchWindowMediator(viewComponent:SusbmaUsbSearchWindow)
		{
			super(NAME, viewComponent);
		}
		
		
		//------------------------------------------------------------------------------
		//
		// Properties #public 
		//
		//------------------------------------------------------------------------------
		
		public function get myWindow():SusbmaUsbSearchWindow
		{
			return viewComponent as SusbmaUsbSearchWindow;
		}
		
		public function searchData():void
		{
			myWindow.startRegDate.selectedDate = SZUtil.dateAdd("YYYY", -5);
			myWindow.endRegDate.selectedDate = SZUtil.dateAdd("YYYY");
			
			myWindow.startConnectDate.selectedDate = SZUtil.dateAdd("YYYY", -5);
			myWindow.endConnectDate.selectedDate = SZUtil.dateAdd("YYYY");
		}
		
		//------------------------------------------------------------------------------
		//
		// Methods 
		//
		//------------------------------------------------------------------------------
		
		//--------------------------------------
		// Event Handlers 
		//--------------------------------------

		protected function confirmButton_clickHandler(event:MouseEvent):void
		{
			if(!ApplicationFacade(facade).searchVO)
				ApplicationFacade(facade).searchVO = new SearchSusbMasterVO();
			var masterVo:SearchSusbMasterVO = ApplicationFacade(facade).searchVO;
			masterVo.startLastConnectDate = myWindow.startLatestConnectDateToString;
			masterVo.endLastConnectDate = myWindow.endLatestConnectDateToString;
			masterVo.startDate = myWindow.startRegDateToString;
			masterVo.endDate = myWindow.endRegDateToString;
			masterVo.sno = myWindow.serialNo;
			masterVo.managementId = myWindow.managementId;
			masterVo.classList = myWindow.classListToString;
			masterVo.empName = myWindow.empName;
			masterVo.mngEmpName = myWindow.manager;
			masterVo.mediaId = myWindow.mediaId;
			masterVo.stateId = myWindow.stateId;
			//20130408 김정욱 검색창에서 이전 검색  조건 중 부서 값 출력 안되는 현상 수정  #1647 - START
			//masterVo.orgId = myWindow.orgId;
			//20130408 김정욱 검색창에서 이전 검색  조건 중 부서 값 출력 안되는 현상 수정  #1647 - END
			masterVo.userOrgName = myWindow.deptInput.text;
			masterVo.retireState = int(myWindow.retireCheck.selected);
			masterVo.isoVersion = myWindow.isoVersionInput.text;
			masterVo.requestState = myWindow.requestStateSelector.selectedItem.value;
				
			//20130410 김정욱 검색창에서  이전 데이터 지워지지 않는 현상 수정  #1647 - START
			//sendNotification(LocalConst.SUSBMA_USBMANAGE_USB_LIST, masterVo);
			
			ApplicationFacade(facade).searchVO = masterVo;
			
			callPopupOnOk(masterVo);
			closeMyWindow();
			//20130410 김정욱 검색창에서  이전 데이터 지워지지 않는 현상 수정  #1647 - END
		}
		
		protected function cancelButton_clickHandler(event:MouseEvent):void
		{
			closeMyWindow();
		}
		
		private function closeHandler(event:Event):void
		{
			closeMyWindow();
		}
		//--------------------------------------
		// Overriden Methods 
		//--------------------------------------
		
		override public function listNotificationInterests():Array
		{
			return [
				LocalConst.SUSBMA_USBMANAGE_COMMON_LIST_LOADSUCCESS
				];
		}
		
		override public function handleNotification(notification:INotification):void
		{
			switch(notification.getName())
			{
				case LocalConst.SUSBMA_USBMANAGE_COMMON_LIST_LOADSUCCESS:
				{
					if(notification.getBody() == null)
						return;
					
					var allString:String = DmosFramework.getInstance().SNL("SC_ALL");
					
					if(notification.getBody().hasOwnProperty(GlobalConst.CLASS_LIST))
					{
						myWindow.classList.dataProvider = notification.getBody()[GlobalConst.CLASS_LIST] as IList;
					}
					
					if(notification.getBody().hasOwnProperty(GlobalConst.STATE_LIST))
					{
						var stateAll:SusbmaStateVO = new SusbmaStateVO();
						stateAll.stateId = -1;
						stateAll.stateName = allString;
						var stateProvider:IList = notification.getBody()[GlobalConst.STATE_LIST] as IList;
						stateProvider.addItemAt(stateAll, 0);
						myWindow.stateSelector.dataProvider = stateProvider;
					}
					
					if(notification.getBody().hasOwnProperty(GlobalConst.MEDIA_TYPE_LIST))
					{
						var mediaAll:SusbmaMediaVO = new SusbmaMediaVO();
						mediaAll.mediaId = -1;
						mediaAll.mediaName = allString;
						var mediaProvider:IList = notification.getBody()[GlobalConst.MEDIA_TYPE_LIST] as IList;
						mediaProvider.addItemAt(mediaAll, 0);
						myWindow.mediaTypeSelector.dataProvider = mediaProvider;
					}
					setSearchCondition(ApplicationFacade(facade).searchVO);
					
					break;
				}
			}
		}
		
		override public function onRegister():void
		{
			myWindow.confirmButton.addEventListener(MouseEvent.CLICK, confirmButton_clickHandler);
			myWindow.cancelButton.addEventListener(MouseEvent.CLICK, cancelButton_clickHandler);
			myWindow.addEventListener(Event.CLOSE, closeHandler);
			searchData();
			
			
		}
		
		override public function onRemove():void
		{
			myWindow.confirmButton.removeEventListener(MouseEvent.CLICK, confirmButton_clickHandler);
			myWindow.cancelButton.removeEventListener(MouseEvent.CLICK, cancelButton_clickHandler);
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
		
		public function setSearchCondition(vo:SearchSusbMasterVO):void
		{
			
			if(vo.startDate == null || vo.startDate == "")
			{
				myWindow.startRegDate.selectedDate = SZUtil.dateAdd("YYYY", -5);
			}
			else
			{
				myWindow.startRegDate.selectedDate = new Date(vo.startDate.substr(0,
					4),
					int(vo.startDate.substr(4,
						2)) - 1,
					vo.startDate.substr(6,
						2));
			}
			
			if(vo.endDate == null || vo.endDate == "")
			{
				myWindow.endRegDate.selectedDate = SZUtil.dateAdd("YYYY");
			}
			else
			{
				myWindow.endRegDate.selectedDate = new Date(vo.endDate.substr(0, 4),
					int(vo.endDate.substr(4,
						2)) - 1,
					vo.endDate.substr(6, 2));
			}
			
			if(vo.startLastConnectDate == null || vo.startLastConnectDate == "")
			{
				myWindow.startConnectDate.selectedDate = SZUtil.dateAdd("YYYY", -5);
			}
			else
			{
				myWindow.startConnectDate.selectedDate = new Date(vo.startLastConnectDate.substr(0,
					4),
					int(vo.startLastConnectDate.substr(4,
						2)) - 1,
					vo.startLastConnectDate.substr(6,
						2));
			}
			
			if(vo.endLastConnectDate == null || vo.endLastConnectDate == "")
			{
				myWindow.endConnectDate.selectedDate = SZUtil.dateAdd("YYYY");
			}
			else
			{
				
				myWindow.endConnectDate.selectedDate = new Date(vo.endLastConnectDate.substr(0, 4),
					int(vo.endLastConnectDate.substr(4,
						2)) - 1,
					vo.endLastConnectDate.substr(6, 2));
			}
			
			myWindow.searchToClassList = vo.classList;
			var dataProvider:IList = myWindow.classList.dataProvider;
			var length:int = dataProvider.length;
			if(vo.classList != null && vo.classList != null) 
			{	
				var arrayClass:Array =  myWindow.searchToClassList.split(",");
				var idx:int;
				
				for(var i:int = 0; i < arrayClass.length; i++)
				{
					idx = int(arrayClass[i]);
					for(var j:int = 0; j < length; j++)
					{
						if(dataProvider.getItemAt(j).classId == arrayClass[i])
						{
							dataProvider.getItemAt(j).enable = true;
						}
					}		
				}
			}else{
				for(var j:int = 0; j < length; j++)
				{
					dataProvider.getItemAt(j).enable = true;
				}
			}
			
			if(vo.classList == "" || vo.classList == null){
				myWindow.classListAllSelected.selected = true;
			}else{
				myWindow.classListAllSelected.selected = false;
			}
				
			
			myWindow.serialNoInput.text = vo.sno;
			myWindow.managementIdInput.text = vo.managementId;
			
			myWindow.empNameInput.text = vo.empName;
			//20130408 김정욱 검색창에서 이전 검색  조건 중 부서 값 출력 안되는 현상 수정  #1647 - START
			myWindow.orgId = vo.orgId;
			//20130408 김정욱 검색창에서 이전 검색  조건 중 부서 값 출력 안되는 현상 수정  #1647 - END
			myWindow.deptInput.text = vo.userOrgName;
			
			myWindow.managerInput.text = vo.mngEmpName;
			
			myWindow.mediaTypeSelector.selectedIndex = SZUtil.getIndexItem(String(vo.mediaId), ArrayCollection(myWindow.mediaTypeSelector.dataProvider), "mediaId");
			myWindow.stateSelector.selectedIndex = SZUtil.getIndexItem(String(vo.stateId), ArrayCollection(myWindow.stateSelector.dataProvider), "stateId");
			
			myWindow.retireCheck.selected = vo.retireState;
			myWindow.searchSubsMasterVo = vo;
			myWindow.isoVersionInput.text = vo.isoVersion;
			myWindow.requestStateSelector.selectedIndex = SZUtil.getIndexItem(String(vo.requestState), ArrayCollection(myWindow.requestStateSelector.dataProvider), "value");
		}
	}
}
