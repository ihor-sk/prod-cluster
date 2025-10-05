variable "tenant" {
  type        = string
  description = "The name of the tenant (schema) to create"
}

schema "tenant" {
  name = var.tenant
}

table "site" {
  schema = schema.tenant

  column "site_key" {
    type = text
  }

  column "transaction_count" {
    type = integer
    default = 0
  }

  column "name" {
    type = text
  }

  column "country" {
    type = text
    null = true
  }

  primary_key {
    columns = [column.site_key]
  }
}

table "connector" {
  schema = schema.tenant

  column "transaction_count" {
    type = integer
    default = 0
  }

  column "connector_key" {
    type = text
  }

  column "last_seen" {
    type = timestamp
  }

  column "create_date" {
    type = timestamp
  }

  primary_key {
    columns = [column.connector_key]
  }
}

table "subsystem_interface" {
  schema = schema.tenant

  column "created_by" {
    type = text
  }

  column "create_date" {
    type = timestamp
  }

  column "updated_by" {
    type = text
    null = true
  }

  column "update_date" {
    type = timestamp
    null = true
  }

  column "transaction_count" {
    type = integer
    default = 0
  }

  column "id" {
    type    = uuid
    default = sql("gen_random_uuid()")
  }
  primary_key {
    columns = [column.id]
  }

  column "name" {
    type = text
  }

  column "type" {
    type = text
    default = "UNKNOWN"
  }

  column "message_specficiation_key" {
    type = text
  }

  column "json_message_type_field" {
    type = text
    null = true
  }

  column "json_message_payload_field" {
    type = text
    null = true
  }
}

table "subsystem" {
  schema = schema.tenant

  column "created_by" {
    type = text
  }

  column "create_date" {
    type = timestamp
  }

  column "updated_by" {
    type = text
    null = true
  }

  column "update_date" {
    type = timestamp
    null = true
  }

  column "transaction_count" {
    type = integer
    default = 0
  }

  column "id" {
    type    = uuid
    default = sql("gen_random_uuid()")
  }
  primary_key {
    columns = [column.id]
  }

  column "name" {
    type = text
  }

  column "subsystem_key" {
    type = text
    default = "TBD"
  }

  column "connector_key" {
    type = text
    null = true
  }

  column "subsystem_interface_id" {
    type = uuid
  }

  column "site_key" {
    type = text
  }

  column "system_mode" {
    type = text
    null = true
  }

  column "status" {
    type = text
    null = true
  }

  foreign_key "owner_id" {
    columns     = [column.site_key]
    ref_columns = [table.site.column.site_key]
    on_update   = NO_ACTION
    on_delete   = NO_ACTION
  }

  foreign_key "subsystem_interface_fk" {
    columns     = [column.subsystem_interface_id]
    ref_columns = [table.subsystem_interface.column.id]
    on_update   = NO_ACTION
    on_delete   = NO_ACTION
  }

  foreign_key "connector_key" {
    columns     = [column.connector_key]
    ref_columns = [table.connector.column.connector_key]
    on_update   = NO_ACTION
    on_delete   = NO_ACTION
  }
}

table "sorting_event" {
  schema = schema.tenant

  column "id" {
    type    = uuid
    default = sql("gen_random_uuid()")
  }
  primary_key {
    columns = [column.id]
  }

  column "msg_id" {
    type = text
  }

  column "msg_type" {
    type = text
  }

  column "location_id" {
    type = text
  }

  column "tracking_number" {
    type = text
  }
  column "kolli_id" {
    type = text
  }

  column "sort_result" {
    type = integer
  }

  column "created_date" {
    type = timestamp
  }
}

