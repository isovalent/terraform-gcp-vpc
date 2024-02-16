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

variable "name" {
  description = "The name of the VPC."
  type        = string
}

variable "project_id" {
  description = "The ID of the project in which to create the VPC."
  type        = string
}

variable "mtu" {
  default     = 1460
  description = "mtu value for vpc"
}
variable "subnets" {
  description = "The list of subnets to create."
  type = list(object({
    cidr        = string
    description = string
    name        = string
    region      = string
    secondary_ranges = list(object({
      cidr = string
      name = string
    }))
  }))
}
