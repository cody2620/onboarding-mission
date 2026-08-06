# 프로젝트 개요(미션 목표 요약)

# 실행 환경(OS/쉘/터미널, Docker 버전, Git 버전)
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

- 터미널 출력을 파일로 저장(결과: permission denied)
```
docker --version ~/docker-mission/logs/01-docker-version.log
docker info >> ~/docker-mission/logs/01-docker-version.log
```

- 저장 확인(아직 실행 X)
```
cat ~/docker-mission/logs/01-docker-version.log
```

- hello-world 이미지로 테스트 
```
docker run --rm hello-world
```

- 3단계 웹서버 Dokerfile 작성과 빌드

- 4단계: 포트 매핑 & 바인드 마운트 & 볼륨 실습 (1시간) << 여기서부터 ㄱㄱ


# 수행 항목 체크리스트(터미널/권한/Docker/Dockerfile/포트/볼륨/Git/GitHub)

# 검증 방법(어떤 명령으로 무엇을 확인했는지) + 결과 위치 링크

# 트러블슈팅 2건 이상(문제 → 원인 가설 → 확인 → 해결/대안)

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
