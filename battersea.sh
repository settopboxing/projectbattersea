#!/bin/bash

BITRATEV=2600000
BITRATEA=128000
BITRATEVTS=3000000
BITRATEATS=188000
BUFFERSZ=1835008
BITRATE=0
XMLPATH=NONE
NID=0

export HACKRFSERIAL=00000000

ADDPARAMS=""

PLATFORMS=("ONdigital" "Virgin (Samsung)" "NTL (CR1/CR3)")

echo ""
echo "projectbattersea transmission lab"
echo ""
PS3="Please select a platform: "
select platform in "${PLATFORMS[@]}"; do
	case $platform in
		"ONdigital")
			echo "ONdigital Transmission:"
			BITRATE=24128342 # ONdigital 64QAM 2K 2/3 FEC
			XMLPATH=ondigital
			ADDPARAMS="-P timeref --add 3600"
			break
			;;
		"Virgin (Samsung)")
			echo "Virgin Transmission (Samsung SMT-2100C compatible):"
			BITRATE=38440471 # NTL 64QAM
			XMLPATH=virgin-samsung
			read -p "Please enter a network ID: " NID
			break
			;;
		"NTL (CR1/CR3)")
			echo "NTL Transmission (CR1/CR3 compatible - no video):"
			BITRATE=38440471 # NTL 64QAM
			XMLPATH=ntl-cr1
			read -p "Please enter a network ID: " NID
			break
			;;
	esac
done

PCR_PER_SEC=5
PCR_DISTANCE=$(( $BITRATE / $(( $PCR_PER_SEC * 188 * 8 )) ))
PCR_PID=5004

echo "PCR distance is $PCR_DISTANCE"

MUXCONTENTS=""

mkfifo ./videolive/livetrans.ts

echo ""
echo "Reading configuration..."

while IFS= read -r line
do
	set -- $line
	if [ "$1" != "#" ]
	then
		MUXCONTENTS="${MUXCONTENTS} -P inject --poll-files --eit-normalization ./$XMLPATH/$1.$3 --pid $1 --bitrate $2 -s -f "
	fi
done < "./$XMLPATH/streams.conf"

echo "Configuration read."
echo ""

echo "Starting muxer..."
tsp --verbose --bitrate $BITRATE --buffer-size-mb 128 \
-I null \
-P filter --max-payload-size 0 --negate -s \
-P regulate --bitrate $BITRATE \
-P merge 'tsp -I ip 224.0.0.1:1234' --incremental-pcr-restamp --no-smoothing \
-P merge 'tsp -I ip 224.0.0.1:1235' --incremental-pcr-restamp --no-smoothing \
-P merge 'tsp -I ip 224.0.0.1:1236' --incremental-pcr-restamp --no-smoothing \
-P filter --negate -p 0 -s \
-P filter --negate -p 16 -s \
-P filter --negate -p 17 -s \
-P filter --negate -p 1000 -s \
-P filter --negate -p 2000 -s \
-P filter --negate -p 3000 -s \
${MUXCONTENTS} \
-P inject --poll-files --eit-normalization ./common/eit.xml --pid 0x0012 --bitrate 15000 -s -f \
-P inject ./common/tot.xml --pid 0x0014 --bitrate 1500 -s -f \
-P nit --network-id $NID \
-P timeref --start system --local-time-offset 60 $ADDPARAMS \
-O file ./videolive/livetrans.ts &

echo "Starting modulator..."
./$XMLPATH/tx.py 

# End of script
echo "Done."

