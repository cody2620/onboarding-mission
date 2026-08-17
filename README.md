## 프로젝트 개요
Docker의 핵심 개념과 실무 워크플로우를 습득하고, 재현 가능한 컨테이너 환경 구축을 경험하는 것을 목표로 한다. 
<br><br>

## 실행 환경(OS/쉘/터미널, Docker 버전, Git 버전)
- OS
```
sw_vers
```
<img width="412" height="62" alt="os버전" src="https://github.com/user-attachments/assets/3fbd6fe5-f8e6-4724-aaba-c440da0946e8" />  
<br><br>

- 쉘
```
 zsh --version
```
<img width="359" height="22" alt="zsh" src="https://github.com/user-attachments/assets/a1396672-c422-4ccb-92ec-a771d6557ab8" />
<br><br>

- git --version
```
git version 2.53.0
```

- orbctl version
```
Version: 2.0.5 (2000500)
Commit: - (v2.0.5)
```

- docker --version
```
Docker version 28.5.2, build ecc6942
```

- docker info
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

- 작업 디렉토리 생성
```
# 디렉토리 만들기, 나의 위치 이동
mkdir -p ~/onboarding-mission
cd ~/onboarding-mission

# 프로젝트 구조 미리 만들기
mkdir -p app logs volumes
touch Dockerfile README.md
```

* 프로젝트 구조
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

- 터미널 출력을 파일로 저장
```
docker --version > ~/onboarding-mission/logs/docker-version.log
docker info >> ~/onboarding-mission/logs/docker-info.log
```

- 저장 확인
```
cat ~/onboarding-mission/logs/docker-version.log
```

- 권한 확인 및 설정 
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

- 웹 서버 코드 작성
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

