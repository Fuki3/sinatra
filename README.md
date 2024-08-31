# sinatraでメモアプリを作成しました。

## アプリケーションの立ち上げ方

1. 右上のForkボタンを押してください。
2. #{自分のアカウント名}/sinatraが作成されます。
3. 作業PCの任意の作業ディレクトリにてgit clone してください。
4. Bundlerで必要なGemをインストールします。作業ディレクトリでbundle initしてください。Gemfileは以下のように設定します。
```
# frozen_string_literal: true

source "https://rubygems.org"

# gem "rails"
gem 'sinatra'
gem 'erb_lint', require: false
gem 'webrick'
gem 'rackup'
gem 'sinatra-contrib'
group :development do
  gem 'rubocop-fjord', require: false
end
```
5. ターミナルでbundle exec ruby sinatra_memo.rbを実施してアプリケーションを起動してください。
6. ブラウザーで http://localhost:4567/memos にアクセスしてください。
