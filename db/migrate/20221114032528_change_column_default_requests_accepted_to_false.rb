class ChangeColumnDefaultRequestsAcceptedToFalse < ActiveRecord::Migration[7.0]
  def change
    change_column_default :requests, :accepted, from: nil, to: false
  end
end
