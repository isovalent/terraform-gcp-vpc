// Copyright 2022 Isovalent, Inc.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

module "main" {
  source  = "terraform-google-modules/network/google"
  version = "9.0.0"

  network_name = var.name
  project_id   = var.project_id
  routing_mode = local.routing_mode

  routes = [
    {
      description       = "Default internet gateway."
      destination_range = "0.0.0.0/0"
      name              = "${var.name}-internet"
      next_hop_internet = "true"
      priority          = 1000
    },
  ]

  subnets = [
    for key, subnet in var.subnets : {
      description   = subnet.description
      subnet_name   = subnet.name
      subnet_ip     = subnet.cidr
      subnet_region = subnet.region
    }
  ]

  secondary_ranges = {
    for key, subnet in var.subnets :
    subnet.name => [
      for key, range in subnet.secondary_ranges : {
        ip_cidr_range = range.cidr
        range_name    = range.name
      }
    ]
  }
}
