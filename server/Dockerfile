# 阶段1：构建阶段
FROM python:3.10 AS builder

WORKDIR /app

COPY requirements.txt /app/requirements.txt

RUN pip install --upgrade pip

RUN pip install -r requirements.txt


# 阶段2：运行阶段
FROM python:3.10

WORKDIR /app


# 複製整個應用程式到容器
COPY --from=builder . /app

#VOLUME /app/flask


# 開放應用程式所需的端口
EXPOSE 8888


# 定義啟動應用程式的命令
CMD ["python", "main.py"]
