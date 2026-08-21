## 프로젝트 개요
Docker의 핵심 개념과 실무 워크플로우를 습득하고, 재현 가능한 컨테이너 환경 구축을 경험하는 것을 목표로 한다. 
<br><br>

## 실행 환경(OS/쉘/터미널, Docker 버전, Git 버전)
| 이름 | 버전 | 명령어 |
|---|---|---|
| os | macOS 15.7.7 | sw_vers |
| 터미널 | zsh 5.9(x86_64-apple-darwin24.0) | zsh --version |
| git | git version 2.53.0 | git --version |
| orbstack | Version: 2.0.5 (2000500) | orbctl version |
| docker | Docker version 28.5.2, build ecc6942 | docker --version |

<br>

<details>
<summary>  캡처 이미지 </summary>

- ### OS
```
sw_vers
```
<img width="412" height="62" alt="os버전" src="https://github.com/user-attachments/assets/3fbd6fe5-f8e6-4724-aaba-c440da0946e8" />  
<br><br>

- ### 쉘
```
 zsh --version
```
<img width="359" height="22" alt="zsh" src="https://github.com/user-attachments/assets/a1396672-c422-4ccb-92ec-a771d6557ab8" />
<br><br>

- ### git 버전
```
# git --version
git version 2.53.0
```

- ### orbstack
```
# orbctl version
Version: 2.0.5 (2000500)
Commit: - (v2.0.5)
```
docker 버전
```
# docker --version
Docker version 28.5.2, build ecc6942
```


### 도커 실행 순서 
- 도커파일 작성: 이미지 어떻게 만들지 정의
- 이미지 빌드: 도커파일 바탕으로 이미지 생성
  ```
  docker build -t my-app .
  ```
  
- 컨테이너 실행: 이미지를 실행해 컨테이너 실행
  ```
  docker run -p 8080:80 -v /home/user/logs:/var/log/nginx my-app  
  ```
  
- 관리: 컨테이너 상태 확인 및 제어
  ```
  # 실행 중인 컨테이너 확인
  docker ps
  
  # 컨테이너 중지
  docker stop <container-id>
  
  # 컨테이너 삭제
  docker rm <container-id>
  ```

</details>

- #### docker info

```
Client:
 Version:    28.5.2
 Context:    orbstack
 Debug Mode: false
 Plugins:
  buildx: Docker Buildx (Docker Inc.)
    Version:  v0.29.1
    Path:     /Users/-
  compose: Docker Compose (Docker Inc.)
    Version:  v2.40.3
    Path:     /Users/-

Server:
 Containers: 0
  Running: 0
  Paused: 0
  Stopped: 0
 Images: 0
 Server Version: 28.5.2
 Storage Driver: overlay2
  Backing Filesystem: btrfs
  Supports d_type: true
  Using metacopy: false
  Native Overlay Diff: true
  userxattr: false
 Logging Driver: json-file
 Cgroup Driver: cgroupfs
 Cgroup Version: 2
 Plugins:
  Volume: local
  Network: bridge host ipvlan macvlan null overlay
  Log: awslogs fluentd gcplogs gelf journald json-file local splunk syslog
 CDI spec directories:
  /etc/cdi
  /var/run/cdi
 Swarm: inactive
 Runtimes: io.containerd.runc.v2 runc
 Default Runtime: runc
 Init Binary: docker-init
 containerd version: # 빈값이지만 버전 정보
 runc version: # 빈값이지만 버전 정보
 init version: # 빈값이지만 버전 정보
 Security Options:
  seccomp
   Profile: builtin
  cgroupns
 Kernel Version: # 빈값이지만 커널 정보
 Operating System: OrbStack
 OSType: linux
 Architecture: x86_64
 CPUs: 6
 Total Memory: 15.67GiB
 Name: orbstack 호스트명(개인정보)
 ID: #-#-#-#-# 도커 데몬 고유 아이디
 Docker Root Dir: /var/lib/docker
 Debug Mode: false
 Experimental: false
 Insecure Registries:
  ::0/000 네트워크 설정 노출
  000.0.0.0/0
 Live Restore Enabled: false
 Product License: Community Engine
 Default Address Pools: # IP 풀 설정
   Base: 000.000.00.0/00, Size: 00
   ~ 
   Base: ____:____:____:____::/__, Size: 00

```

- hello-world 이미지로 테스트 
```
docker run --rm hello-world
```
<img width="843" height="417" alt="hello-world" src="https://github.com/user-attachments/assets/e9cb84a6-3aea-44b6-a062-59ffd3803056" />
<br><br>

