# Check if the spec folder exists
if [ ! -d "./spec/proto/utxorpc/v1alpha/" ]; then
  echo "Error: The directory ./spec/proto/utxorpc/v1alpha/ does not exist."
  exit 1
fi

find ./spec/proto/utxorpc/v1alpha -name \*.proto | xargs protoc --proto_path=./spec/proto \
    --proto_path=./spec/proto/utxorpc \
    --proto_path=./spec/proto/utxorpc/v1alpha \
    --elixir_out=plugins=grpc:./lib
