# 中国股票数据 (china-stocks)

基于 AkShare 财经数据接口的股票查询工具。

## 功能

- **实时行情** - 获取个股实时价格、涨跌幅等
- **K线数据** - 获取历史K线
- **股票搜索** - 按代码/名称搜索

## 使用方法

```bash
# 获取实时行情（需要获取全市场数据，约1-2分钟）
python scripts/stocks.py quote 688018

# 获取K线数据（最近30天）
python scripts/stocks.py info 688018

# 搜索股票（首次需要下载全市场数据）
python scripts/stocks.py search 绿的
```

## 示例输出

### 实时行情
```json
{
  "code": "688018",
  "name": "乐鑫科技",
  "price": 161.49,
  "change": -5.81,
  "pct": -3.47,
  "vol": 689430613,
  "amount": 4283400000,
  "open": 168.19,
  "high": 169.00,
  "low": 158.88,
  "preclose": 167.30,
  "turnover": 1.84
}
```

### K线数据
```json
[
  {
    "date": "2026-01-20",
    "open": 165.00,
    "close": 168.50,
    "high": 169.80,
    "low": 164.20,
    "vol": 523400,
    "amount": 8692000000
  }
]
```

## 依赖

- akshare (已安装)
- pandas
- requests

## 注意事项

- 首次运行需要下载全市场股票数据（约1-2分钟）
- 后续运行会使用缓存，速度更快
- 网络不稳定时可能失败，建议重试
