#!/bin/bash

tar -c $1 | pigz > $1.tar.gz
