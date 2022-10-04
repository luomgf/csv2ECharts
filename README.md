# csv2ECharts


**一行命令查看数据趋势图！**





基于shell，实现将CSV格式数据转化为数据图。运维中尝尝需要查看某个监控指标的变化，通过图表观察更直观，

且用其他excel/powerbi等由太麻烦，因此用这个直接将csv数据转化为可视化折线图，快捷简单。

当然看其他数据也是可以的。



- [gitee项目地址](https://gitee.com/luomg/csv2ECharts.git):https://gitee.com/luomg/csv2ECharts.git

- [github项目地址](https://github.com/luomgf/csv2ECharts.git):https://github.com/luomgf/csv2ECharts.git



# 使用

## 命令

```bash
./csv2ECharts.sh ./test/free_mon_202209.csv > demo.html
```

## 数据

### 数据格式

第一行：为列头名称，“,”逗号分隔

2~N: 为数据行，支持格式可以见示例数据



### 示例数据

```
time,total,free,use
20221001T122320,20,5,15
20221002122320,50,30,20
2022-10-03 12:23:20,60,35,25
2022/10/04 12:23:20,70,30,40
```





如下展示监控主机的内存数据情况，查看数据变化趋势。

![demo1](./demo1.gif)



## To Do



- [ ] 添加主题切换按钮

- [ ] 图例居中
- [ ] 增加全选按钮
- [ ] 增加反选按钮
- [ ] 增加基于字段分组查看

