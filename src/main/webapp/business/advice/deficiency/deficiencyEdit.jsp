<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script type="text/javascript">
	$(function() {
		parent.$.messager.progress('close');
		$('#form').form({
			url : '${pageContext.request.contextPath}/business/controller/AdviceController/editDeficiency.do',
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
					parent.$.modalDialog.openner_dataGrid.datagrid('reload');//之所以能在这里调用到parent.$.modalDialog.openner_dataGrid这个对象，是因为user.jsp页面预定义好了
					parent.$.modalDialog.handler.dialog('close');
				} else {
					parent.$.messager.alert('错误', result.msg, 'error');
				}
			}
		});
	});
</script>
<div class="easyui-layout" data-options="fit:true,border:false">
	<div data-options="region:'center',border:false" title="" style="overflow: hidden;">
		<form id="form" method="post">
		<input name="advice_deficiency_id" type="hidden" value="${ advice.advice_deficiency_id }"/>
			<table class="table table-hover table-condensed">
				<tr>
				<th>农作物</th>
					<td colspan=""><input id="crops_id" name="crops_id" readonly="readonly" class="easyui-combobox" data-options="required:true,width:120, valueField: 'crops_id',textField: 'crops_name', 
								url: '${pageContext.request.contextPath}/business/controller/CropController/queryCropCombo.do', onLoadSuccess : function(){
									$('#crops_id').combobox('select', '${advice.crops_id}');
								}" />   </td>
								</tr>
								<tr>
					<th>缺素症名称  </th>
					<td colspan="3"><textarea name="name" rows="" cols="" class="span5">${advice.name}</textarea></td>
				</tr> 
								<tr>
					<th>症状 </th>
					<td colspan="3"><textarea name="content" rows="10" cols="" class="span5">${advice.content}</textarea></td>
				</tr>
			</table>
		</form>
	</div>
</div>