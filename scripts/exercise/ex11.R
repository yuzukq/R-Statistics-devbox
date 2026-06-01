# 3種類の授業形態によって定着度テストの得点に有意な差があるかを
# 分散分析（対応あり）により確認しなさい。

df <- read.csv("../../data/exercise/ex11.csv")

# wide形式 → long形式に変換
long_df <- data.frame(
  student = rep(df$学生, 3),
  method  = rep(c("講義", "問題練習", "コンピュータ実習"), each = nrow(df)),
  score   = c(df$講義, df$問題練習, df$コンピュータ実習)
)

# 1要因分散分析（対応あり）
# Error(student/method) で個人差を除いた誤差項を指定
result <- aov(score ~ method + Error(student/method), data = long_df)
summary(result)

# --- 結果の解釈 ---
# 帰無仮説：3種類の授業形態による定着度の母平均はすべて等しい
# 対立仮説：少なくとも1つの授業形態間に差がある
#
# 対応なし（ex10）との違いは Error(student/method) の指定。
# 同じ学生が全条件を受けているため個人差を誤差から分離でき、
# 検定力が上がる。
#
# p値 < 0.05 であれば授業形態によって定着度に有意な差があると結論づける。
