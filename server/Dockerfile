# 使用官方的Python映像
FROM python:3.10

# 設定工作目錄
WORKDIR /app

# 複製 requirements.txt 並安裝相依套件
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# 複製整個應用程式到容器
COPY . .

# 開放應用程式所需的端口
EXPOSE 5000

# 定義啟動應用程式的命令
CMD ["python", "main.py"]