## 터미널 기본 조작 및 폴더 구성

- ### 작업 디렉토리 생성
```
# 디렉토리 만들기, 나의 위치 이동
mkdir -p ~/onboarding-mission
cd ~/onboarding-mission

# 프로젝트 구조 미리 만들기
mkdir -p app logs volumes
touch Dockerfile README.md
```

- ### 폴더 이동, 삭제
<img width="310" height="22" alt="스크린샷 2026-08-21 오후 5 54 05" src="https://github.com/user-attachments/assets/a56f9e95-a4b6-4949-8775-1a1a34fb7c1b" />
<br>
<img width="395" height="38" alt="스크린샷 2026-08-21 오후 5 57 31" src="https://github.com/user-attachments/assets/db18ca8e-d50e-4dc2-bf3a-0229cfe5c3d5" />
<br>
<img width="306" height="19" alt="스크린샷 2026-08-21 오후 5 58 30" src="https://github.com/user-attachments/assets/f89311f4-c184-478c-90ec-4c9952221921" />
<br>
<img width="323" height="19" alt="스크린샷 2026-08-21 오후 5 59 34" src="https://github.com/user-attachments/assets/3f1ac653-bba3-46d0-87ee-e744db1a6c6a" />


```
# 파일(폴더) 이동
mv 파일명.형식 이동할 폴더/

# 파일명 변경
mv 파일명.형식 변경할 이름.형식

# 파일 삭제
rm [파일명.형식]

# 폴더 삭제  
rm -r 폴더 이름/
```

* ### 프로젝트 구조
```
onboarding-mission/
├── README.md           (메인 문서)
├── Dockerfile          (이미지 정의)
├── app/
│   └── index.html      (웹 서버 코드)
├── logs/               (실행 로그)
│   └── docker-version.log
└── volumes/
└── ubuntu-custom/      (커스텀 이미지 실습)
    └── Dockerfile

```

- ### 터미널 출력을 파일로 저장
```
docker --version > ~/onboarding-mission/logs/docker-version.log
docker info >> ~/onboarding-mission/logs/docker-info.log
```

- ### 저장 확인
```
cat ~/onboarding-mission/logs/docker-version.log
```

- ### 권한 확인 및 설정 
```
# 현재 디렉토리 권한 확인
ls -la ~/onboarding-mission
```
<img width="779" height="221" alt="권한 확인" src="https://github.com/user-attachments/assets/2823c08f-ef9c-4f78-839b-235b781c0185" />

<br><br>
```
# 권한 설정하기(보통 755) : 644에서 600로 변경
chmod 600 Dockerfile
```
<img width="779" height="222" alt="스크린샷 2026-08-14 오후 6 40 27" src="https://github.com/user-attachments/assets/7df358d3-e890-4096-8447-459b5a51f9b0" />

<br><br>

- ### 웹 서버 코드 작성
```
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Docker Mission</title>
    <style>
        body { font-family: Arial; text-align: center; margin-top: 50px; }
        h1 { color: #0066cc; }
    </style>
</head>
<body>
    <h1>🐳 Docker Mission 성공!</h1>
    <p>이 페이지는 Docker 컨테이너에서 실행 중입니다.</p>
    <p>현재 시간: <span id="time"></span></p>
    <script>
        document.getElementById('time').textContent = new Date().toLocaleString();
    </script>
</body>
</html>
```


## 도커 파일 빌드/실행
1. Dockerfile 작성

파일 위치: onboarding-mission/Dockerfile

```
# 기반이 되는 이미지 선택
FROM nginx:latest

# 내 컴퓨터의 파일을 컨테이너 안으로 복사(컨테이너의 웹 루트로 복사)
COPY app/ /usr/share/nginx/html/

# 포트 80을 노출 (문서화 목적)
EXPOSE 80

# nginx 실행(컨테이너 실행)
CMD ["nginx", "-g", "daemon off;"]
```

2. 도커 이미지 빌드
```
cd ~/onboarding-mission

# 이미지 빌드 (태그: onboarding-mission:v1)
docker build -t onboarding-mission:v1 .
```
<img width="837" height="663" alt="이미지 빌드" src="https://github.com/user-attachments/assets/6723b561-a6d6-4642-9b0b-1272f5fc8f2f" />


```
# 이미지 목록 확인
docker images
```
<img width="652" height="92" alt="스크린샷 2026-08-16 오후 6 14 58" src="https://github.com/user-attachments/assets/9137ebf3-f969-4395-bedf-7e0566bdaaaf" />

<br><br>

