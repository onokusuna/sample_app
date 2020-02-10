Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  	get 'todolists/new'

  	# HTTPメソッド「GET」 'URL' => 'コントローラ#アクション'
	get 'top' => 'homes#top'

	# todolists_controller.rbへ送る
	post 'todolists' => 'todolists#create'

	# index.html.erbファイルの内容が表示されるように、ルーティングを追加
	get 'todolists' => 'todolists#index'
	# 詳細ページでは、どの投稿データを表示するかを判別するために、投稿データのidもURLに含めます
	# .../todolists/1 や .../todolists/3 に該当する
	get 'todolists/:id' => 'todolists#show', as:'todolist'
	# editアクションを追加 今回も、名前付きルート（as: 'edit_todolist'）の記述を定義
	# ルーティングのURLに:idを用いて記述すると、todolists/◯◯/editのすべてのURLが対象になります。
	get 'todolists/:id/edit' => 'todolists#edit', as:'edit_todolist'

	# updateアクションのルーティングを追加
	patch 'todolists/:id' => 'todolists#update', as: 'update_todolist'

	# desteoyアクション追加
	delete 'todolists/:id' => 'todolists#destroy', as: 'destroy_todolist'
end