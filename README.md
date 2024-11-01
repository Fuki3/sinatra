# sinatra でメモアプリを作成しました。

## アプリケーションの立ち上げ方

1. 右上の Fork ボタンを押してください。
2. #{自分のアカウント名}/sinatra が作成されます。
3. 作業 PC の任意の作業ディレクトリにて git clone してください。
4. Bundler で必要な Gem をインストールします。作業ディレクトリで bundle init してください。
5. PostgreSQL を起動し、db.sql の内容でデータベースとテーブルを定義してください。
6. ターミナルで bundle exec ruby sinatra_memo.rb を実施してアプリケーションを起動してください。
7. ブラウザーで http://localhost:4567/memos にアクセスしてください。
