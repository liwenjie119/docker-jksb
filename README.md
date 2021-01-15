# zzu-jksb



### 使用命令(阿里云)

https://github.com/wcwac/zzu-jksb

自用的命令：

```
docker run -dit --name jksb -e username=username -e password=password -e api=api registry.cn-hangzhou.aliyuncs.com/muxinghe/docker-jksb:latest
```


### 使用命令

可通过ssh连接到docker，或使用

```
docker run -dit --name jksb1 -e username=username -e password=password -e api=api muxinghe/docker-jksb:latest
```


### 注意事项

注意替换-e的环境变量