table "subsystem_message_log" {
  schema = schema.tenant

  column "created_by" {
    type = text
  }

  column "create_date" {
    type = timestamp
  }

  column "updated_by" {
    type = text
    null = true
  }

  column "update_date" {
    type = timestamp
    null = true
  }

  column "transaction_count" {
    type = integer
    default = 0
  }

  column "id" {
    type    = uuid
    default = sql("gen_random_uuid()")
  }

  primary_key {
    columns = [column.id]
  }
  
  column "subsystem_key" {
    type = text
    null = true
  }

  column "site_key" {
    type = text
    null = true
  }

  column "result" {
    type = text
  }

  column "process_time_ms" {
    type = integer
  }

  column "message" {
    type = text
    null = true
  }

  column "error_message" {
    type = text
    null = true
  }

  column "direction" {
    type = text
    default = "INBOUND"
  }
}

table "routing_layout_setup" {
  schema = schema.tenant

  column "created_by" {
    type = text
  }

  column "create_date" {
    type = timestamp
  }

  column "updated_by" {
    type = text
    null = true
  }

  column "update_date" {
    type = timestamp
    null = true
  }

  column "transaction_count" {
    type = integer
    default = 0
  }

  column "id" {
    type    = uuid
    default = sql("gen_random_uuid()")
  }

  primary_key {
    columns = [column.id]
  }

  column "name" {
    type = text
    default = "UNKNOWN"
  }

  column "grid_layout" {
    type = jsonb
  }
  
  column "default_column_widths" {
    type = jsonb
    default = "[]"
  }

}

table "field_setup" {
  schema = schema.tenant

  column "created_by" {
    type = text
  }

  column "create_date" {
    type = timestamp
  }

  column "updated_by" {
    type = text
    null = true
  }

  column "update_date" {
    type = timestamp
    null = true
  }

  column "transaction_count" {
    type = integer
    default = 0
  }

  column "id" {
    type    = uuid
    default = sql("gen_random_uuid()")
  }

  primary_key {
    columns = [column.id]
  }

  column "name" {
    type = text
    default = "UNKNOWN"
  }

  column "fields" {
    type = jsonb
  }
}

table "preference_setup" {
  schema = schema.tenant

  column "created_by" {
    type = text
  }

  column "create_date" {
    type = timestamp
  }

  column "updated_by" {
    type = text
    null = true
  }

  column "update_date" {
    type = timestamp
    null = true
  }

  column "transaction_count" {
    type = integer
    default = 0
  }

  column "id" {
    type    = uuid
    default = sql("gen_random_uuid()")
  }
  primary_key {
    columns = [column.id]
  }

  column "category" {
    type = text
  }

  column "sub_category" {
    type = text
  }

  column "preference_key" {
    type = text
  }

  column "use_user_id" {
    type = boolean
  }

  column "use_role_name" {
    type = boolean
  }

  column "use_workstation_name" {
    type = boolean
  }

  column "use_site_key" {
    type = boolean
  }
}

table "preference" {
  schema = schema.tenant

  column "created_by" {
    type = text
  }

  column "create_date" {
    type = timestamp
  }

  column "updated_by" {
    type = text
    null = true
  }

  column "update_date" {
    type = timestamp
    null = true
  }

  column "transaction_count" {
    type = integer
    default = 0
  }

  column "id" {
    type    = uuid
    default = sql("gen_random_uuid()")
  }
  primary_key {
    columns = [column.id]
  }

  column "preference_setup_id" {
    type = uuid
  }

  column "string_value" {
    type = text
    null = true
  }

  column "int_value" {
    type = integer
    null = true
  }

  column "float_value" {
    type = float
    null = true
  }

  column "map_value" {
    type = jsonb
    null = true
  }

  column "json_value" {
    type = jsonb
    null = true
  }

  column "user_ids" {
    type = jsonb
    null = true
  }

  column "role_ids" {
    type = jsonb
    null = true
  }

  column "workstation_ids" {
    type = jsonb
    null = true
  }

  column "site_keys" {
    type = jsonb
    null = true
  }

  foreign_key "preference_setup_fk" {
    columns     = [column.preference_setup_id]
    ref_columns = [table.preference_setup.column.id]
    on_update   = NO_ACTION
    on_delete   = NO_ACTION
  }
}

