## Java POI

### 创建一个工作薄

```csharp
public static void main(String[] args) throws IOException {
    Workbook wk=new HSSFWorkbook();//定义一个工作薄
    FileOutputStream out= new FileOutputStream("C:\\Users\\Administrator\\Desktop\\用Poi搞出来的工作薄.xls");
    wk.write(out);
    out.close();
}
```

### 基本操作

```csharp
public static void main(String[] args) throws IOException {
    Workbook wk=new HSSFWorkbook();//创建一个工作薄
    Sheet sh=wk.createSheet("第一个sheet页");//创建一个sheet页
    Row row=sh.createRow(0);//创建第一行
    Cell cell=row.createCell(0);//创建第一行的第一个单元格
    cell.setCellValue(1);//为第一行第一个单元格塞值
    row.createCell(1).setCellValue(1.2);//创建第一行第2个单元格并赋值
    row.createCell(2).setCellValue("这是一个字符串");//创建第一行第3个单元格并赋值
    row.createCell(3).setCellValue(true);//创建第一行第4个单元格并赋值
    FileOutputStream out= new FileOutputStream("C:\\Users\\Administrator\\Desktop\\用Poi搞出来的cells和sheet页.xls");
    wk.write(out);
    out.close();
}
```

### 设置单元格边框颜色

```csharp
public static void main(String[] args) throws IOException {
    Workbook wb=new HSSFWorkbook();//创建工作簿
    Sheet sh=wb.createSheet("第一个sheet页");//创建一个sheet页
    Row row=sh.createRow(2);//创建一行
    Cell cell=row.createCell(2);//创建一个单元格
    cell.setCellValue(4);//设置值

    //设置边框颜色
    CellStyle cellStyle=wb.createCellStyle();
    cellStyle.setBorderBottom(CellStyle.THIN_BACKWARD_DIAG);//设置底部边框
    cellStyle.setBottomBorderColor(IndexedColors.BLACK.getIndex());//设置底部边框颜色
    cellStyle.setBorderLeft(CellStyle.BORDER_THIN);//设置左部边框
    cellStyle.setLeftBorderColor(IndexedColors.BLUE.getIndex());//设置左部边框颜色
    cellStyle.setBorderRight(CellStyle.BORDER_THIN);//设置右部边框
    cellStyle.setRightBorderColor(IndexedColors.RED.getIndex());//设置右部边框颜色
    cellStyle.setBorderTop(CellStyle.BORDER_THIN);//设置顶部边框
    cellStyle.setTopBorderColor(IndexedColors.ORANGE.getIndex());//设置顶部边框颜色
    cell.setCellStyle(cellStyle);

    FileOutputStream out=new FileOutputStream("C:\\Users\\Administrator\\Desktop\\设置单元格颜色.xls");
    wb.write(out);
    out.close();
}
```

### 字体处理（标题）

```csharp
public static void main(String[] args) throws IOException {
    Workbook workbook=new HSSFWorkbook();
    Sheet sheet=workbook.createSheet();
    Row row=sheet.createRow(1);
    //字体处理类
    Font font=workbook.createFont();
    font.setFontHeightInPoints((short)50);//设置字体高度
    font.setItalic(true);//字体是否是斜体
    font.setFontName("宋体");//设置字体名字

    CellStyle cellStyle=workbook.createCellStyle();
    cellStyle.setFont(font);
    Cell cell=row.createCell(1);
    cell.setCellValue("This is test fonts");
    cell.setCellStyle(cellStyle);

    FileOutputStream out=new FileOutputStream("C:\\Users\\Administrator\\Desktop\\字体处理.xls");
    workbook.write(out);
    out.close();
}
```

### 时间格式的单元格

```csharp
public static void main(String[] args) throws IOException {
        Workbook wk=new HSSFWorkbook();//创建一个工作薄
        Sheet sh=wk.createSheet();//创建sheet页
        Row row=sh.createRow(0);//创建第一行
        Cell cells= row.createCell(0);//创建第一个单元格
        cells.setCellValue(new Date());//给第一个单元格塞值

        CreationHelper creationHelper=wk.getCreationHelper();//时间格式化工具
        CellStyle style=wk.createCellStyle();//单元格样式
        style.setDataFormat(creationHelper.createDataFormat().getFormat("yyyy-MM-dd hh:mm:ss"));//时间格式化
        cells=row.createCell(1);//创建第一行第二个单元格
        cells.setCellValue(new Date());//给第一个单元格塞值
        cells.setCellStyle(style);//改变单元格样式
//        第二种方式
        cells=row.createCell(2);
        cells.setCellValue(Calendar.getInstance());
        cells.setCellStyle(style);
        FileOutputStream out=new FileOutputStream("C:\\Users\\Administrator\\Desktop\\时间格式.xls");
        wk.write(out);
        out.close();
    }
```

### 遍历行和列

```csharp
public static void main(String[] args) throws IOException {
    InputStream in= new FileInputStream("C:\\Users\\Administrator\\Desktop\\设备借用单（出库用）12.09.xls");
    POIFSFileSystem pfs=new POIFSFileSystem(in);//文件系统可接受一个输入流
    HSSFWorkbook hwb=new HSSFWorkbook(pfs);
    HSSFSheet sheet=hwb.getSheetAt(0);//获取第一个sheet页
    if(sheet == null) {
        return;
    }
    //遍历row
    for(int rowNum= 0;rowNum <= sheet.getLastRowNum();rowNum++) {
        HSSFRow hssfRow=sheet.getRow(rowNum);
        if(hssfRow== null) {
            continue;
        }
        //遍历cells
        for(int cellNum=0;cellNum <= hssfRow.getLastCellNum();cellNum++) {
            HSSFCell hssfcell=hssfRow.getCell(cellNum);
            if(hssfcell== null) {
                continue;
            }
            System.out.print(" "+hssfcell);
        }
        System.out.println();
    }
    in.close();
}
```

