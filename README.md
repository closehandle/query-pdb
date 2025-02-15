# Query PDB
对 [原仓库](https://github.com/zouxianyu/query-pdb) 重新打包的 Docker 镜像

```yaml
volumes:
  query-pdb:
    name: query-pdb
    external: false

services:
  query-pdb:
    dns:
      - 127.0.0.1
    image: closehandle/query-pdb:latest
    volumes:
      - query-pdb:/data
    restart: always
    environment:
      - TZ=Asia/Shanghai
      - BIND_ADDR=0.0.0.0
      - BIND_PORT=8080
      - DATA_PATH=data
    network_mode: host
    container_name: query-pdb
```
