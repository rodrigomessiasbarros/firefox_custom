#!/bin/bash

## Script personalização do Firefox
# 
# Author: Rodrigo Messias Barros <rodrigomessiasbarros@gmail.com>
#
# Date: 2021-05-08 - 22:58:45
# 
# Este script tem por finalidade personalizar o Firefox com opções de rolagem
# suave (smooth scroll) e habilitar a renderização por GPU.
# 
# Documentação utilizada como referência:   
# https://averagelinuxuser.com/firefox-smooth-scrolling/
# 
# 

# Configurações que serão adicionadas caso não existam no arquivo user.js
cf1="user_pref(\"general.smoothScroll.mouseWheel.durationMaxMS\", 600);"
cf2="user_pref(\"general.smoothScroll.mouseWheel.durationMinMS\", 400);"
cf3="user_pref(\"mousewheel.min_line_scroll_amount\", 100);"
cf4="user_pref(\"dom.webgpu.enabled\", true);"
cf5="user_pref(\"layers.gpu-process.enabled\", true);"
cf6="user_pref(\"media.gpu-process-decoder\", true);"

# Crio as variáveis necessárias para personalização
MOZ_DIR=$HOME/.mozilla/firefox/
USER_JS=user.js

# Acessando o diretório do Firefox
cd $MOZ_DIR

# Obtendo o diretório padrão utilizado pelo usuário
USER_PROFILE=$(cat profiles.ini | grep Default | grep release | cut -d"=" -f2)
cd $USER_PROFILE

echo "---------------------------------------START AT $(date +"%Y-%m-%d %H:%M:%S")-----------------------------------------" >> $HOME/.fc_custom.log

if [ -f $USER_JS ]
then
   echo $(date '+%Y-%m-%d %H:%M:%S') "- user.js existe" >> $HOME/.fc_custom.log
   # Faço backup do arquivo 'user.js'existente
   now=$(date +"%Y%m%d%H%M%S")
   filename=bkp_user.$now.js
   echo $filename
   cp $USER_JS $filename
   echo $(date '+%Y-%m-%d %H:%M:%S') "- Backup realizado. Filename: $filename" >> $HOME/.fc_custom.log
else
   # Se o arquivo 'user.js' não existir, crio um vazio.
   echo $(date '+%Y-%m-%d %H:%M:%S') "- user.js não existe. Criando um vazio." >> $HOME/.fc_custom.log
   touch $USER_JS
fi

# Verifico se as configurações já existem no 'user.js' se existir conf$ terá conteúdo maior que zero
conf1=$(egrep -e "user_pref\(\"general.smoothScroll.mouseWheel.durationMaxMS\", 600\);" $USER_JS)
conf2=$(egrep -e "user_pref\(\"general.smoothScroll.mouseWheel.durationMinMS\", 400\);" $USER_JS)
conf3=$(egrep -e "user_pref\(\"mousewheel.min_line_scroll_amount\", 100\);" $USER_JS)
conf4=$(egrep -e "user_pref\(\"dom.webgpu.enabled\", true\);" $USER_JS)
conf5=$(egrep -e "user_pref\(\"layers.gpu-process.enabled\", true\);" $USER_JS)
conf6=$(egrep -e "user_pref\(\"media.gpu-process-decoder\", true\);" $USER_JS)

# Essa validação é necessária para o caso de alguma linha já existir com as configurações corretas
# e assim evitar duplicidade de linhas. A duplicidade não atrapalha o funcionamento do Firefox
# mas faço o controle mesmo assim, excesso de zelo.
# TODO: fazer a troca das variáveis através do sed para evitar linhas duplicadas com valores diferentes
if [ ${#conf1} -gt 0 ]
then
   echo $(date '+%Y-%m-%d %H:%M:%S') "- Achei a configuração => $cf1" >> $HOME/.fc_custom.log
else
   echo $(date '+%Y-%m-%d %H:%M:%S') "- Não achei a configuração => $cf1" >> $HOME/.fc_custom.log
   echo $cf1 >> $USER_JS
fi

if [ ${#conf2} -gt 0 ]
then
   echo $(date '+%Y-%m-%d %H:%M:%S') "- Achei a configuração => $cf2" >> $HOME/.fc_custom.log
else
   echo $(date '+%Y-%m-%d %H:%M:%S') "- Não achei a configuração => $cf2" >> $HOME/.fc_custom.log
   echo $cf2 >> $USER_JS
fi

if [ ${#conf3} -gt 0 ]
then
   echo $(date '+%Y-%m-%d %H:%M:%S') "- Achei a configuração => $cf3" >> $HOME/.fc_custom.log
else
   echo $(date '+%Y-%m-%d %H:%M:%S') "- Não achei a configuração => $cf3" >> $HOME/.fc_custom.log
   echo $cf3 >> $USER_JS
fi

if [ ${#conf4} -gt 0 ]
then
   echo $(date '+%Y-%m-%d %H:%M:%S') "- Achei a configuração => $cf4" >> $HOME/.fc_custom.log
else
   echo $(date '+%Y-%m-%d %H:%M:%S') "- Não achei a configuração => $cf4" >> $HOME/.fc_custom.log
   echo $cf4 >> $USER_JS
fi

if [ ${#conf5} -gt 0 ]
then
   echo $(date '+%Y-%m-%d %H:%M:%S') "- Achei a configuração => $cf5" >> $HOME/.fc_custom.log
else
   echo $(date '+%Y-%m-%d %H:%M:%S') "- Não achei a configuração => $cf5" >> $HOME/.fc_custom.log
   echo $cf5 >> $USER_JS
fi

if [ ${#conf6} -gt 0 ]
then
   echo $(date '+%Y-%m-%d %H:%M:%S') "- Achei a configuração => $cf6" >> $HOME/.fc_custom.log
else
   echo $(date '+%Y-%m-%d %H:%M:%S') "- Não achei a configuração => $cf6" >> $HOME/.fc_custom.log
   echo $cf6 >> $USER_JS
fi

echo "-------------------------------------FINISHED AT $(date +"%Y-%m-%d %H:%M:%S")----------------------------------------" >> $HOME/.fc_custom.log
