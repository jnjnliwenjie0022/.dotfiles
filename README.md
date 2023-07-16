# .dotfiles

https://www.notion.so/tnvim_workflow-d885d9ff0f2049e4b9ea04e6002b2701#107e22b24f9b4ee9b2be2daf213d0892
```
##ssh
ssh-keygen -t rsa -b 4096 -C "https://github.com/jnjnliwenjie0022"
Enter
Enter
Enter
eval "$(ssh-agent -s)"
ssh-add -k ~/.ssh/id_rsa

#copy ssh key to github(https://github.com/jnjnliwenjie0022) from ~/.ssh/id_rsa.pub
```
```
##git
git init
git remote add origin git@github.com:jnjnliwenjie0022/.dotfiles.git
git pull git@github.com:jnjnliwenjie0022/.dotfiles.git master
git push --set-upstream origin master
```
```
##AppImage
1. --appimage-extract and amend the AppRun file
2. installed libfuse2
https://github.com/AppImage/AppImageKit/wiki/FUSE
```
