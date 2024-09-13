# frozen_string_literal: true

require 'sinatra'
require 'sinatra/reloader'
require 'json'
require 'erb'

def load_memos(file_name)
  File.open(file_name) { |file| JSON.parse(file.read) }
end

def write_memos(file_name, memos)
  File.open(file_name, 'w') { |file| JSON.dump(memos, file) }
end

get '/memos' do
  @memos = load_memos('memos.json')
  erb :memos_list
end

get '/memos/new' do
  erb :new
end

get '/memos/:id' do
  memos = load_memos('memos.json')
  @title = memos[params[:id]]['title']
  @body = memos[params[:id]]['body']
  erb :each_memo
end

post '/memos' do
  title = params[:title]
  body = params[:body]

  memos = load_memos('memos.json')
  id = if memos == {}
         1
       else
         (memos.keys.map(&:to_i).max + 1).to_s
       end
  memos[id] = { 'title' => title, 'body' => body }
  write_memos('memos.json', memos)

  redirect '/memos'
end

get '/memos/:id/edit' do
  memos = load_memos('memos.json')
  @title = memos[params[:id]]['title']
  @body = memos[params[:id]]['body']
  erb :edit
end

patch '/memos/:id' do
  title = params[:title]
  body = params[:body]

  memos = load_memos('memos.json')
  memos[params[:id]] = { 'title' => title, 'body' => body }
  write_memos('memos.json', memos)

  redirect "/memos/#{params[:id]}"
end

delete '/memos/:id' do
  memos = load_memos('memos.json')
  memos.delete(params[:id])
  write_memos('memos.json', memos)

  redirect '/memos'
end
