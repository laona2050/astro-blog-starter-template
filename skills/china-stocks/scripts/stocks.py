#!/usr/bin/env python3
"""
中国股票数据 - 基于 AkShare
"""

import json
import sys
import warnings
warnings.filterwarnings('ignore')

def get_quote(code):
    """获取实时行情"""
    try:
        import akshare as ak
        from datetime import datetime, timedelta
        
        # 使用 spot_em 获取全部实时行情，然后筛选
        df = ak.stock_zh_a_spot_em()
        
        # 筛选指定股票
        stock = df[df['代码'] == code]
        
        if len(stock) > 0:
            row = stock.iloc[0]
            return json.dumps({
                "code": str(row.get('代码', '')),
                "name": str(row.get('名称', '')),
                "price": float(row.get('最新价', 0)) if row.get('最新价') else 0,
                "change": float(row.get('涨跌额', 0)) if row.get('涨跌额') else 0,
                "pct": float(row.get('涨跌幅', 0)) if row.get('涨跌幅') else 0,
                "vol": float(row.get('成交量', 0)) if row.get('成交量') else 0,
                "amount": float(row.get('成交额', 0)) if row.get('成交额') else 0,
                "open": float(row.get('今开', 0)) if row.get('今开') else 0,
                "high": float(row.get('最高', 0)) if row.get('最高') else 0,
                "low": float(row.get('最低', 0)) if row.get('最低') else 0,
                "preclose": float(row.get('昨收', 0)) if row.get('昨收') else 0,
                "turnover": float(row.get('换手率', 0)) if row.get('换手率') else 0
            }, ensure_ascii=False, indent=2)
        return json.dumps({"error": f"Stock {code} not found"})
    except Exception as e:
        return json.dumps({"error": str(e)})

def get_kline(code, days=30):
    """获取K线数据"""
    try:
        import akshare as ak
        from datetime import datetime, timedelta
        
        end = datetime.now().strftime("%Y%m%d")
        start = (datetime.now() - timedelta(days=days+30)).strftime("%Y%m%d")
        
        df = ak.stock_zh_a_hist(symbol=code, period="daily", 
                                start_date=start, end_date=end, adjust="qfq")
        
        if df is not None and len(df) > 0:
            result = []
            for _, row in df.tail(10).iterrows():
                result.append({
                    "date": str(row.get('日期', '')),
                    "open": float(row.get('开盘', 0)),
                    "close": float(row.get('收盘', 0)),
                    "high": float(row.get('最高', 0)),
                    "low": float(row.get('最低', 0)),
                    "vol": float(row.get('成交量', 0)),
                    "amount": float(row.get('成交额', 0))
                })
            return json.dumps(result, ensure_ascii=False, indent=2)
        return json.dumps({"error": "No data"})
    except Exception as e:
        return json.dumps({"error": str(e)})

def search_stock(keyword):
    """搜索股票"""
    try:
        import akshare as ak
        
        df = ak.stock_zh_a_spot_em()
        result = df[df['名称'].str.contains(keyword, na=False) | 
                   df['代码'].str.contains(keyword, na=False)]
        
        return result.head(10)[['代码', '名称', '最新价', '涨跌幅']].to_json(orient='records', force_ascii=False)
    except Exception as e:
        return json.dumps({"error": str(e)})

def main():
    if len(sys.argv) < 2:
        print("Usage: stocks.py <command> [args]")
        print("Commands: search <keyword>, info <code>, quote <code>")
        sys.exit(1)
    
    cmd = sys.argv[1]
    
    if cmd == "search":
        print(search_stock(sys.argv[2] if len(sys.argv) > 2 else ""))
    elif cmd == "info":
        print(get_kline(sys.argv[2] if len(sys.argv) > 2 else "", 30))
    elif cmd == "quote":
        print(get_quote(sys.argv[2] if len(sys.argv) > 2 else ""))
    else:
        print(json.dumps({"error": f"Unknown command: {cmd}"}))

if __name__ == "__main__":
    main()
