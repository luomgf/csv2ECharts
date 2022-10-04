#!/bin/sh


#name:csv2Echarts
#version:v1.0
#update:2022-10-4 12:00
#create by:luomgf
#mail: luomgf@163.com

#如下为测试数据(去掉#保存csv):支持4种时间格式
# time,total,free,use
# 20221001T122320,20,5,15
# 20221002122320,50,30,20
# 2022-10-03 12:23:20,60,35,25
# 2022/10/04 12:23:20,70,30,40


AWK_CODE=$(cat<<'EOF'
#!/usr/bin/env awk  -f 

#test: head -3 ./free_mon_202209.csv |./csv2chart.sh 

#下一版本增加全选和取消


BEGIN{
    RS="\r\n|\r|\n"

    FS="[,]+";
}

#csv table head title
1==NR{
    header[1]="\""$1"\""
    for(i=2;i<=NF;i++){
        header[i]=$i;
        if(i==2){
            legend="\""$2"\"";
            }
        else{
            legend=legend",""\""$i"\"";
        }
    }
        
}

#csv data start
1<NR {
    if(NR ==2){
        indexdata="\""$1"\""
        for(i=2;i<=NF;i++){
        data[i]=$i;
        }
    }
    else {
        indexdata=indexdata",""\""$1"\"";
        for(i=2;i<=NF;i++){
            data[i]=data[i]","$i;
            
        }
    }
}
END{
    print "<!DOCTYPE html>"
    print "<html>"
    print "  <head>"
    print "    <meta charset=\"utf-8\" />"
    print "    <title>ECharts</title>"
    print "   "
    print "<script crossorigin=\"anonymous\" integrity=\"sha512-MfVqysVqqTjFahELW0WOXQfF0aJj4RSZRmT9Btnyuv3rRg5L+6g72LPYs4yBNJAjQ/aTsymbR+oOcwVqJiNC7A==\" src=\"https://lib.baomitu.com/echarts/5.3.3/echarts.common.min.js\"></script>"
    print "  </head>"
    print "  <body>"
    print "    <!-- 为 ECharts 准备一个定义了宽高的 DOM -->"
    print "    <div id=\"main\" style=\"width: 100%;height:800px;\"></div>"
    print "    <script type=\"text/javascript\">"
    print "      // 基于准备好的dom，初始化echarts实例"
    print "      var myChart = echarts.init(document.getElementById(\"main\"),\"dark\" );"


    print "var option={ "
    print "title: { text: \"free -wt监控数据\", subtext: \"监控\"},"
    print "tooltip: { trigger: \"axis\"},"
    #print "legend: { data: ["legend"],type: \"scroll\", orient: \"vertical\",top:\"30\",right: \"right\",y: \"center\",bottom: \"top\",itemWidth:6,textStyle: {fontSize: 10,fontFamily: \"Microsoft YaHei\"},},"
    print "legend: { data: ["legend"], x:\"\bottom\",top:\"auto\",right: \"right\", bottom: \"bottom\",itemWidth:6,textStyle: {fontSize: 10,fontFamily: \"Microsoft YaHei\"},},"
    print "calculable: true,"
    print "xAxis: [ {type: \"category\",boundaryGap: false,data: ["indexdata" ] }],"
    print "yAxis: [ {type: \"value\", name: \"字节\"}],"

    print "series: ["
   for(d in data){
        #print header[d],data[d];
    print "{ name: \""header[d]"\",type: \"line\",data: ["data[d]" ] },"
    }
    print "]," #series end

    print " toolbox: {"
    print "        show: true,"
    print "        feature: { dataZoom: {"
    print "        orient: \"horizontal\", "
    print "        backgroundColor: \"rgba(0,0,0,0)\",     "
    print "        dataBackgroundColor: \"#eee\",           "
    print "        fillerColor: \"rgba(144,197,237,0.2)\", "
    print "        handleColor: \"rgba(70,130,180,0.8)\"  "
    print "    },"
    print "            mark: {"
    print "                show: true"
    print "            },"
    print "            dataView: {"
    print "                show: true,"
    print "                readOnly: true"
    print "            },"
    print "            magicType: {"
    print "                show: false,"
    print "                type: ["line", "bar"]"
    print "            },"
    print "            restore: {"
    print "                show: true"
    print "            },"
    print "            saveAsImage: {"
    print "                show: true"
    print "            }"
    print "        }" # feature end
    print "    }" #toolbox end

    print "}"  #option end

    print "  myChart.setOption(option,\"dark\" );"
    print " </script>"
    print "</body>"
    print "</html>"
}
EOF
)


perl   -npe '
s#^(\d{4})[-/]*(\d{2})[-/]*(\d{2})[\sT]*(\d{2}):*(\d{2}):*(\d{2})#\1-\2-\3 \4:\5:\6#;
s#[ \t]+#,#g;
s#[ ,\t]+(\d{2}):*(\d{2}):*(\d{2})# #g;
' $1 \
| awk   "${AWK_CODE}" 





