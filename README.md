# containerからselenumを使うときのメモ

## 最初に
M1 Macだとcontainer buildに失敗するので、GoogleCloudでGCEを使ってVMインスタンスを作成する。
それにDockerとGitをインストールして、VMインスタンス上で作成するか、CI/CDでcontainer作る。

## VM環境でDockerをインストールする
- UbuntuでVMインスタンスを作る
- Dockerをインストールする

https://docs.docker.com/engine/install/ubuntu/

この通りにやれば出来る

出来たらgit cloneしてVMに入れる

ビルドする
```
docker build -t selenum_test .
```

出来たらログインして動かしてみる
```
docker exec -it selenume_test /bin/bash
```

手動でちゃんと動くか確認

```
python main.py https:www.google.com
```

