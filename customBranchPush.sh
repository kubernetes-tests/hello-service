#!/bin/bash
git branch <br-name>
git checkout <br-name>
git add *
git commit -m "Commit from shell script"
git pull
git push origin <br-name>