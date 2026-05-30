# データの読み込み
scores <- read.csv("data/raw/scores.csv")

# 中身を確認
print(scores)

# 各科目の分散
cat("\n--- 分散 ---\n")
cat("数学:", var(scores$math), "\n")
cat("英語:", var(scores$english), "\n")
cat("理科:", var(scores$science), "\n")

# まとめて見たい場合
cat("\n--- 基本統計量 ---\n")
summary(scores)
