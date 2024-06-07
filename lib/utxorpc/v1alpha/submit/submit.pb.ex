defmodule Utxorpc.V1alpha.Submit.Stage do
  @moduledoc false

  use Protobuf, enum: true, syntax: :proto3, protoc_gen_elixir_version: "0.12.0"

  field :STAGE_UNSPECIFIED, 0
  field :STAGE_ACKNOWLEDGED, 1
  field :STAGE_MEMPOOL, 2
  field :STAGE_NETWORK, 3
  field :STAGE_CONFIRMED, 4
end

defmodule Utxorpc.V1alpha.Submit.AnyChainTx do
  @moduledoc false

  use Protobuf, syntax: :proto3, protoc_gen_elixir_version: "0.12.0"

  oneof :type, 0

  field :raw, 1, type: :bytes, oneof: 0
end

defmodule Utxorpc.V1alpha.Submit.SubmitTxRequest do
  @moduledoc false

  use Protobuf, syntax: :proto3, protoc_gen_elixir_version: "0.12.0"

  field :tx, 1, repeated: true, type: Utxorpc.V1alpha.Submit.AnyChainTx
end

defmodule Utxorpc.V1alpha.Submit.SubmitTxResponse do
  @moduledoc false

  use Protobuf, syntax: :proto3, protoc_gen_elixir_version: "0.12.0"

  field :ref, 1, repeated: true, type: :bytes
end

defmodule Utxorpc.V1alpha.Submit.TxInMempool do
  @moduledoc false

  use Protobuf, syntax: :proto3, protoc_gen_elixir_version: "0.12.0"

  field :tx, 1, type: Utxorpc.V1alpha.Submit.AnyChainTx
  field :stage, 2, type: Utxorpc.V1alpha.Submit.Stage, enum: true
end

defmodule Utxorpc.V1alpha.Submit.ReadMempoolRequest do
  @moduledoc false

  use Protobuf, syntax: :proto3, protoc_gen_elixir_version: "0.12.0"

  field :tx, 1, repeated: true, type: Utxorpc.V1alpha.Submit.TxInMempool
end

defmodule Utxorpc.V1alpha.Submit.ReadMempoolResponse do
  @moduledoc false

  use Protobuf, syntax: :proto3, protoc_gen_elixir_version: "0.12.0"

  field :stage, 1, repeated: true, type: Utxorpc.V1alpha.Submit.Stage, enum: true
end

defmodule Utxorpc.V1alpha.Submit.WaitForTxRequest do
  @moduledoc false

  use Protobuf, syntax: :proto3, protoc_gen_elixir_version: "0.12.0"

  field :ref, 1, repeated: true, type: :bytes
end

defmodule Utxorpc.V1alpha.Submit.WaitForTxResponse do
  @moduledoc false

  use Protobuf, syntax: :proto3, protoc_gen_elixir_version: "0.12.0"

  field :ref, 1, type: :bytes
  field :stage, 2, type: Utxorpc.V1alpha.Submit.Stage, enum: true
end

defmodule Utxorpc.V1alpha.Submit.AnyChainTxPattern do
  @moduledoc false

  use Protobuf, syntax: :proto3, protoc_gen_elixir_version: "0.12.0"

  oneof :chain, 0

  field :cardano, 1, type: Utxorpc.V1alpha.Cardano.TxPattern, oneof: 0
end

defmodule Utxorpc.V1alpha.Submit.TxPredicate do
  @moduledoc false

  use Protobuf, syntax: :proto3, protoc_gen_elixir_version: "0.12.0"

  field :match, 1, type: Utxorpc.V1alpha.Submit.AnyChainTxPattern
  field :not, 2, repeated: true, type: Utxorpc.V1alpha.Submit.TxPredicate
  field :all_of, 3, repeated: true, type: Utxorpc.V1alpha.Submit.TxPredicate, json_name: "allOf"
  field :any_of, 4, repeated: true, type: Utxorpc.V1alpha.Submit.TxPredicate, json_name: "anyOf"
end

defmodule Utxorpc.V1alpha.Submit.WatchMempoolRequest do
  @moduledoc false

  use Protobuf, syntax: :proto3, protoc_gen_elixir_version: "0.12.0"

  field :predicate, 1, type: Utxorpc.V1alpha.Submit.TxPredicate
  field :field_mask, 2, type: Google.Protobuf.FieldMask, json_name: "fieldMask"
end

defmodule Utxorpc.V1alpha.Submit.WatchMempoolResponse do
  @moduledoc false

  use Protobuf, syntax: :proto3, protoc_gen_elixir_version: "0.12.0"

  field :tx, 1, type: Utxorpc.V1alpha.Submit.TxInMempool
end

defmodule Utxorpc.V1alpha.Submit.SubmitService.Service do
  @moduledoc false

  use GRPC.Service,
    name: "utxorpc.v1alpha.submit.SubmitService",
    protoc_gen_elixir_version: "0.12.0"

  rpc :SubmitTx, Utxorpc.V1alpha.Submit.SubmitTxRequest, Utxorpc.V1alpha.Submit.SubmitTxResponse

  rpc :WaitForTx,
      Utxorpc.V1alpha.Submit.WaitForTxRequest,
      stream(Utxorpc.V1alpha.Submit.WaitForTxResponse)

  rpc :ReadMempool,
      Utxorpc.V1alpha.Submit.ReadMempoolRequest,
      Utxorpc.V1alpha.Submit.ReadMempoolResponse

  rpc :WatchMempool,
      Utxorpc.V1alpha.Submit.WatchMempoolRequest,
      stream(Utxorpc.V1alpha.Submit.WatchMempoolResponse)
end

defmodule Utxorpc.V1alpha.Submit.SubmitService.Stub do
  @moduledoc false

  use GRPC.Stub, service: Utxorpc.V1alpha.Submit.SubmitService.Service
end