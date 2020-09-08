package com.saferzone.defcon4.susbma.policy.consts
{
	public class LocalConst
	{

		public static const BTN_SAVE:int = 0;
		public static const BTN_ADD:int = 1;
		public static const BTN_DELETE:int = 2;
		public static const BTN_REFRESH:int = 3;
		
		/**
		 * ---------------------------------------------------------
		 * SUSBMA_POLIICY_CLASS_LIST
		 * ---------------------------------------------------------
		 * 용도 
		 * 		- 변경사유 리스트를 요청하는 Command
		 * Sender
		 * 		- Class : ApplicationMediator
		 * 		  InvokeTime : 새로고침 버튼 클릭시
		 * 		  Parameter : None
		 * 		- Class : ApplicationFacade
		 * 		  Invoke : applicationStartup() --> 최초구동시 자동로드
		 * 		  Parameter : None
		 * Receiver
		 * 		- Class : SusbmaUsbmanageUsbListCommand
		 * 		  Action : SusbmaUsbmanageRemoteProxy 의  selectSusbmaUsbmanageUsbList() 호출
		 * ---------------------------------------------------------
		 */
		public static const SUSBMA_POLIICY_CLASS_LIST:String	= "SUSBMA_POLIICY_CLASS_LIST";
		
		/**
		 * ---------------------------------------------------------
		 * SUSBMA_POLIICY_CLASS_MODIFY
		 * ---------------------------------------------------------
		 * 용도 
		 * 		- 변경사유 수정을  요청하는 Command
		 * Sender
		 * 		- Class : ApplicationMediator
		 * 		  InvokeTime : 입력Popup창에서 확인을 누른후 
		 * 		  Parameter : OpemanAccumaGroupVO
		 * Receiver
		 * 		- Class : OpemanAccumaModifyCommand
		 * 		  Action : OpemanAccumaRemoteProxy 의  modifyOpemanAccumaGroup() 호출
		 * ---------------------------------------------------------
		 */
		public static const SUSBMA_POLIICY_CLASS_MODIFY:String 	= "SUSBMA_POLIICY_CLASS_MODIFY";
		
		/**
		 * ---------------------------------------------------------
		 * SUSBMA_POLIICY_CLASSCHECK_MODIFY
		 * ---------------------------------------------------------
		 * 용도 
		 * 		- 변경사유 수정을  요청하는 Command
		 * Sender
		 * 		- Class : ApplicationMediator
		 * 		  InvokeTime : 입력Popup창에서 확인을 누른후 
		 * 		  Parameter : OpemanAccumaGroupVO
		 * Receiver
		 * 		- Class : OpemanAccumaModifyCommand
		 * 		  Action : OpemanAccumaRemoteProxy 의  modifyOpemanAccumaGroup() 호출
		 * ---------------------------------------------------------
		 */
		public static const SUSBMA_POLIICY_CLASSCHECK_MODIFY:String 	= "SUSBMA_POLIICY_CLASSCHECK_MODIFY";
		
		/**
		 * ---------------------------------------------------------
		 * SUSBMA_POLIICY_CLASS_LIST_LOADSUCCESS
		 * SUSBMA_POLIICY_CLASS_LIST_LOADFAIL
		 * 
		 * SUSBMA_POLIICY_CLASS_MODIFYSUCCESS
		 * SUSBMA_POLIICY_CLASS_MODIFYFAIL
		 * 
		 * SUSBMA_POLIICY_CLASSCHECK_MODIFYSUCCESS
		 * SUSBMA_POLIICY_CLASSCHECK_MODIFYFAIL
		 * ---------------------------------------------------------
		 * 용도 
		 * 		- 변경사유 리스트 수신완료에 대한 notify
		 * Sender
		 * 		- Class : OpemanAccumaRemoteProxy
		 * 		  InvokeTime : 변경사유목록수신성공 
		 * 		  Parameter : 변경사유목록 VO list  
		 * Receiver
		 * 		- Class : ApplicationMediator
		 * 		  Action : datagrid에 저장한다
		 * ---------------------------------------------------------
		 */
		public static const SUSBMA_POLIICY_CLASS_LIST_LOADSUCCESS:String = "SUSBMA_POLIICY_CLASS_LIST_LOADSUCCESS";
		public static const SUSBMA_POLIICY_CLASS_LIST_LOADFAIL:String = "SUSBMA_POLIICY_CLASS_LIST_LOADFAIL";
		
		public static const SUSBMA_POLIICY_CLASS_MODIFYSUCCESS:String = "SUSBMA_POLIICY_CLASS_MODIFYSUCCESS";
		public static const SUSBMA_POLIICY_CLASS_MODIFYFAIL:String = "SUSBMA_POLIICY_CLASS_MODIFYFAIL";
		
		public static const SUSBMA_POLIICY_CLASSCHECK_MODIFYSUCCESS:String = "SUSBMA_POLIICY_CLASSCHECK_MODIFYSUCCESS";
		public static const SUSBMA_POLIICY_CLASSCHECK_MODIFYFAIL:String = "SUSBMA_POLIICY_CLASSCHECK_MODIFYFAIL";
		
		/**
		 * ---------------------------------------------------------
		 * SUSBMA_POLIICY_RAW_LIST
		 * ---------------------------------------------------------
		 * 용도 
		 * 		- 변경사유 수정을  요청하는 Command
		 * Sender
		 * 		- Class : ApplicationMediator
		 * 		  InvokeTime : 입력Popup창에서 확인을 누른후 
		 * 		  Parameter : OpemanAccumaGroupVO
		 * Receiver
		 * 		- Class : OpemanAccumaModifyCommand
		 * 		  Action : OpemanAccumaRemoteProxy 의  modifyOpemanAccumaGroup() 호출
		 * ---------------------------------------------------------
		 */
		public static const SUSBMA_POLIICY_RAW_LIST:String 	= "SUSBMA_POLIICY_RAW_LIST";
		
		
		/**
		 * ---------------------------------------------------------
		 * SUSBMA_POLIICY_RAW_ADD
		 * ---------------------------------------------------------
		 * 용도 
		 * 		- 신규 변경사유 추가를  요청하는 Command
		 * Sender
		 * 		- Class : ApplicationMediator
		 * 		  InvokeTime : 입력Popup창에서 확인을 누른후 
		 * 		  Parameter : OpemanAccumaGroupVO
		 * Receiver
		 * 		- Class : OpemanAccumaAddCommand
		 * 		  Action : OpemanAccumaRemoteProxy 의  addOpemanAccumaGroup() 호출
		 * ---------------------------------------------------------
		 */
		public static const SUSBMA_POLIICY_RAW_ADD:String 	= "SUSBMA_POLIICY_RAW_ADD";
		
		/**
		 * ---------------------------------------------------------
		 * SUSBMA_POLIICY_RAW_MODIFY
		 * ---------------------------------------------------------
		 * 용도 
		 * 		- 변경사유 수정을  요청하는 Command
		 * Sender
		 * 		- Class : ApplicationMediator
		 * 		  InvokeTime : 입력Popup창에서 확인을 누른후 
		 * 		  Parameter : OpemanAccumaGroupVO
		 * Receiver
		 * 		- Class : OpemanAccumaModifyCommand
		 * 		  Action : OpemanAccumaRemoteProxy 의  modifyOpemanAccumaGroup() 호출
		 * ---------------------------------------------------------
		 */
		public static const SUSBMA_POLIICY_RAW_MODIFY:String 	= "SUSBMA_POLIICY_RAW_MODIFY";
		
		/**
		 * ---------------------------------------------------------
		 * SUSBMA_POLIICY_RAW_DELETE
		 * ---------------------------------------------------------
		 * 용도 
		 * 		- 변경사유 삭제를  요청하는 Command
		 * Sender
		 * 		- Class : ApplicationMediator
		 * 		  InvokeTime : 그리드에서 선택을 하고 삭제버튼 클릭시 
		 * 		  Parameter : OpemanAccumaGroupVO
		 * Receiver
		 * 		- Class : OpemanAccumaDeleteCommand
		 * 		  Action : OpemanAccumaRemoteProxy 의  deleteOpemanAccumaGroup() 호출
		 * ---------------------------------------------------------
		 */
		public static const SUSBMA_POLIICY_RAW_DELETE:String 	= "SUSBMA_POLIICY_RAW_DELETE";
		
		/**
		 * ---------------------------------------------------------
		 * SUSBMA_POLIICY_RAW_LIST_LOADSUCCESS
		 * SUSBMA_POLIICY_RAW_LIST_LOADFAIL
		 * 
		 * SUSBMA_POLIICY_RAW_ADDSUCCESS
		 * SUSBMA_POLIICY_RAW_ADDFAIL
		 * 
		 * SUSBMA_POLIICY_RAW_MODIFYSUCCESS
		 * SUSBMA_POLIICY_RAW_MODIFYFAIL
		 * 
		 * SUSBMA_POLIICY_RAW_DELETESUCCESS
		 * SUSBMA_POLIICY_RAW_DELETEFAIL
		 * ---------------------------------------------------------
		 * 용도 
		 * 		- 변경사유 리스트 수신완료에 대한 notify
		 * Sender
		 * 		- Class : OpemanAccumaRemoteProxy
		 * 		  InvokeTime : 변경사유목록수신성공 
		 * 		  Parameter : 변경사유목록 VO list  
		 * Receiver
		 * 		- Class : ApplicationMediator
		 * 		  Action : datagrid에 저장한다
		 * ---------------------------------------------------------
		 */
		public static const SUSBMA_POLIICY_RAW_LIST_LOADSUCCESS:String = "SUSBMA_POLIICY_RAW_LIST_LOADSUCCESS";
		public static const SUSBMA_POLIICY_RAW_LIST_LOADFAIL:String = "SUSBMA_POLIICY_RAW_LIST_LOADFAIL";
		
		public static const SUSBMA_POLIICY_RAW_ADDSUCCESS:String = "SUSBMA_POLIICY_RAW_ADDSUCCESS";
		public static const SUSBMA_POLIICY_RAW_ADDFAIL:String = "SUSBMA_POLIICY_RAW_ADDFAIL";
		
		public static const SUSBMA_POLIICY_RAW_MODIFYSUCCESS:String = "SUSBMA_POLIICY_RAW_MODIFYSUCCESS";
		public static const SUSBMA_POLIICY_RAW_MODIFYFAIL:String = "SUSBMA_POLIICY_RAW_MODIFYFAIL";
		
		public static const SUSBMA_POLIICY_RAW_DELETESUCCESS:String = "SUSBMA_POLIICY_RAW_DELETESUCCESS";
		public static const SUSBMA_POLIICY_RAW_DELETEFAIL:String = "SUSBMA_POLIICY_RAW_DELETEFAIL";
		
		/**
		 * ---------------------------------------------------------
		 * SUSBMA_POLIICY_DEPT_LIST
		 * ---------------------------------------------------------
		 * 용도 
		 * 		- 변경사유 리스트를 요청하는 Command
		 * Sender
		 * 		- Class : ApplicationMediator
		 * 		  InvokeTime : 새로고침 버튼 클릭시
		 * 		  Parameter : None
		 * 		- Class : ApplicationFacade
		 * 		  Invoke : applicationStartup() --> 최초구동시 자동로드
		 * 		  Parameter : None
		 * Receiver
		 * 		- Class : SusbmaUsbmanageUsbListCommand
		 * 		  Action : SusbmaUsbmanageRemoteProxy 의  selectSusbmaUsbmanageUsbList() 호출
		 * ---------------------------------------------------------
		 */
		public static const SUSBMA_POLIICY_DEPT_LIST:String	= "SUSBMA_POLIICY_DEPT_LIST";
		

		/**
		 * ---------------------------------------------------------
		 * SUSBMA_POLIICY_DEPT_ADD
		 * ---------------------------------------------------------
		 * 용도 
		 * 		- 신규 변경사유 추가를  요청하는 Command
		 * Sender
		 * 		- Class : ApplicationMediator
		 * 		  InvokeTime : 입력Popup창에서 확인을 누른후 
		 * 		  Parameter : OpemanAccumaGroupVO
		 * Receiver
		 * 		- Class : OpemanAccumaAddCommand
		 * 		  Action : OpemanAccumaRemoteProxy 의  addOpemanAccumaGroup() 호출
		 * ---------------------------------------------------------
		 */
		public static const SUSBMA_POLIICY_DEPT_ADD:String 	= "SUSBMA_POLIICY_DEPT_ADD";

		/**
		 * ---------------------------------------------------------
		 * SUSBMA_POLIICY_DEPT_MODIFY
		 * ---------------------------------------------------------
		 * 용도 
		 * 		- 신규 변경사유 추가를  요청하는 Command
		 * Sender
		 * 		- Class : ApplicationMediator
		 * 		  InvokeTime : 입력Popup창에서 확인을 누른후 
		 * 		  Parameter : OpemanAccumaGroupVO
		 * Receiver
		 * 		- Class : OpemanAccumaAddCommand
		 * 		  Action : OpemanAccumaRemoteProxy 의  addOpemanAccumaGroup() 호출
		 * ---------------------------------------------------------
		 */
		public static const SUSBMA_POLIICY_DEPT_MODIFY:String 	= "SUSBMA_POLIICY_DEPT_MODIFY";
		
		/**
		 * ---------------------------------------------------------
		 * SUSBMA_POLIICY_DEPT_DELETE
		 * ---------------------------------------------------------
		 * 용도 
		 * 		- 변경사유 삭제를  요청하는 Command
		 * Sender
		 * 		- Class : ApplicationMediator
		 * 		  InvokeTime : 그리드에서 선택을 하고 삭제버튼 클릭시 
		 * 		  Parameter : OpemanAccumaGroupVO
		 * Receiver
		 * 		- Class : OpemanAccumaDeleteCommand
		 * 		  Action : OpemanAccumaRemoteProxy 의  deleteOpemanAccumaGroup() 호출
		 * ---------------------------------------------------------
		 */
		public static const SUSBMA_POLIICY_DEPT_DELETE:String 	= "SUSBMA_POLIICY_DEPT_DELETE";
		
		
		/**
		 * ---------------------------------------------------------
		 * SUSBMA_POLIICY_DEPT_LIST_LOADSUCCESS
		 * SUSBMA_POLIICY_DEPT_LIST_LOADFAIL
		 * 
		 * SUSBMA_POLIICY_DEPT_ADDSUCCESS
		 * SUSBMA_POLIICY_DEPT_ADDFAIL
		 * 
		 * SUSBMA_POLIICY_DEPT_MODIFYSUCCESS
		 * SUSBMA_POLIICY_DEPT_MODIFYFAIL
		 * 
		 * SUSBMA_POLIICY_DEPT_DELETESUCCESS
		 * SUSBMA_POLIICY_DEPT_DELETEFAIL
		 * ---------------------------------------------------------
		 * 용도 
		 * 		- 변경사유 리스트 수신완료에 대한 notify
		 * Sender
		 * 		- Class : OpemanAccumaRemoteProxy
		 * 		  InvokeTime : 변경사유목록수신성공 
		 * 		  Parameter : 변경사유목록 VO list  
		 * Receiver
		 * 		- Class : ApplicationMediator
		 * 		  Action : datagrid에 저장한다
		 * ---------------------------------------------------------
		 */
		public static const SUSBMA_POLIICY_DEPT_LIST_LOADSUCCESS:String = "SUSBMA_POLIICY_DEPT_LIST_LOADSUCCESS";
		public static const SUSBMA_POLIICY_DEPT_LIST_LOADFAIL:String = "SUSBMA_POLIICY_DEPT_LIST_LOADFAIL";
		
		public static const SUSBMA_POLIICY_DEPT_ADDSUCCESS:String = "SUSBMA_POLIICY_DEPT_ADDSUCCESS";
		public static const SUSBMA_POLIICY_DEPT_ADDFAIL:String = "SUSBMA_POLIICY_DEPT_ADDFAIL";
		
		public static const SUSBMA_POLIICY_DEPT_MODIFYSUCCESS:String = "SUSBMA_POLIICY_DEPT_MODIFYSUCCESS";
		public static const SUSBMA_POLIICY_DEPT_MODIFYFAIL:String = "SUSBMA_POLIICY_DEPT_MODIFYFAIL";
		
		public static const SUSBMA_POLIICY_DEPT_DELETESUCCESS:String = "SUSBMA_POLIICY_DEPT_DELETESUCCESS";
		public static const SUSBMA_POLIICY_DEPT_DELETEFAIL:String = "SUSBMA_POLIICY_DEPT_DELETEFAIL";
		
		
		/**
		 * ---------------------------------------------------------
		 * SUSBMA_POLIICY_POLICY_GROUP_LIST
		 * ---------------------------------------------------------
		 * 용도 
		 * 		- 변경사유 리스트를 요청하는 Command
		 * Sender
		 * 		- Class : ApplicationMediator
		 * 		  InvokeTime : 새로고침 버튼 클릭시
		 * 		  Parameter : None
		 * 		- Class : ApplicationFacade
		 * 		  Invoke : applicationStartup() --> 최초구동시 자동로드
		 * 		  Parameter : None
		 * Receiver
		 * 		- Class : SusbmaUsbmanageUsbListCommand
		 * 		  Action : SusbmaUsbmanageRemoteProxy 의  selectSusbmaUsbmanageUsbList() 호출
		 * ---------------------------------------------------------
		 */
		public static const SUSBMA_POLIICY_POLICY_GROUP_LIST:String	= "SUSBMA_POLIICY_POLICY_GROUP_LIST";
		
		/**
		 * ---------------------------------------------------------
		 * SUSBMA_POLIICY_POLICY_GROUP_RAW_LIST
		 * ---------------------------------------------------------
		 * 용도 
		 * 		- 변경사유 리스트를 요청하는 Command
		 * Sender
		 * 		- Class : ApplicationMediator
		 * 		  InvokeTime : 새로고침 버튼 클릭시
		 * 		  Parameter : None
		 * 		- Class : ApplicationFacade
		 * 		  Invoke : applicationStartup() --> 최초구동시 자동로드
		 * 		  Parameter : None
		 * Receiver
		 * 		- Class : SusbmaUsbmanageUsbListCommand
		 * 		  Action : SusbmaUsbmanageRemoteProxy 의  selectSusbmaUsbmanageUsbList() 호출
		 * ---------------------------------------------------------
		 */
		public static const SUSBMA_POLIICY_POLICY_GROUP_RAW_LIST:String	= "SUSBMA_POLIICY_POLICY_GROUP_RAW_LIST";
		

		/**
		 * ---------------------------------------------------------
		 * SUSBMA_POLIICY_POLICY_GROUP_ADD
		 * ---------------------------------------------------------
		 * 용도 
		 * 		- 신규 변경사유 추가를  요청하는 Command
		 * Sender
		 * 		- Class : ApplicationMediator
		 * 		  InvokeTime : 입력Popup창에서 확인을 누른후 
		 * 		  Parameter : OpemanAccumaGroupVO
		 * Receiver
		 * 		- Class : OpemanAccumaAddCommand
		 * 		  Action : OpemanAccumaRemoteProxy 의  addOpemanAccumaGroup() 호출
		 * ---------------------------------------------------------
		 */
		public static const SUSBMA_POLIICY_POLICY_GROUP_ADD:String 	= "SUSBMA_POLIICY_POLICY_GROUP_ADD";

		
		/**
		 * ---------------------------------------------------------
		 * SUSBMA_POLIICY_POLICY_GROUP_MODIFY
		 * ---------------------------------------------------------
		 * 용도 
		 * 		- 변경사유 수정을  요청하는 Command
		 * Sender
		 * 		- Class : ApplicationMediator
		 * 		  InvokeTime : 입력Popup창에서 확인을 누른후 
		 * 		  Parameter : OpemanAccumaGroupVO
		 * Receiver
		 * 		- Class : OpemanAccumaModifyCommand
		 * 		  Action : OpemanAccumaRemoteProxy 의  modifyOpemanAccumaGroup() 호출
		 * ---------------------------------------------------------
		 */
		public static const SUSBMA_POLIICY_POLICY_GROUP_MODIFY:String 	= "SUSBMA_POLIICY_POLICY_GROUP_MODIFY";

		
		/**
		 * ---------------------------------------------------------
		 * SUSBMA_POLIICY_POLICY_GROUP_DELETE
		 * ---------------------------------------------------------
		 * 용도 
		 * 		- 변경사유 삭제를  요청하는 Command
		 * Sender
		 * 		- Class : ApplicationMediator
		 * 		  InvokeTime : 그리드에서 선택을 하고 삭제버튼 클릭시 
		 * 		  Parameter : OpemanAccumaGroupVO
		 * Receiver
		 * 		- Class : OpemanAccumaDeleteCommand
		 * 		  Action : OpemanAccumaRemoteProxy 의  deleteOpemanAccumaGroup() 호출
		 * ---------------------------------------------------------
		 */
		public static const SUSBMA_POLIICY_POLICY_GROUP_DELETE:String 	= "SUSBMA_POLIICY_POLICY_GROUP_DELETE";
		
		
		/**
		 * ---------------------------------------------------------
		 * SUSBMA_POLIICY_POLICY_GROUP_LIST_LOADSUCCESS
		 * SUSBMA_POLIICY_POLICY_GROUP_LIST_LOADFAIL
		 * 
		 * SUSBMA_POLIICY_POLICY_GROUP_RAW_LIST_LOADSUCCESS
		 * SUSBMA_POLIICY_POLICY_GROUP_RAW_LIST_LOADFAIL
		 * 
		 * SUSBMA_POLIICY_POLICY_GROUP_ADDSUCCESS
		 * SUSBMA_POLIICY_POLICY_GROUP_ADDFAIL
		 * 
		 * SUSBMA_POLIICY_POLICY_GROUP_MODIFYSUCCESS
		 * SUSBMA_POLIICY_POLICY_GROUP_MODIFYFAIL
		 * 
		 * SUSBMA_POLIICY_POLICY_GROUP_DELETESUCCESS
		 * SUSBMA_POLIICY_POLICY_GROUP_DELETEFAIL
		 * ---------------------------------------------------------
		 * 용도 
		 * 		- 변경사유 리스트 수신완료에 대한 notify
		 * Sender
		 * 		- Class : OpemanAccumaRemoteProxy
		 * 		  InvokeTime : 변경사유목록수신성공 
		 * 		  Parameter : 변경사유목록 VO list  
		 * Receiver
		 * 		- Class : ApplicationMediator
		 * 		  Action : datagrid에 저장한다
		 * ---------------------------------------------------------
		 */
		public static const SUSBMA_POLIICY_POLICY_GROUP_LIST_LOADSUCCESS:String = "SUSBMA_POLIICY_POLICY_GROUP_LIST_LOADSUCCESS";
		public static const SUSBMA_POLIICY_POLICY_GROUP_LIST_LOADFAIL:String = "SUSBMA_POLIICY_POLICY_GROUP_LIST_LOADFAIL";
		
		public static const SUSBMA_POLIICY_POLICY_GROUP_RAW_LIST_LOADSUCCESS:String = "SUSBMA_POLIICY_POLICY_GROUP_RAW_LIST_LOADSUCCESS";
		public static const SUSBMA_POLIICY_POLICY_GROUP_RAW_LIST_LOADFAIL:String = "SUSBMA_POLIICY_POLICY_GROUP_RAW_LIST_LOADFAIL";
		
		public static const SUSBMA_POLIICY_POLICY_GROUP_ADDSUCCESS:String = "SUSBMA_POLIICY_POLICY_GROUP_ADDSUCCESS";
		public static const SUSBMA_POLIICY_POLICY_GROUP_ADDFAIL:String = "SUSBMA_POLIICY_POLICY_GROUP_ADDFAIL";
		
		public static const SUSBMA_POLIICY_POLICY_GROUP_MODIFYSUCCESS:String = "SUSBMA_POLIICY_POLICY_GROUP_MODIFYSUCCESS";
		public static const SUSBMA_POLIICY_POLICY_GROUP_MODIFYFAIL:String = "SUSBMA_POLIICY_POLICY_GROUP_MODIFYFAIL";
		
		public static const SUSBMA_POLIICY_POLICY_GROUP_DELETESUCCESS:String = "SUSBMA_POLIICY_POLICY_GROUP_DELETESUCCESS";
		public static const SUSBMA_POLIICY_POLICY_GROUP_DELETEFAIL:String = "SUSBMA_POLIICY_POLICY_GROUP_DELETEFAIL";
		
		/**
		 * ---------------------------------------------------------
		 * SUSBMA_POLIICY_POLICY_USB_LIST
		 * ---------------------------------------------------------
		 * 용도 
		 * 		- 변경사유 리스트를 요청하는 Command
		 * Sender
		 * 		- Class : ApplicationMediator
		 * 		  InvokeTime : 새로고침 버튼 클릭시
		 * 		  Parameter : None
		 * 		- Class : ApplicationFacade
		 * 		  Invoke : applicationStartup() --> 최초구동시 자동로드
		 * 		  Parameter : None
		 * Receiver
		 * 		- Class : SusbmaUsbmanageUsbListCommand
		 * 		  Action : SusbmaUsbmanageRemoteProxy 의  selectSusbmaUsbmanageUsbList() 호출
		 * ---------------------------------------------------------
		 */
		public static const SUSBMA_POLIICY_POLICY_USB_LIST:String	= "SUSBMA_POLIICY_POLICY_USB_LIST";
		

		/**
		 * ---------------------------------------------------------
		 * SUSBMA_POLIICY_POLICY_USB_ADD
		 * ---------------------------------------------------------
		 * 용도 
		 * 		- 신규 변경사유 추가를  요청하는 Command
		 * Sender
		 * 		- Class : ApplicationMediator
		 * 		  InvokeTime : 입력Popup창에서 확인을 누른후 
		 * 		  Parameter : OpemanAccumaGroupVO
		 * Receiver
		 * 		- Class : OpemanAccumaAddCommand
		 * 		  Action : OpemanAccumaRemoteProxy 의  addOpemanAccumaGroup() 호출
		 * ---------------------------------------------------------
		 */
		public static const SUSBMA_POLIICY_POLICY_USB_ADD:String 	= "SUSBMA_POLIICY_POLICY_USB_ADD";
		
		/**
		 * ---------------------------------------------------------
		 * SUSBMA_POLIICY_POLICY_USB_MODIFY
		 * ---------------------------------------------------------
		 * 용도 
		 * 		- 신규 변경사유 추가를  요청하는 Command
		 * Sender
		 * 		- Class : ApplicationMediator
		 * 		  InvokeTime : 입력Popup창에서 확인을 누른후 
		 * 		  Parameter : OpemanAccumaGroupVO
		 * Receiver
		 * 		- Class : OpemanAccumaAddCommand
		 * 		  Action : OpemanAccumaRemoteProxy 의  addOpemanAccumaGroup() 호출
		 * ---------------------------------------------------------
		 */
		public static const SUSBMA_POLIICY_POLICY_USB_MODIFY:String 	= "SUSBMA_POLIICY_POLICY_USB_MODIFY";
		
		
		/**
		 * ---------------------------------------------------------
		 * SUSBMA_POLIICY_POLICY_USB_DELETE
		 * ---------------------------------------------------------
		 * 용도 
		 * 		- 변경사유 삭제를  요청하는 Command
		 * Sender
		 * 		- Class : ApplicationMediator
		 * 		  InvokeTime : 그리드에서 선택을 하고 삭제버튼 클릭시 
		 * 		  Parameter : OpemanAccumaGroupVO
		 * Receiver
		 * 		- Class : OpemanAccumaDeleteCommand
		 * 		  Action : OpemanAccumaRemoteProxy 의  deleteOpemanAccumaGroup() 호출
		 * ---------------------------------------------------------
		 */
		public static const SUSBMA_POLIICY_POLICY_USB_DELETE:String 	= "SUSBMA_POLIICY_POLICY_USB_DELETE";
		
		/**
		 * ---------------------------------------------------------
		 * SUSBMA_POLIICY_POLICY_USB_LIST_LOADSUCCESS
		 * SUSBMA_POLIICY_POLICY_USB_LIST_LOADFAIL
		 * 
		 * SUSBMA_POLIICY_POLICY_USB_ADDSUCCESS
		 * SUSBMA_POLIICY_POLICY_USB_ADDFAIL
		 * 
		 * SUSBMA_POLIICY_POLICY_USB_DELETESUCCESS
		 * SUSBMA_POLIICY_POLICY_USB_DELETEFAIL
		 * ---------------------------------------------------------
		 * 용도 
		 * 		- 변경사유 리스트 수신완료에 대한 notify
		 * Sender
		 * 		- Class : OpemanAccumaRemoteProxy
		 * 		  InvokeTime : 변경사유목록수신성공 
		 * 		  Parameter : 변경사유목록 VO list  
		 * Receiver
		 * 		- Class : ApplicationMediator
		 * 		  Action : datagrid에 저장한다
		 * ---------------------------------------------------------
		 */
		public static const SUSBMA_POLIICY_POLICY_USB_LIST_LOADSUCCESS:String = "SUSBMA_POLIICY_POLICY_USB_LIST_LOADSUCCESS";
		public static const SUSBMA_POLIICY_POLICY_USB_LIST_LOADFAIL:String = "SUSBMA_POLIICY_POLICY_USB_LIST_LOADFAIL";
		
		public static const SUSBMA_POLIICY_POLICY_USB_ADDSUCCESS:String = "SUSBMA_POLIICY_POLICY_USB_ADDSUCCESS";
		public static const SUSBMA_POLIICY_POLICY_USB_ADDFAIL:String = "SUSBMA_POLIICY_POLICY_USB_ADDFAIL";
		
		public static const SUSBMA_POLIICY_POLICY_USB_MODIFYSUCCESS:String = "SUSBMA_POLIICY_POLICY_USB_MODIFYSUCCESS";
		public static const SUSBMA_POLIICY_POLICY_USB_MODIFYFAIL:String = "SUSBMA_POLIICY_POLICY_USB_MODIFYFAIL";
		
		public static const SUSBMA_POLIICY_POLICY_USB_DELETESUCCESS:String = "SUSBMA_POLIICY_POLICY_USB_DELETESUCCESS";
		public static const SUSBMA_POLIICY_POLICY_USB_DELETEFAIL:String = "SUSBMA_POLIICY_POLICY_USB_DELETEFAIL";
		
		
		public static const SUSBMA_COMMON_POLICY_SAVE:String	= "SUSBMA_COMMON_POLICY_SAVE";
		
		public static const SUSBMA_COMMON_POLICY_SAVESUCCESS:String	= "SUSBMA_COMMON_POLICY_SAVESUCCESS";
		public static const SUSBMA_COMMON_POLICY_SAVEFAIL:String	= "SUSBMA_COMMON_POLICY_SAVEFAIL";
		
		public static const SUSBMA_COMMON_POLICY_LOAD:String	= "SUSBMA_COMMON_POLICY_LOAD";
		
		public static const SUSBMA_COMMON_POLICY_LOADSUCCESS:String	= "SUSBMA_COMMON_POLICY_LOADSUCCESS";
		public static const SUSBMA_COMMON_POLICY_LOADFAIL:String	= "SUSBMA_COMMON_POLICY_LOADFAIL";
		
		public static const D4LC_CMD_PASSWORD_INITIALIZE:String	= "D4LC_CMD_PASSWORD_INITIALIZE";
		public static const D4LC_NOTIFY_PASSWORD_INITIALIZE_RESULT:String	= "D4LC_NOTIFY_PASSWORD_INITIALIZE_RESULT";
		public static const D4LC_NOTIFY_PASSWORD_INITIALIZE_FAULT:String	= "D4LC_NOTIFY_PASSWORD_INITIALIZE_FAULT";
		
		public static const D4LC_CMD_POPUP_LIST_LOAD:String	= "D4LC_CMD_POPUP_LIST_LOAD";
		public static const D4LC_NOTIFY_POPUP_LIST_LOADSUCCESS:String	= "D4LC_NOTIFY_POPUP_LIST_LOADSUCCESS";
		public static const D4LC_NOTIFY_POPUP_LIST_LOADFAIL:String	= "D4LC_NOTIFY_POPUP_LIST_LOADSUCCESS";
		
		public static const D4LC_CMD_POPUP_LIST_SAVE:String	= "D4LC_CMD_POPUP_LIST_SAVE";
		public static const D4LC_NOTIFY_POPUP_LIST_SAVESUCCESS:String	= "D4LC_NOTIFY_POPUP_LIST_SAVESUCCESS";
		public static const D4LC_NOTIFY_POPUP_LIST_SAVEFAIL:String	= "D4LC_NOTIFY_POPUP_LIST_SAVEFAIL";
		
		public static const D4LC_CMD_SECURE_ADMIN_INFO_SAVE:String	= "D4LC_CMD_SECURE_ADMIN_INFO_SAVE";
		public static const D4LC_NOTIFY_SECURE_ADMIN_INFO_SAVESUCCESS:String	= "D4LC_NOTIFY_SECURE_ADMIN_INFO_SAVESUCCESS";
		public static const D4LC_NOTIFY_SECURE_ADMIN_INFO_SAVEFAIL:String	= "D4LC_NOTIFY_SECURE_ADMIN_INFO_SAVEFAIL";
		
		public static const D4LC_CMD_SECURE_ADMIN_INFO_LOAD:String	= "D4LC_CMD_SECURE_ADMIN_INFO_LOAD";
		public static const D4LC_NOTIFY_SECURE_ADMIN_INFO_LOADSUCCESS:String	= "D4LC_NOTIFY_SECURE_ADMIN_INFO_LOADSUCCESS";
		public static const D4LC_NOTIFY_SECURE_ADMIN_INFO_LOADFAIL:String	= "D4LC_NOTIFY_SECURE_ADMIN_INFO_LOADSUCCESS";
		
		public static const D4LC_CMD_GROUPTYPE_SELECT:String	= "D4LC_CMD_GROUPTYPE_SELECT";
		public static const D4LC_NOTIFY_GROUPTYPE_SELECTSUCCESS:String	= "D4LC_NOTIFY_GROUPTYPE_SELECTSUCCESS";
		public static const D4LC_NOTIFY_GROUPTYPE_SELECTFAIL:String	= "D4LC_NOTIFY_GROUPTYPE_SELECTFAIL";
		
	}
}
