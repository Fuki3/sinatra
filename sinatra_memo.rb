# frozen_string_literal: true

require 'sinatra'
require 'sinatra/reloader'
require 'pg'
require 'erb'

def conn
  PG.connect(dbname: 'sinatra_note_app')
end

def load_memo(id)
  conn.exec('SELECT * FROM memos') do |result|
    (result.map { |row| row if row['id'] == id }).compact.first
  end
end

def load_memos
  conn.exec('SELECT * FROM memos')
end

def create_memo(title, body)
  conn.exec_params('INSERT INTO memos(title, body) VALUES ($1, $2);', [title, body])
end

def edit_memo(title, body, id)
  conn.exec_params('UPDATE memos SET title = $1, body = $2 WHERE id = $3;', [title, body, id])
end

def delete_memo(id)
  conn.exec_params('DELETE FROM memos WHERE id = $1;', [id])
end

get '/memos' do
  @memos = load_memos
  conn.close
  erb :memos_list
end

get '/memos/new' do
  conn.close
  erb :new
end

get '/memos/:id' do
  @title = load_memo(params[:id])['title']
  @body = load_memo(params[:id])['body']
  conn.close
  erb :each_memo
end

post '/memos' do
  title = params[:title]
  body = params[:body]
  create_memo(title, body)
  conn.close
  redirect '/memos'
end

get '/memos/:id/edit' do
  @title = load_memo(params[:id])['title']
  @body = load_memo(params[:id])['body']
  conn.close
  erb :edit
end

patch '/memos/:id' do
  title = params[:title]
  body = params[:body]
  edit_memo(title, body, params[:id])
  conn.close
  redirect "/memos/#{params[:id]}"
end

delete '/memos/:id' do
  delete_memo(params[:id])
  conn.close
  redirect '/memos'
end
