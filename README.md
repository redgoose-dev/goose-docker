# goose-docker
docker on goose

## port guide

- `mysql:3306`: mysql
- `7999`: phpmyadmin
- `8000`: goose api
- `8001`: goose manager
- `8002`: goose app


## install

```bash
./tools.sh install
```


## TODO

- manager 부분 작업 시작하기
- 퍼블릭 키가 만들어지면 그걸 쉽게 입력하게할 수 있는 방법 찾기
- 뭔가 db 데이터가 늦게 만들어지는거 같아서 goose-api 인스톨이 불가능하다. 그래서 수동으로 인스톨을 하게하는 방법을 찾아야할듯..


https://stackoverflow.com/questions/41405998/mysql-user-not-created-in-user-table-when-using-docker-compose

`docker-compose exec mysql /bin/bash` 로 접속만 하면 바로 볼륨에 피일이 만들어지진 않는다.
컨테이너 내부에서도 꽤 시간이 걸린다.

그냥 db 설정은 따로 분리시켜버리는게 어떨까 싶다. 어짜피 사용하는 사람들은 대부분 따로 사용할거라 생각되고...

따로 컨테이터 띄었을때도 한번 테스트해봐야겠다.
