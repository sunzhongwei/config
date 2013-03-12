hg cat $1 | vim - -c  ":vert diffsplit $1" -c "map q :qa!<CR>";
