# 공식 nginx 이미지를 기반으로 사용
FROM nginx:latest

# 호스트의 app 디렉토리를 컨테이너의 웹 루트로 복사
COPY app/ /usr/share/nginx/html/

# 포트 80을 노출 (문서화 목적)
EXPOSE 80

# nginx 실행 (포그라운드 모드)
CMD ["nginx", "-g", "daemon off;"]
