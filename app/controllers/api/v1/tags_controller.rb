class Api::V1::TagsController < ApplicationController
  def index
    current_user = User.find request.env['current_user_id']
    return render status: 401 if current_user.nil?
    tags = Tag.where(user_id: current_user).page(params[:page])
    render json: { resources: tags, pager: {
      page: params[:page] || 1,
      per_page: Tag.default_per_page,
      count: Tag.count
    }}
  end
  def create
    current_user = User.find request.env['current_user_id']
    return render status: 401 if current_user.nil?

    tag = Tag.new name: params[:name], sign: params[:sign], user_id: current_user.id
    # 由于直接Tag.create 不传参数的时候数据库会报错，分部进行——先创建，后保存
    if tag.save
      render json: { resource: tag }, status: :ok
    else
      render json: { errors: tag.errors }, status: :unprocessable_entity
    end
  end
  def update
    # find 如果找不到是会报错的
    tag = Tag.find params[:id]
    # permit即在参数查找name和sign的key和值返回一个哈希值
    tag.update params.permit(:name, :sign)
    if tag.errors.empty?
      render json: { resource: tag }
    else
      render json: { errors: tag.errors }, status: :unprocessable_entity
    end
  end
  def destroy
    tag = Tag.find params[:id]
    return head :forbidden unless tag.user_id == request.env['current_user_id']
    tag.deleted_at = Time.now
    if tag.save
      head 200
    else
      render json: { errors: tag.errors }, status: :unprocessable_entity
    end
  end
end