# 실행 확인
docker ps
```
<img width="1510" height="61" alt="포트 매핑" src="https://github.com/user-attachments/assets/bec5857e-dd2f-47e2-a676-fd3324773deb" />
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

* 🎓 학습 요점

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

    
* 내가 적용한 커스텀 포인트 각각의 목적
  

* 핵심결과


## 바운드 마운트 반영
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

## 수행 항목 체크리스트(터미널/권한/Docker/Dockerfile/포트/볼륨/Git/GitHub)
- [x] 터미널 기본 조작 및 폴더 구성
- [x] 권한 변경 실습
- [x] Docker 설치/점검
- [x] hello-world 실행
- [x] Dockerfile 빌드/실행
- [x] 포트 매핑 접속(2회)
- [x] 바인드 마운트 반영
- [x] 볼륨 영속성
- [x] Git 설정 + VSCode GitHub 연동


# 검증 방법(어떤 명령으로 무엇을 확인했는지) + 결과 위치 링크

# 트러블슈팅 2건 이상(문제 → 원인 가설 → 확인 → 해결/대안)
* 포트 볼륨 수정 후 문자 깨짐 현상
<img width="1330" height="810" alt="포트볼륨 수정 후" src="https://github.com/user-attachments/assets/f263b99c-51af-49ab-acbb-f1597cc44bb8" />

  - Docker 컨테이너로 실행 중인 Nginx 웹 서버에서 HTML 페이지를 호출할 때, 한글이 정상적으로 출력되지 않고 깨짐 현상이 발생함.\n
HTML 소스 코드 내에 <meta charset="UTF-8">이 명시되어 있음에도 불구하고 브라우저에서 인코딩 오류가 지속됨.

  - 원인분석
   2.1 HTTP 응답 헤더의 우선순위 문제
브라우저가 웹 페이지의 인코딩을 결정할 때, HTML 문서 내부의 <meta> 태그보다 웹 서버가 보내는 HTTP 응답 헤더(Response Header)의 정보를 우선적으로 신뢰합니다.

현재 상태: Nginx의 기본 설정에는 Content-Type 헤더에 charset 정보가 누락되어 있거나, 기본값(예: ISO-8859-1)으로 설정되어 있음.
결과: 브라우저는 서버가 보낸 헤더 정보를 따라 페이지를 해석하려 시도하며, 이 과정에서 UTF-8로 작성된 한글 데이터를 잘못된 방식으로 렌더링하여 깨짐 현상이 발생함.

2.2 인코딩 결정 흐름
브라우저가 서버에 페이지 요청.
서버(Nginx)가 응답을 보낼 때 헤더에 Content-Type: text/html만 전달 (charset 미지정).
브라우저는 서버의 지시가 없으므로 기본 인코딩으로 해석 시작.
HTML 내부의 <meta charset="UTF-8">을 발견하기 전에 이미 헤더 정보를 바탕으로 렌더링을 시작하여 한글이 깨짐.

  - 해결
   Nginx 설정 파일에서 HTTP 응답 헤더에 UTF-8 인코딩을 명시하도록 수정합니다.

   Nginx 설정 파일(보통 /etc/nginx/conf.d/default.conf)의 server 블록 또는 location 블록에 charset utf-8; 지시어를 추가합니다.

   강한 새로고침 실행 커맨드+시프트+R


* 포트볼륨 수정 후 403 forbidden
<img width="615" height="363" alt="스크린샷 2026-08-16 오후 5 05 04" src="https://github.com/user-attachments/assets/eb9b2889-11b2-42db-b2d1-8c0cb0a226d5" />

- 원인: 폴더 경로가 잘못됨
  

** ** 

## 미션 목표
1. 터미널로 작업 디렉토리와 권한을 정리한 뒤, Docker를 설치 및 점검하고 컨테이너를 실행/관리.
2. 간단한 웹 서버를 Dokerfile로 컨테이너화 하고, 포트 매핑으로 접속을 확인하며, 바인드 마운트/볼륨으로 "변경 반영"과 "데이터 영속성"을 직접 검증.

단순히 따라 치는 실습이 아니라, 실행 결과(로그/접속/데이터 유지)로 핵심 흐름을 확인합니다. 
또한, 이미지와 컨테이너의 분리, 격리된 실행 환경, 포트·스토리지 연결 방식이라는 구조적 원칙을 적용해 
"왜 이런 설계가 필요한지"를 설명 가능한 형태로 정리합니다.

같은 서비스를 여러 번 실행해도 재현되는 환경을 만드는 사고방식을 경험하는 것이 목표.

## 최종 결과물
1. 제출 저장소(GitHub Repository)
- 공개(또는 과제 제출 규칙에 맞는 권한)로 생성한다.
- 저장소 링크만으로 아래 산출물 전부를 확인할 수 있어야 한다.

2. 기술 문서(README.md 등)
- 프로젝트 개요(미션 목표 요약)
- 실행 환경(OS/쉘/터미널, Docker 버전, Git 버전)
- 수행 항목 체크리스트(터미널/권한/Docker/Dockerfile/포트/볼륨/Git/GitHub)
- 검증 방법(어떤 명령으로 무엇을 확인했는지) + 결과 위치 링크
- 트러블슈팅 2건 이상(문제 → 원인 가설 → 확인 → 해결/대안)
- 기술 문서만 읽어도 전체 수행 내용을 파악할 수 있어야 한다.

3. 터미널 조작 로그
- 터미널에서 수행한 핵심 명령과 출력 결과를 기술 문서에 기록한다.

4. Docker 운영/검증 로그
- docker --version, docker info 등 설치·점검 결과
- docker images, docker ps -a, docker logs, docker stats 등 운영 명령 실행 흔적

5. Dockerfile 기반 웹 서버 컨테이너
- 웹 서버 소스코드(예: app/ 또는 src/)
- Dockerfile
- 빌드/실행 명령 및 결과 로그(터미널 스크린샷 가능)
- 포트 매핑 접속 성공 증거(스크린샷 또는 로그)

6. 포트 매핑 접속 증거
- p <host_port>:<container_port>로 실행 후, 브라우저 접속 화면(주소창 포함)을 기술 문서에 첨부한다.

8. 바인드 마운트 반영 + 볼륨 영속성 증거
- 바인드 마운트: 실행 명령 + 호스트 변경 전/후 비교
- Docker 볼륨: 생성/연결/검증 명령 + 컨테이너 삭제 전/후 비교

8. Git 설정 및 GitHub/VSCode 연동 증거
- Git 사용자 정보·기본 브랜치 설정 후, VSCode에서 GitHub 로그인 및 저장소 연동 완료
- 민감한 개인 정보(ID/PW, 토큰 등)가 포함되지 않도록 주의한다.

## 기능 요구사항
1. 제출 저장소 및 기술 문서
- GitHub Repository 링크로 제출한다.
- 기술 문서(README.md 등)는 아래 내용을 반드시 포함한다.
  * 모든 수행 결과는 “기술 문서(README.md 등)”에서 확인 가능해야 한다.
  * 프로젝트 개요(미션 목표 요약)
  * 실행 환경(OS/쉘/터미널, Docker 버전, Git 버전)
  * 수행 항목 체크리스트(터미널/권한/Docker/Dockerfile/포트/마운트/볼륨/Git/GitHub)
  * 검증 방법(어떤 명령으로 무엇을 확인했는지) + 결과 위치/증거 링크

- 기술 문서 내 명령/출력은 코드블록으로 정리한다.

2. 터미널 조작 로그 기록
- 다음 작업을 터미널로 수행하고, 명령어 + 출력 결과를 기술 문서에 기록한다.
  * 현재 위치 확인, 목록 확인(숨김 파일 포함), 이동, 생성, 복사, 이동/이름변경, 삭제
  * 파일 내용 확인, 빈 파일 생성

3. 권한 실습 및 증거 기록
- 권한을 확인/변경하는 명령을 수행하고, 변경 전/후 비교를 기술 문서에 남긴다.
- 최소 요구: 파일 1개, 디렉토리 1개에 대해 권한 변경 실험을 수행한다.

4. Docker 설치 및 기본 점검
- Docker 버전 확인 결과를 기록한다. (docker --version)
- Docker 데몬 동작 여부 확인 결과를 기록한다. (docker info 또는 동등 점검)

5. Docker 기본 운영 명령 수행
- 이미지: 다운로드/목록 확인 (예: docker images)
- 컨테이너: 실행/중지/목록 확인 (예: docker ps, docker ps -a)
- 운영: 로그 확인 (예: docker logs), 리소스 확인 (예: docker stats)
- 수행 명령과 출력 결과를 기술 문서에 남긴다.

6. 컨테이너 실행 실습
- hello-world 실행 성공을 기록한다.
- ubuntu 컨테이너를 실행하고 내부 진입 후 간단 명령(예: ls, echo) 수행 결과를 기록한다.
- 컨테이너 종료/유지(attach/exec 등)의 차이를 스스로 관찰하고 간단히 정리한다. 

7. 기존 Dockerfile 기반 커스텀 이미지 제작
- 아래 방식 중 하나를 선택하여 기존 Dockerfile/이미지 기반의 커스텀 이미지를 만든다.
  * (A) 웹 서버 베이스 이미지 활용(예: NGINX/Apache 등) + 정적 콘텐츠/설정만 교체
  * (B) Linux 베이스 이미지(예: ubuntu/alpine 등) + 기본 기능(패키지/사용자/환경변수/헬스체크 등) 추가

- 제작 결과는 아래 조건을 만족해야 한다.
  * 커스텀 이미지 빌드 성공 및 컨테이너 실행 성공
  * 기술 문서에 다음을 포함한다.
  1) 어떤 “기존 베이스(이미지/예시 Dockerfile)”를 선택했는지
  2) 내가 적용한 커스텀 포인트 각각의 목적(간단 요약)
  3) 빌드/실행 명령 + 핵심 결과(출력/스크린샷)

8. 포트 매핑 및 접속 증거
- 브라우저 접속 화면(또는 curl 응답)을 기술 문서에 첨부한다.

9. Docker 볼륨 영속성 검증
- Docker 볼륨을 생성하고 컨테이너에 연결한다.
- 컨테이너 삭제 전/후로 데이터를 확인하여 데이터가 유지됨을 증명한다.
- 기술 문서에 생성/연결/검증 절차(명령+출력)를 포함한다.

10. Git 설정 및 GitHub 연동
- Git 사용자 정보/기본 브랜치 설정을 완료하고 git config --list 결과를 기록한다.
- GitHub 로그인 및 저장소 연동을 완료하고, 연동 증거(스크린샷 등)를 기술 문서에 첨부한다.

11. 보안 및 개인정보 보호
- 기술 문서/로그/스크린샷에 토큰, 비밀번호, 개인키, 인증 코드 등이 포함되지 않도록 마스킹한다.
- 의심되는 민감정보가 노출된 경우, 즉시 히스토리/문서에서 제거하고 재발급 절차를 수행한다 (가능한 범위에서)

** **

### convention 예시

Feat: 퀴즈 출제 기능 구현

Fix: 점수 계산 오류 수정

Docs: README 실행 방법 추가

Refactor: QuizGame 책임 분리  

<br>

### 프로젝트 개요(미션 목표 요약)

1. 실행 환경(OS/쉘/터미널, Docker 버전, Git 버전)

2. 수행 항목 체크리스트(터미널/권한/Docker/Dockerfile/포트/볼륨/Git/GitHub)

3. 검증 방법(어떤 명령으로 무엇을 확인했는지) + 결과 위치 링크

4. 트러블슈팅 2건 이상(문제 → 원인 가설 → 확인 → 해결/대안)

5. 기술 문서만 읽어도 전체 수행 내용을 파악할 수 있어야 한다.
