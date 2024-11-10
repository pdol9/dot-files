#!/bin/bash

chmod 600 ~/.ssh/id_rs
chmod 600 ~/.ssh/id_rsa

ssh-add ~/.ssh/id_rs
ssh-add ~/.ssh/id_rsa