### 单元格合并居中

```csharp
public static void main(String[] args) throws IOException {
    Workbook wb=new HSSFWorkbook();//创建工作薄
    Sheet sheet=wb.createSheet();//创建sheet页
    Row row=sheet.createRow(1);//创建行

    Cell cell=row.createCell(1);//创建单元格
    cell.setCellValue("单元格合并测试");
    /**
     * 合并单元格的API
     */
    sheet.addMergedRegion(new CellRangeAddress(
            1,//起始行
            2,//结束行
            1,//起始列
            2//结束列
    ));
    CellStyle cellStyle=wb.createCellStyle();
    cellStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER);
    cellStyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
    cell.setCellStyle(cellStyle);

    FileOutputStream out=new FileOutputStream("C:\\Users\\Administrator\\Desktop\\单元格合并.xls");
    wb.write(out);
    out.close();
}
```

### 导出Excel

```csharp
/**
 *
 * @param title 标题
 * @param headers  表头
 * @param values  表中元素
 * @return
 */
public HSSFWorkbook getHSSFWorkbook(String title, String headers[], String [][] values){

    //创建一个HSSFWorkbook，对应一个Excel文件
    HSSFWorkbook hssfWorkbook = new HSSFWorkbook();
    //在workbook中添加一个sheet,对应Excel文件中的sheet
    HSSFSheet hssfSheet = hssfWorkbook.createSheet(title);
    //创建标题合并行
    hssfSheet.addMergedRegion(new CellRangeAddress(0,(short)0,0,(short)headers.length - 1));
    //设置标题样式
    HSSFCellStyle style = hssfWorkbook.createCellStyle();
    style.setAlignment(HorizontalAlignment.CENTER);   //设置居中样式
    style.setVerticalAlignment(VerticalAlignment.CENTER);
    //设置标题字体
    Font titleFont = hssfWorkbook.createFont();
    titleFont.setFontHeightInPoints((short) 14);
    style.setFont(titleFont);

    //设置值表头样式 设置表头居中
    HSSFCellStyle hssfCellStyle = hssfWorkbook.createCellStyle();
    hssfCellStyle.setAlignment(HorizontalAlignment.CENTER);   //设置居中样式
    hssfCellStyle.setBorderBottom(BorderStyle.THIN);
    hssfCellStyle.setBorderLeft(BorderStyle.THIN);
    hssfCellStyle.setBorderRight(BorderStyle.THIN);
    hssfCellStyle.setBorderTop(BorderStyle.THIN);

    //设置表内容样式
    //创建单元格，并设置值表头 设置表头居中
    HSSFCellStyle style1 = hssfWorkbook.createCellStyle();
    style1.setBorderBottom(BorderStyle.THIN);
    style1.setBorderLeft(BorderStyle.THIN);
    style1.setBorderRight(BorderStyle.THIN);
    style1.setBorderTop(BorderStyle.THIN);

    //产生标题行
    HSSFRow hssfRow = hssfSheet.createRow(0);
    HSSFCell cell = hssfRow.createCell(0);
    cell.setCellValue(title);
    cell.setCellStyle(style);
    
    //产生表头
    HSSFRow row1 = hssfSheet.createRow(1);
    for (int i = 0; i < headers.length; i++) {
        HSSFCell hssfCell = row1.createCell(i);
        hssfCell.setCellValue(headers[i]);
        hssfCell.setCellStyle(hssfCellStyle);
    }

    //创建内容
    for (int i = 0; i <values.length; i++){
        row1 = hssfSheet.createRow(i +2);
        for (int j = 0; j < values[i].length; j++){
            //将内容按顺序赋给对应列对象
            HSSFCell hssfCell = row1.createCell(j);
            hssfCell.setCellValue(values[i][j]);
            hssfCell.setCellStyle(style1);
        }
    }
    return hssfWorkbook;
}
@Test
public void GetModelList() throws IOException {
    List<TestRecord> testRecords = testRecordImpl.GetModelList();
    //excel表名
    String [] headers = {"id","getMachineName", "getTestDate", "getCreateDate","getPatientName","getSimpleColor"};
    //excel文件名
    String fileName = "xxx";

    //excel元素
    String content[][] = new String[testRecords.size()][1000000];
    for (int i = 0; i < testRecords.size(); i++) {
        content[i] = new String[headers.length];
        content[i][0] = testRecords.get(i).getId();
        content[i][1] = testRecords.get(i).getMachineName();
        content[i][2] = testRecords.get(i).getTestDate().toString();
        content[i][3] = testRecords.get(i).getCreateDate().toString();
        content[i][4] = testRecords.get(i).getPatientName();
        content[i][5] = testRecords.get(i).getSimpleColor();
    }
    headers[0] = "TestRecord";
    HSSFWorkbook hssfWorkbook = excelUtil.getHSSFWorkbook(fileName, headers, content);
    hssfWorkbook.write(new FileOutputStream("C:\\Users\\Administrator\\Desktop\\a.xls"));
}
```

