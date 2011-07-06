package com.graffix.drawingTool.vo
{
	import mx.collections.ArrayCollection;
	
	import spark.collections.Sort;
	import spark.collections.SortField;
	
	public class MembersList extends ArrayCollection
	{
		public function MembersList(source:Array=null)
		{
			super(source);
		}
		
//		private var _sorted:Boolean;
//		public function sort():void
//		{
//			if(!_sorted)
//			{
//				var sort:Sort = new Sort();
//				var nameField:SortField = new SortField("usuario");
//				sort.fields = [nameField];
//				this.sort = sort;
//				refresh();
//				_sorted = true;
//			}
//		}
	}
}