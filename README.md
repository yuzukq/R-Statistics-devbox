# R Statistics with devbox

devbox（Nixベース）を使ってホストOSを汚さずにRの実行環境を構築します。
VMのオーバヘッドないため軽量であり、ZedのLSP補完とAirによるフォーマットと併用すれば軽量かつ高速なR実行環境になります。

## セットアップ手順
### 1. devboxのインストール

```bash
curl -fsSL https://get.jetify.com/devbox | bash
```

### 2. リポジトリのclone

```bash
git clone https://github.com/yuzukq/R-Statistics-devbox
cd R-Statistics-devbox
```

### 3. Rのインストール

```bash
devbox install
```

`devbox.json`に定義されたR本体・languageserverが自動でインストールされます。

### 4. ラッパースクリプトに実行権限を付与

```bash
chmod +x r-lsp-wrapper.sh
```

### 5. ZedのExtensionsをインストール

Zedのエクステンションから以下の2つをインストールします：

- `[R](https://github.com/ocsmit/zed-r)` - シンタックスハイライト・LSP補完
- `[Air](https://github.com/posit-dev/air)` - コードフォーマッター

### 6. ZedのLSP設定を作成

プロジェクトルートに `.zed/settings.json` を作成します：

```bash
mkdir -p .zed
```

`.zed/settings.json` の内容（`/your/path/to`は実際のパスに変更）：

```json
{
  "lsp": {
    "r_language_server": {
      "binary": {
        "path": "/your/path/to/R-Statistics-devbox/r-lsp-wrapper.sh",
        "arguments": ["--slave", "--no-save", "--no-restore", "-e", "languageserver::run()"]
      }
    }
  }
}
```

プロジェクトの絶対パスは以下で確認できます：

```bash
pwd
```

## 使い方

### devbox環境に入る

```bash
devbox shell
```

プロンプトに `(devbox)` が付いたら環境に入った状態です。`exit` で抜けられます。

### Rスクリプトを実行する

```bash
devbox shell
Rscript scripts/スクリプト名.R
```

### 対話モードのRコンソール

```bash
devbox shell
R
```

`q()` で終了します。

## ディレクトリ構成

```
R-Statistics-devbox/
├── devbox.json          # 環境定義（R本体・devツールのバージョン管理）
├── r-lsp-wrapper.sh     # ZedのLSP用ラッパースクリプト
├── data/
│   ├── raw/             # 元データ（CSV等）※gitで管理
│   └── processed/       # 加工済みデータ ※gitで管理しない
├── R/                   # 自作関数
├── scripts/             # 分析スクリプト
└── output/
    ├── figures/         # グラフ出力先 ※gitで管理しない
    └── tables/          # 集計表出力先 ※gitで管理しない
```

## [備考]パッケージ管理について

解析パッケージも含めてすべて `devbox add` で管理します。

```bash
devbox add rPackages.tidyverse rPackages.sem
```

nixpkgsのRパッケージはCRANのスナップショットから自動生成されており、統計解析で使う主要パッケージはほぼカバーされています。

> "The R-packages available in `<nixpkgs>` are generated from a recent snapshot of CRAN."
> — [NixOS Wiki - R](https://wiki.nixos.org/wiki/R)

> "There is a script and associated environment for regenerating the package sets and synchronising the rPackages tree to the current CRAN and matching BIOC release."
> — [nixpkgs languages-frameworks/r](https://github.com/NixOS/nixpkgs/blob/master/doc/languages-frameworks/r.section.md)

ただし一部パッケージはバージョンが遅れる場合があります。インストール前に存在確認したい場合は以下で検索できます：

```bash
devbox search rPackages.パッケージ名
```

> **注意:** `install.packages()` による直接インストールはNixストアが読み取り専用のためエラーになります。
