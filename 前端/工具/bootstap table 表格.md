## bootstap table 表格

```javascript
$('#table').bootstrapTable({
    url: '/System/Role/GetRoleList',         //请求后台的URL（*）
    method: 'get',                      //请求方式（*）
    striped: true,                      //是否显示行间隔色
    cache: false,                       //是否使用缓存，默认为true，所以一般情况下需要设置一下这个属性（*）
    pagination: true,                   //是否显示分页（*）
    sortable: false,                     //是否启用排序
    order: "asc",                  //排序方式
    sidePagination: "server",           //分页方式：client客户端分页，server服务端分页（*）
    pageNumber: 1,                       //初始化加载第一页，默认第一页
    pageSize: 25,                       //每页的记录行数（*）
    pageList: [10, 25, 50, 100],        //可供选择的每页的行数（*）
    search: true,                       //是否显示表格搜索，此搜索是客户端搜索，不会进服务端，所以，个人感觉意义不大
    strictSearch: true,
    showColumns: true,                  //是否显示所有的列
    showRefresh: true,                  //是否显示刷新按钮
    minimumCountColumns: 2,             //最少允许的列数
    clickToSelect: false,                //是否启用点击选中行
    height: 0,                        //行高，如果没有设置height属性，表格自动根据记录条数觉得表格高度
    uniqueId: "Id", 
    showToggle: true,                    //是否显示详细视图和列表视图的切换按钮
    cardView: false,                    //是否显示详细视图
    detailView: false,                   //是否显示父子表
    limit: 1,                       // 需要配置 否则 是undefined
    offset: 10,                    // 需要配置 否则 是undefined
    sortName: 'Id',                    // 需要配置 否则 是undefined
    queryParams: function (params) { //传递参数（*）
        var temp = {
            limit: params.limit,   //页面大小
            page: (params.offset / params.limit) + 1,  //页码
            keyword: params.search
        };
        return temp;
    },
    columns: [{
        checkbox: true
    },
    {
        field: 'Id',
        title: '编号'
    },
    {
        field: 'RoleName',
        title: '角色名称',
    },
    {
        field: 'RoleSort',
        title: '角色排序',
    },
    {
        field: 'Remark',
        title: '备注',
    },
    {
        field: 'RoleStatus',
        title: '角色状态',
        formatter: function (value, row, index) {
            if (value === 0) {
                return '禁用';
            } else if (value === 1) {
                return '启用';
            }
        }
    },
    {
        field: 'Id',
        title: '操作',
        formatter: function (value, row, index) {
            return [
                '<a href="javascript:;" class="btn btn-xs btn-primary" onclick="edit(\'' + value + '\')"><i class="fa fa-edit"></i> 编辑</a>',
                '<a href="javascript:;" class="btn btn-xs btn-danger m-l-xs" onclick="del(\'' + value + '\')"><i class="fa fa-close"></i> 删除</a>',
            ].join('');
        }
    }]

});

/**
 * 编辑操作
 * @param id {主键}
 * @author liuguofeng
 */ 
function edit(id) {
    openWindow('/System/Role/EditRole');
}

/**
 * 删除单个角色操作
 * @param id {主键}
 * @author liuguofeng
 */
function del(id) {
    layer.confirm('是否删除角色？', {
        btn: ['删除', '取消'] //按钮
    }, function () {
        post('/System/Role/DelectRole', { id: id })
            .then(function (res) {
                if (res.Data === true && res.Tag === 1) {
                    layer.msg('删除成功');
                    setTimeout(function () {
                        $('#table').bootstrapTable('refresh');
                    },2000)
                } else {
                    layer.alert('删除失败', { icon: 2 });
                }
            })
            .catch(function (err) {
                layer.alert(err, { icon: 2 });
            });
    });
}

/**
 * 
 * 删除多个选中的角色
 * @author liuguofeng
 * 
 * */
function delList() {
    //获取选中的列
    var rowList = $('#table').bootstrapTable('getSelections');
    var idList = [];
    for (var item of rowList) {
        idList.push(item.Id);
    }
    if (idList.length == 0) {
        layer.alert('请选择角色');
        return false;
    }
    layer.confirm('是否删除这些角色？', {
        btn: ['删除', '取消'] //按钮
    }, function () {
            //请求删除
            var data = {
                idList: idList
            };
            post('/System/Role/DelectRole', data)
                .then(function (res) {
                    if (res.Data === true && res.Tag === 1) {
                        layer.msg('删除成功');
                        setTimeout(function () {
                            $('#table').bootstrapTable('refresh');
                        }, 2000)
                    } else {
                        layer.alert('删除失败', { icon: 2 });
                    }
                })
                .catch(function (err) {
                    layer.alert('请求服务器失败:' + err, { icon: 1, })
                })
    });
}

```

