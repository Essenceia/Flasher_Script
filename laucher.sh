#!/bin/bash
echo -e '\033[0;31m'
echo -e "Notice d'utilisations :
pour changer les paramettre ecrire les paths a la suite
de l'appelle au script dans l'ordre specifiez :

1 - path vers .elf
2 - workspace
3 - board
4 - interace de flashage
5 - lines vers les server gbd ici OpenOCD \n
Remarque : il n'est pas obliger de remplir les paramettres mais
si vous voulez modifer le 3eme il vous faudra remplir 1 et 2 ect ... "
if [ $# -ne 5 ]; then
  serverpath='opt/Atollic_TrueSTUDIO_for_ARM_7.0.1/Servers/openocd/0.10.0-201610281609-dev'
else
  serverpath=$5
fi
if [ $# -ne 4 ]; then
  link='stlink-v2-1'
else
  link=$4
fi
if [ $# -ne 3 ]; then
  target='stm32f4discovery'
else
  target=$3
fi
if [ $# -ne 2 ]; then
  workspace='/home/pooki/Documents/code/Mips'
else
  workspace=$2
fi
if [ $# -ne 1 ]; then
  prog='STM32PMSMFOCLIB/Web/Project/AC6/STM32F4xx_UserProject/STM324xG-EVAL/STM32F4xx_UserProject'
else
  prog=$1
fi
echo $'\n'
echo -e '\033[0;33m'
echo "***************LINUX C EST MIEUX QUE WINDOWS***********************"
echo $'\n\n'
echo "CONFIGURATIONS PATH"
echo $'\n'
echo "Workspace :  $workspace"
echo "Liens vers le resultat de la compilation : $prog"
echo "Path vers OpenOCD : $serverpath"
echo "Model du linker choisi : $link"
echo "Model de la board : $target"
echo $'\n\n\n\n\n'
cd /
echo "Conversion du .elf en .bin afin de compiler"
arm-none-eabi-objcopy -O binary $workspace/$prog.elf $workspace/$prog.bin
echo $'\n\n\n'
echo "Lancement de la procedure de flashage"
echo -e '\033[0m'
$serverpath/bin/openocd -f $serverpath/scripts/interface/$link.cfg -f $serverpath/scripts/board/$target.cfg -c "program $workspace/$prog.bin verify reset exit"
echo $'\n\n'
echo -e '\033[0;32m'
echo "programmation terminer"
echo -e '\033[0m'
