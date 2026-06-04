# 検定力分析によるサンプルサイズの決定
# pwr::pwr.t.test() は効果量（Cohen's d）を引数に取る。
#   d      : 効果量（= delta / sd）
#   n      : サンプルサイズ（各群）
#   sig.level : 有意水準（デフォルト 0.05）
#   power  : 検定力（デフォルト 0.80）
#   type   : "two.sample"（2標本）/ "one.sample" / "paired"
# 4つのうち1つを NULL にすると、その値を逆算してくれる。

library(pwr)

# 効果量（Cohen's d）の計算：差 delta=5, sd=10
d <- 5 / 10  # 0.5（中程度の効果量）

# --- (1) サンプルサイズを求める ---
# 効果量 d=0.5, power=0.80 を達成するのに必要な n は？
pwr.t.test(d = d, sig.level = 0.05, power = 0.80, type = "two.sample")

# --- (2) 検定力を求める ---
# n=20 のとき、同じ条件での検定力は？
pwr.t.test(n = 20, d = d, sig.level = 0.05, type = "two.sample")

# --- (3) 検出できる最小の効果量（d）を求める ---
# n=20, power=0.80 のとき、検出できる d は？
# 実際の差に換算するには delta = d * sd
result <- pwr.t.test(n = 20, sig.level = 0.05, power = 0.80, type = "two.sample")
result
cat("検出できる最小の差（delta）:", result$d * 10, "\n")

# --- 結果の解釈 ---
# power.t.test() との違い：
#   - power.t.test() は delta と sd を個別に指定する
#   - pwr.t.test()   は Cohen's d（= delta/sd）という標準化された効果量を使う
#   - 効果量を使うことで、異なる研究間での比較・文献値との照合が容易になる
#
# Cohen's d の目安：
#   0.2 = 小、0.5 = 中、0.8 = 大
#
# 検定力分析の4要素はトレードオフの関係にある：
#   - n を増やす → 検定力が上がる・小さな差も検出できる
#   - d を大きくする（大きな効果を検出したい）→ 必要な n が減る
#   - sig.level を厳しくする（0.01 など）→ 必要な n が増える
#   - power を高くする（0.90 など）→ 必要な n が増える
