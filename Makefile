# コンテナを立ち上げる
up:
	docker-compose up -d

# コンテナを落とす
down:
	docker-compose down

# コンテナを再開
start:
	docker-compose start

# コンテナを一時停止
stop:
	docker-compose stop

# appコンテナの中に移動する
ex:
	docker exec -it asterisk-app sh

# migration実行
mg:
	docker exec -it asterisk-app php artisan migrate

# migration実行状況確認
mgs:
	docker exec -it asterisk-app php artisan migrate:status

# migration実行取り消し
mgr:
	docker exec -it asterisk-app php artisan migrate:rollback

# seeder実行
sd:
	docker exec -it asterisk-app php artisan db:seed

# css・jsをビルド(更新なし)
dev:
	npm run dev

# css・jsをビルド(更新あり)
watch:
	npm run watch

# NOTE: コンテナの中でcomposerをインストール
i-composer:
	docker exec -it asterisk-app composer install

# 環境構築用のコマンド(必要なパッケージやデータを入れる)
init:
	@make destroy
	cp .env.example .env
	@make up
	@make i-composer
	@make mg
	@make sd

# 環境構築用コマンド(.envを読み直し)
set-up:
	@make up
	npm install
	@make watch

# 既存環境の削除
destroy:
	docker compose down --rmi all --volumes --remove-orphans
	rm -rf .env
	rm -rf vendor
