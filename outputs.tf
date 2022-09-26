output "RgName" {
  value = module.ResourceGroups.rg_name_out
}

output "StgAccName" {
  value = module.StorageAccount.stg_acc_name_out
}

output "object_id" {
  value = data.azuread_client_config.current.object_id
}