## tracker.sh

- 执行以下命令可直接获取 Aria2 可用格式的 BT tracker 列表。
```
bash <(curl -fsSL git.io/tracker.sh) cat
```

- 在 Aria2 配置文件(`aria2.conf`)所在目录执行以下命令即可获取最新 BT tracker 列表并自动添加到配置文件中。
```
bash <(curl -fsSL git.io/tracker.sh)
```

- 指定 Aria2 配置文件路径，比如配置文件在`/root/.aria2/aria2.conf`：
```
bash <(curl -fsSL git.io/tracker.sh) "/root/.aria2/aria2.conf"
```

- 通过 RPC 方式给远程 Aria2 更新 BT tracker 列表。
```
bash <(curl -fsSL git.io/tracker.sh) RPC '233.233.233.233:6800' 'Secret123'
```

- 通过 RPC 方式给本地 Aria2 更新 BT tracker 列表，并写入到 Aria2 配置文件中。
```
bash <(curl -fsSL git.io/tracker.sh) "/root/.aria2/aria2.conf" RPC
```
