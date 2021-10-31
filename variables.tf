variable "cidr_ip"{
    type= string
    description = "enter the ip range"
   
}
variable "publicsubnet"{
    type= string
    description = "enter the public subnet range"
   
}
variable "privatesubnet"{
    type= string
    description = "enter the private subnet range"
   
}
variable "VPCNAME" {
    type= string
    description = "enter the vpc name"

}

variable "internetgateway" {
    type= string
    description = "enter the gateway name"
    
}

variable "elasticip" {
    type= string
    description = "enter the elasticip name"
    
}
