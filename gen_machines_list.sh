#!/bin/bash

docker ps --format '{{ .Names }}' | awk '/shad/ && /node/' > machines

HEAD_NODE=$(docker ps --format '{{ .Names }}' | awk '/shad/ && /head/')

docker cp machines $HEAD_NODE:/home/tutorial/machines
