class TodolistsController < ApplicationController
  # 6,7章でview関連アクションを追加 controllerのアクション書く順番はvieｗが関係するものを上に書く(頻繁にいじるため)
  # index>new>show>edit>create>update>destroyが推奨
  # new>create>index>show>edit>update>destroyという作成順もある
  def index
	@lists = List.all
  end

  def new
  	 # viewへ渡すためのインスタンス変数に空の*モデルオブジェクトを生成する
  	 # *アプリケーション固有のデータを扱う部分/のオブジェクト(データとメソッドを1つにまとめたもの)
  	  # @listはインスタンス変数、@がついているのでviewファイルへ受け渡せる
  	@list = List.new
  end

  def show
  	# 詳細ページで呼び出される投稿データは、URLの/todolist/:id内の:idで判別
  	# レコード1件を取得するので、変数名は単数形の「@list」にします
  	@list = List.find(params[:id])
  end

  def edit
  	@list = List.find(params[:id])
  end

# 5章で以下を追加
	def create
		# ストロングパラメーターを使用(Web上から入力されてきた値を制限)
		# インスタンス変数 = クラス名.newメソッド（引数）
		# @の付いていないローカルのインスタンス変数はviewファイルへ受け渡せない
		list = List.new(list_params) # パラメーターの略
		# DBへ保存する(送り先は上記で作ったやつ)
		list.save # データベースに保存をするためのメソッド
		# トップ画面へリダイレクト
		redirect_to todolist_path(list.id) # 詳細画面へリダイレクト 外部サイトを指定する方法：redirect_to ‘URL'
	end

	def update
		list = List.find(params[:id])
		list.update(list_params)
		redirect_to todolist_path(list.id)
	end

	private# ここから下はcontrollerの中でしか呼び出せませんというメソッド（todolists_controller.rb内だけ）

	def list_params# requireメソッドで受け取るパラメータ群を指定、permitメソッドで利用可能なパラメータ名を指定
		params.require(:list).permit(:title, :body)
	end
end