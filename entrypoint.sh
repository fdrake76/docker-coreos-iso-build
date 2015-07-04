#!/bin/sh

INPUT_DIR="/input"
OUTPUT_DIR="/output"

# Arg parse
while [[ $# > 0 ]]
do
key="$1"
case $key in
    -h|--help)
    echo "Mount volumes:"
    echo "  /input: Directory containing the config YML file.  Only the first file in the directory is used."
    echo "  /output: Directory containing the resulting ISO file, using the YML file's filename."
    echo ""
    echo "Example:"
    echo "  docker -it --rm run -v /Users/bob/coreos-config/files:/input -v /Users/bob/coreos-config/iso:/output coreos-iso-build:latest"
    exit 0
    ;;
    *)
            # unknown option
    ;;
esac
shift # past argument or value
done

if [ ! -d "$INPUT_DIR" ]; then
    echo "Input directory $INPUT_DIR not found.  Did you forget to mount it as a volume?"
    exit 1
fi
if [ ! -d "$OUTPUT_DIR" ]; then
    echo "Output directory $OUTPUT_DIR not found.  Did you forget to mount it as a volume?"
    exit 1
fi

FILE=`ls $INPUT_DIR | sort -n | head -1`
ISONAME=$(basename "$FILE")
ISONAME="${ISONAME%.*}"

mkdir -p /tmp/config-drive/openstack/latest
cp "$INPUT_DIR/$FILE" /tmp/config-drive/openstack/latest
echo "Creating ISO file $ISONAME.iso for file $FILE"
mkisofs -R -V config-2 -o /output/$ISONAME.iso /tmp/config-drive
