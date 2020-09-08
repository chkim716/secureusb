//------------------------------------------------------------------------------
//
//   Copyright 2011 
//   Saferzone All rights reserved. 
//
//------------------------------------------------------------------------------

package com.saferzone.defcon4.susbma.policy.view
{
	import com.saferzone.defcon4.common.DmosFramework;
	import com.saferzone.defcon4.common.ISZPopupResponder;
	import com.saferzone.defcon4.services.vo.SusbmaClassVO;
	import com.saferzone.defcon4.services.vo.SusbmaPolicyMasterVO;
	import com.saferzone.defcon4.services.vo.SusbmaPolicyRawVO;
	import com.saferzone.defcon4.susbma.policy.consts.LocalConst;
	import com.saferzone.defcon4.susbma.policy.event.CustomCheckBoxClickEvent;
	import com.saferzone.defcon4.susbma.policy.view.comp.SusbmaPolicyClassView;
	import com.saferzone.defcon4.susbma.policy.view.comp.SusbmaPolicyGroupPopup;
	
	import flash.display.DisplayObject;
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
	
	public class SusbmaPolicyClassMediator extends Mediator implements ISZPopupResponder
	{
		
		//------------------------------------------------------------------------------
		//
		// Constants 
		//
		//------------------------------------------------------------------------------
		
		public static const NAME:String = 'SusbmaPolicyClassMediator';
		
		//------------------------------------------------------------------------------
		//
		// Constructor 
		//
		//------------------------------------------------------------------------------
		
		public function SusbmaPolicyClassMediator(viewComponent:Object)
		{
			super(NAME, viewComponent);
		}
		
		
		//------------------------------------------------------------------------------
		//
		// Properties #public 
		//
		//------------------------------------------------------------------------------
		
		public function get myWindow():SusbmaPolicyClassView
		{
			return viewComponent as SusbmaPolicyClassView;
		}
		
		//------------------------------------------------------------------------------
		//
		// Properties #private 
		//
		//------------------------------------------------------------------------------
		
		//private var firstTime:Boolean = true;
		
		//private var optionVO:SusbmaPolicyRawVO;
		
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
//			sendNotification(LocalConst.SUSBMA_POLIICY_CLASS_LIST, myWindow.rangeType);
//		}
		
		/**
		 * 버튼클릭 Listener
		 */
		protected function onBtnClickHandler(event:MouseEvent):void
		{
			switch(event.currentTarget.id)
			{
				case "modBtn":
				{
					if(myWindow.classDG.selectedIndex < 0)
						return;
					var popup:SusbmaPolicyGroupPopup = PopUpManager.createPopUp(myWindow.parentApplication as DisplayObject,
																				SusbmaPolicyGroupPopup,
																				true) as SusbmaPolicyGroupPopup;
					PopUpManager.centerPopUp(popup);
					
					var popupMediator:SusbmaPolicyGroupPopupMediator = new SusbmaPolicyGroupPopupMediator(popup);
					popupMediator.setPopupResponder(this, "MODIFY");
					popupMediator.groupName = (myWindow.classDG.selectedItem as SusbmaPolicyMasterVO).className;
					
					facade.registerMediator(popupMediator);
					break;
				}
				
				case "reloadBtn":
				{
					sendNotification(LocalConst.SUSBMA_POLIICY_CLASS_LIST, myWindow.rangeType);
					break;
				}
				
				default:
					break;
			}
		}
		
		private function selectionChangeHandler(event:GridSelectionEvent):void
		{
			var optionMediator:SusbmaPolicyOptionMediator = facade.retrieveMediator(SusbmaPolicyOptionMediator.NAME) as SusbmaPolicyOptionMediator;
			optionMediator.selectMasterVO = (event.currentTarget as DataGrid).selectedItem as SusbmaPolicyMasterVO;
			
			sendNotification(LocalConst.SUSBMA_POLIICY_RAW_LIST, optionMediator.selectMasterVO.usbPolicyId);
		}
		
		private function checkBoxClickHandler(event:CustomCheckBoxClickEvent):void
		{
			var masterVo:SusbmaPolicyMasterVO = event.m_vo as SusbmaPolicyMasterVO;
			var classVO:SusbmaClassVO = new SusbmaClassVO();
			classVO.classId = masterVo.classId;
			classVO.className = masterVo.className;
			classVO.enable = masterVo.enable;
			
			//20121030 김정욱 체크된 보조기억매체 등급 갯수 조회 START
			//선택된 등급이 없을 경우 마지막으로 선택된 등급 정보 값을 선택된 상태로 변경 
			if(!selectedCheckBoxCount(classVO)){
				Alert.show(DmosFramework.getInstance().SNL("SC_PROMPT_SEARCH_MIN_CLASS"),
					DmosFramework.getInstance().SNL("SC_SEARCH"));
			}
			//20121030 김정욱 체크된 보조기억매체 등급 갯수 조회 END 
			sendNotification(LocalConst.SUSBMA_POLIICY_CLASSCHECK_MODIFY, classVO);
		}
		
		
		/**
		 * 20121030 김정욱 체크된 보조기억매체 등급 갯수 조회 START
		 * 선택된 등급이 없을 경우 마지막으로 선택된 등급 정보 값을 선택된 상태로 변경 
		 */
		private function selectedCheckBoxCount(classVO:SusbmaClassVO):int {
			var count:int = 0;
			if(myWindow.classArr != null){
				var length:int = myWindow.classArr.length;
				var susbmaPolicyMasterVO:SusbmaPolicyMasterVO;
				for(var i:int=0;i<length;i++){
					susbmaPolicyMasterVO = myWindow.classArr.getItemAt(i) as SusbmaPolicyMasterVO;
					if(susbmaPolicyMasterVO.enable) count++;
				}
			}
						
			if(!count){
				classVO.enable = 1;
			}
			return count;
		}
		/**
		 * 20121030 김정욱 체크된 보조기억매체 등급 갯수 조회 END 
		 */
		
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
				LocalConst.SUSBMA_POLIICY_CLASS_LIST_LOADSUCCESS,
				LocalConst.SUSBMA_POLIICY_CLASS_MODIFYSUCCESS,
				LocalConst.SUSBMA_POLIICY_CLASSCHECK_MODIFYSUCCESS,
				
				
				//실패 notify
				LocalConst.SUSBMA_POLIICY_CLASS_LIST_LOADFAIL,
				LocalConst.SUSBMA_POLIICY_CLASS_MODIFYFAIL,
				LocalConst.SUSBMA_POLIICY_CLASSCHECK_MODIFYFAIL,
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
				//Grid에 저장될 데이터 로드 성공
				case LocalConst.SUSBMA_POLIICY_CLASS_LIST_LOADSUCCESS:
				{
					var isAspService:Boolean = DmosFramework.getInstance().CONFIG('SAFERZONE_ASP_SERVICE_USE')=="1"?true:false

					myWindow.classArr = notification.getBody() as ArrayCollection;
					if(myWindow.classArr.length > 0)
					{
						myWindow.classDG.selectedIndex = 0;
						myWindow.classDG.dispatchEvent(new GridSelectionEvent(GridSelectionEvent.SELECTION_CHANGE,
																			  false,
																			  false,
																			  null,
																			  new CellRegion(0,
																							 0)));
						myWindow.classDG.setFocus();
					}
					setRangeType();
					break;
				}
				
				//Grid에 저장될 데이터 로드 실패
				case LocalConst.SUSBMA_POLIICY_CLASS_LIST_LOADFAIL:
				{
					break;
				}
				
				//새항목 추가 성공
				case LocalConst.SUSBMA_POLIICY_CLASS_MODIFYSUCCESS:
				{
					sendNotification(LocalConst.SUSBMA_POLIICY_CLASS_LIST, myWindow.rangeType);
					break;
				}
				
				//새항목 추가 실패
				case LocalConst.SUSBMA_POLIICY_CLASS_MODIFYFAIL:
				{
					break;
				}
				
				//새항목 추가 성공
				case LocalConst.SUSBMA_POLIICY_CLASSCHECK_MODIFYSUCCESS:
					break;
				
				//새항목 추가 실패
				case LocalConst.SUSBMA_POLIICY_CLASSCHECK_MODIFYFAIL:
				{
					break;
				}
					
				default:
					break;
			}
		}
		
		override public function onRegister():void
		{
			//컨트롤 초기화 루틴은 여기서
			myWindow.modBtn.addEventListener(MouseEvent.CLICK, onBtnClickHandler);
			myWindow.reloadBtn.addEventListener(MouseEvent.CLICK, onBtnClickHandler);
			
			//권한설정
			if(DmosFramework.getInstance().PERMISSION("D4_SUSBMA_POLICY"))
			{
				myWindow.modBtn.enabled = DmosFramework.getInstance().PERMISSION("D4_SUSBMA_POLICY").isAbleUpdate();
			}
			
			myWindow.classDG.addEventListener(GridSelectionEvent.SELECTION_CHANGE,
											  selectionChangeHandler);
			myWindow.addEventListener(CustomCheckBoxClickEvent.CUSTOM_CHECKBOX_CLICK,
									  checkBoxClickHandler);
		}
		
		override public function onRemove():void
		{
			myWindow.modBtn.removeEventListener(MouseEvent.CLICK, onBtnClickHandler);
			myWindow.reloadBtn.removeEventListener(MouseEvent.CLICK, onBtnClickHandler);
			
			myWindow.classDG.removeEventListener(GridSelectionEvent.SELECTION_CHANGE,
												 selectionChangeHandler);
		}
		
		
		//--------------------------------------
		// public 
		//--------------------------------------
		
		/**
		 * Popup창의 "OK" callback
		 */
		public function popupOnOk(popup:Object, context:Object, extra:Object):void
		{
			switch(context.toString())
			{
				case "MODIFY":
				{
					var modVO:SusbmaPolicyMasterVO = myWindow.classDG.selectedItem as SusbmaPolicyMasterVO;
					var classVO:SusbmaClassVO = new SusbmaClassVO();
					classVO.classId = modVO.classId;
					classVO.className = extra as String;
					classVO.enable = modVO.enable;
					sendNotification(LocalConst.SUSBMA_POLIICY_CLASS_MODIFY, classVO);
					break;
				}
				case "":
					break;
				default:
					break;
			}
		}
		
		/**
		 * Popup창의 "Cancel" callback
		 */
		public function popupOnCancel(popup:Object, context:Object, extra:Object):void
		{
		}
		
		private function setRangeType():void
		{
			var optionMediator:SusbmaPolicyOptionMediator = facade.retrieveMediator(SusbmaPolicyOptionMediator.NAME) as SusbmaPolicyOptionMediator;
			
			optionMediator.selectMasterVO.rangeType = 1;
			
			/**
			 * 20130227 김정욱 보조기억매체정책 비정상 정책 화면 출력현상 수정 START
			 */ 
			if(myWindow.classDG.dataProviderLength == 0) {
				optionMediator.selectMasterVO.orgId = null;
				optionMediator.selectMasterVO.usbPolicyId = -1;
			}
			/**
			 * 20130227 김정욱 보조기억매체정책 비정상 정책 화면 출력현상 수정 END
			 */ 
		}
	}
}
