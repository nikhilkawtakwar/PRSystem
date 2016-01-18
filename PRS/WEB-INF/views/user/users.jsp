<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<html>
<head>
	<title>Users</title>
	<jsp:include page="../header.jsp"></jsp:include>
	<style type="text/css" media="screen">
	    th.ui-th-column div{
	        white-space:normal !important;
	        height:auto !important;
	        padding:2px;
	    }
	    .ui-jqgrid .ui-jqgrid-resize {height:100% !important;}
    </style>
</head>
<body>
    <jsp:include page="../menubar.jsp"></jsp:include>
	<div class="form-container">
        <div style="font-size: 13px;margin: 5px;color: #000080;font-weight: bold;">Users</div>
        <div id="usersHeader" style="width:100%;position:relative;z-index:3;">
            <table id="usersTable">
            </table>
        </div>
	</div>
	<jsp:include page="../footer.jsp"></jsp:include>
	
<script>
$(function () {
        $("#usersTable").jqGrid({
            datatype:'local',
            colNames:['User Id', 'User Name', 'First Name', 'Last Name', 'Email Address', 'Authorized Transaction Limit', 'Reporting To','Roles','Status'],
            colModel:[
                {name:'id', width:30, sortable: false, align:'center', resizable: true},
                {name:'ssoId', width:40, sortable: false, align:'left', resizable: true},
                {name:'firstName', width:40, sortable: false, align:'left', resizable: true},
                {name:'lastName', width:40, sortable: false, align:'left', resizable: true},
                {name:'email', width:60, sortable: false, align:'left', resizable: true},
                {name:'authorizedTransactionLimit', width:40, sortable: false, align:'right', resizable: true},
                {name:'reportingTo', width:60, sortable: false, align:'left', resizable: true},
                {name:'roles', width:80, sortable: false, align:'left', resizable: true},
                {name:'status', width:30, sortable: false, align:'center', resizable: true}
			],
            width: $("#usersHeader").width()-30,
            height: "400",
            scroll : true,
            gridview : true,
            loadtext: 'building list...',
            jsonReader: {
                repeatitems: false,
            },
            loadError: function(jqXHR, status, error) {
            	if( jqXHR.status == 401 ) {
                	jQuery("#usersTable").html('<div style="height: 205px">Session Expired</div>');            		
            	} else if ( jqXHR.responseText.length == 0 ) {
            		jQuery("#usersTable").html('<div style="height: 205px">Service Unavailable</div>');
            	} else {
                	jQuery("#usersTable").html('<div style="height: 205px">' + jqXHR.statusText + '</div>');
            	}
            },
            rownumbers: true
        });
    	
        var newUrlUsersTable = "rest/user/_search";
        $("#usersTable").jqGrid().setGridParam({
    		url : newUrlUsersTable, 
    		page : 1, 
    		mtype:'POST',
    		datatype : "json",
			ajaxGridOptions: { 
				type :'POST',
				contentType :"application/json; charset=utf-8"
			},
			serializeGridData: function(postData) {
				postData['pageSize'] =  defaultPageSize;
			    return JSON.stringify(postData);
			}
    	});
         $("#usersTable").jqGrid().trigger('reloadGrid');
   });
</script>
</body>
</html>