```
# 빌드 결과 확인
docker images | grep onboarding-mission
```
<img width="837" height="42" alt="빌드결과 확인" src="https://github.com/user-attachments/assets/5773de4b-1eb0-476f-8b9c-5cdf074b4a8b" />
<br><br>

3. 컨테이너 실행(포트 매핑)
```
# 컨테이너 실행
# -d: 백그라운드 실행
# -p 8080:80: 호스트의 8080 포트 → 컨테이너의 80 포트
# --name: 컨테이너 이름
docker run -d -p 8080:80 --name my-web docker-mission:v1
docker run [옵션(--name, -p, -d)] [이미지 이름(항상 마지막)]

# 실행 확인
docker ps
```
<img width="1510" height="61" alt="포트 매핑" src="https://github.com/user-attachments/assets/bec5857e-dd2f-47e2-a676-fd3324773deb" />

<br>

- ### 컨테이너 중단 후 포트 변경
  ```
  # 1. 기존 컨테이너 중지 & 삭제
  docker stop my-web
  docker rm my-web
  
  # 2. 새 포트로 다시 실행
  docker run -d -p 8081:80 --name my-web my-web
  ```

<br><br>


4. 접속 확인
```
# 터미널에서 curl로 확인
curl http://localhost:8080
```
<img width="974" height="363" alt="curl 접속확인" src="https://github.com/user-attachments/assets/80a0fb43-68ad-427a-8f78-d74ac55d007f" />
<br><br>

```
# 브라우저에서 직접 접속
# http://localhost:8080
```
<img width="615" height="363" alt="스크린샷 2026-08-16 오후 4 43 55" src="https://github.com/user-attachments/assets/19b355d3-ebaa-4bbd-9c21-5446d63ca43e" />

5. 우분투 컨테이너 실행
```
# 우분투 컨테이너 진입
docker run -it ubuntu:latest /bin/bash
```
<img width="454" height="172" alt="스크린샷 2026-08-17 오후 3 38 28" src="https://github.com/user-attachments/assets/c9679830-cfb9-43f2-9532-1c4056f0052c" />
<br><br>

```
# 파일 이름만 나열
ls

# 문자열 출력
echo

# OS 정보
cat /etc/os-release

# 종료하기
exit
```
<img width="513" height="61" alt="스크린샷 2026-08-17 오후 3 42 16" src="https://github.com/user-attachments/assets/4801ef4d-9208-4002-96d0-219d2a4dd013" />

<img width="763" height="280" alt="스크린샷 2026-08-17 오후 3 56 18" src="https://github.com/user-attachments/assets/bea13b47-1a13-43e4-9de3-9a59734d5826" />

## 컨테이너 종료와 유지의 차이
attach와 exec는 이미 실행 중인 컨테이너에 접근하는 방법

* attach 방식
```
# nginx 웹 서버를 백그라운드에서 실행
docker run -d -p 8080:80 --name 컨테이너 이름 nginx

# 컨테이너 실행 확인
docker ps

# attach로 접근
docker attach 컨테이너 이름

# 브라우저나 터미널로 접속 후 터미널을 보면 메인 프로세스의 실시간 로그가 보임

# 컨테이너 종료 후 확인
docker ps -a | grep my-nginx
```

* exec 방식
```
# 새 컨테이너 실행
docker run -d -p 8080:80 --name my-exec nginx

# exec로 bash 접근
docker exec -it my-exec bash

# 현재 디렉토리 확인
pwd

# ngnix 설정파일 확인
cat /etc/nginx/nginx.conf | head -20
# 결과 예시
user nginx;
worker_processes auto;
error_log /var/log/nginx/error.log warn;
pid /var/run/nginx.pid;

events {
    worker_connections 1024;
}
...

# 웹 루트 디렉토리 확인
ls -la /usr/share/nginx/html/
# 결과 예시
total 8
drwxr-xr-x 2 root root  25 Aug 16 12:00 .
drwxr-xr-x 3 root root  17 Aug 16 12:00 ..
-rw-r--r-- 1 root root 612 Aug 16 12:00 index.html

# 환경변수 확인
echo $PATH

# 프로세스 확인
ps aux
# 실행이 안될 경우 패키지 추가 설치 하기
apt update
apt install -y procps

# 테스트를 위한 새로운 파일 생성
touch /tmp/test_file.txt
ls -la /tmp/test_file.txt

# 종료
exit

# exec는 종료해도 컨테이너(ngnix)는 계속 실행돼고 있다 
```

🎓 학습 요점

