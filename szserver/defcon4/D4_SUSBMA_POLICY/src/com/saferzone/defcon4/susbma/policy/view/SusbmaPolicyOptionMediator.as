//------------------------------------------------------------------------------
//
//   Copyright 2011 
//   Saferzone All rights reserved. 
//
//------------------------------------------------------------------------------

package com.saferzone.defcon4.susbma.policy.view
{
	import com.saferzone.defcon4.common.DmosFramework;
	import com.saferzone.defcon4.common.consts.CustomerId;
	import com.saferzone.defcon4.common.utils.SZUtil;
	import com.saferzone.defcon4.services.vo.SusbmaPolicyMasterVO;
	import com.saferzone.defcon4.services.vo.SusbmaPolicyRawVO;
	import com.saferzone.defcon4.susbma.policy.ApplicationFacade;
	import com.saferzone.defcon4.susbma.policy.consts.LocalConst;
	import com.saferzone.defcon4.susbma.policy.view.comp.SusbmaPolicyOptionView;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.events.CloseEvent;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;
	
	import spark.events.IndexChangeEvent;
	
	public class SusbmaPolicyOptionMediator extends Mediator
	{
		
		//------------------------------------------------------------------------------
		//
		// Constants 
		//
		//------------------------------------------------------------------------------
		
		public static const NAME:String = 'SusbmaPolicyOptionMediator';
		public var isAgentlessWebUse:Boolean = DmosFramework.getInstance().CONFIG("AGENTLESS_MNGWEB_USE")=="1"?true:false;
		public var isWindowExplorerUse:Boolean = 
			DmosFramework.getInstance().CONFIG("AGENTLESS_MNGWEB_USE")=="1" && DmosFramework.getInstance().CONFIG("AGENTLESS_WINDOW_EXPLORER")=="0"?false:true;
		
		//------------------------------------------------------------------------------
		//
		// Constructor 
		//
		//------------------------------------------------------------------------------
		
		public function SusbmaPolicyOptionMediator(viewComponent:Object)
		{
			super(NAME, viewComponent);
		}
		
		
		//------------------------------------------------------------------------------
		//
		// Properties #public 
		//
		//------------------------------------------------------------------------------
		
		public var selectMasterVO:SusbmaPolicyMasterVO;
		
		public function get myWindow():SusbmaPolicyOptionView
		{
			return viewComponent as SusbmaPolicyOptionView;
		}
		
		//------------------------------------------------------------------------------
		//
		// Properties #private 
		//
		//------------------------------------------------------------------------------
		
		private var optionVO:SusbmaPolicyRawVO;
		private var state:int;
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
		//			sendNotification(LocalConst.SUSBMA_POLIICY_RAW_LIST, selectMasterVO.usbPolicyId);
		//		}
		
		/**
		 * 버튼클릭 Listener
		 */
		protected function onBtnClickHandler(event:MouseEvent):void
		{
			switch(event.currentTarget.id)
			{
				case "addBtn":
				{
					facade.sendNotification(LocalConst.SUSBMA_POLIICY_RAW_ADD, selectMasterVO.usbPolicyId);
					break;
				}
					
				case "saveBtn":
				{
					if(selectMasterVO == null)
						return;
					if((DmosFramework.getInstance().CUSTOMERID == CustomerId.CC_V5) &&	// cc일때만 체크
						//(int(myWindow.pwFailCount.text) > 5 || int(myWindow.pwFailCount.text) < 1)){			//SaferZone Version 2.0미만
						(int(myWindow.loginFailCount.text) > 5 || int(myWindow.loginFailCount.text) < 1)){      //SaferZone Version 2.0이상
						Alert.show(DmosFramework.getInstance().SNL("SC_INVALID_PASSWORD_FAILCNT"),
							DmosFramework.getInstance().SNL("PROGRAMTITLE_D4_SUSBMA_POLICY"), 
							Alert.OK | Alert.CANCEL, myWindow.parentApplication as Sprite, null, null, Alert.OK);
						break;
					}else{
						optionVO = getOptionValue();
						facade.sendNotification(LocalConst.SUSBMA_POLIICY_RAW_MODIFY,
							optionVO);
						break;	
					}	
				}
					
				case "delBtn":
				{
					//					facade.sendNotification(LocalConst.SUSBMA_POLIICY_RAW_DELETE,
					//											optionVO.policyId);
					Alert.show(DmosFramework.getInstance().SNL("SC_PROMPT_DELETE"),
						DmosFramework.getInstance().SNL("PROGRAMTITLE_D4_SUSBMA_POLICY"), 
						Alert.OK | Alert.CANCEL, myWindow.parentApplication as Sprite, deleteBtn_closeHandler, null, Alert.OK);
					break;
				}
					
				case "reloadBtn":
				{
					sendNotification(LocalConst.SUSBMA_POLIICY_RAW_LIST, selectMasterVO.usbPolicyId);
					break;
				}
					
				default:
					break;
			}
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
				LocalConst.SUSBMA_POLIICY_RAW_LIST_LOADSUCCESS,
				LocalConst.SUSBMA_POLIICY_RAW_ADDSUCCESS,
				LocalConst.SUSBMA_POLIICY_RAW_MODIFYSUCCESS,
				LocalConst.SUSBMA_POLIICY_RAW_DELETESUCCESS,
				
				//실패 notify
				LocalConst.SUSBMA_POLIICY_RAW_LIST_LOADFAIL,
				LocalConst.SUSBMA_POLIICY_RAW_ADDFAIL,
				LocalConst.SUSBMA_POLIICY_RAW_MODIFYFAIL,
				LocalConst.SUSBMA_POLIICY_RAW_DELETEFAIL
			];
		}
		
		/**
		 * 처리할 notification
		 */
		override public function handleNotification(notification:INotification):void
		{
			switch(notification.getName())
			{
				//항목 수정 성공
				case LocalConst.SUSBMA_POLIICY_RAW_LIST_LOADSUCCESS:
				{
					setRawList(notification.getBody());
					//sendNotification(LocalConst.SUSBMA_COMMON_POLICY_LOAD);
					break;
				}
					
					//항목 수정 성공
				case LocalConst.SUSBMA_POLIICY_RAW_LIST_LOADFAIL:
				{
					break;
				}
					
					//항목 수정 성공
				case LocalConst.SUSBMA_POLIICY_RAW_ADDSUCCESS:
				{
					if(selectMasterVO)
						myWindow.currentState = "selection";
					//					setDefaultOption();
					sendNotification(LocalConst.SUSBMA_POLIICY_RAW_LIST, selectMasterVO.usbPolicyId);
					break;
				}
					
					//항목 수정 성공
				case LocalConst.SUSBMA_POLIICY_RAW_ADDFAIL:
				{
				}
					
					//항목 저장 성공
				case LocalConst.SUSBMA_POLIICY_RAW_MODIFYSUCCESS:
				{
					sendNotification(LocalConst.SUSBMA_POLIICY_RAW_LIST, selectMasterVO.usbPolicyId);
					
					Alert.show(DmosFramework.getInstance().SNL("SC_POLICY_SAVE"),
						DmosFramework.getInstance().SNL("PROGRAMTITLE_D4_SUSBMA_POLICY"),
						Alert.OK);
					
					break;
				}
					
					//항목 삭제 실패
				case LocalConst.SUSBMA_POLIICY_RAW_MODIFYFAIL:
				{
					break;
				}
					
					//항목 삭제 성공
				case LocalConst.SUSBMA_POLIICY_RAW_DELETESUCCESS:
				{
					sendNotification(LocalConst.SUSBMA_POLIICY_RAW_LIST, selectMasterVO.usbPolicyId);
					break;
				}
					
					//항목 삭제 실패
				case LocalConst.SUSBMA_POLIICY_RAW_DELETEFAIL:
				{
					break;
				}
					
			}
		}
		
		protected function explorerGroupChangeRadioHandler(event:Event):void
		{
			state = 1;
			explorerGroupChangeRadionButton();
		}
		
		private function explorerGroupChangeRadionButton():void
		{
			if(myWindow.windowExplorer.selected){
				//전용탐색기 정책 사용금지
				myWindow.dedicatedExplorerFilePrint.selected = false;
				myWindow.dedicatedExplorerFileCopy.selected = false;
				myWindow.dedicatedExplorerFileEdit.selected = false;
				myWindow.dedicatedExplorerExternCopy.selected = false;
				myWindow.dedicatedExplorerPolicyOption.enabled = false;
				myWindow.fileSavePermission.dataProvider = myWindow.windowExplorerArr;
				
				if(myWindow.outSideReadWrite.selected)
				{
					myWindow.carryoutApprovalPolicyOption.enabled = true;
				}
			}
			else if(myWindow.dedicatedExplorer.selected){
				//전용탐색기 정책 사용
				
				if(myWindow.outSideReadOnly.selected)
				{
					myWindow.carryoutApprovalPolicyOption.enabled = true;
					if(myWindow.dedicatedExplorer.selected && myWindow.readWrite.selected && !myWindow.carryoutApproval.selected)
					{
						myWindow.dedicatedExplorerPolicyOption.enabled = true;	
					}else{
						myWindow.dedicatedExplorerFilePrint.selected = false;
						myWindow.dedicatedExplorerFileCopy.selected = false;
						myWindow.dedicatedExplorerFileEdit.selected = false;
						myWindow.dedicatedExplorerExternCopy.selected = false;
						myWindow.dedicatedExplorerPolicyOption.enabled = false;
					}
					
					
				}
				else if(myWindow.outSideReadWrite.selected)
				{
					myWindow.carryoutApprovalPolicyOption.enabled = true;
					myWindow.dedicatedExplorerFilePrint.selected = false;
					myWindow.dedicatedExplorerFileCopy.selected = false;
					myWindow.dedicatedExplorerFileEdit.selected = false;
					myWindow.dedicatedExplorerExternCopy.selected = false;
					myWindow.dedicatedExplorerPolicyOption.enabled = false;
				}
				else if(myWindow.outSideNotUse.selected)
				{
					myWindow.carryoutApprovalPolicyOption.enabled = false;
					myWindow.dedicatedExplorerFilePrint.selected = false;
					myWindow.dedicatedExplorerFileCopy.selected = false;
					myWindow.dedicatedExplorerFileEdit.selected = false;
					myWindow.dedicatedExplorerExternCopy.selected = false;
					myWindow.dedicatedExplorerPolicyOption.enabled = false;
				}
				
				
				myWindow.fileSavePermission.dataProvider = myWindow.decicatedExplorerArr;
			}
			
			if(myWindow.readOnly.selected){
				myWindow.outSideReadWrite.enabled = false;
				myWindow.fileSaveType.enabled = false;
				myWindow.fileApproval.selected = false;
				myWindow.fileApproval.enabled = false;
				
				
			}else if(myWindow.readWrite.selected){
				myWindow.outSideReadWrite.enabled = true;
				myWindow.fileSaveType.enabled = true;
				myWindow.fileApproval.enabled = true;
			}
			
			if(state== 1){
				myWindow.fileSavePermission.selectedIndex = 0;
			}
			
//			if(myWindow.windowExplorer.selected && myWindow.readWrite.selected && int(myWindow.fileSavePermission.selectedItem.value) == 0 )
//			{
//				myWindow.secureUsbFileSave.enabled = true;
//			}
//			else
//			{
//				myWindow.secureUsbFileSave.enabled = false;
//			}
			
			if(!isWindowExplorerUse){
				myWindow.dedicatedExplorer.selected = true;
			}
		}
		
		protected function fileReadWriteGroupChangeRadioHandler(event:Event):void
		{
			state = 1;
			fileReadWriteGroupChangeRadionButton();
		}
		
		private function fileReadWriteGroupChangeRadionButton():void
		{
			if(myWindow.readOnly.selected){
				myWindow.fileApproval.selected = false;
				myWindow.fileApproval.enabled = false;
				myWindow.approvalFileMoveDataDelete.selected = false;
				myWindow.approvalFileMoveDataDelete.enabled = false;
				myWindow.outSideReadWrite.enabled = false;
				if(state== 1){
					myWindow.outSideReadOnly.selected = true;
				}
				myWindow.fileSaveType.enabled = false;
				myWindow.dedicatedExplorerFilePrint.selected = false;
				myWindow.dedicatedExplorerFileCopy.selected = false;
				myWindow.dedicatedExplorerFileEdit.selected = false;
				myWindow.dedicatedExplorerExternCopy.selected = false;
				myWindow.dedicatedExplorerPolicyOption.enabled = false;
			}else if(myWindow.readWrite.selected){
				myWindow.fileApproval.enabled = true;
				if(myWindow.fileApproval.selected)
				{
					myWindow.approvalFileMoveDataDelete.enabled = true;
				}
				myWindow.outSideReadWrite.enabled = true;
				myWindow.fileSaveType.enabled = true;
				if(!myWindow.carryoutApproval.selected && myWindow.dedicatedExplorer.selected){
					myWindow.dedicatedExplorerPolicyOption.enabled = true;	
				}
				
			}
			
			if(myWindow.windowExplorer.selected)
			{
				myWindow.fileSavePermission.dataProvider = myWindow.windowExplorerArr;
			}
			else if(myWindow.dedicatedExplorer.selected)
			{
				myWindow.fileSavePermission.dataProvider = myWindow.decicatedExplorerArr;
			}
			
			if(state== 1)
			{	
				myWindow.fileSavePermission.selectedIndex = 0;
			}
			
//			if(myWindow.windowExplorer.selected && myWindow.readWrite.selected && int(myWindow.fileSavePermission.selectedItem.value) == 0 )
//			{
//				myWindow.secureUsbFileSave.enabled = true;
//			}
//			else
//			{
//				myWindow.secureUsbFileSave.enabled = false;
//			}
		}
		
		protected function outSideGroupChangeRadioHandler(event:Event):void
		{
			outSideGroupChangeRadionButton();
		}
		
		private function outSideGroupChangeRadionButton():void
		{
			//사외 사용 - 읽기 전용
			if(myWindow.outSideReadOnly.selected)  
			{
				myWindow.carryoutApprovalPolicyOption.enabled = true;
				
				if(myWindow.dedicatedExplorer.selected && myWindow.readWrite.selected && !myWindow.carryoutApproval.selected )
				{
					myWindow.dedicatedExplorerPolicyOption.enabled = true;	
				}else{
					myWindow.dedicatedExplorerFilePrint.selected = false;
					myWindow.dedicatedExplorerFileCopy.selected = false;
					myWindow.dedicatedExplorerFileEdit.selected = false;
					myWindow.dedicatedExplorerExternCopy.selected = false;
					myWindow.dedicatedExplorerPolicyOption.enabled = false;
				}	
			}
				
			//사외 사용 - 읽기 / 쓰기 전용
			else if(myWindow.outSideReadWrite.selected)  
			{
				myWindow.carryoutApprovalPolicyOption.enabled = true;
				
				if(myWindow.windowExplorer.selected)  
				{
					//전용탐색기 정책 사용 금지
					myWindow.dedicatedExplorerFilePrint.selected = false;
					myWindow.dedicatedExplorerFileCopy.selected = false;
					myWindow.dedicatedExplorerFileEdit.selected = false;
					myWindow.dedicatedExplorerExternCopy.selected = false;
					myWindow.dedicatedExplorerPolicyOption.enabled = false;	
				}
				else if(myWindow.dedicatedExplorer.selected)  
				{
					myWindow.dedicatedExplorerFilePrint.selected = false;
					myWindow.dedicatedExplorerFileCopy.selected = false;
					myWindow.dedicatedExplorerFileEdit.selected = false;
					myWindow.dedicatedExplorerExternCopy.selected = false;
					myWindow.dedicatedExplorerPolicyOption.enabled = false;					
				}	
			}
				
				//사외 사용 - 사용 불가
			else  if(myWindow.outSideNotUse.selected)  
			{
				//사외 사용 - 반출 결재 사용
				myWindow.carryoutApprovalPolicyOption.enabled = false;
				//전용탐색기 정책 사용 금지
				myWindow.dedicatedExplorerFilePrint.selected = false;
				myWindow.dedicatedExplorerFileCopy.selected = false;
				myWindow.dedicatedExplorerFileEdit.selected = false;
				myWindow.dedicatedExplorerExternCopy.selected = false;
				myWindow.dedicatedExplorerPolicyOption.enabled = false;
			}
		}
		
		protected function carryoutApprovalChangeRadioHandler(event:Event):void
		{
			carryoutApprovalChangeToggleButton();
		}
		
		private function carryoutApprovalChangeToggleButton():void
		{
			// 반출 결재 사용
			if(!myWindow.carryoutApproval.selected)
			{
				if(myWindow.windowExplorer.selected)  
				{
					//전용탐색기 정책 사용 금지
					myWindow.dedicatedExplorerFilePrint.selected = false;
					myWindow.dedicatedExplorerFileCopy.selected = false;
					myWindow.dedicatedExplorerFileEdit.selected = false;
					myWindow.dedicatedExplorerExternCopy.selected = false;
					myWindow.dedicatedExplorerPolicyOption.enabled = false;
				}
				else if(myWindow.dedicatedExplorer.selected)  
				{
					if(myWindow.outSideReadOnly.selected && myWindow.readWrite.selected)
					{
						//전용탐색기 정책 사용
						myWindow.dedicatedExplorerPolicyOption.enabled = true;
					}
				}
			}
			else if(myWindow.carryoutApproval.selected)
			{
				//전용탐색기 정책 사용 금지
				myWindow.dedicatedExplorerFilePrint.selected = false;
				myWindow.dedicatedExplorerFileCopy.selected = false;
				myWindow.dedicatedExplorerFileEdit.selected = false;
				myWindow.dedicatedExplorerExternCopy.selected = false;
				myWindow.dedicatedExplorerPolicyOption.enabled = false;
			}
		}
		
//		protected function fileSavePermIndexChangeHandler(event:IndexChangeEvent):void
//		{
//			var value:int = int(event.currentTarget.selectedItem.value)
//			switch  (value)
//			{
//				case 0:
//				{
//					myWindow.secureUsbFileSave.enabled = true;
//					break;
//				}
//					
//				default :
//				{
//					myWindow.secureUsbFileSave.enabled = false;
//					break;
//				}
//			}
//		}
		
		override public function onRegister():void
		{
			//컨트롤 초기화 루틴은 여기서
			myWindow.addBtn.addEventListener(MouseEvent.CLICK, onBtnClickHandler);
			myWindow.saveBtn.addEventListener(MouseEvent.CLICK, onBtnClickHandler);
			myWindow.delBtn.addEventListener(MouseEvent.CLICK, onBtnClickHandler);
			myWindow.reloadBtn.addEventListener(MouseEvent.CLICK, onBtnClickHandler);
			
			myWindow.fileSaveGroup.addEventListener(Event.CHANGE, onChangeRadioHandler);
			myWindow.takeOutGroup.addEventListener(Event.CHANGE, takeOutGroupChangeRadioHandler);
			
			myWindow.explorerGroup.addEventListener(Event.CHANGE, explorerGroupChangeRadioHandler);
			myWindow.fileReadWriteGroup.addEventListener(Event.CHANGE, fileReadWriteGroupChangeRadioHandler);
			myWindow.outSideGroup.addEventListener(Event.CHANGE, outSideGroupChangeRadioHandler);
			myWindow.carryoutApproval.addEventListener(Event.CHANGE, carryoutApprovalChangeRadioHandler);
			//myWindow.fileSavePermission.addEventListener(IndexChangeEvent.CHANGE, fileSavePermIndexChangeHandler);
			if(DmosFramework.getInstance().PERMISSION("D4_SUSBMA_POLICY"))
			{
				myWindow.addBtn.enabled = DmosFramework.getInstance().PERMISSION("D4_SUSBMA_POLICY").isAbleCreate();
				myWindow.saveBtn.enabled = DmosFramework.getInstance().PERMISSION("D4_SUSBMA_POLICY").isAbleUpdate();
				myWindow.delBtn.enabled = DmosFramework.getInstance().PERMISSION("D4_SUSBMA_POLICY").isAbleDelete();
			}			
			
			if(!isWindowExplorerUse){
				myWindow.dedicatedExplorer.selected = true;
			}
			
			myWindow.fileApproval.addEventListener(Event.CHANGE, fileApprovalChangeHandler);
		}
		
		override public function onRemove():void
		{
			myWindow.addBtn.removeEventListener(MouseEvent.CLICK, onBtnClickHandler);
			myWindow.saveBtn.removeEventListener(MouseEvent.CLICK, onBtnClickHandler);
			myWindow.delBtn.removeEventListener(MouseEvent.CLICK, onBtnClickHandler);
			myWindow.reloadBtn.removeEventListener(MouseEvent.CLICK, onBtnClickHandler);
			
			myWindow.fileSaveGroup.removeEventListener(Event.CHANGE, onChangeRadioHandler);
			myWindow.takeOutGroup.removeEventListener(Event.CHANGE, takeOutGroupChangeRadioHandler);

			myWindow.explorerGroup.removeEventListener(Event.CHANGE, explorerGroupChangeRadioHandler);
			myWindow.fileReadWriteGroup.removeEventListener(Event.CHANGE, fileReadWriteGroupChangeRadioHandler);
			myWindow.outSideGroup.removeEventListener(Event.CHANGE, outSideGroupChangeRadioHandler);
			myWindow.carryoutApproval.removeEventListener(Event.CHANGE, carryoutApprovalChangeRadioHandler);
//			myWindow.fileSavePermission.removeEventListener(IndexChangeEvent.CHANGE, fileSavePermIndexChangeHandler);
			
			myWindow.fileApproval.removeEventListener(Event.CHANGE, fileApprovalChangeHandler);
		}
		
		protected function fileApprovalChangeHandler(event:Event):void
		{
			fileApprovalChangeButton()
		}
		
		private function  fileApprovalChangeButton():void
		{	
			if(myWindow.readWrite.selected && myWindow.fileApproval.selected)
			{
				myWindow.approvalFileMoveDataDelete.enabled = true;
			}
			else
			{
				myWindow.approvalFileMoveDataDelete.enabled = false;
			}
		}
		
		
		/**
		 * 20130206 김정욱 보조기억매체정책 화면에서 라디오박스 선택 시 파일 저장 옵션 활성/비활성 옵션이 동작하도록 수정 START - #1515
		 * 
		 */
		protected function onChangeRadioHandler(event:Event):void
		{
			changeRadionButton();
		}
			
		private function changeRadionButton():void
		{
			if(myWindow.saveTypeDec.selected || myWindow.saveTypeNor.selected || myWindow.saveTypeRead.selected ){
				myWindow.fileAppGroup.enabled = false;
				myWindow.exFileGroup.enabled = false;
			}else{
				if(myWindow.exFileType.selected){
					myWindow.exFileGroup.enabled = true;
					myWindow.fileAppGroup.enabled = false;
					if(!myWindow.rbExReadOnly.selected && !myWindow.rbExReadWrite.selected){
						myWindow.rbExReadOnly.selected = true;
					}
				}else if(myWindow.saveTypeFileApp.selected){
					myWindow.exFileGroup.enabled = false;
					myWindow.fileAppGroup.enabled = true;
					if(!myWindow.fileWriteY.selected && !myWindow.fileWriteN.selected){
						myWindow.fileWriteY.selected = true;
					}
				}
			}
		}
		
		protected function takeOutGroupChangeRadioHandler(event:Event):void
		{
			takeOutGroupChangeRadionButton();
		}
		
		private function takeOutGroupChangeRadionButton():void
		{
			if(myWindow.takeOutUseY.selected == true) 
			{
				myWindow.takeOutUseNYGroup.enabled = false;	
			}
			
			if(myWindow.takeOutUseNN.selected == true)
			{	
				myWindow.takeOutUseNYGroup.enabled = false;
			}
			
			if(myWindow.takeOutUseNY.selected == true)
			{
				myWindow.takeOutUseNYGroup.enabled = true;
			}
		}
		
		/**
		 * 20130206 보조기억매체정책 화면에서 라디오박스 선택 시 파일 저장 옵션 활성/비활성 옵션이 동작하도록 수정 END - #1515
		 * 
		 */
		
		//--------------------------------------
		// public 
		//--------------------------------------
		
		public function setRawList(object:Object):void
		{
			changeToolbarEnable(LocalConst.BTN_SAVE, false);
			changeToolbarEnable(LocalConst.BTN_ADD, false);
			changeToolbarEnable(LocalConst.BTN_DELETE, false);
			changeToolbarEnable(LocalConst.BTN_REFRESH, true);
			
			myWindow.currentState = "selection";
			state = 0;
			optionVO = object as SusbmaPolicyRawVO;
			if(!optionVO || optionVO.policyId == 0 || isNaN(optionVO.policyId))
			{
				if(optionVO.usbPolicyId != -1)
				{
					changeToolbarEnable(LocalConst.BTN_ADD, true);
				}
				changeToolbarEnable(LocalConst.BTN_SAVE, false);
				changeToolbarEnable(LocalConst.BTN_DELETE, false);
				changeToolbarEnable(LocalConst.BTN_REFRESH, true);
				clearOptionView();
			}
			else
			{
				changeToolbarEnable(LocalConst.BTN_SAVE, true);
				changeToolbarEnable(LocalConst.BTN_DELETE, true);
				changeToolbarEnable(LocalConst.BTN_REFRESH, true);
				setOptionValue();
			}
			/*
			if(selectMasterVO.rangeType == 2){
			if(selectMasterVO.orgId == null)
			changeToolbarEnable(LocalConst.BTN_ADD, false);
			else 
			changeToolbarEnable(LocalConst.BTN_ADD, true);
			}
			else if(selectMasterVO.rangeType == 3)
			{
			if(selectMasterVO.grpId == 0)
			changeToolbarEnable(LocalConst.BTN_ADD, false);
			else
			changeToolbarEnable(LocalConst.BTN_ADD, true);
			}
			*/
			/*  BTS - 1029번 반영, 정책 목록 있으면 추가 버튼 비활성화 처리
			else
			{
			changeToolbarEnable(LocalConst.BTN_ADD, false);
			}
			*/
			
			/**
			 * 20130206 김정욱 보조기억매체정책 화면에서 라디오박스 선택 시 파일 저장 옵션 활성/비활성 옵션이 동작하도록 수정 START - #1515
			 * 
			 */
			changeRadionButton();
			takeOutGroupChangeRadionButton();
			explorerGroupChangeRadionButton();
			fileReadWriteGroupChangeRadionButton();
			outSideGroupChangeRadionButton();
			carryoutApprovalChangeToggleButton();
			fileApprovalChangeButton();
			/**
			 * 20130206 김정욱 보조기억매체정책 화면에서 라디오박스 선택 시 파일 저장 옵션 활성/비활성 옵션이 동작하도록 수정 END - #1515
			 * 
			 */
		}
		
		public function clearOptionView():void
		{
			myWindow.currentState = "nothing";
			clearOptionValue();
		}
		
		//--------------------------------------
		// private 
		//--------------------------------------
		
		private function setOptionValue():void
		{
			/**
			 * 20130206 김정욱 보조기억매체정책 화면에서 라디오박스 선택 시 파일 저장 옵션 활성/비활성 옵션이 동작하도록 수정 START - #1515
			 * 
			 */
			if(myWindow.SaferZoneVersion < 2)
			{
				var configValue:String = DmosFramework.getInstance().CONFIG("USB_POLICY_DECICATED_EXPLORER");
				var fileAppConfigValue:String = DmosFramework.getInstance().CONFIG("USB_POLICY_FILE_APPROVAL");
				
				if(optionVO.saveType == 2){
					myWindow.saveTypeDec.selected = true;
					myWindow.saveTypeNor.selected = false;
					myWindow.saveTypeRead.selected = false;
					myWindow.saveTypeFileApp.selected = false;
					myWindow.exFileType.selected = false;
					myWindow.fileWriteY.selected = false;
					myWindow.fileWriteN.selected = false;
					myWindow.rbExReadOnly.selected = false;
					myWindow.rbExReadWrite.selected = false;
				}else if(optionVO.saveType == 1){
					if(optionVO.fileRead == 0 && optionVO.fileWrite== 0){
						myWindow.saveTypeDec.selected = false;
						myWindow.saveTypeNor.selected = true;
						myWindow.saveTypeRead.selected = false;
						myWindow.saveTypeFileApp.selected = false;
						myWindow.exFileType.selected = false;
						myWindow.fileWriteY.selected = false;
						myWindow.fileWriteN.selected = false;
						myWindow.rbExReadOnly.selected = false;
						myWindow.rbExReadWrite.selected = false;
					}else if(optionVO.fileRead == 0 && optionVO.fileWrite == 1){
						myWindow.saveTypeDec.selected = false;
						myWindow.saveTypeNor.selected = false;
						myWindow.saveTypeRead.selected = true;
						myWindow.saveTypeFileApp.selected = false;
						myWindow.exFileType.selected = false;
						myWindow.fileWriteY.selected = false;
						myWindow.fileWriteN.selected = false;
						myWindow.rbExReadOnly.selected = false;
						myWindow.rbExReadWrite.selected = false;
					}
				}else if(optionVO.saveType == 4){
					myWindow.saveTypeDec.selected = false;
					myWindow.saveTypeNor.selected = false;
					myWindow.saveTypeRead.selected = false;
					myWindow.saveTypeFileApp.selected = false;
					myWindow.exFileType.selected = true;
					myWindow.fileWriteY.selected = false;
					myWindow.fileWriteN.selected = false;
					myWindow.rbExReadOnly.selected = true;
					myWindow.rbExReadWrite.selected = false;
				}else if(optionVO.saveType == 5){
					myWindow.saveTypeDec.selected = false;
					myWindow.saveTypeNor.selected = false;
					myWindow.saveTypeRead.selected = false;
					myWindow.saveTypeFileApp.selected = false;
					myWindow.exFileType.selected = true;
					myWindow.fileWriteY.selected = false;
					myWindow.fileWriteN.selected = false;
					myWindow.rbExReadOnly.selected = false;
					myWindow.rbExReadWrite.selected = true;
				}else if(optionVO.saveType == 7){
					myWindow.saveTypeDec.selected = false;
					myWindow.saveTypeNor.selected = false;
					myWindow.saveTypeRead.selected = false;
					myWindow.saveTypeFileApp.selected = true;
					myWindow.exFileType.selected = false;
					myWindow.fileWriteY.selected = true;
					myWindow.fileWriteN.selected = false;
					myWindow.rbExReadOnly.selected = false;
					myWindow.rbExReadWrite.selected = false;
				}else if(optionVO.saveType == 8){
					myWindow.saveTypeDec.selected = false;
					myWindow.saveTypeNor.selected = false;
					myWindow.saveTypeRead.selected = false;
					myWindow.saveTypeFileApp.selected = true;
					myWindow.exFileType.selected = false;
					myWindow.fileWriteY.selected = false;
					myWindow.fileWriteN.selected = true;
					myWindow.rbExReadOnly.selected = false;
					myWindow.rbExReadWrite.selected = false;
				}	
				
				//반출기능사용
				if (configValue == "1") {
					if(optionVO.takeOutUse == 0){
						myWindow.takeOutUseY.selected = true;
						myWindow.takeOutUseNN.selected = false;
						myWindow.takeOutUseNY.selected = false;
					}else if(optionVO.takeOutUse == 256){
						myWindow.takeOutUseY.selected = false;
						myWindow.takeOutUseNN.selected = true;
						myWindow.takeOutUseNY.selected = false;
					}else{
						myWindow.takeOutUseY.selected = false;
						myWindow.takeOutUseNN.selected = false;
						myWindow.takeOutUseNY.selected = true;
						
						var bit:String = int(optionVO.takeOutUse).toString(2);
						bit = bit.substring(6,bit.length)
						var arrPolicy:Array = [myWindow.filePrint, myWindow.fileCopy, myWindow.fileEdit, myWindow.externalCopy];
						for(var pos:int = 1; pos <= arrPolicy.length; pos++){
							if(bit.substring(arrPolicy.length-pos,arrPolicy.length-pos+1) == "1"){
								arrPolicy[pos-1].selected = true;
							}
						}	
						
					}
				}else{
					if(optionVO.takeOutUse == 0 ||optionVO.takeOutUse == 3){
						myWindow.takeOutUseY.selected = true;
					}else if(optionVO.takeOutUse == 1){
						myWindow.takeOutUseNN.selected = true;
					}else if(optionVO.takeOutUse == 2 || optionVO.takeOutUse == 4){
						myWindow.takeOutUseNY.selected = true;
					}
				}
				
				/**
				 * 20130206 김정욱 보조기억매체정책 화면에서 라디오박스 선택 시 파일 저장 옵션 활성/비활성 옵션이 동작하도록 수정 END - #1515
				 * 
				 */
				/*
				else if(optionVO.saveType == 0)
				myWindow.saveTypeCert.selected = true;
				*/
				
				//패스워드 실패시-실패횟수
				if(!isNaN(optionVO.pwFailCount))
					myWindow.pwFailCount.text = String(optionVO.pwFailCount);
				//분실신고
				myWindow.pwFail.selected = Boolean(optionVO.pwFailAlert);
				//사용여부
				myWindow.pwFailBlock.selected = Boolean(optionVO.pwFailBlock);
				//데이터삭제
				myWindow.pwFailDelete.selected = Boolean(optionVO.pwFailDelete);
				
				//외부PC에서 파일 복호화
				if(optionVO.decriptOpt == 0)
					myWindow.decriptOptY.selected = true;
				else if(optionVO.decriptOpt == 1)
					myWindow.decriptOptN.selected = true;
				else if(optionVO.decriptOpt == 2)
					myWindow.decriptOptYY.selected = true;
				
				//원본저장여부
				myWindow.sourceFileOpt.selected = Boolean(optionVO.sourceFileOpt);
			}
			//**************************************SaferZone v5.2 Policy VO UI Setting ******************************************
			else
			{
				
				if(optionVO.saveType == 0 || optionVO.saveType == 1 || optionVO.saveType == 2)
				{
					myWindow.fileSavePermission.dataProvider = myWindow.windowExplorerArr;
				}
				else
				{
					myWindow.fileSavePermission.dataProvider = myWindow.decicatedExplorerArr;
				}
				
				if(optionVO.saveType == 0)
				{
					myWindow.windowExplorer.selected = true;
					myWindow.readWrite.selected = true;
					myWindow.dedicatedExplorer.selected = false;
					myWindow.readOnly.selected = false;
					myWindow.fileSavePermission.selectedIndex = 1;
				}
				else if(optionVO.saveType == 1)
				{
					myWindow.windowExplorer.selected = true;
					myWindow.readOnly.selected = true;
					myWindow.dedicatedExplorer.selected = false;
					myWindow.readWrite.selected = false;
				}
				else if(optionVO.saveType == 2)
				{
					myWindow.windowExplorer.selected = true;
					myWindow.readWrite.selected = true;
					myWindow.dedicatedExplorer.selected = false;
					myWindow.readOnly.selected = false;
					myWindow.fileSavePermission.selectedIndex = 0;
				}
				else if(optionVO.saveType == 3)
				{
					myWindow.dedicatedExplorer.selected = true;
					myWindow.readOnly.selected = true;
					myWindow.windowExplorer.selected = false;
					myWindow.readWrite.selected = false;
				}
				else if(optionVO.saveType == 4)
				{
					myWindow.dedicatedExplorer.selected = true;
					myWindow.readWrite.selected = true;
					myWindow.windowExplorer.selected = false;
					myWindow.readOnly.selected = false;
					myWindow.fileSavePermission.selectedIndex = 0;
				}
				else if(optionVO.saveType == 5)
				{
					myWindow.dedicatedExplorer.selected = true;
					myWindow.readWrite.selected = true;
					myWindow.windowExplorer.selected = false;
					myWindow.readOnly.selected = false;
					myWindow.fileSavePermission.selectedIndex = 1;
				}
				else if(optionVO.saveType == 6)
				{
					myWindow.dedicatedExplorer.selected = true;
					myWindow.readWrite.selected = true;
					myWindow.windowExplorer.selected = false;
					myWindow.readOnly.selected = false;
					myWindow.fileSavePermission.selectedIndex = 2;
				}
				else if(optionVO.saveType == 7)
				{
					myWindow.dedicatedExplorer.selected = true;
					myWindow.readWrite.selected = true;
					myWindow.windowExplorer.selected = false;
					myWindow.readOnly.selected = false;
//					myWindow.readWriteDetail04.selected = true;
				}
				
				if(optionVO.takeOutUse == 0)
				{
					myWindow.outSideReadOnly.selected = true;
					myWindow.outSideReadWrite.selected = false;
					myWindow.outSideNotUse.selected = false;
				}
				else if(optionVO.takeOutUse == 1)
				{
					myWindow.outSideReadOnly.selected = false;
					myWindow.outSideReadWrite.selected = true;
					myWindow.outSideNotUse.selected = false;
				}
				else if(optionVO.takeOutUse == 2)
				{
					myWindow.outSideReadOnly.selected = false;
					myWindow.outSideReadWrite.selected = false;
					myWindow.outSideNotUse.selected = true;
				}
				
				if(optionVO.approvalSystem == 1)
				{
					myWindow.carryoutApproval.selected = true;
				}
				else if(optionVO.approvalSystem == 0)
				{
					myWindow.carryoutApproval.selected = false;
				}
				
				if(optionVO.printUse == 1)
				{
					myWindow.dedicatedExplorerFilePrint.selected = true;
				}
				else if(optionVO.printUse == 0)
				{
					myWindow.dedicatedExplorerFilePrint.selected = false;
				}
				
				if(optionVO.externalCopy == 1)
				{
					myWindow.dedicatedExplorerFileCopy.selected = true;
				}
				else if(optionVO.externalCopy == 0)
				{
					myWindow.dedicatedExplorerFileCopy.selected = false;
				}
				
				if(optionVO.editFile == 1)
				{
					myWindow.dedicatedExplorerFileEdit.selected = true;
				}
				else if(optionVO.editFile == 0)
				{
					myWindow.dedicatedExplorerFileEdit.selected = false;
				}
				
				if(optionVO.internalCopy == 1)
				{
					myWindow.dedicatedExplorerExternCopy.selected = true;
				}
				else if(optionVO.internalCopy == 0)
				{
					myWindow.dedicatedExplorerExternCopy.selected = false;
				}
				
				//패스워드 실패시-실패횟수
				if(!isNaN(optionVO.pwFailCount))
					myWindow.loginFailCount.text = String(optionVO.pwFailCount);
				
				//사용여부
				myWindow.usbUseDeny.selected = Boolean(optionVO.pwFailBlock);
				
				//데이터삭제
				myWindow.usbDataDelete.selected = Boolean(optionVO.pwFailDelete);
				
				//분실신고
				myWindow.usbLostReport.selected = Boolean(optionVO.pwFailAlert);
				
				//반출시 원본저장 여부
				//반출시 원본저장 여부
				// if(myWindow.windowExplorer.selected && myWindow.readWrite.selected && int(myWindow.fileSavePermission.selectedItem.value) == 0 )
				// {
				//	myWindow.secureUsbFileSave.enabled = true;
			//	}
		//		else
	//			{
//					myWindow.secureUsbFileSave.enabled = true;
				// }
				myWindow.secureUsbFileSave.selected = Boolean(optionVO.sourceFileOpt);
				
				//파일 결재 사용 유무
				myWindow.fileApproval.selected = Boolean(optionVO.fileApproval);
				
				myWindow.approvalFileMoveDataDelete.selected = Boolean(optionVO.approvalFileMoveDataDelete);
				
				if(!isWindowExplorerUse){
					myWindow.dedicatedExplorer.selected = true;
				}
			}
		}
		
		private function clearOptionValue():void
		{
			//파일저장옵션
			myWindow.saveTypeDec.selected = false;
			myWindow.saveTypeNor.selected = false;
			myWindow.saveTypeRead.selected = false;
			myWindow.saveTypeFileApp.selected = false;
			myWindow.fileWriteY.selected = false;
			myWindow.fileWriteN.selected = false;
			myWindow.exFileType.selected = false;
			myWindow.rbExReadOnly.selected = false;
			myWindow.rbExReadWrite.selected = false;
			
			//패스워드 실패시-실패횟수
			myWindow.pwFailCount.text = "";
			//분실신고
			myWindow.pwFail.selected = false;
			//사용여부
			myWindow.pwFailBlock.selected = false;
			//데이터삭제
			myWindow.pwFailDelete.selected = false;
			
			//반출기능사용
			myWindow.takeOutUseY.selected = false;
			myWindow.takeOutUseNN.selected = false;
			myWindow.takeOutUseNY.selected = false;
			myWindow.filePrint.selected = false;
			myWindow.fileCopy.selected = false;
			myWindow.fileEdit.selected = false;
			myWindow.externalCopy.selected = false;
			
			//외부PC에서 파일 복호화
			myWindow.decriptOptY.selected = false;
			myWindow.decriptOptN.selected = false;
			myWindow.decriptOptYY.selected = false;
			
			//원본저장여부
			myWindow.sourceFileOpt.selected = false;
			
			//**************************************SaferZone v5.2 Policy UI ******************************************
			
			//기본정책 보안 USB 사용 방식
			myWindow.windowExplorer.selected = false;
			myWindow.dedicatedExplorer.selected = false;
			myWindow.readOnly.selected = false;
			myWindow.readWrite.selected = false;
//			myWindow.readWriteDetail01.selected = false;
//			myWindow.readWriteDetail02.selected = false;
//			myWindow.readWriteDetail03.selected = false;
//			myWindow.readWriteDetail04.selected = false;
			
			//기본정책 보안 USB 사외 사용
			myWindow.outSideReadOnly.selected = false;
			myWindow.outSideReadWrite.selected = false;
			myWindow.outSideNotUse.selected = false;
			myWindow.carryoutApproval.selected = false;
			myWindow.dedicatedExplorerFilePrint.selected = false;
			myWindow.dedicatedExplorerFileCopy.selected = false;
			myWindow.dedicatedExplorerFileCopy.selected = false;
			myWindow.dedicatedExplorerFileCopy.selected = false;
			
			//기본정책 보안 USB 로그인 실패 처리
			myWindow.loginFailCount.text = "";
			myWindow.usbUseDeny.selected = false;
			myWindow.usbDataDelete.selected = false;
			myWindow.usbLostReport.selected = false;
			
			//기본정책 보안 원본 남김(사내)
			myWindow.secureUsbFileSave.selected = false;
			
			myWindow.fileApproval.selected = false;
			myWindow.approvalFileMoveDataDelete.selected = false;
			
			
			if(!isWindowExplorerUse){
				myWindow.dedicatedExplorer.selected = true;
			}
		}
		
		private function getOptionValue():SusbmaPolicyRawVO
		{
			if(myWindow.SaferZoneVersion < 2)
			{
				var configValue:String = DmosFramework.getInstance().CONFIG("USB_POLICY_DECICATED_EXPLORER");
				
				if(myWindow.saveTypeDec.selected){
					optionVO.saveType = 2;
					optionVO.fileRead = 0;
					optionVO.fileWrite = 0;
				}else if(myWindow.saveTypeNor.selected){
					optionVO.saveType = 1;
					optionVO.fileRead = 0;
					optionVO.fileWrite = 0;
				}else if(myWindow.saveTypeRead.selected){
					optionVO.saveType = 1;
					optionVO.fileRead = 0;
					optionVO.fileWrite = 1;
				}else if(myWindow.saveTypeFileApp.selected){
					if(myWindow.fileWriteY.selected){
						optionVO.saveType = 7;	
					}else if(myWindow.fileWriteN.selected){
						optionVO.saveType = 8;
					}
				}else if(myWindow.exFileType.selected){
					if(myWindow.rbExReadOnly.selected){
						optionVO.saveType = 4;	
					}else if(myWindow.rbExReadWrite.selected){
						optionVO.saveType = 5;
					}
				}
				
				
				var bit:String;	
				if (configValue == "1") {
					if(myWindow.takeOutUseY.selected){
						bit = "0000000000000000";
						optionVO.takeOutUse = parseInt(bit,2);
					}
					if(myWindow.takeOutUseNN.selected){
						bit = "0000000100000000";
						optionVO.takeOutUse = parseInt(bit,2);
					}
					if(myWindow.takeOutUseNY.selected){
						var frontBit:String = "00000010"
						var rearBit:String = "00000000";
						var arrPolicy:Array = [myWindow.filePrint, myWindow.fileCopy, myWindow.fileEdit, myWindow.externalCopy];
						for(var pos:int = 0; pos < arrPolicy.length; pos++){
							if(arrPolicy[pos].selected == true){
								rearBit = rearBit.slice(0,7-pos) + "1" + rearBit.substring(8-pos,8);
							}
						}
						bit = frontBit + rearBit;
						optionVO.takeOutUse = parseInt(bit,2);	
					}
				}else{
					if(myWindow.takeOutUseY.selected){
						optionVO.takeOutUse = 0;
					}
					
					if(myWindow.takeOutUseNN.selected){
						optionVO.takeOutUse = 1;
					}
					
					if(myWindow.takeOutUseNY.selected){
						optionVO.takeOutUse = 2;
					}
				}
				
				if(DmosFramework.getInstance().CUSTOMERID == CustomerId.CC_V5)
				{
					//패스워드 실패시-실패횟수
					if(int(myWindow.pwFailCount.text) > 5 || int(myWindow.pwFailCount.text) < 1)	optionVO.pwFailCount = 5;
					else	optionVO.pwFailCount = int(myWindow.pwFailCount.text);
					
					
					
					optionVO.pwFailAlert	= 1;
					optionVO.pwFailBlock	= 1;
					optionVO.pwFailDelete	= 1;
					//파일사용옵션-읽기
					optionVO.fileRead = 1;
					//파일사용옵션-쓰기
					optionVO.fileWrite = 1;
				}
				else
				{
					//패스워드 실패시-실패횟수
					optionVO.pwFailCount = int(myWindow.pwFailCount.text);
					//분실신고
					optionVO.pwFailAlert = int(myWindow.pwFail.selected);
					//사용여부
					optionVO.pwFailBlock = int(myWindow.pwFailBlock.selected);
					//데이터삭제
					optionVO.pwFailDelete = int(myWindow.pwFailDelete.selected);
				}
				
				//외부PC에서 파일 복호화
				if(myWindow.decriptOptY.selected)
					optionVO.decriptOpt = 0;
				if(myWindow.decriptOptN.selected)
					optionVO.decriptOpt = 1;
				if(myWindow.decriptOptYY.selected)
					optionVO.decriptOpt = 2;
				
				optionVO.policyId = selectMasterVO.policyId;
				optionVO.usbPolicyId = selectMasterVO.usbPolicyId;
				
				//원본저장여부
				optionVO.sourceFileOpt = int(myWindow.sourceFileOpt.selected);
			}
			//*********************************** SaferZone v5.2 Value get VO *************************************
			else
			{

				if(myWindow.windowExplorer.selected)
				{
					if(myWindow.readOnly.selected)
					{
						optionVO.saveType = 1;
						optionVO.fileRead = 0;
						optionVO.fileWrite = 1;	
					}
					else if(myWindow.readWrite.selected)
					{
						if(int(myWindow.fileSavePermission.selectedItem.value) == 0)
						{
							optionVO.saveType = 2;
							optionVO.fileRead = 0;
							optionVO.fileWrite = 0;	
						}
						else if(int(myWindow.fileSavePermission.selectedItem.value) == 1)
						{
							optionVO.saveType = 0;
							optionVO.fileRead = 0;
							optionVO.fileWrite = 1;	
						}
					}
				}
				else if(myWindow.dedicatedExplorer.selected)
				{
					if(myWindow.readOnly.selected)
					{
						optionVO.saveType = 3;
					}
					else if(myWindow.readWrite.selected)
					{
						if(int(myWindow.fileSavePermission.selectedItem.value) == 0)
						{
							optionVO.saveType = 4;
						}
						else if(int(myWindow.fileSavePermission.selectedItem.value) == 1)
						{
							optionVO.saveType = 5;
						}
						else if(int(myWindow.fileSavePermission.selectedItem.value) == 2)
						{
							optionVO.saveType = 6;
						}
					}
					optionVO.fileRead = 1;
					optionVO.fileWrite = 1;	
				}
				

				
				if(myWindow.outSideReadOnly.selected)
				{
					//사외 정책 - 읽기전용
					optionVO.takeOutUse = 0;
					if(myWindow.carryoutApproval.selected)
					{
						optionVO.approvalSystem = 1;
						optionVO.printUse = 0;	
						optionVO.externalCopy = 0;	
						optionVO.editFile = 0;	
						optionVO.internalCopy = 0;	
					}
					else
					{
						optionVO.approvalSystem = 0;	
						if(myWindow.dedicatedExplorerFilePrint.selected)
						{
							optionVO.printUse = 1;
						}
						else
						{
							optionVO.printUse = 0;	
						}
						
						if(myWindow.dedicatedExplorerFileCopy.selected)
						{
							optionVO.externalCopy= 1;
						}
						else
						{
							optionVO.externalCopy = 0;	
						}
						
						if(myWindow.dedicatedExplorerFileEdit.selected)
						{
							optionVO.editFile = 1;
						}
						else
						{
							optionVO.editFile = 0;	
						}
						
						if(myWindow.dedicatedExplorerExternCopy.selected)
						{
							optionVO.internalCopy = 1;
						}
						else
						{
							optionVO.internalCopy = 0;	
						}
						
						
					}
				}
				else if(myWindow.outSideReadWrite.selected)
				{
					//사외 정책 - 읽기 쓰기
					optionVO.takeOutUse = 1;
					if(myWindow.carryoutApproval.selected)
					{
						optionVO.approvalSystem = 1;
					}
					else
					{
						optionVO.approvalSystem = 0;	
					}
					optionVO.printUse = 0;	
					optionVO.externalCopy = 0;	
					optionVO.editFile = 0;	
					optionVO.internalCopy = 0;	
				}
				else if(myWindow.outSideNotUse.selected)
				{
					//사외 정책 - 사용불가
					optionVO.takeOutUse = 2;
					optionVO.approvalSystem = 0;	
					optionVO.printUse = 0;	
					optionVO.externalCopy = 0;	
					optionVO.editFile = 0;	
					optionVO.internalCopy = 0;	
				}
	
				//패스워드 실패시-실패횟수
				optionVO.pwFailCount = int(myWindow.loginFailCount.text);
				//사용여부
				optionVO.pwFailBlock = int(myWindow.usbUseDeny.selected);
				//데이터삭제
				optionVO.pwFailDelete = int(myWindow.usbDataDelete.selected);
				//분실신고
				optionVO.pwFailAlert = int(myWindow.usbLostReport.selected);
				
				optionVO.decriptOpt = 0;
				
				//반출시 원본저장 여부
				if(myWindow.windowExplorer.selected && myWindow.readWrite.selected && int(myWindow.fileSavePermission.selectedItem.value) == 0 )
				{
					optionVO.sourceFileOpt = int(myWindow.secureUsbFileSave.selected);
				}
				else
				{
					optionVO.sourceFileOpt  = int(myWindow.secureUsbFileSave.selected);
				}

				optionVO.fileApproval = int(myWindow.fileApproval.selected);
				optionVO.approvalFileMoveDataDelete = int(myWindow.approvalFileMoveDataDelete.selected);
			
				optionVO.policyId = selectMasterVO.policyId;
				optionVO.usbPolicyId = selectMasterVO.usbPolicyId;
				
			}
			
			return optionVO;
		}
		
		protected function deleteBtn_closeHandler(event:CloseEvent):void
		{
			if(event.detail == Alert.OK)
			{
				facade.sendNotification(LocalConst.SUSBMA_POLIICY_RAW_DELETE,
					optionVO);
			}
		}
		
		public function changeToolbarEnable(btn:int, enable:Boolean):void
		{
			switch(btn)
			{
				case LocalConst.BTN_SAVE:
				{
					myWindow.saveBtn.enabled = enable;
					break;
				}
				case LocalConst.BTN_ADD:
				{
					myWindow.addBtn.enabled = enable;
					break;
				}
				case LocalConst.BTN_DELETE:
				{
					myWindow.delBtn.enabled = enable;
					break;
				}
				case LocalConst.BTN_REFRESH:
				{
					myWindow.reloadBtn.enabled = enable;
					break;
				}
			}		
		}
	}
}