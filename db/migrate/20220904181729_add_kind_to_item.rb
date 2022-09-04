class AddKindToItem < ActiveRecord::Migration[7.0]
  def change
    # 给items表添加一列为kind，类型为integer，默认为1，不能为空
    add_column :items, :kind, :integer, default: 1, null: false
  end
end
