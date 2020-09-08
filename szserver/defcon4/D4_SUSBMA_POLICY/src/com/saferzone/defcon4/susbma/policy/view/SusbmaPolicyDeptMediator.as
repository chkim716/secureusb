//------------------------------------------------------------------------------
//
//   Copyright 2011 
//   Saferzone All rights reserved. 
//
//------------------------------------------------------------------------------

package com.saferzone.defcon4.susbma.policy.view
{
	import com.saferzone.defcon4.common.DmosFramework;
	import com.saferzone.defcon4.common.components.DeptSearchPopup;
	import com.saferzone.defcon4.common.events.DeptSearchPopupEvent;
	import com.saferzone.defcon4.services.vo.SusbmaPolicyMasterVO;
	import com.saferzone.defcon4.susbma.policy.consts.LocalConst;
	import com.saferzone.defcon4.susbma.policy.event.CustomCheckBoxClickEvent;
	import com.saferzone.defcon4.susbma.policy.view.comp.SusbmaPolicyDeptView;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.events.CloseEvent;
	import mx.managers.PopUpManager;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;
	
	import spark.components.DataGrid;
	import spark.components.gridClasses.CellRegion;
	import spark.events.GridSelectionEvent;
	
	public class SusbmaPolicyDeptMediator extends Mediator
	{
		
		//------------------------------------------------------------------------------
		//
		// Constants 
		//
		//------------------------------------------------------------------------------
		
		public static const NAME:String = 'SusbmaPolicyDeptMediator';
		
		//------------------------------------------------------------------------------
		//
		// Constructor 
		//
		//------------------------------------------------------------------------------
		
		public function SusbmaPolicyDeptMediator(viewComponent:Object)
		{
			super(NAME, viewComponent);
		}
		
		
		//------------------------------------------------------------------------------
		//
		// Properties #public 
		//
		//------------------------------------------------------------------------------
		
		public function get myWindow():SusbmaPolicyDeptView
		{
			return viewComponent as SusbmaPolicyDeptView;
		}
		
		//------------------------------------------------------------------------------
		//
		// Properties #private 
		//
		//------------------------------------------------------------------------------
		
		/**
		 * 버튼클릭 Listener
		 */
		private var popup:DeptSearchPopup;
		
		//------------------------------------------------------------------------------
		//
		// Methods 
		//
		//------------------------------------------------------------------------------
		
		//--------------------------------------
		// Event Handlers 
		//--------------------------------------
		
//		private function okCloseEventHandler(event:CloseEvent):void
//		{
//			sendNotification(LocalConst.SUSBMA_POLIICY_DEPT_LIST, myWindow.rangeType);
//		}
		
		protected function onBtnClickHandler(event:MouseEvent):void
		{
			switch(event.currentTarget.id)
			{
				case "addBtn":
				{
					popup = PopUpManager.createPopUp(myWindow.parentApplication as DisplayObject,
													 DeptSearchPopup, true) as DeptSearchPopup;
					popup.addEventListener(DeptSearchPopupEvent.CONFIRM, addDeptHandler);
					popup.addEventListener(CloseEvent.CLOSE, closeDeptSearchHandler);
					popup.facade = facade;
					PopUpManager.centerPopUp(popup);
					break;
				}
				
				case "delBtn":
				{
					if(myWindow.deptDG.selectedIndex < 0)
						return;
//					var masterVO:SusbmaPolicyMasterVO = myWindow.deptDG.selectedItem as SusbmaPolicyMasterVO;
//					sendNotification(LocalConst.SUSBMA_POLIICY_DEPT_DELETE, masterVO.usbPolicyId);
					
					Alert.show(DmosFramework.getInstance().SNL("SC_PROMPT_DELETE"),
						DmosFramework.getInstance().SNL("PROGRAMTITLE_D4_SUSBMA_POLICY"), 
						Alert.OK | Alert.CANCEL, myWindow.parentApplication as Sprite, deleteBtn_closeHandler, null, Alert.OK);
					break;
				}
				
				case "reloadBtn":
				{
					sendNotification(LocalConst.SUSBMA_POLIICY_DEPT_LIST, myWindow.rangeType);
					break;
				}
				
				default:
					break;
			}
		}
		
		protected function deleteBtn_closeHandler(event:CloseEvent):void
		{
			if(event.detail == Alert.OK)
			{
				var masterVO:SusbmaPolicyMasterVO = myWindow.deptDG.selectedItem as SusbmaPolicyMasterVO;
				sendNotification(LocalConst.SUSBMA_POLIICY_DEPT_DELETE, masterVO.usbPolicyId);
			}
		}
		
		private function selectionChangeHandler(event:GridSelectionEvent):void
		{
			var optionMediator:SusbmaPolicyOptionMediator = facade.retrieveMediator(SusbmaPolicyOptionMediator.NAME) as SusbmaPolicyOptionMediator;
			optionMediator.selectMasterVO = (event.currentTarget as DataGrid).selectedItem as SusbmaPolicyMasterVO;
			
			sendNotification(LocalConst.SUSBMA_POLIICY_RAW_LIST, optionMediator.selectMasterVO.usbPolicyId);
		}
		
		private function addDeptHandler(event:DeptSearchPopupEvent):void
		{
			popup.removeEventListener(DeptSearchPopupEvent.CONFIRM, addDeptHandler);
			var masterVO:SusbmaPolicyMasterVO = new SusbmaPolicyMasterVO();
			masterVO.orgId = event.selectedDept.orgId;
			masterVO.orgName = event.selectedDept.orgName;
			if(event.includeSubDept)
				masterVO.incChild = 1;
			else
				masterVO.incChild = 0;
			masterVO.rangeType = 2;
			
			sendNotification(LocalConst.SUSBMA_POLIICY_DEPT_ADD, masterVO);
		}
		
		private function closeDeptSearchHandler(event:CloseEvent):void
		{
			popup.removeEventListener(CloseEvent.CLOSE, closeDeptSearchHandler);
			PopUpManager.removePopUp(popup);
		}
		
		private function checkBoxClickHandler(event:CustomCheckBoxClickEvent):void
		{
			sendNotification(LocalConst.SUSBMA_POLIICY_DEPT_MODIFY, event.m_vo);
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
				//성공 notify
				LocalConst.SUSBMA_POLIICY_DEPT_LIST_LOADSUCCESS,
				LocalConst.SUSBMA_POLIICY_DEPT_ADDSUCCESS,
				LocalConst.SUSBMA_POLIICY_DEPT_DELETESUCCESS,
				
				//실패 notify
				LocalConst.SUSBMA_POLIICY_DEPT_LIST_LOADFAIL,
				LocalConst.SUSBMA_POLIICY_DEPT_ADDFAIL,
				LocalConst.SUSBMA_POLIICY_DEPT_DELETEFAIL
				];
		}
		
		/**
		 * 처리할 notification
		 */
		override public function handleNotification(notification:INotification):void
		{
			switch(notification.getName())
			{
				//Grid에 저장될 데이터 로드 성공
				case LocalConst.SUSBMA_POLIICY_DEPT_LIST_LOADSUCCESS:
				{
					myWindow.deptArr = notification.getBody() as ArrayCollection;
					if(myWindow.deptArr.length > 0)
					{
						myWindow.delBtn.enabled = true;
						myWindow.deptDG.enabled = true;
						
						myWindow.deptDG.selectedIndex = 0;
						myWindow.deptDG.dispatchEvent(new GridSelectionEvent(GridSelectionEvent.SELECTION_CHANGE,
																			 false,
																			 false,
																			 null,
																			 new CellRegion(0,
																							0)));
						myWindow.deptDG.setFocus();
					}
					else
					{
						myWindow.delBtn.enabled = false
						myWindow.deptDG.enabled = false;
					}
					if(myWindow.deptDG.dataProviderLength == 0)
						sendNotification(LocalConst.SUSBMA_POLIICY_RAW_LIST, -1);
					setRangeType();
					break;
				}
				
				//Grid에 저장될 데이터 로드 실패
				case LocalConst.SUSBMA_POLIICY_DEPT_LIST_LOADFAIL:
				{
					break;
				}
				
				//새항목 추가 성공
				case LocalConst.SUSBMA_POLIICY_DEPT_ADDSUCCESS:
				{
					sendNotification(LocalConst.SUSBMA_POLIICY_DEPT_LIST, myWindow.rangeType);
					break;
				}
				
				//새항목 추가 실패
				case LocalConst.SUSBMA_POLIICY_DEPT_ADDFAIL:
				{
					break;
				}
				
				//항목 삭제 성공
				case LocalConst.SUSBMA_POLIICY_DEPT_DELETESUCCESS:
				{
					sendNotification(LocalConst.SUSBMA_POLIICY_DEPT_LIST, myWindow.rangeType);
					break;
				}
				
				//항목 삭제 실패
				case LocalConst.SUSBMA_POLIICY_DEPT_DELETEFAIL:
				{
					break;
				}
				
			}
		}
		
		override public function onRegister():void
		{
			//컨트롤 초기화 루틴은 여기서
			myWindow.addBtn.addEventListener(MouseEvent.CLICK, onBtnClickHandler);
			myWindow.delBtn.addEventListener(MouseEvent.CLICK, onBtnClickHandler);
			myWindow.reloadBtn.addEventListener(MouseEvent.CLICK, onBtnClickHandler);
			
			//권한설정
			if(DmosFramework.getInstance().PERMISSION("D4_SUSBMA_POLICY"))
			{
				myWindow.addBtn.enabled = DmosFramework.getInstance().PERMISSION("D4_SUSBMA_POLICY").isAbleCreate();
				myWindow.delBtn.enabled = DmosFramework.getInstance().PERMISSION("D4_SUSBMA_POLICY").isAbleDelete();
			}
			
			myWindow.deptDG.addEventListener(GridSelectionEvent.SELECTION_CHANGE,
											 selectionChangeHandler);
			myWindow.addEventListener(CustomCheckBoxClickEvent.CUSTOM_CHECKBOX_CLICK,
									  checkBoxClickHandler);
		}
		
		override public function onRemove():void
		{
			myWindow.addBtn.removeEventListener(MouseEvent.CLICK, onBtnClickHandler);
			myWindow.delBtn.removeEventListener(MouseEvent.CLICK, onBtnClickHandler);
			myWindow.reloadBtn.removeEventListener(MouseEvent.CLICK, onBtnClickHandler);
			
			myWindow.deptDG.removeEventListener(GridSelectionEvent.SELECTION_CHANGE,
												selectionChangeHandler);
			myWindow.removeEventListener(CustomCheckBoxClickEvent.CUSTOM_CHECKBOX_CLICK,
										 checkBoxClickHandler);
		}
		
		private function setRangeType():void
		{
			var optionMediator:SusbmaPolicyOptionMediator = facade.retrieveMediator(SusbmaPolicyOptionMediator.NAME) as SusbmaPolicyOptionMediator;

			optionMediator.selectMasterVO.rangeType = 2;
			
			/**
			 * 20130227 김정욱 보조기억매체정책 비정상 정책 화면 출력현상 수정 START
			 */ 
			if(myWindow.deptDG.dataProviderLength == 0) {
				optionMediator.selectMasterVO.orgId = null;
				optionMediator.selectMasterVO.usbPolicyId = -1;
			}
			/**
			 * 20130227 김정욱 보조기억매체정책 비정상 정책 화면 출력현상 수정 END
			 */ 
		}
	}
}
