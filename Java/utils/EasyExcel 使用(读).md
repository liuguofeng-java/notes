## EasyExcel 使用(读)

##### 1. 添加 EasyExcel 依赖

在 `pom.xml` 中添加依赖（以 Maven 为例）：

```java
<dependency>
    <groupId>com.alibaba</groupId>
    <artifactId>easyexcel</artifactId>
    <version>3.3.2</version>
</dependency>
```

##### 2.定义 Java 数据模型

| xxxx            | xxxx           | xxxx           | xxxx         | xxxx            | xxxx         |
| --------------- | :------------- | :------------- | ------------ | --------------- | ------------ |
| **#法院:**      | 胶州市人民法院 |                |              |                 |              |
| **#案件类型:**  | 民事           |                |              |                 |              |
| **#诉讼代理人** | **代理人类型** | **代理人姓名** | **手机号码** | **证件类型**    | **证件号码** |
|                 | 执业律师       | 王五           | 18888888888  | 山东xxxx事务所  | 37aaa        |
|                 | 执业律师       | 张三           | 16666666666  | 山东zzzzz事务所 | 37xxxx       |

定义对应的 Java 类：

```java
public class CasesInfo implements Serializable {   
    @ApiModelProperty(value = "法院名称")
    private String courtName;

    @ApiModelProperty(value = "案件类型")
    private String caseType;

    @ApiModelProperty(value = "诉讼代理人")
    private List<LitigationAgent> litigationAgent = new ArrayList<>();
}
public class LitigationAgent {
    @ApiModelProperty("代理人类型")
    private String agentType;

    @ApiModelProperty("代理人姓名")
    private String name;

    @ApiModelProperty("手机号码")
    private String tel;

    @ApiModelProperty("证件类型")
    private String documentType;

    @ApiModelProperty("证件号码")
    private String documentNumber;
}
```

##### 3.编写读取监听器

```java
public class ComplexCaseDataListener extends AnalysisEventListener<Map<Integer, String>> {
    private final CasesInfo currentCase = new CasesInfo();

    private String identify = null;

    @Override
    public void invoke(Map<Integer, String> rowData, AnalysisContext context) {
        String firstCellValue = rowData.get(0);
        // 判断区块起始
        if ("#法院:".equals(firstCellValue)) {
            currentCase.setCourtName(rowData.get(1));
        } else if ("#案件类型:".equals(firstCellValue)) {
            currentCase.setCaseType(rowData.get(1));
        } else if ("#诉讼代理人".equals(firstCellValue)) {
            identify = "litigationAgents";
        } else {
            switch (identify) {
                case "litigationAgents":
                    currentCase.getLitigationAgent().add(setLitigationAgents(rowData));
                    break;
            }
        }
    }
    private LitigationAgent setLitigationAgents(Map<Integer, String> rowData) {
        int i = 1;
        LitigationAgent litigationAgent = new LitigationAgent();
        litigationAgent.setAgentType(rowData.get(i++));
        litigationAgent.setName(rowData.get(i++));
        litigationAgent.setTel(rowData.get(i++));
        litigationAgent.setDocumentType(rowData.get(i++));
        litigationAgent.setDocumentNumber(rowData.get(i++));
        return litigationAgent;
    }
    @Override
    public void doAfterAllAnalysed(AnalysisContext analysisContext) {

    }
    public CasesInfo getList() {
        return currentCase;
    }
}
```

##### 4.读取 Excel 数据

```java
public static void main(String[] args) {
     String fileName = "C:\\Users\\liugu\\Desktop\\test.xlsx";
        ExcelReader excelReader = EasyExcel.read(fileName).build();
        List<ReadSheet> sheets = excelReader.excelExecutor().sheetList();
    	// 循环所有sheet
        for (ReadSheet sheet : sheets) {
            ComplexCaseDataListener listener = new ComplexCaseDataListener();
            EasyExcel.read(fileName, listener)
                    .sheet(sheet.getSheetName())
                    .headRowNumber(0) // 无表头，按行解析
                    .doRead();

            CasesInfo caseData = listener.getList();
            System.out.println("读取到的案件数据: " + caseData);
        }
}
```