table "query_matcher" {
  schema = schema.tenant

  column "created_by" {
    type = text
  }

  column "create_date" {
    type = timestamp
  }

  column "updated_by" {
    type = text
    null = true
  }

  column "update_date" {
    type = timestamp
    null = true
  }

  column "transaction_count" {
    type = integer
    default = 0
  }

  column "id" {
    type    = uuid
    default = sql("gen_random_uuid()")
  }

  primary_key {
    columns = [column.id]
  }

  column "name" {
    type = text
  }

  column "type" {
    type = text
  }

  column "reference_id" {
    type = text
  }

  column "field_setup_id" {
    type = uuid
    null = true
  }

  foreign_key "field_setup_id_fk" {
    columns     = [column.field_setup_id]
    ref_columns = [table.field_setup.column.id]
    on_update   = NO_ACTION
    on_delete   = NO_ACTION
  }

  column "query_settings" {
    type = jsonb
  }

  column "routing_location_id" {
    type = uuid
    null = true
  }

  foreign_key "routing_location_id_fk" {
    columns     = [column.routing_location_id]
    ref_columns = [table.location.column.id]
    on_update   = NO_ACTION
    on_delete   = NO_ACTION
  }
}

table "query_matcher_instance" {
  schema = schema.tenant

  column "created_by" {
    type = text
  }

  column "create_date" {
    type = timestamp
  }

  column "updated_by" {
    type = text
    null = true
  }

  column "update_date" {
    type = timestamp
    null = true
  }

  column "transaction_count" {
    type = integer
    default = 0
  }

  column "id" {
    type    = uuid
    default = sql("gen_random_uuid()")
  }

  primary_key {
    columns = [column.id]
  }

  column "name" {
    type = text
  }

  column "queries" {
    type = jsonb
  }

  column "is_active" {
    type = boolean
  }

  column "query_matcher_id" {
    type = uuid
  }

    column "fallback_destination_id" {
      type = uuid
      null = true
    }

  foreign_key "query_matcher_id_fk" {
    columns     = [column.query_matcher_id]
    ref_columns = [table.query_matcher.column.id]
    on_update   = NO_ACTION
    on_delete   = NO_ACTION
  }

    foreign_key "fallback_destination_id_fk" {
      columns     = [column.fallback_destination_id]
      ref_columns = [table.location.column.id]
      on_update   = NO_ACTION
      on_delete   = NO_ACTION
    }
}

table "action_condition" {
  schema = schema.tenant

  column "created_by" {
    type = text
  }

  column "create_date" {
    type = timestamp
  }

  column "updated_by" {
    type = text
    null = true
  }

  column "update_date" {
    type = timestamp
    null = true
  }

  column "transaction_count" {
    type = integer
    default = 0
  }

  column "id" {
    type    = uuid
    default = sql("gen_random_uuid()")
  }

  primary_key {
    columns = [column.id]
  }

  column "from_action" {
    type = text
    null = true
  }

  column "action_to_execute" {
    type = text
  }

  column "group_key" {
    type = text
    null = true
  }

  column "attributes" {
    type = jsonb
    null = true
  }
}

table "transport_node" {
  schema = schema.tenant

  column "created_by" {
    type = text
  }

  column "create_date" {
    type = timestamp
  }

  column "updated_by" {
    type = text
    null = true
  }

  column "update_date" {
    type = timestamp
    null = true
  }

  column "transaction_count" {
    type = integer
    default = 0
  }

  column "id" {
    type    = uuid
    default = sql("gen_random_uuid()")
  }

  primary_key {
    columns = [column.id]
  }

  column "address" {
    type = text
    null = true
  }

  column "location_id" {
    type = uuid
  }

  column "subsystem_id" {
    type = uuid
  }

  foreign_key "location_id_fk" {
    columns     = [column.location_id]
    ref_columns = [table.location.column.id]
    on_update   = NO_ACTION
    on_delete   = NO_ACTION
  }

  foreign_key "subsystem_id_fk" {
    columns     = [column.subsystem_id]
    ref_columns = [table.subsystem.column.id]
    on_update   = NO_ACTION
    on_delete   = NO_ACTION
  }
}

