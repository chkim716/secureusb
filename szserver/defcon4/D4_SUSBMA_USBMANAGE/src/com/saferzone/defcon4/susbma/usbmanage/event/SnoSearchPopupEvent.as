package com.saferzone.defcon4.susbma.usbmanage.event
{
	import com.saferzone.defcon4.services.vo.CommonUiUsbMasterVO;
	
	import flash.events.Event;
	
	import mx.collections.IList;

	public class SnoSearchPopupEvent extends Event
	{
		//------------------------------------------------------------------------------
		//
		// Constants 
		//
		//------------------------------------------------------------------------------
		
		public static const CONFIRM:String = "confirm";
		
		//------------------------------------------------------------------------------
		//
		// Constructor 
		//
		//------------------------------------------------------------------------------
		
		public function SnoSearchPopupEvent(type:String,
											selectedItem:CommonUiUsbMasterVO = null,
											selectedItems:IList = null)
		{
			super(type, false, false);
			_selectedItem = selectedItem;
			_selectedItems = selectedItems;
		}
		
		//------------------------------------------------------------------------------
		//
		// Properties #public 
		//
		//------------------------------------------------------------------------------
		
		//--------------------------------------
		// selectedItem 
		//--------------------------------------
		
		private var _selectedItem:CommonUiUsbMasterVO;
		
		public function get selectedItem():CommonUiUsbMasterVO
		{
			return _selectedItem;
		}
		
		public function set selectedItem(value:CommonUiUsbMasterVO):void
		{
			_selectedItem = value;
		}
		
		//--------------------------------------
		// selectedItems 
		//--------------------------------------
		
		private var _selectedItems:IList;
		
		public function get selectedItems():IList
		{
			return _selectedItems;
		}
		
		public function set selectedItems(value:IList):void
		{
			_selectedItems = value;
		}
		
	}
}