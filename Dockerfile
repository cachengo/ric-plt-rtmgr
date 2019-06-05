#==================================================================================
#   Copyright (c) 2019 AT&T Intellectual Property.
#   Copyright (c) 2019 Nokia
#
#   Licensed under the Apache License, Version 2.0 (the "License");
#   you may not use this file except in compliance with the License.
#   You may obtain a copy of the License at
#
#       http://www.apache.org/licenses/LICENSE-2.0
#
#   Unless required by applicable law or agreed to in writing, software
#   distributed under the License is distributed on an "AS IS" BASIS,
#   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#   See the License for the specific language governing permissions and
#   limitations under the License.
#==================================================================================

# The CI system creates and publishes the rtmgr Docker image
# from the last step in this multi-stage build and applies 
# a Docker tag from the string in file container-tag.yaml

FROM golang:1.12 as rtmgrbuild
ENV GOPATH /opt
RUN apt-get update \
    && apt-get install golang-glide
COPY . /opt
RUN mkdir -p $GOPATH/bin \
    && ln -s -f  $GOPATH/pkg $GOPATH/src \
    && cd $GOPATH/src \
    && glide install --strip-vendor \
    && cd $GOPATH/cmd \
    && go build rtmgr.go \
    && mv $GOPATH/cmd/rtmgr $GOPATH/bin

FROM ubuntu:16.04
COPY --from=rtmgrbuild /opt/bin/rtmgr /
RUN mkdir /db && touch /db/rt.json
CMD /rtmgr