# 法学部・文学部・理学部・工学部の4学部間でテストの母平均に
# 有意な差があるかを分散分析により確認しなさい。

df <- read.csv("../../data/exercise/ex10.csv")

# wide形式 → long形式に変換（aov()はlong形式が必要）
long_df <- stack(df)
names(long_df) <- c("score", "faculty")

# 1要因分散分析（対応なし）
result <- aov(score ~ faculty, data = long_df)
summary(result)

# 有意差があった場合の多重比較（Tukey法）
TukeyHSD(result)

# --- 結果の解釈 ---
# 帰無仮説：4学部の母平均はすべて等しい
# 対立仮説：少なくとも1つの学部間に差がある
#
# summary() の F値に対応する p値 < 0.05 であれば、
# どこかの学部間に有意差ありと結論づける。
#
# ただし分散分析は「どこかに差がある」しかわからないため、
# TukeyHSD() で全ペアの多重比較を行い、具体的にどの学部間に差があるかを確認する。
#
# 工学部の平均点が他学部より低めなので、工学部 vs 他学部で有意差が出ると予想される。
