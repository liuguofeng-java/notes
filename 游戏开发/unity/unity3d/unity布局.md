## unity布局

#### 1.HorizontalLayoutGroup(水平布局)
**padding**                        边距(被布局控件与四边框的距离)
**Spacing**                        间距(被布局控件之间的距离)
**Child Alignment**            子物体对齐方式
**ChildForceExpend**       自适应宽高

#### 2.VerticalLayoutGroup(垂直布局)
**Padding**                        边距
**Spacing**                        间距
**Child Alignment**            子物体排列方式
**ChildForceExpend**        自适应宽高

#### 3.GridLayoutGroup(网格布局)

**Padding**                        边距
**CellSize**                        被布局控件的宽高
**Spacing**                         间距
**StartCorner**                   开始位置
**StartAxis**                       开始轴
**Child Alignment**            子物体排列方式
**Constraint**                     填充方式,可以固定行和列数
​	**Flexible**                                (不限制)
​	**Fixed Column Count**           (限制列数)
​	**Fixed Row Count**                (限制行数)