# frozen_string_literal: true

require 'sinatra'
require 'sinatra/reloader'
require 'json'
require 'erb'

get '/memos' do
  @memos = File.open('memos.json') { |file| JSON.parse(file.read) }
  erb :memos_list
end

get '/memos/new' do
  erb :new
end

get '/memos/:id' do
  memos = File.open('memos.json') { |file| JSON.parse(file.read) }
  @title = memos[params[:id]]['title']
  @body = memos[params[:id]]['body']
  erb :each_memo
end

post '/memos' do
  title = params[:title]
  body = params[:body]

  memos = File.open('memos.json') { |file| JSON.parse(file.read) }
  id = (memos.keys.map(&:to_i).max + 1).to_s
  memos[id] = { 'title' => title, 'body' => body }
  File.open('memos.json', 'w') { |file| JSON.dump(memos, file) }

  redirect '/memos'
end

get '/memos/:id/edit' do
  memos = File.open('memos.json') { |file| JSON.parse(file.read) }
  @title = memos[params[:id]]['title']
  @body = memos[params[:id]]['body']
  erb :edit
end

patch '/memos/:id' do
  title = params[:title]
  body = params[:body]

  memos = File.open('memos.json') { |file| JSON.parse(file.read) }
  memos[params[:id]] = { 'title' => title, 'body' => body }
  File.open('memos.json', 'w') { |file| JSON.dump(memos, file) }

  redirect "/memos/#{params[:id]}"
end

delete '/memos/:id' do
  memos = File.open('memos.json') { |file| JSON.parse(file.read) }
  memos.delete(params[:id])
  File.open('memos.json', 'w') { |file| JSON.dump(memos, file) }

  redirect '/memos'
end
