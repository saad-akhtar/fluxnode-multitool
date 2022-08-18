#!/bin/bash

source /dev/stdin <<< "$(curl -s https://raw.githubusercontent.com/RunOnFlux/fluxnode-multitool/${ROOT_BRANCH}/flux_common.sh)"

rand_by_domain=("5" "6" "7" "8" "9" "10" "11" "12")
size_list=()
i=0
len=${#rand_by_domain[@]}
echo -e ""
echo -e "${YELLOW}Running quick download speed test for flux_explorer_bootstrap...${NC}"
while [ $i -lt $len ];
do
    testing=$(curl -m 4 http://cdn-${rand_by_domain[$i]}.runonflux.io/apps/fluxshare/getfile/flux_explorer_bootstrap.tar.gz  --output testspeed -fail --silent --show-error 2>&1)
    testing_size=$(grep -Po "\d+" <<< "$testing" | paste - - - - | awk '{printf  "%d\n",$3}')
    mb=$(bc <<<"scale=2; $testing_size / 1048576 / 4" | awk '{printf "%2.2f\n", $1}')
    echo -e "  ${RIGHT_ANGLE} ${GREEN}cdn-${YELLOW}${rand_by_domain[$i]}${GREEN} - Bits Downloaded: ${YELLOW}$testing_size${NC} ${GREEN}Average speed: ${YELLOW}$mb ${GREEN}MB/s${NC}"
    size_list+=($testing_size)
    i=$(($i+1))
done

sudo rm -rf testspeed > /dev/null 2>&1

arr_max=$(printf '%s\n' "${size_list[@]}" | sort -n | tail -1)
for i in "${!size_list[@]}"; do
    [[ "${size_list[i]}" == "$arr_max" ]] &&
    max_indexes+=($i)
done

BOOTSTRAP_URL="http://cdn-${rand_by_domain[${max_indexes[@]}]}.runonflux.io/apps/fluxshare/getfile/flux_explorer_bootstrap.tar.gz"
BOOTSTRAP_URL=$bestServer

# Print the results
mb=$(bc <<<"scale=2; $arr_max / 1048576 / 4" | awk '{printf "%2.2f\n", $1}')
echo -e ""
echo -e "${YELLOW}Best server is: ${GREEN}cdn-${YELLOW}${rand_by_domain[${max_indexes[0]}]} ${GREEN}Average speed: ${YELLOW}$mb ${GREEN}MB/s${NC}"
echo -e "${CHECK_MARK} ${GREEN}Fastest Server: ${YELLOW}$BOOTSTRAP_URL${NC}"
echo -e ""
