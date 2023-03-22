## java导出zip
```java
/**
     * 导出企业相关图片信息
     * @param extIds 企业id
     * @return
     */
    @ApiOperation(value="导出企业相关图片信息",notes="导出企业相关图片信息")
    @PostMapping("/exportExtImages")
    public void exportExtImages(@RequestBody ExtImagesVo extIds, HttpServletResponse response) throws Exception {
//        extInfoService.exportExtImages();

        LambdaQueryWrapper<ExtInfo> extInfoWrapper = new LambdaQueryWrapper<>();
        for (String s : extIds.getExtIds()) {
            extInfoWrapper.eq(ExtInfo::getExtId, s).or();
        }
        List<ExtInfo> list = extInfoService.list(extInfoWrapper);
        if (list.size() == 0){
            throw new RuntimeException("请选择企业!");
        }

        ServletOutputStream outputStream = response.getOutputStream();
        ZipOutputStream zipOutputStream = new ZipOutputStream(outputStream);
        for (ExtInfo item : list) {

            zipOutputStream.putNextEntry(new ZipEntry(String.format("%s/%s.png",item.getExtName(),item.getExtName())));
            byte[] wxaCodeBytes = wxMaService.getWxMaService().getQrcodeService().createWxaCodeBytes("/pages/index",
                    30, false,
                    new WxMaCodeLineColor("0", "0", "0"),
                    false);

            zipOutputStream.write(wxaCodeBytes);


            zipOutputStream.putNextEntry(new ZipEntry(String.format("%s/%s-logo.png",item.getExtName(),item.getExtName())));
            URL url = new URL(cosConfig.getServeUrl() + item.getExtLogo());
            URLConnection connection = url.openConnection();
            InputStream is = connection.getInputStream();
            byte[] bytes = new byte[is.available()];
            int len;
            while ((len = is.read(bytes)) != -1){
                zipOutputStream.write(bytes,0,len);
            }
            is.close();

        }
        response.setContentType("application/octet-stream");
        response.setHeader("Content-disposition", "attachment; filename=" + new String("导出".getBytes(StandardCharsets.UTF_8), "ISO8859-1"));
        zipOutputStream.close();
        outputStream.close();
    }
```