table "location" {
  schema = schema.tenant

  column "created_by" {
    type = text
  }

  column "create_date" {
    type = timestamp
  }

  column "updated_by" {
    type = text
    null = true
  }

  column "update_date" {
    type = timestamp
    null = true
  }

  column "transaction_count" {
    type = integer
    default = 0
  }

  column "id" {
    type    = uuid
    default = sql("gen_random_uuid()")
  }

  primary_key {
    columns = [column.id]
  }

  column "name" {
    type = text
    default = "UNKNOWN"
  }

  column "parent_location_id" {
    type = uuid
    null = true
  }

  column "default_sort_order" {
    type = integer
    null = false
    default = 0
  }

  column "physical_status" {
    type = text
    null = true
  }

    column "location_type" {
        type = text
        null = true
    }

  foreign_key "parent_location_id_fk" {
    columns     = [column.parent_location_id]
    ref_columns = [table.location.column.id]
    on_update   = NO_ACTION
    on_delete   = NO_ACTION
  }
}

table "host_message_log" {
  schema = schema.tenant

  column "created_by" {
    type = text
  }

  column "create_date" {
    type = timestamp
  }

  column "updated_by" {
    type = text
    null = true
  }

  column "update_date" {
    type = timestamp
    null = true
  }

  column "transaction_count" {
    type = integer
    default = 0
  }

  column "id" {
    type    = uuid
    default = sql("gen_random_uuid()")
  }

  primary_key {
    columns = [column.id]
  }

  column "status" {
    type = text
    default = "NEW"
  }

  column "process_time_total" {
    type = integer
    null = true
  }

  column "process_time_splits" {
    type = text
    null = true
  }

  column "integration_type" {
    type = text
    null = true
  }

  column "credential_name" {
    type = text
    null = true
  }

  column "request" {
    type = text
    null = true
  }

  column "response" {
    type = text
    null = true
  }

  column "log" {
    type = text
    null = true
  }
}

table "external_credential" {
  schema = schema.tenant
   
  column "created_by" {
    type = text
  }

  column "create_date" {
    type = timestamp
  }

  column "updated_by" {
    type = text
    null = true
  }

  column "update_date" {
    type = timestamp
    null = true
  }

  column "transaction_count" {
    type = integer
    default = 0
  }

  column "id" {
    type    = uuid
    default = sql("gen_random_uuid()")
  }

  primary_key {
    columns = [column.id]
  }

  column "name" {
    type = text
  }

  column "value" {
    type = text
  }
}

table "user_dashboards" {
  schema = schema.tenant

  column "id" {
    type    = uuid
    default = sql("gen_random_uuid()")
  }

  primary_key {
    columns = [column.id]
  }

  column "user_id" {
    type = uuid
    null = false
  }

  column "name" {
    type = text
    null = false
  }

  column "dashboard" {
    type = jsonb
    null = false
  }

  unique "user_dashboards_user_id_name_index" {
    columns = [column.user_id, column.name]
  }
}

table "visualization3d_layout" {
  schema = schema.tenant

  column "created_by" {
    type = text
  }

  column "create_date" {
    type = timestamp
  }

  column "updated_by" {
    type = text
    null = true
  }

  column "update_date" {
    type = timestamp
    null = true
  }

  column "transaction_count" {
    type    = integer
    default = 0
  }

  column "id" {
    type = uuid
    default = sql("gen_random_uuid()")
  }

  column "layoutId" {
    type    = text
    default = ""
  }

  column "layout" {
    type = jsonb
  }

  column "revision_number" {
    type = integer
    default = 1  # Default to 1 for the first entry. Just star
    null = true
  }

  column "site" {
    type = text
    null = true
  }

  primary_key {
    columns = [column.id]
  }
}

