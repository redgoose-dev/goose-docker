# goose-docker
docker on goose

## port guide

| Name | Port |
|:---:|:---:|
| mysql | 3306 |
| api | 8000 |
| manager | 8001 |
| app | 8002 |
| phpmyadmin | 8003 |


## install

먼저 필요한 이미지들을 빌드합니다.

```bash
docker-compose build
```

다음 명령으로 컨테이너를 띄웁니다.

```bash
docker-compose up -d
```

성공적으로 컨테이너가 띄어졌다면 먼저확인


```bash
docker-compose exec api ./script.sh install
```


## 최소한의 data 구조

- (dir) /data
- (dir) /data/api/upload
- (file) /data/api.env
- (file) /data/api/nginx.conf

- (dir) /data/manager
- (file) /data/manager/.env

- (dir) /data/app
- (file) /data/app/env.js
- (file) /data/app/env.scss
- (file) /data/app/ico-logo.png
- (file) /data/app/img-error.png

- (file) /data/Dockerfile-manager
- (file) /data/Dockerfile-app


## docker install process (docker-compose 로 사용할때..)

1. mysql, `api`를 띄운다.  
`docker-compose up -d mysql api`
1. `api` 인스톨을 하여 `token`값 알아낸다. (mysql 처음 띄우면 파일이 만들어질때까지 기다려야함)  
`docker-compose exec api ./script.sh install`
1. `.env`파일들을 수정한다. (manager, app 파일들 token 값 삽입)
1. `goose-manager`, `goose-app`를 빌드한다.  
`docker-compose build`
1. `docker-compose down`으로 컨테이너를 내린다.
1. `docker-compose up -d`로 다시 컨테이너를 올린다.

문제점은 `goose-manager`와 `goose-app`을 빌드하고 컨테이너 띄울 필요가 없는데 해야한다는것이다. 뭔가 옵션으로 조건을 걸 수 있으면 좋을법한데...





## 이슈 메모

- manager 부분 작업 시작하기
- 퍼블릭 키가 만들어지면 그걸 쉽게 입력하게할 수 있는 방법 찾기
- 뭔가 db 데이터가 늦게 만들어지는거 같아서 goose-api 인스톨이 불가능하다. 그래서 수동으로 인스톨을 하게하는 방법을 찾아야할듯..

https://stackoverflow.com/questions/41405998/mysql-user-not-created-in-user-table-when-using-docker-compose

`docker-compose exec mysql /bin/bash` 로 접속만 하면 바로 볼륨에 피일이 만들어지진 않는다.
컨테이너 내부에서도 꽤 시간이 걸린다.

그냥 db 설정은 따로 분리시켜버리는게 어떨까 싶다. 어짜피 사용하는 사람들은 대부분 따로 사용할거라 생각되고...

따로 컨테이터 띄었을때도 한번 테스트해봐야겠다.

----

manager에서 ssr 영역에서 api 가져오기 하면 127.0.0.1 관련 오류가 생기면서 새로고침하면 오류가 생긴다. 명확한 해결책을 못찾고 있는상황..

---

호스트 이름 문제가 해결되지 않는다면 플랜B로 api 이미지 베이스로 node와 manager, app 들을 추가시키고 pm2로 관리시키는 방법도 생각해봐야겠다.