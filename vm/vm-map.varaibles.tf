variable "car" {
  description = "type of vw cars"
  type = map(string)
  default = {
    "audi" = "vwg",
    
  }
}