defmodule Utxorpc.V1alpha.Sync.BlockRef do
  @moduledoc false

  use Protobuf, syntax: :proto3, protoc_gen_elixir_version: "0.12.0"

  field :index, 1, type: :uint64
  field :hash, 2, type: :bytes
end

defmodule Utxorpc.V1alpha.Sync.AnyChainBlock do
  @moduledoc false

  use Protobuf, syntax: :proto3, protoc_gen_elixir_version: "0.12.0"

  oneof :chain, 0

  field :raw, 1, type: :bytes, oneof: 0
  field :cardano, 2, type: Utxorpc.V1alpha.Cardano.Block, oneof: 0
end

defmodule Utxorpc.V1alpha.Sync.FetchBlockRequest do
  @moduledoc false

  use Protobuf, syntax: :proto3, protoc_gen_elixir_version: "0.12.0"

  field :ref, 1, repeated: true, type: Utxorpc.V1alpha.Sync.BlockRef
  field :field_mask, 2, type: Google.Protobuf.FieldMask, json_name: "fieldMask"
end

defmodule Utxorpc.V1alpha.Sync.FetchBlockResponse do
  @moduledoc false

  use Protobuf, syntax: :proto3, protoc_gen_elixir_version: "0.12.0"

  field :block, 1, repeated: true, type: Utxorpc.V1alpha.Sync.AnyChainBlock
end

defmodule Utxorpc.V1alpha.Sync.DumpHistoryRequest do
  @moduledoc false

  use Protobuf, syntax: :proto3, protoc_gen_elixir_version: "0.12.0"

  field :start_token, 2, type: Utxorpc.V1alpha.Sync.BlockRef, json_name: "startToken"
  field :max_items, 3, type: :uint32, json_name: "maxItems"
  field :field_mask, 4, type: Google.Protobuf.FieldMask, json_name: "fieldMask"
end

defmodule Utxorpc.V1alpha.Sync.DumpHistoryResponse do
  @moduledoc false

  use Protobuf, syntax: :proto3, protoc_gen_elixir_version: "0.12.0"

  field :block, 1, repeated: true, type: Utxorpc.V1alpha.Sync.AnyChainBlock
  field :next_token, 2, type: Utxorpc.V1alpha.Sync.BlockRef, json_name: "nextToken"
end

defmodule Utxorpc.V1alpha.Sync.FollowTipRequest do
  @moduledoc false

  use Protobuf, syntax: :proto3, protoc_gen_elixir_version: "0.12.0"

  field :intersect, 1, repeated: true, type: Utxorpc.V1alpha.Sync.BlockRef
end

defmodule Utxorpc.V1alpha.Sync.FollowTipResponse do
  @moduledoc false

  use Protobuf, syntax: :proto3, protoc_gen_elixir_version: "0.12.0"

  oneof :action, 0

  field :apply, 1, type: Utxorpc.V1alpha.Sync.AnyChainBlock, oneof: 0
  field :undo, 2, type: Utxorpc.V1alpha.Sync.AnyChainBlock, oneof: 0
  field :reset, 3, type: Utxorpc.V1alpha.Sync.BlockRef, oneof: 0
end

defmodule Utxorpc.V1alpha.Sync.ChainSyncService.Service do
  @moduledoc false

  use GRPC.Service,
    name: "utxorpc.v1alpha.sync.ChainSyncService",
    protoc_gen_elixir_version: "0.12.0"

  rpc :FetchBlock, Utxorpc.V1alpha.Sync.FetchBlockRequest, Utxorpc.V1alpha.Sync.FetchBlockResponse

  rpc :DumpHistory,
      Utxorpc.V1alpha.Sync.DumpHistoryRequest,
      Utxorpc.V1alpha.Sync.DumpHistoryResponse

  rpc :FollowTip,
      Utxorpc.V1alpha.Sync.FollowTipRequest,
      stream(Utxorpc.V1alpha.Sync.FollowTipResponse)
end

defmodule Utxorpc.V1alpha.Sync.ChainSyncService.Stub do
  @moduledoc false

  use GRPC.Stub, service: Utxorpc.V1alpha.Sync.ChainSyncService.Service
end