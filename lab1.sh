#!/bin/bash

SOURCE_DIR=${1:-lab_uno}
RM_LIST=${2:-2remove}
TARGET_DIR=${3:-bakap}

if [[ -e "${TARGET_DIR}" ]] ; then
    rm -rd ${TARGET_DIR}
fi

if [[ -e "${SOURCE_DIR}" ]] ; then
    rm -rd ${SOURCE_DIR}
fi

if [[ -e "${TARGET_DIR}" ]] ; then
    echo "${TARGET_DIR} juz istnieje"
else
    mkdir ${TARGET_DIR}
fi

./kanai-cube.sh ${SOURCE_DIR}

cd ./${SOURCE_DIR}

ITEMS=$(cat ${RM_LIST})

for ITEM in ${ITEMS} ; do
    if [[ -d "${ITEM}" ]] ; then
        rm -rd ${ITEM}
    else if [[ -f "${ITEM}" ]] ; then
        rm ${ITEM}
        fi
    fi
done

find . -maxdepth 1 -type f -print0 | xargs -0 mv -t ../${TARGET_DIR}

find . -maxdepth 1 -type d -print0 | xargs -0 cp -r -t ../${TARGET_DIR}

COUNT=$(find . -type f | wc -l)

if [[ "${COUNT}" -ne 0 ]] ; then
    echo "jeszcze cos zostalo"
    if [[ "${COUNT}" -ge 2 ]] ; then
        echo "zostaly co najmniej 2 pliki"
        if [[ "${COUNT}" -gt 4 ]] ; then
            echo "zostaly wiecej niz 4 pliki"
        else
            echo "cos tam"
        fi
    fi
else
    echo "tu byl Kononowicz"
fi

cd ..

if [[ -e "bakap_$(date +"%Y-%m-%d").zip" ]] ; then
    rm bakap_$(date +"%Y-%m-%d").zip
fi

zip -r "bakap_$(date +"%Y-%m-%d").zip" ${TARGET_DIR}