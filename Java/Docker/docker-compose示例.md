1. 创建项目文件夹
   ```sh
    mkdir composetest
    cd composetest
   ```

2. 创建`app.py`
   ```python
   import time
   
   import redis
   from flask import Flask
   
   app = Flask(__name__)
   cache = redis.Redis(host='redis', port=6379)
   
   def get_hit_count():
       retries = 5
       while True:
           try:
               return cache.incr('hits')
           except redis.exceptions.ConnectionError as exc:
               if retries == 0:
                   raise exc
               retries -= 1
               time.sleep(0.5)
   
   @app.route('/')
   def hello():
       count = get_hit_count()
       return 'Hello World! I have been seen {} times.\n'.format(count)
   ```

   在本例之中，redis是程序网络上redis容器的主机名，我们使用Reids的默认端口6379

3. 创建`requirements.txt`文件，python项目的依赖
   ```txt
   flask
   redis
   ```

4.  创建Dockerfile
   ```dockerfile
   # syntax=docker/dockerfile:1
   FROM python:3.7-alpine
   WORKDIR /code
   ENV FLASK_APP=app.py
   ENV FLASK_RUN_HOST=0.0.0.0
   RUN apk add --no-cache gcc musl-dev linux-headers
   COPY requirements.txt requirements.txt
   RUN pip install -r requirements.txt
   EXPOSE 5000
   COPY . .
   CMD ["flask", "run"]
   ```

5. 定义`docker-compose.yml`文件
   ```yaml
   version: "3.9"
   services:
     web:
       build: .
       ports:
         - "5000:5000"
     redis:
       image: "redis:6.0"
   ```
   在上面，我们定义了两个service，第二个是redis，使用的镜像是redis:6.0

6. 使用compose运行app或者服务

   ```dockerfile
   docker-compose up
   ```
7. 访问即可

