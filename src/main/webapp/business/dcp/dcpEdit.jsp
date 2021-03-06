<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script type="text/javascript">

	 $(function() {
		 
		parent.$.messager.progress('close');

		$('#form').form({
			url : '${pageContext.request.contextPath}/business/controller/DCPController/addDCP.do',
			onSubmit : function() {
				parent.$.messager.progress({
					title : '提示',
					text : '数据处理中，请稍后....'
				});
				var isValid = $(this).form('validate');
				if (!isValid) {
					parent.$.messager.progress('close');
				}
				return isValid;
			},
			success : function(result) {
				parent.$.messager.progress('close');
				result = $.parseJSON(result);
				if (result.success) {
					parent.$.messager.alert('提示','保存成功');
					parent.$.modalDialog.openner_dataGrid.datagrid('reload');//之所以能在这里调用到parent.$.modalDialog.openner_treeGrid这个对象，是因为resource.jsp页面预定义好了
					parent.$.modalDialog.handler.dialog('close');
				}
			}
		});
		
		
		
	}); 
	
	function checkDCPByPeriod(period_id) {
		var isValid = $('#form').form('validate');
		if (!isValid) {
			return;
		}
		
		var regionId = $('#regionId').combotree('getValue');
		
		checkDCP(regionId, period_id);
	}
	
	function checkDCPByRegion(regionId) {
		var isValid = $('#form').form('validate');
		if (!isValid) {
			return;
		}
		
		var period_id = $('#period_id').combobox('getValue');
		
		checkDCP(regionId, period_id);
	}
	
	
	function checkDCP(regionId, period_id) {
	
		var productId = $('#productId').combobox('getValue');
		
	
			$.post('${pageContext.request.contextPath}/business/controller/DCPController/queryPeriod.do', {
						regionId : regionId, productId : productId, period_id : period_id
					}, function(result) {
						if (result.success) {
							//parent.$.messager.alert('提示', result.msg, 'info');
							$("#form input[name=relation_period_id]").val(result.obj.relation_period_id);
							
							$('#stime').val(result.obj.stime);
							$('#etime').val(result.obj.etime);
								
						} else {
							
							$('#stime').val('');
							$('#etime').val('');
							$("#form input[name=relation_period_id]").val('');
						}
						parent.$.messager.progress('close');
					}, 'JSON');
	}
</script>
<div class="easyui-layout" data-options="fit:true,border:false">
	<div data-options="region:'center',border:false" title="" style="overflow: hidden;">
		 <form id="form" method="post">
		 <input name="relation_period_id" type="hidden" value="${dcp.relation_period_id }"/>
			<table class="table table-hover table-condensed">
				<tr>
					<th width="80px">产 品</th>
					<td width="80px">
					<input id="productId" name="productId" readonly="readonly" class="easyui-combobox" data-options="editable:false,required:true, valueField: 'Productid',textField: 'Product_name', 
					url: '${pageContext.request.contextPath}/business/controller/ProductController/queryProductCombo.do', 
							onSelect: function(rec){ 
							var url ='${pageContext.request.contextPath}/business/controller/ProductController/queryRegionTree.do?productId=' + rec.Productid;
							$('#regionId').combotree('clear');
           				 	$('#regionId').combotree('reload', url);  }"/>
					</td>
					<script>
						$('#productId').combobox({
							onLoadSuccess : function() {
								$('#productId').combobox('select', '${dcp.product_id}');
							}
						});
					</script>
					<th width="50px">区 划</th>
					<td width="100px">
					
					<select id="regionId" name="regionId" readonly="readonly" class="easyui-combotree" style="width:200px;" required="required" data-options="onSelect: function(rec){  checkDCPByRegion(rec.id);
        				var tree = $(this).tree;  
       					var isLeaf = tree('isLeaf', rec.target);  
        				if (!isLeaf) {  
           					$('#regionId').combotree('clear');  
        				}  
					}"></select>  
           			</td>
           			<script>
						$('#regionId').combotree({
							onLoadSuccess : function(param) {
								$('#regionId').combotree('setValue', '${dcp.region_id}');
							}
						});
					</script>
				</tr>
				<tr>
					<th>生育时期</th>
					<td colspan="3"><input id="period_id" name="period_id" readonly="readonly" class="easyui-combobox" data-options="required:true,width:320, valueField: 'period_id',textField: 'period_name', 
								url: '${pageContext.request.contextPath}/business/controller/PeriodController/queryPeriodCombo.do', onSelect : function(rec){
									checkDCPByPeriod(rec.period_id);
								}" />   </td>	
					<script>
						$('#period_id').combobox({
							onLoadSuccess : function(param) {
								$('#period_id').combobox('select', '${dcp.period_id}');
							}
						});
					</script>			
				</tr>
				<tr>
					<th>范 围</th>
					<td colspan="3">
					<input class="easyui-validatebox" style="width: 300 px" id="stime" name="stime" placeholder="点击选择时间" onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd',maxDate:'#F{$dp.$D(\'etime\')}'})" readonly="readonly" value="${dcp.stime }" />
					至
					<input style="width: 300 px" class="easyui-validatebox" id="etime" name="etime" placeholder="点击选择时间" onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd',minDate:'#F{$dp.$D(\'stime\')}'})" readonly="readonly" value="${dcp.etime }"/>   </td>
				</tr>
			</table>
		</form> 
	</div>
</div>