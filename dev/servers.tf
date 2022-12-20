module "web-server"{
    source = "../modules/servers"
    name = "web-launch-conf"
 web-image-id = "07651f0c4c315a529 "
instance-type= "t2.micro"
key_name = "key-pair"
web-sg = [lookup(module.front-end-sg.output-sg-id,"web-server",null)]
asg-name = "web-server-asg"
min-size ="2"
desired-size="2"
max-size="2"
target-group= module.front-end-alb.frontend-tg-arn
#instance-profile = 
}

module "app-server"{
    source = "../modules/servers"
    name = "app-launch-conf"
 web-image-id = "07651f0c4c315a529 "
instance-type= "t2.micro"
key_name = "key-pair"
web-sg = [lookup(module.back-end-sg.output-sg-id,"app-server",null)]
asg-name = "web-server-asg"
min-size ="2"
desired-size="2"
max-size="2"
target-group= module.front-end-alb.backend-tg-arn
#instance-profile = 
}



