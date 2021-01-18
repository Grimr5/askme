class UsersController < ApplicationController
  def index
    @users = [
      User.new(
        id: 1,
        name: 'Sergei',
        username: 'grimreaper',
        avatar_url: 'https://whatsism.com/uploads/posts/2018-07/1530546770_rmk_vdjbx10.jpg'
      ),
      User.new(
        id: 2,
        name: 'Misha',
        username: 'aristofun'
      )
    ]
  end

  def new
  end

  def edit
  end

  def show
    @user = User.new(
      name: 'Sergey',
      username: 'grimreaper',
      avatar_url: 'https://whatsism.com/uploads/posts/2018-07/1530546770_rmk_vdjbx10.jpg'
    )

    @questions = [
      Question.new(text: 'Как дела', created_at: Date.parse('15.01.2021')),
      Question.new(text: 'В чем смысл жизни?', created_at: Date.parse('15.01.2021'))
    ]

    @new_question = Question.new
  end
end
