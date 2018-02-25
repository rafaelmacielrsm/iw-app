class AddPostgresqlExtensions < ActiveRecord::Migration[5.1]
  def change
    enable_extension 'pgcrypto'
    enable_extension "plpgsql"
  end
end