| 배운 내용 | 설명 |
|----------|------|
| **Attach의 목적** | 메인 프로세스의 실시간 로그 확인 |
| **Attach의 위험** | Ctrl+C로 프로세스 종료됨 |
| **Exec의 목적** | 컨테이너 내부에서 자유로운 명령 실행 |
| **Exec의 안전성** | 종료해도 원래 프로세스는 계속 실행 |
| **권장 방식** | 항상 exec 사용, attach는 주의 깊게 |


## Dockerfile 기반 커스텀 이미지 제작
* (B) Linux 베이스 이미지(예: ubuntu/alpine 등) + 기본 기능(패키지/사용자/환경변수/헬스체크 등) 추가

* 경로
```
Desktop/onboarding-mission/ubuntu-custom
```

* 빌드, 실행 명령
  - 빌드, 빌드 성공
  ```
  # 빌드
  docker build -t ubuntu-custom:v1 .

  # 빌드 성공 확인
  docker images | grep ubuntu-custom
  ```
  <img width="942" height="455" alt="스크린샷 2026-08-17 오후 5 53 18" src="https://github.com/user-attachments/assets/caf450fd-3fff-43d0-b64a-ccd8983de4ec" />
  
  - 컨테이너 실행
    1. 직접 제어
    <img width="1019" height="342" alt="스크린샷 2026-08-17 오후 6 01 59" src="https://github.com/user-attachments/assets/427e4fbc-c179-41b1-a929-54dd2a034fb4" />
    

    2. 백그라운드 실행
    ```
    # 백그라운드에서 컨테이너 실행(3600초 동안 유지)
    docker run -d --name ubuntu-server ubuntu-custom:v1 sleep 3600
    ```

    - exit 후에도 컨테이너 작동 중
    <img width="1501" height="75" alt="스크린샷 2026-08-17 오후 7 28 57" src="https://github.com/user-attachments/assets/b26d17fb-d7b8-4869-83fd-8997a26dca71" />


## 바인드 마운트 반영
```
# 기존 컨테이너 중지 및 삭제
docker stop my-web
docker rm my-web

# 바인드 마운트로 다시 실행
# -v ~/onboarding-mission/app:/usr/share/nginx/html: 호스트 폴더 ↔ 컨테이너 폴더 연결
docker run -d -p 8080:80 \
  -v ~/onboarding-mission/app:/usr/share/nginx/html \
  --name my-web-bind onboarding-mission:v1

# 실행 확인
docker ps
```
* 호스트에서 파일 수정
```
# app/index.html
cat > ~/onboarding-mission/app/index.html << 'EOF'

<!DOCTYPE html>
<html>
<head>
    <title>Docker Mission - 수정됨!</title>
    <style>
        body { font-family: Arial; text-align: center; margin-top: 50px; background-color: #f0f0f0; }
        h1 { color: #ff6600; }
    </style>
</head>
<body>
    <h1>🎉 파일이 수정되었습니다!</h1>
    <p>바인드 마운트가 정상 작동합니다.</p>
    <p>호스트에서 수정한 파일이 컨테이너에 즉시 반영됩니다.</p>
</body>
</html>
EOF
```
  * 포트볼륨 생성, 연결
<img width="1330" height="810" alt="포트볼륨 생성_연결" src="https://github.com/user-attachments/assets/de355f47-6aad-4d44-844d-cf6cb68ebca4" />
 
 * 포트볼륨 수정 후
<img width="948" height="629" alt="포트볼륨 수정 후 성공" src="https://github.com/user-attachments/assets/c8c9b290-cf6a-4b87-9f63-a8cd0d0df712" />

 * 포트 충돌 진단 및 대응
   ```
   # 기존 컨테이너 확인
   docker ps
   
   # 현재 열려있는 모든 파일과 네트워크 포트 조회
   sudo lsof -i :[포트 번호]

   # 리눅스 ㅊㅊ
   netstat -nlp | grep :[포트 번호]
   ss -nlp | grep :[포트 번호]

   # 윈도우 ㅊㅊ
   netstat -ano | findstr :[포트 번호]
   ```

   ```  
   # 호스트 포트 변경
   docker run -d -p [포트번호] --name [새 컨테이너] [이미지]
   ```

   
  
## 볼륨 영속성

* 컨테이너 삭제 후에도 데이터가 유지되는지 확인
  
1. 볼륨 생성
```
docker volume create my-data
```
<img width="670" height="206" alt="볼륨 생성" src="https://github.com/user-attachments/assets/08e10ba4-f85d-4248-b3b7-40e449dcc6ae" />
<br><br>

