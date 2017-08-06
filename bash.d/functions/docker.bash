# # ----------------------------------------------------------------------------
# #  BASH: Functions - Docker
# #  $Id$
# # ----------------------------------------------------------------------------
# # ::::::::::::::::::::::::::::::: vim: set noai noet ru nu ml ts=4 sw=4 tw=0:
# # ----------------------------------------------------------------------------
# nbe_msg "${icon[child]} Docker Helper" ${BASH_SOURCE}

# # 
# # Reload Default Docker Environment
# # 
# function reloaddocker() 
# {
# 	if [[ $(which docker-machine) ]]; 
# 	then
# 	    if [[ $(docker-machine status default) == "Running" ]]; 
# 	    then
# 	        eval $(docker-machine env default)
# 	    fi
# 	fi
# }

# function docker-reset-hard() 
# {
# 	docker-machine restart default && \
# 	eval "$(docker-machine env default)" && \
# 	yes | docker-machine regenerate-certs default
# }


# # Docker compose
# function dc() 
# {
# 	docker-compose "$@"
# }

# # Docker machine
# function dm() 
# {
# 	docker-machine "$@"
# }

# # Docker native
# function dn() 
# {
# 	unset ${!DOCKER_*}
# }

# # Docker machine environment switch
# function dme() 
# {
# 	if [ $# -eq 0 ]; 
# 	then
# 		eval $(docker-machine env)
# 	else
# 		eval $(docker-machine env $1)
# 	fi
# }

# # List of all containers
# function dps() 
# {
# 	docker ps -a
# }

# # Delete exited conntainers and all dangling images
# function drm() 
# {
# 	docker rm -v $(docker ps --filter status=exited -q 2>/dev/null) 2>/dev/null
# 	docker rmi $(docker images --filter dangling=true -q 2>/dev/null) 2>/dev/null
# }

# # Delete exited conntainers, all dangling images and volumes
# function dclean() 
# {
# 	drm
# 	docker volume rm $(docker volume ls -q -f dangling=true) 2>/dev/null
# }

# # Search in docker hub repository
# function dhub() 
# {
# 	if [ "$1" == "-o" ]; then
#     open "https://hub.docker.com/search/?isAutomated=0&isOfficial=0&page=1&pullCount=0&starCount=0&q=$2"
# 	else
# 		http -b "https://hub.docker.com/v2/search/repositories/" query=="$@"
# 	fi
# }

# # Docker Bench for Security
# function dsec() 
# {
# 	docker run --rm -it --net host --pid host --cap-add audit_control \
#     -v /var/lib:/var/lib \
#     -v /var/run/docker.sock:/var/run/docker.sock \
#     -v /usr/lib/systemd:/usr/lib/systemd \
#     -v /etc:/etc --label docker_bench_security \
#     docker/docker-bench-security
# }

# ### Container aliases

# # Alpine container for testing purpose
# function alpine() 
# {
# 	docker run --rm -it alpine:latest sh
# }

# # Debian container for testing purpose
# function debian() 
# {
# 	docker run --rm -it debian:latest bash
# }

# # Ubuntu container for testing purpose
# function ubuntu() 
# {
# 	docker run --rm -it ubuntu:latest bash
# }

# # cURL with HTTP/2 support
# function curl() 
# {
# 	docker run --rm -t --net=host -v $PWD:/$PWD:ro -w $PWD svagi/curl "$@"
# }

# # HTTPie
# function http() 
# {
# 	docker run --rm -t --net=host -v $PWD:/$PWD:ro -w $PWD jess/httpie "$@"
# }

# # HTTPie with HTTP/2 support
# function http2() 
# {
# 	docker run --rm -t --net=host -v $PWD:/$PWD:ro -w $PWD svagi/httpie "$@"
# }

# # Python
# function python() 
# {
# 	docker run --rm -it python:alpine "$@"
# }

# # LaTex
# function latex() 
# {
# 	docker run --rm -i -v $PWD:/tmp -w /tmp svagi/latex-tul xelatex "$@"
# }

# # Apache Benchmark
# function ab() 
# {
# 	docker run --rm -t --net=host svagi/ab "$@"
# }

# # h2load benchmark
# function h2load() 
# {
# 	docker run --rm -t --net=host svagi/h2load "$@"
# }

# # nghttp - HTTP/2 client
# function nghttp() 
# {
# 	docker run --rm -t svagi/nghttp2 nghttp "$@"
# }

# # Speedtest
# function speedtest() 
# {
# 	docker run --rm --net=host tianon/speedtest "$@"
# }

# # AWS
# function aws() 
# {
# 	docker run --rm -it -v ~/.aws:/root/.aws cgswong/aws aws "$@"
# }