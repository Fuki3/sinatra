# frozen_string_literal: true

require 'sinatra'
require 'sinatra/reloader'
require 'pg'
require 'erb'

def conn
  PG.connect(dbname: 'sinatra_note_app')
end

def load_memo(id)
  conn.exec('SELECT * FROM contents') do |result|
    (result.map{|row| row if row['id'] == id}).compact.first
  end
end

def load_memos
  conn.exec('SELECT * FROM contents')
end

def create_memo(title, body)
  conn.exec_params('INSERT INTO contents(title, body) VALUES ($1, $2);', [title, body])
end

def edit_memo(title, body, id)
  conn.exec_params('UPDATE contents SET title = $1, body = $2 WHERE id = $3;', [title, body, id])
end

def delete_memo(id)
  conn.exec_params('DELETE FROM contents WHERE id = $1;', [id])
end

get '/memos' do
  @memos = load_memos
  erb :memos_list
end

get '/memos/new' do
  erb :new
end

get '/memos/:id' do
  @title = load_memo(params[:id])['title']
  @body = load_memo(params[:id])['body']
  erb :each_memo
end

post '/memos' do
  title = params[:title]
  body = params[:body]
  create_memo(title, body)
  redirect '/memos'
end

get '/memos/:id/edit' do
  @title = load_memo(params[:id])['title']
  @body = load_memo(params[:id])['body']
  erb :edit
end

patch '/memos/:id' do
  title = params[:title]
  body = params[:body]
  edit_memo(title, body, params[:id])
  redirect "/memos/#{params[:id]}"
end

delete '/memos/:id' do
  delete_memo(params[:id])
  redirect '/memos'
end