table "visualization3d_view" {
  schema = schema.tenant

  column "created_by" {
    type = text
  }

  column "create_date" {
    type = timestamp
  }

  column "updated_by" {
    type = text
    null = true
  }

  column "update_date" {
    type = timestamp
    null = true
  }

  column "transaction_count" {
    type    = integer
    default = 0
  }

  column "id" {
    type = uuid
    default = sql("gen_random_uuid()")
  }

  column "name" {
    type = text
    null = false
  }

  column "camera_offset" {
    type = jsonb
    null = false
  }

  column "target_offset" {
    type = jsonb
    null = false
  }

  column "zoom" {
    type = float
    null = false
  }

  column "site" {
    type = text
    null = false
  }

  primary_key {
    columns = [column.id]
  }
}

table "parcel" {
  schema = schema.tenant

  column "created_by" {
    type = text
  }

  column "create_date" {
    type = timestamp
  }

  column "updated_by" {
    type = text
    null = true
  }

  column "update_date" {
    type = timestamp
    null = true
  }

  column "transaction_count" {
    type = integer
    default = 0
  }

  column "id" {
    type    = uuid
    default = sql("gen_random_uuid()")
  }
  primary_key {
    columns = [column.id]
  }

  column "parcel_type_id" {
    type = uuid
    null = true
  }

  column "status" {
    type = text
  }

  column "aliases" {
    type = jsonb
  }

  column "length" {
    type = numeric(10, 2)
    default = 0
  }

  column "width" {
    type = numeric(10, 2)
    default = 0
  }

  column "height" {
    type = numeric(10, 2)
    default = 0
  }

  column "weight" {
    type = numeric(10, 2)
    default = 0
  }

  column "details" {
    type = jsonb
    null = true
  }

  foreign_key "parcel_type_fk" {
    columns     = [column.parcel_type_id]
    ref_columns = [table.parcel_type.column.id]
    on_update   = NO_ACTION
    on_delete   = NO_ACTION
  }
}

table "parcel_type" {
  schema = schema.tenant

  column "created_by" {
    type = text
  }

  column "create_date" {
    type = timestamp
  }

  column "updated_by" {
    type = text
    null = true
  }

  column "update_date" {
    type = timestamp
    null = true
  }

  column "transaction_count" {
    type = integer
    default = 0
  }

  column "id" {
    type    = uuid
    default = sql("gen_random_uuid()")
  }
  primary_key {
    columns = [column.id]
  }

  column "name" {
    type = text
    null = true
  }

  column "length" {
    type = numeric(10, 2)
    default = 0
  }

  column "width" {
    type = numeric(10, 2)
    default = 0
  }

  column "height" {
    type = numeric(10, 2)
    default = 0
  }

  column "length_tolerance_percent" {
    type = numeric(10, 2)
    default = 0
  }

  column "width_tolerance_percent" {
    type = numeric(10, 2)
    default = 0
  }

  column "height_tolerance_percent" {
    type = numeric(10, 2)
    default = 0
  }

  column "length_tolerance_mm" {
    type = numeric(10, 2)
    default = 0
  }

  column "width_tolerance_mm" {
    type = numeric(10, 2)
    default = 0
  }

  column "height_tolerance_mm" {
    type = numeric(10, 2)
    default = 0
  }

  column "fixed_weight" {
    type = numeric(10, 2)
    null = true
  }

  column "density_per_length_meter" {
    type = numeric(10, 2)
    null = true
  }
}

