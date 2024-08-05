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

```java
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
		// 第二种方式
        cells=row.createCell(2);
        cells.setCellValue(Calendar.getInstance());
        cells.setCellStyle(style);
        FileOutputStream out=new FileOutputStream("C:\\Users\\Administrator\\Desktop\\时间格式.xls");
        wk.write(out);
        out.close();
    }
```

### 遍历行和列

```java
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

```java
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

### 导出Excel工具类

```java
/**
 * excel 导出工具类
 */
public class ExcelUtil {

    /**
     * 创建工作表
     *
     * @param workbook  workbook对象
     * @param sheetName 工作表名称
     * @param headers   表头
     * @param values    值
     */
    public static void createSheet(XSSFWorkbook workbook, String sheetName, List<String> headers, List<Object[]> values) {
        //在workbook中添加一个sheet,对应Excel文件中的sheet
        Sheet sheet = workbook.createSheet(sheetName);
        //设置标题样式
        CellStyle style = workbook.createCellStyle();
        style.setAlignment(HorizontalAlignment.CENTER);   //设置居中样式
        style.setVerticalAlignment(VerticalAlignment.CENTER);
        //设置标题字体
        Font titleFont = workbook.createFont();
        titleFont.setFontHeightInPoints((short) 14);
        style.setFont(titleFont);
        style.setFillForegroundColor(IndexedColors.YELLOW.getIndex()); // 设置前景填充颜色
        style.setFillPattern(FillPatternType.SOLID_FOREGROUND); // 设置前景填充样式
        style.setBorderBottom(BorderStyle.THIN);
        style.setBorderLeft(BorderStyle.THIN);
        style.setBorderRight(BorderStyle.THIN);
        style.setBorderTop(BorderStyle.THIN);


        //设置表内容样式
        //创建单元格，并设置值表头 设置表头居中
        CellStyle style1 = workbook.createCellStyle();
        style1.setBorderBottom(BorderStyle.THIN);
        style1.setBorderLeft(BorderStyle.THIN);
        style1.setBorderRight(BorderStyle.THIN);
        style1.setBorderTop(BorderStyle.THIN);

        //产生表头
        Row row = sheet.createRow(0);
        for (int i = 0; i < headers.size(); i++) {
            Cell hssfCell = row.createCell(i);
            hssfCell.setCellValue(headers.get(i));
            hssfCell.setCellStyle(style);

            // 表头自适应
            int width = hssfCell.getStringCellValue().getBytes().length * 256 + 200;
            int columnWidth = sheet.getColumnWidth(i);
            if (columnWidth < width) {
                sheet.setColumnWidth(i, width);
            }
        }

        //创建内容
        for (int i = 0; i < values.size(); i++) {
            row = sheet.createRow(i + 1);
            for (int j = 0; j < values.get(i).length; j++) {
                //将内容按顺序赋给对应列对象
                Cell hssfCell = row.createCell(j);
                Object val = values.get(i)[j];
                if (val instanceof String) {
                    hssfCell.setCellValue(String.valueOf(val));
                } else if (val instanceof Integer) {
                    hssfCell.setCellValue((Integer) val);
                } else if (val instanceof Double) {
                    hssfCell.setCellValue((Double) val);
                } else if (val instanceof Boolean) {
                    hssfCell.setCellValue((Boolean) val);
                } else if (val instanceof LocalDateTime) {
                    hssfCell.setCellValue((LocalDateTime) val);
                }
                hssfCell.setCellStyle(style1);

                // 内容自适应
                int width = val.toString().getBytes().length * 256 + 200;
                int columnWidth = sheet.getColumnWidth(j);
                if (columnWidth < width) {
                    sheet.setColumnWidth(j, width);
                }
            }
        }
    }

}

```

