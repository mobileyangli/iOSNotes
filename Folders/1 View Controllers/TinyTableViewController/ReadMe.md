
## 设计期望 ##

1. 将view controller中设置tableview的datasource内容，提取分离到一个datasource类中，这样可以复用和测试

2. 将tableview的数据获取从view controller中提取到对应的model类extension中，可以分离数据管理逻辑，复用model和测试