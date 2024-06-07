defmodule Utxorpc.V1alpha.Watch.AnyChainTxPattern do
  @moduledoc false

  use Protobuf, syntax: :proto3, protoc_gen_elixir_version: "0.12.0"

  oneof :chain, 0

  field :cardano, 1, type: Utxorpc.V1alpha.Cardano.TxPattern, oneof: 0
end

defmodule Utxorpc.V1alpha.Watch.TxPredicate do
  @moduledoc false

  use Protobuf, syntax: :proto3, protoc_gen_elixir_version: "0.12.0"

  field :match, 1, type: Utxorpc.V1alpha.Watch.AnyChainTxPattern
  field :not, 2, repeated: true, type: Utxorpc.V1alpha.Watch.TxPredicate
  field :all_of, 3, repeated: true, type: Utxorpc.V1alpha.Watch.TxPredicate, json_name: "allOf"
  field :any_of, 4, repeated: true, type: Utxorpc.V1alpha.Watch.TxPredicate, json_name: "anyOf"
end

defmodule Utxorpc.V1alpha.Watch.WatchTxRequest do
  @moduledoc false

  use Protobuf, syntax: :proto3, protoc_gen_elixir_version: "0.12.0"

  field :predicate, 1, type: Utxorpc.V1alpha.Watch.TxPredicate
  field :field_mask, 2, type: Google.Protobuf.FieldMask, json_name: "fieldMask"
end

defmodule Utxorpc.V1alpha.Watch.AnyChainTx do
  @moduledoc false

  use Protobuf, syntax: :proto3, protoc_gen_elixir_version: "0.12.0"

  oneof :chain, 0

  field :cardano, 1, type: Utxorpc.V1alpha.Cardano.Tx, oneof: 0
end

defmodule Utxorpc.V1alpha.Watch.WatchTxResponse do
  @moduledoc false

  use Protobuf, syntax: :proto3, protoc_gen_elixir_version: "0.12.0"

  oneof :action, 0

  field :apply, 1, type: Utxorpc.V1alpha.Watch.AnyChainTx, oneof: 0
  field :undo, 2, type: Utxorpc.V1alpha.Watch.AnyChainTx, oneof: 0
end

defmodule Utxorpc.V1alpha.Watch.WatchService.Service do
  @moduledoc false

  use GRPC.Service,
    name: "utxorpc.v1alpha.watch.WatchService",
    protoc_gen_elixir_version: "0.12.0"

  rpc :WatchTx,
      Utxorpc.V1alpha.Watch.WatchTxRequest,
      stream(Utxorpc.V1alpha.Watch.WatchTxResponse)
end

defmodule Utxorpc.V1alpha.Watch.WatchService.Stub do
  @moduledoc false

  use GRPC.Stub, service: Utxorpc.V1alpha.Watch.WatchService.Service
end