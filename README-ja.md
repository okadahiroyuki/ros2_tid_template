# ROS2 開発テンプレート
ROS2の開発を簡単に始めるためのテンプレート

## 特徴
- uvによるPythonパッケージ管理
- Docker対応
- pre-commitによる自動コードフォーマット

## 要件
- Docker + Docker Compose
- make (オプション)
- uv (ローカル開発よう)

## クイックスタート
[**⚡️このリポジトリからテンプレートプロジェクトを作成するにはここをクリックしてください**](https://github.com/new?template_name=ros2_TID_template&template_owner=okadahiroyuki)

```
# 作成したテンプレートプロジェクトをクローンする
git clone https://github.com/[your-user-name]/[your_project_name].git

# プロジェクトの名前変更（デフォルトはリポジトリ名）
./rename_project.sh [your_project_name]

# Docker コンテナのビルドと実行
make docker-build
make docker-up
make docker-attach

# あるいは、直接 Dockerコマンドでビルドと実行
docker compose build --no-cache
docker compose up -d
docker compose exec dev bash

# 仮想環境の作成
make venv

# ROS2パッケージのビルド (スクリプトで)
./build.sh

# サンプルROS2ノードの実行
source .venv/bin/activate
ros2 run your_project_name publisher.py
ros2 run your_project_name subscriber.py

```
## プロジェクトの構造
```
.
├── CMakeLists.txt          # ROS build configuration
├── package.xml             # ROS package definition
├── pyproject.toml          # Python project settings
├── scripts/                # 実行スクリプト
│   ├── publisher.py        　# サンプルプログラム（配信ノード）
│   └── subscriber.py       　# サンプルプログラム（購読ノード）
├── src/                    # ソースコード
│   └── your_project_name/  　# Python パッケージ
└── tests/                  # テストコード
```

## Makeコマンド
```
# 仮想環境の生成
make venv

# スクリプトの実行
make scripts-executable

# コードをフォーマットする
make format

# pytestの実行
make test

# パッケージのビルド
./build.sh

```

## カスタマイズの指針
### プロジェクト名の変更
```./rename_project.sh your_project_name```

### Python依存関係のアップデート
pyproject.toml を編集する

### ROS2パッケージの依存関係のアップデート
package.xml を編集する

### ビルド環境の編集
CMakeLists.txtを編集する

### ROS2ノードの追加
scripts/　ディレクトリに追加する

## Python依存関係の管理
Pythonの依存関係を管理するにはuvを使用します
```
# Pythonパッケージの追加
uv add {package-name}

# 開発用のPythonパッケージの追加
uv add --dev {package-name}
```

## License
MIT License - See [LICENSE](https://github.com/okadahiroyuki/ros2_TID_template/blob/main/LICENSE) for details.