2. 볼륨을 마운트하여 컨테이너 실행
```
docker run -d -p 8081:80 \
  -v my-data:/data \
  --name my-web-volume onboarding-mission:v1
```

3. 컨테이너 내부에 파일 생성
```
docker exec my-web-volume sh -c 'echo "중요한 데이터입니다" > /data/important.txt'
```
<img width="741" height="323" alt="스크린샷 2026-08-16 오후 6 02 58" src="https://github.com/user-attachments/assets/f95ccb08-55f2-4c93-9c7e-8e9c151ce98d" />
<br><br>

4. 파일 확인
```
docker exec my-web-volume cat /data/important.txt
```
<img width="832" height="39" alt="스크린샷 2026-08-16 오후 6 03 39" src="https://github.com/user-attachments/assets/4790b850-8bc1-4940-a96e-2bcacf3b8bb1" />

<br><br>

5. 컨테이너 삭제
```
docker stop my-web-volume
docker rm my-web-volume

# 하지만 볼륨 여전히 존재
docker volume ls | grep my-data
```
<br>

6. 볼륨 내용 확인
```
docker run --rm -v my-data:/data alpine cat /data/important.txt
```
<img width="955" height="39" alt="스크린샷 2026-08-16 오후 6 06 17" src="https://github.com/user-attachments/assets/3523c0ee-4b58-49da-961b-719f66ff4532" />

<br><br>

## 수행 항목 체크리스트
- [x] 터미널 기본 조작 및 폴더 구성
- [x] 권한 변경 실습
- [x] Docker 설치/점검
- [x] hello-world 실행
- [x] Dockerfile 빌드/실행
- [x] 포트 매핑 접속(2회)
- [x] 바인드 마운트 반영
- [x] 볼륨 영속성
- [x] Git 설정 + VSCode GitHub 연동


## 트러블슈팅 (문제 → 원인 가설 → 확인 → 해결/대안)
* 포트 볼륨 수정 후 문자 깨짐 현상
<img width="1330" height="810" alt="포트볼륨 수정 후" src="https://github.com/user-attachments/assets/f263b99c-51af-49ab-acbb-f1597cc44bb8" />

1. 현상
  - Docker 컨테이너로 실행 중인 Nginx 웹 서버에서 HTML 페이지를 호출할 때, 한글이 정상적으로 출력되지 않고 깨짐 현상이 발생함.
  - HTML 소스 코드 내에 <meta charset="UTF-8">이 명시되어 있음에도 불구하고 브라우저에서 인코딩 오류가 지속됨.

2. 원인 분석
  - HTTP 응답 헤더의 우선순위 문제
    * 브라우저가 웹 페이지의 인코딩을 결정할 때, HTML 문서 내부의 <meta> 태그보다 웹 서버가 보내는 HTTP 응답 헤더(Response Header)의 정보를 우선적으로 신뢰합니다.
    * 현재 상태
      Nginx의 기본 설정에는 Content-Type 헤더에 charset 정보가 누락되어 있거나, 기본값(예: ISO-8859-1)으로 설정되어 있음.
    * 결과
      브라우저는 서버가 보낸 헤더 정보를 따라 페이지를 해석하려 시도하며, 이 과정에서 UTF-8로 작성된 한글 데이터를 잘못된 방식으로 렌더링하여 깨짐 현상이 발생함.
   
  - 인코딩 결정 흐름
    * 브라우저가 서버에 페이지 요청.
    * 서버(Nginx)가 응답을 보낼 때 헤더에 Content-Type: text/html만 전달 (charset 미지정).
    * 브라우저는 서버의 지시가 없으므로 기본 인코딩으로 해석 시작.
    * HTML 내부의 <meta charset="UTF-8">을 발견하기 전에 이미 헤더 정보를 바탕으로 렌더링을 시작하여 한글이 깨짐.

3. 해결
  - Nginx 설정 파일에서 HTTP 응답 헤더에 UTF-8 인코딩을 명시하도록 수정
  - Nginx 설정 파일(보통 /etc/nginx/conf.d/default.conf)의 server 블록 또는 location 블록에 charset utf-8; 지시어를 추가합니다.
  - 마지막으로 강한 새로고침 실행 커맨드+시프트+R

<br>

* 포트볼륨 수정 후 403 forbidden
<img width="615" height="363" alt="스크린샷 2026-08-16 오후 5 05 04" src="https://github.com/user-attachments/assets/eb9b2889-11b2-42db-b2d1-8c0cb0a226d5" />

1. 원인: 폴더 경로가 잘못됨
2. 해결: cd 명령어로 경로 수정 후 새로고침하니 정상화면 출력
  

