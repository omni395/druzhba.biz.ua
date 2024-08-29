# frozen_string_literal: true

# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 20_240_801_093_520) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'action_text_rich_texts', force: :cascade do |t|
    t.string 'name', null: false
    t.text 'body'
    t.string 'record_type', null: false
    t.bigint 'record_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.string 'locale', null: false
    t.index %w[record_type record_id name locale], name: 'index_action_text_rich_texts_uniqueness',
                                                   unique: true
  end

  create_table 'active_storage_attachments', force: :cascade do |t|
    t.string 'name', null: false
    t.string 'record_type', null: false
    t.bigint 'record_id', null: false
    t.bigint 'blob_id', null: false
    t.datetime 'created_at', null: false
    t.index ['blob_id'], name: 'index_active_storage_attachments_on_blob_id'
    t.index %w[record_type record_id name blob_id], name: 'index_active_storage_attachments_uniqueness',
                                                    unique: true
  end

  create_table 'active_storage_blobs', force: :cascade do |t|
    t.string 'key', null: false
    t.string 'filename', null: false
    t.string 'content_type'
    t.text 'metadata'
    t.string 'service_name', null: false
    t.bigint 'byte_size', null: false
    t.string 'checksum'
    t.datetime 'created_at', null: false
    t.index ['key'], name: 'index_active_storage_blobs_on_key', unique: true
  end

  create_table 'active_storage_variant_records', force: :cascade do |t|
    t.bigint 'blob_id', null: false
    t.string 'variation_digest', null: false
    t.index %w[blob_id variation_digest], name: 'index_active_storage_variant_records_uniqueness', unique: true
  end

  create_table 'admin_users', force: :cascade do |t|
    t.string 'email', default: '', null: false
    t.string 'encrypted_password', default: '', null: false
    t.string 'reset_password_token'
    t.datetime 'reset_password_sent_at'
    t.datetime 'remember_created_at'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.string 'name'
    t.integer 'role', default: 1
    t.index ['email'], name: 'index_admin_users_on_email', unique: true
    t.index ['reset_password_token'], name: 'index_admin_users_on_reset_password_token', unique: true
  end

  create_table 'articles', force: :cascade do |t|
    t.bigint 'service_id', null: false
    t.string 'title'
    t.string 'description'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.boolean 'published'
    t.string 'slug'
    t.index ['service_id'], name: 'index_articles_on_service_id'
    t.index ['slug'], name: 'index_articles_on_slug', unique: true
  end

  create_table 'customers', force: :cascade do |t|
    t.string 'name'
    t.string 'phone'
    t.string 'email'
    t.string 'description'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'friendly_id_slugs', force: :cascade do |t|
    t.string 'slug', null: false
    t.integer 'sluggable_id', null: false
    t.string 'sluggable_type', limit: 50
    t.string 'scope'
    t.datetime 'created_at'
    t.index %w[slug sluggable_type scope], name: 'index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope',
                                           unique: true
    t.index %w[slug sluggable_type], name: 'index_friendly_id_slugs_on_slug_and_sluggable_type'
    t.index %w[sluggable_type sluggable_id], name: 'index_friendly_id_slugs_on_sluggable_type_and_sluggable_id'
  end

  create_table 'landing_messages', force: :cascade do |t|
    t.string 'name'
    t.string 'phone'
    t.string 'email'
    t.text 'message'
    t.integer 'status', default: 0
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'mobility_string_translations', force: :cascade do |t|
    t.string 'locale', null: false
    t.string 'key', null: false
    t.string 'value'
    t.string 'translatable_type'
    t.bigint 'translatable_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index %w[translatable_id translatable_type key],
            name: 'index_mobility_string_translations_on_translatable_attribute'
    t.index %w[translatable_id translatable_type locale key],
            name: 'index_mobility_string_translations_on_keys', unique: true
    t.index %w[translatable_type key value locale], name: 'index_mobility_string_translations_on_query_keys'
  end

  create_table 'mobility_text_translations', force: :cascade do |t|
    t.string 'locale', null: false
    t.string 'key', null: false
    t.text 'value'
    t.string 'translatable_type'
    t.bigint 'translatable_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index %w[translatable_id translatable_type key],
            name: 'index_mobility_text_translations_on_translatable_attribute'
    t.index %w[translatable_id translatable_type locale key],
            name: 'index_mobility_text_translations_on_keys', unique: true
  end

  create_table 'money_flow_categories', force: :cascade do |t|
    t.string 'title'
    t.string 'description'
    t.integer 'flow'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'money_flow_details', force: :cascade do |t|
    t.bigint 'money_flow_id', null: false
    t.bigint 'money_flow_category_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.float 'amount'
    t.index ['money_flow_category_id'], name: 'index_money_flow_details_on_money_flow_category_id'
    t.index ['money_flow_id'], name: 'index_money_flow_details_on_money_flow_id'
  end

  create_table 'money_flows', force: :cascade do |t|
    t.string 'title'
    t.string 'description'
    t.float 'total_amount'
    t.integer 'order_id'
    t.bigint 'admin_user_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['admin_user_id'], name: 'index_money_flows_on_admin_user_id'
  end

  create_table 'order_details', force: :cascade do |t|
    t.bigint 'order_id', null: false
    t.bigint 'service_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['order_id'], name: 'index_order_details_on_order_id'
    t.index ['service_id'], name: 'index_order_details_on_service_id'
  end

  create_table 'orders', force: :cascade do |t|
    t.bigint 'customer_id', null: false
    t.integer 'status', default: 0
    t.integer 'paid', default: 0
    t.integer 'price'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.bigint 'admin_user_id'
    t.date 'dead_date'
    t.time 'dead_time'
    t.string 'description'
    t.index ['admin_user_id'], name: 'index_orders_on_admin_user_id'
    t.index ['customer_id'], name: 'index_orders_on_customer_id'
  end

  create_table 'services', force: :cascade do |t|
    t.string 'title'
    t.string 'description'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.string 'slug'
    t.integer 'price'
    t.integer 'svc'
    t.string 'subtitle'
    t.index ['slug'], name: 'index_services_on_slug', unique: true
  end

  add_foreign_key 'active_storage_attachments', 'active_storage_blobs', column: 'blob_id'
  add_foreign_key 'active_storage_variant_records', 'active_storage_blobs', column: 'blob_id'
  add_foreign_key 'articles', 'services'
  add_foreign_key 'money_flow_details', 'money_flow_categories'
  add_foreign_key 'money_flow_details', 'money_flows'
  add_foreign_key 'money_flows', 'admin_users'
  add_foreign_key 'order_details', 'orders'
  add_foreign_key 'order_details', 'services'
  add_foreign_key 'orders', 'admin_users'
  add_foreign_key 'orders', 'customers'
end