table "parcel_transport" {
  schema = schema.tenant

  column "created_by" {
    type = text
  }

  column "create_date" {
    type = timestamp
  }

  column "updated_by" {
    type = text
    null = true
  }

  column "update_date" {
    type = timestamp
    null = true
  }

  column "transaction_count" {
    type = integer
    default = 0
  }

  column "id" {
    type    = uuid
    default = sql("gen_random_uuid()")
  }
  primary_key {
    columns = [column.id]
  }

  column "parcel_id" {
    type = uuid
  }

  column "destination_transport_node_id" {
    type = uuid
    null = true
  }

  column "current_transport_node_id" {
    type = uuid
    null = true
  }

  column "status" {
    type = text
    null = true
  }

  foreign_key "parcel_fk" {
    columns     = [column.parcel_id]
    ref_columns = [table.parcel.column.id]
    on_update   = NO_ACTION
    on_delete   = NO_ACTION
  }

  foreign_key "destination_transport_node_fk" {
    columns     = [column.destination_transport_node_id]
    ref_columns = [table.transport_node.column.id]
    on_update   = NO_ACTION
    on_delete   = NO_ACTION
  }

  foreign_key "current_transport_node_fk" {
    columns     = [column.current_transport_node_id]
    ref_columns = [table.transport_node.column.id]
    on_update   = NO_ACTION
    on_delete   = NO_ACTION
  }
}

table "parcel_transport_log" {
  schema = schema.tenant

  column "created_by" {
    type = text
  }

  column "create_date" {
    type = timestamp
  }

  column "updated_by" {
    type = text
    null = true
  }

  column "update_date" {
    type = timestamp
    null = true
  }

  column "transaction_count" {
    type = integer
    default = 0
  }

  column "id" {
    type    = uuid
    default = sql("gen_random_uuid()")
  }
  primary_key {
    columns = [column.id]
  }

  column "action" {
    type = text
    null = true
  }

  column "parcel_id" {
    type = uuid
  }

  column "parcel_transport_id" {
    type = uuid
  }

  column "destination_transport_node_id" {
    type = uuid
    null = true
  }

  column "current_transport_node_id" {
    type = uuid
    null = true
  }

  column "status" {
    type = text
    null = true
  }

  column "details" {
    type = jsonb
    null = true
  }
}

table "parcel_reject_reason" {
  schema = schema.tenant

  column "created_by" {
    type = text
  }

  column "create_date" {
    type = timestamp
  }

  column "updated_by" {
    type = text
    null = true
  }

  column "update_date" {
    type = timestamp
    null = true
  }

  column "transaction_count" {
    type = integer
    default = 0
  }

  column "id" {
    type    = uuid
    default = sql("gen_random_uuid()")
  }
  primary_key {
    columns = [column.id]
  }

  column "parcel_id" {
    type = uuid
  }

  column "reason" {
    type = text
  }

  column "pending" {
    type = boolean
  }

  foreign_key "parcel_fk" {
    columns     = [column.parcel_id]
    ref_columns = [table.parcel.column.id]
    on_update   = NO_ACTION
    on_delete   = NO_ACTION
  }
}


table "event_log" {
  schema = schema.tenant

  column "created_by" {
    type = text
  }

  column "create_date" {
    type = timestamp
  }

  column "updated_by" {
    type = text
    null = true
  }

  column "update_date" {
    type = timestamp
    null = true
  }

  column "transaction_count" {
    type    = integer
    default = 0
  }

  column "id" {
    type = uuid
    default = sql("gen_random_uuid()")
  }

  column "object_id" {
    type = text
  }

  column "type" {
    type = text
  }

  column "pending" {
    type = boolean
  }

  column "severity" {
    type = text
  }

  column "category" {
    type = text
    null = true
  }

  column "sub_category" {
    type = text
    null = true
  }

  column "start_date" {
    type = timestamp
  }

  column "end_date" {
    type = timestamp
    null = true
  }

  column "cleared_by" {
    type = text
    null = true
  }

  column "error_code" {
    type = text
    null = true
  }

  column "description_translation_tag" {
    type = text
    null = true
  }

  column "solution_translation_tag" {
    type = text
    null = true
  }

  column "parameters" {
    type = jsonb
    null = true
  }

  column "source" {
    type = text
    null = true
  }

  primary_key {
    columns = [column.id]
  }
}
