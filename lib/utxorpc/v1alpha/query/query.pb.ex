defmodule Utxorpc.V1alpha.Query.ChainPoint do
  @moduledoc false

  use Protobuf, syntax: :proto3, protoc_gen_elixir_version: "0.12.0"

  field :slot, 1, type: :uint64
  field :hash, 2, type: :bytes
end

defmodule Utxorpc.V1alpha.Query.TxoRef do
  @moduledoc false

  use Protobuf, syntax: :proto3, protoc_gen_elixir_version: "0.12.0"

  field :hash, 1, type: :bytes
  field :index, 2, type: :uint32
end

defmodule Utxorpc.V1alpha.Query.ReadParamsRequest do
  @moduledoc false

  use Protobuf, syntax: :proto3, protoc_gen_elixir_version: "0.12.0"

  field :field_mask, 1, type: Google.Protobuf.FieldMask, json_name: "fieldMask"
end

defmodule Utxorpc.V1alpha.Query.AnyChainParams do
  @moduledoc false

  use Protobuf, syntax: :proto3, protoc_gen_elixir_version: "0.12.0"

  oneof :params, 0

  field :cardano, 1, type: Utxorpc.V1alpha.Cardano.Params, oneof: 0
end

defmodule Utxorpc.V1alpha.Query.ReadParamsResponse do
  @moduledoc false

  use Protobuf, syntax: :proto3, protoc_gen_elixir_version: "0.12.0"

  field :values, 1, type: Utxorpc.V1alpha.Query.AnyChainParams
  field :ledger_tip, 2, type: Utxorpc.V1alpha.Query.ChainPoint, json_name: "ledgerTip"
end

defmodule Utxorpc.V1alpha.Query.AnyUtxoPattern do
  @moduledoc false

  use Protobuf, syntax: :proto3, protoc_gen_elixir_version: "0.12.0"

  oneof :utxo_pattern, 0

  field :cardano, 1, type: Utxorpc.V1alpha.Cardano.TxOutputPattern, oneof: 0
end

defmodule Utxorpc.V1alpha.Query.UtxoPredicate do
  @moduledoc false

  use Protobuf, syntax: :proto3, protoc_gen_elixir_version: "0.12.0"

  field :match, 1, type: Utxorpc.V1alpha.Query.AnyUtxoPattern
  field :not, 2, repeated: true, type: Utxorpc.V1alpha.Query.UtxoPredicate
  field :all_of, 3, repeated: true, type: Utxorpc.V1alpha.Query.UtxoPredicate, json_name: "allOf"
  field :any_of, 4, repeated: true, type: Utxorpc.V1alpha.Query.UtxoPredicate, json_name: "anyOf"
end

defmodule Utxorpc.V1alpha.Query.AnyUtxoData do
  @moduledoc false

  use Protobuf, syntax: :proto3, protoc_gen_elixir_version: "0.12.0"

  oneof :parsed_state, 0

  field :txo_ref, 1, type: Utxorpc.V1alpha.Query.TxoRef, json_name: "txoRef"
  field :native_bytes, 2, type: :bytes, json_name: "nativeBytes"
  field :cardano, 3, type: Utxorpc.V1alpha.Cardano.TxOutput, oneof: 0
end

defmodule Utxorpc.V1alpha.Query.ReadUtxosRequest do
  @moduledoc false

  use Protobuf, syntax: :proto3, protoc_gen_elixir_version: "0.12.0"

  field :keys, 1, repeated: true, type: Utxorpc.V1alpha.Query.TxoRef
end

defmodule Utxorpc.V1alpha.Query.ReadUtxosResponse do
  @moduledoc false

  use Protobuf, syntax: :proto3, protoc_gen_elixir_version: "0.12.0"

  field :items, 1, repeated: true, type: Utxorpc.V1alpha.Query.AnyUtxoData
  field :ledger_tip, 2, type: Utxorpc.V1alpha.Query.ChainPoint, json_name: "ledgerTip"
end

defmodule Utxorpc.V1alpha.Query.SearchUtxosRequest do
  @moduledoc false

  use Protobuf, syntax: :proto3, protoc_gen_elixir_version: "0.12.0"

  field :predicate, 1, type: Utxorpc.V1alpha.Query.UtxoPredicate
end

defmodule Utxorpc.V1alpha.Query.SearchUtxosResponse do
  @moduledoc false

  use Protobuf, syntax: :proto3, protoc_gen_elixir_version: "0.12.0"

  field :items, 1, repeated: true, type: Utxorpc.V1alpha.Query.AnyUtxoData
  field :ledger_tip, 2, type: Utxorpc.V1alpha.Query.ChainPoint, json_name: "ledgerTip"
end

defmodule Utxorpc.V1alpha.Query.QueryService.Service do
  @moduledoc false

  use GRPC.Service,
    name: "utxorpc.v1alpha.query.QueryService",
    protoc_gen_elixir_version: "0.12.0"

  rpc :ReadParams,
      Utxorpc.V1alpha.Query.ReadParamsRequest,
      Utxorpc.V1alpha.Query.ReadParamsResponse

  rpc :ReadUtxos, Utxorpc.V1alpha.Query.ReadUtxosRequest, Utxorpc.V1alpha.Query.ReadUtxosResponse

  rpc :SearchUtxos,
      Utxorpc.V1alpha.Query.SearchUtxosRequest,
      Utxorpc.V1alpha.Query.SearchUtxosResponse

  rpc :StreamUtxos,
      Utxorpc.V1alpha.Query.ReadUtxosRequest,
      stream(Utxorpc.V1alpha.Query.ReadUtxosResponse)
end

defmodule Utxorpc.V1alpha.Query.QueryService.Stub do
  @moduledoc false

  use GRPC.Stub, service: Utxorpc.V1alpha.Query.QueryService.Service
end