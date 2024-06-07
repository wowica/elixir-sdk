defmodule Utxorpc.V1alpha.Cardano.RedeemerPurpose do
  @moduledoc false

  use Protobuf, enum: true, syntax: :proto3, protoc_gen_elixir_version: "0.12.0"

  field :REDEEMER_PURPOSE_UNSPECIFIED, 0
  field :REDEEMER_PURPOSE_SPEND, 1
  field :REDEEMER_PURPOSE_MINT, 2
  field :REDEEMER_PURPOSE_CERT, 3
  field :REDEEMER_PURPOSE_REWARD, 4
end

defmodule Utxorpc.V1alpha.Cardano.MirSource do
  @moduledoc false

  use Protobuf, enum: true, syntax: :proto3, protoc_gen_elixir_version: "0.12.0"

  field :MIR_SOURCE_UNSPECIFIED, 0
  field :MIR_SOURCE_RESERVES, 1
  field :MIR_SOURCE_TREASURY, 2
end

defmodule Utxorpc.V1alpha.Cardano.Redeemer do
  @moduledoc false

  use Protobuf, syntax: :proto3, protoc_gen_elixir_version: "0.12.0"

  field :purpose, 1, type: Utxorpc.V1alpha.Cardano.RedeemerPurpose, enum: true
  field :datum, 2, type: Utxorpc.V1alpha.Cardano.PlutusData
end

defmodule Utxorpc.V1alpha.Cardano.TxInput do
  @moduledoc false

  use Protobuf, syntax: :proto3, protoc_gen_elixir_version: "0.12.0"

  field :tx_hash, 1, type: :bytes, json_name: "txHash"
  field :output_index, 2, type: :uint32, json_name: "outputIndex"
  field :as_output, 3, type: Utxorpc.V1alpha.Cardano.TxOutput, json_name: "asOutput"
  field :redeemer, 4, type: Utxorpc.V1alpha.Cardano.Redeemer
end

defmodule Utxorpc.V1alpha.Cardano.TxOutput do
  @moduledoc false

  use Protobuf, syntax: :proto3, protoc_gen_elixir_version: "0.12.0"

  field :address, 1, type: :bytes
  field :coin, 2, type: :uint64
  field :assets, 3, repeated: true, type: Utxorpc.V1alpha.Cardano.Multiasset
  field :datum, 4, type: Utxorpc.V1alpha.Cardano.PlutusData
  field :datum_hash, 5, type: :bytes, json_name: "datumHash"
  field :script, 6, type: Utxorpc.V1alpha.Cardano.Script
end

defmodule Utxorpc.V1alpha.Cardano.Asset do
  @moduledoc false

  use Protobuf, syntax: :proto3, protoc_gen_elixir_version: "0.12.0"

  field :name, 1, type: :bytes
  field :output_coin, 2, type: :uint64, json_name: "outputCoin"
  field :mint_coin, 3, type: :int64, json_name: "mintCoin"
end

defmodule Utxorpc.V1alpha.Cardano.Multiasset do
  @moduledoc false

  use Protobuf, syntax: :proto3, protoc_gen_elixir_version: "0.12.0"

  field :policy_id, 1, type: :bytes, json_name: "policyId"
  field :assets, 2, repeated: true, type: Utxorpc.V1alpha.Cardano.Asset
end

defmodule Utxorpc.V1alpha.Cardano.TxValidity do
  @moduledoc false

  use Protobuf, syntax: :proto3, protoc_gen_elixir_version: "0.12.0"

  field :start, 1, type: :uint64
  field :ttl, 2, type: :uint64
end

defmodule Utxorpc.V1alpha.Cardano.Collateral do
  @moduledoc false

  use Protobuf, syntax: :proto3, protoc_gen_elixir_version: "0.12.0"

  field :collateral, 1, repeated: true, type: Utxorpc.V1alpha.Cardano.TxInput

  field :collateral_return, 2,
    type: Utxorpc.V1alpha.Cardano.TxOutput,
    json_name: "collateralReturn"

  field :total_collateral, 3, type: :uint64, json_name: "totalCollateral"
end

defmodule Utxorpc.V1alpha.Cardano.Withdrawal do
  @moduledoc false

  use Protobuf, syntax: :proto3, protoc_gen_elixir_version: "0.12.0"

  field :reward_account, 1, type: :bytes, json_name: "rewardAccount"
  field :coin, 2, type: :uint64
end

defmodule Utxorpc.V1alpha.Cardano.WitnessSet do
  @moduledoc false

  use Protobuf, syntax: :proto3, protoc_gen_elixir_version: "0.12.0"

  field :vkeywitness, 1, repeated: true, type: Utxorpc.V1alpha.Cardano.VKeyWitness
  field :script, 2, repeated: true, type: Utxorpc.V1alpha.Cardano.Script

  field :plutus_datums, 3,
    repeated: true,
    type: Utxorpc.V1alpha.Cardano.PlutusData,
    json_name: "plutusDatums"
end

defmodule Utxorpc.V1alpha.Cardano.AuxData do
  @moduledoc false

  use Protobuf, syntax: :proto3, protoc_gen_elixir_version: "0.12.0"

  field :metadata, 1, repeated: true, type: Utxorpc.V1alpha.Cardano.Metadata
  field :scripts, 2, repeated: true, type: Utxorpc.V1alpha.Cardano.Script
end

defmodule Utxorpc.V1alpha.Cardano.Tx do
  @moduledoc false

  use Protobuf, syntax: :proto3, protoc_gen_elixir_version: "0.12.0"

  field :inputs, 1, repeated: true, type: Utxorpc.V1alpha.Cardano.TxInput
  field :outputs, 2, repeated: true, type: Utxorpc.V1alpha.Cardano.TxOutput
  field :certificates, 3, repeated: true, type: Utxorpc.V1alpha.Cardano.Certificate
  field :withdrawals, 4, repeated: true, type: Utxorpc.V1alpha.Cardano.Withdrawal
  field :mint, 5, repeated: true, type: Utxorpc.V1alpha.Cardano.Multiasset

  field :reference_inputs, 6,
    repeated: true,
    type: Utxorpc.V1alpha.Cardano.TxInput,
    json_name: "referenceInputs"

  field :witnesses, 7, type: Utxorpc.V1alpha.Cardano.WitnessSet
  field :collateral, 8, type: Utxorpc.V1alpha.Cardano.Collateral
  field :fee, 9, type: :uint64
  field :validity, 10, type: Utxorpc.V1alpha.Cardano.TxValidity
  field :successful, 11, type: :bool
  field :auxiliary, 12, type: Utxorpc.V1alpha.Cardano.AuxData
  field :hash, 13, type: :bytes
end

defmodule Utxorpc.V1alpha.Cardano.BlockHeader do
  @moduledoc false

  use Protobuf, syntax: :proto3, protoc_gen_elixir_version: "0.12.0"

  field :slot, 1, type: :uint64
  field :hash, 2, type: :bytes
  field :height, 3, type: :uint64
end

defmodule Utxorpc.V1alpha.Cardano.BlockBody do
  @moduledoc false

  use Protobuf, syntax: :proto3, protoc_gen_elixir_version: "0.12.0"

  field :tx, 1, repeated: true, type: Utxorpc.V1alpha.Cardano.Tx
end

defmodule Utxorpc.V1alpha.Cardano.Block do
  @moduledoc false

  use Protobuf, syntax: :proto3, protoc_gen_elixir_version: "0.12.0"

  field :header, 1, type: Utxorpc.V1alpha.Cardano.BlockHeader
  field :body, 2, type: Utxorpc.V1alpha.Cardano.BlockBody
end

defmodule Utxorpc.V1alpha.Cardano.VKeyWitness do
  @moduledoc false

  use Protobuf, syntax: :proto3, protoc_gen_elixir_version: "0.12.0"

  field :vkey, 1, type: :bytes
  field :signature, 2, type: :bytes
end

defmodule Utxorpc.V1alpha.Cardano.NativeScript do
  @moduledoc false

  use Protobuf, syntax: :proto3, protoc_gen_elixir_version: "0.12.0"

  oneof :native_script, 0

  field :script_pubkey, 1, type: :bytes, json_name: "scriptPubkey", oneof: 0

  field :script_all, 2,
    type: Utxorpc.V1alpha.Cardano.NativeScriptList,
    json_name: "scriptAll",
    oneof: 0

  field :script_any, 3,
    type: Utxorpc.V1alpha.Cardano.NativeScriptList,
    json_name: "scriptAny",
    oneof: 0

  field :script_n_of_k, 4,
    type: Utxorpc.V1alpha.Cardano.ScriptNOfK,
    json_name: "scriptNOfK",
    oneof: 0

  field :invalid_before, 5, type: :uint64, json_name: "invalidBefore", oneof: 0
  field :invalid_hereafter, 6, type: :uint64, json_name: "invalidHereafter", oneof: 0
end

defmodule Utxorpc.V1alpha.Cardano.NativeScriptList do
  @moduledoc false

  use Protobuf, syntax: :proto3, protoc_gen_elixir_version: "0.12.0"

  field :items, 1, repeated: true, type: Utxorpc.V1alpha.Cardano.NativeScript
end

defmodule Utxorpc.V1alpha.Cardano.ScriptNOfK do
  @moduledoc false

  use Protobuf, syntax: :proto3, protoc_gen_elixir_version: "0.12.0"

  field :k, 1, type: :uint32
  field :scripts, 2, repeated: true, type: Utxorpc.V1alpha.Cardano.NativeScript
end

defmodule Utxorpc.V1alpha.Cardano.Constr do
  @moduledoc false

  use Protobuf, syntax: :proto3, protoc_gen_elixir_version: "0.12.0"

  field :tag, 1, type: :uint32
  field :any_constructor, 2, type: :uint64, json_name: "anyConstructor"
  field :fields, 3, repeated: true, type: Utxorpc.V1alpha.Cardano.PlutusData
end

defmodule Utxorpc.V1alpha.Cardano.BigInt do
  @moduledoc false

  use Protobuf, syntax: :proto3, protoc_gen_elixir_version: "0.12.0"

  oneof :big_int, 0

  field :int, 1, type: :int64, oneof: 0
  field :big_u_int, 2, type: :bytes, json_name: "bigUInt", oneof: 0
  field :big_n_int, 3, type: :bytes, json_name: "bigNInt", oneof: 0
end

defmodule Utxorpc.V1alpha.Cardano.PlutusDataPair do
  @moduledoc false

  use Protobuf, syntax: :proto3, protoc_gen_elixir_version: "0.12.0"

  field :key, 1, type: Utxorpc.V1alpha.Cardano.PlutusData
  field :value, 2, type: Utxorpc.V1alpha.Cardano.PlutusData
end

defmodule Utxorpc.V1alpha.Cardano.PlutusData do
  @moduledoc false

  use Protobuf, syntax: :proto3, protoc_gen_elixir_version: "0.12.0"

  oneof :plutus_data, 0

  field :constr, 1, type: Utxorpc.V1alpha.Cardano.Constr, oneof: 0
  field :map, 2, type: Utxorpc.V1alpha.Cardano.PlutusDataMap, oneof: 0
  field :big_int, 3, type: Utxorpc.V1alpha.Cardano.BigInt, json_name: "bigInt", oneof: 0
  field :bounded_bytes, 4, type: :bytes, json_name: "boundedBytes", oneof: 0
  field :array, 5, type: Utxorpc.V1alpha.Cardano.PlutusDataArray, oneof: 0
end

defmodule Utxorpc.V1alpha.Cardano.PlutusDataMap do
  @moduledoc false

  use Protobuf, syntax: :proto3, protoc_gen_elixir_version: "0.12.0"

  field :pairs, 1, repeated: true, type: Utxorpc.V1alpha.Cardano.PlutusDataPair
end

defmodule Utxorpc.V1alpha.Cardano.PlutusDataArray do
  @moduledoc false

  use Protobuf, syntax: :proto3, protoc_gen_elixir_version: "0.12.0"

  field :items, 1, repeated: true, type: Utxorpc.V1alpha.Cardano.PlutusData
end

defmodule Utxorpc.V1alpha.Cardano.Script do
  @moduledoc false

  use Protobuf, syntax: :proto3, protoc_gen_elixir_version: "0.12.0"

  oneof :script, 0

  field :native, 1, type: Utxorpc.V1alpha.Cardano.NativeScript, oneof: 0
  field :plutus_v1, 2, type: :bytes, json_name: "plutusV1", oneof: 0
  field :plutus_v2, 3, type: :bytes, json_name: "plutusV2", oneof: 0
end

defmodule Utxorpc.V1alpha.Cardano.Metadatum do
  @moduledoc false

  use Protobuf, syntax: :proto3, protoc_gen_elixir_version: "0.12.0"

  oneof :metadatum, 0

  field :int, 1, type: :int64, oneof: 0
  field :bytes, 2, type: :bytes, oneof: 0
  field :text, 3, type: :string, oneof: 0
  field :array, 4, type: Utxorpc.V1alpha.Cardano.MetadatumArray, oneof: 0
  field :map, 5, type: Utxorpc.V1alpha.Cardano.MetadatumMap, oneof: 0
end

defmodule Utxorpc.V1alpha.Cardano.MetadatumArray do
  @moduledoc false

  use Protobuf, syntax: :proto3, protoc_gen_elixir_version: "0.12.0"

  field :items, 1, repeated: true, type: Utxorpc.V1alpha.Cardano.Metadatum
end

defmodule Utxorpc.V1alpha.Cardano.MetadatumMap do
  @moduledoc false

  use Protobuf, syntax: :proto3, protoc_gen_elixir_version: "0.12.0"

  field :pairs, 1, repeated: true, type: Utxorpc.V1alpha.Cardano.MetadatumPair
end

defmodule Utxorpc.V1alpha.Cardano.MetadatumPair do
  @moduledoc false

  use Protobuf, syntax: :proto3, protoc_gen_elixir_version: "0.12.0"

  field :key, 1, type: Utxorpc.V1alpha.Cardano.Metadatum
  field :value, 2, type: Utxorpc.V1alpha.Cardano.Metadatum
end

defmodule Utxorpc.V1alpha.Cardano.Metadata do
  @moduledoc false

  use Protobuf, syntax: :proto3, protoc_gen_elixir_version: "0.12.0"

  field :label, 1, type: :uint64
  field :value, 2, type: Utxorpc.V1alpha.Cardano.Metadatum
end

defmodule Utxorpc.V1alpha.Cardano.StakeCredential do
  @moduledoc false

  use Protobuf, syntax: :proto3, protoc_gen_elixir_version: "0.12.0"

  oneof :stake_credential, 0

  field :addr_key_hash, 1, type: :bytes, json_name: "addrKeyHash", oneof: 0
  field :script_hash, 2, type: :bytes, json_name: "scriptHash", oneof: 0
end

defmodule Utxorpc.V1alpha.Cardano.RationalNumber do
  @moduledoc false

  use Protobuf, syntax: :proto3, protoc_gen_elixir_version: "0.12.0"

  field :numerator, 1, type: :int32
  field :denominator, 2, type: :uint32
end

defmodule Utxorpc.V1alpha.Cardano.Relay do
  @moduledoc false

  use Protobuf, syntax: :proto3, protoc_gen_elixir_version: "0.12.0"

  field :ip_v4, 1, type: :bytes, json_name: "ipV4"
  field :ip_v6, 2, type: :bytes, json_name: "ipV6"
  field :dns_name, 3, type: :string, json_name: "dnsName"
  field :port, 4, type: :uint32
end

defmodule Utxorpc.V1alpha.Cardano.PoolMetadata do
  @moduledoc false

  use Protobuf, syntax: :proto3, protoc_gen_elixir_version: "0.12.0"

  field :url, 1, type: :string
  field :hash, 2, type: :bytes
end

defmodule Utxorpc.V1alpha.Cardano.Certificate do
  @moduledoc false

  use Protobuf, syntax: :proto3, protoc_gen_elixir_version: "0.12.0"

  oneof :certificate, 0

  field :stake_registration, 1,
    type: Utxorpc.V1alpha.Cardano.StakeCredential,
    json_name: "stakeRegistration",
    oneof: 0

  field :stake_deregistration, 2,
    type: Utxorpc.V1alpha.Cardano.StakeCredential,
    json_name: "stakeDeregistration",
    oneof: 0

  field :stake_delegation, 3,
    type: Utxorpc.V1alpha.Cardano.StakeDelegationCert,
    json_name: "stakeDelegation",
    oneof: 0

  field :pool_registration, 4,
    type: Utxorpc.V1alpha.Cardano.PoolRegistrationCert,
    json_name: "poolRegistration",
    oneof: 0

  field :pool_retirement, 5,
    type: Utxorpc.V1alpha.Cardano.PoolRetirementCert,
    json_name: "poolRetirement",
    oneof: 0

  field :genesis_key_delegation, 6,
    type: Utxorpc.V1alpha.Cardano.GenesisKeyDelegationCert,
    json_name: "genesisKeyDelegation",
    oneof: 0

  field :mir_cert, 7, type: Utxorpc.V1alpha.Cardano.MirCert, json_name: "mirCert", oneof: 0
end

defmodule Utxorpc.V1alpha.Cardano.StakeDelegationCert do
  @moduledoc false

  use Protobuf, syntax: :proto3, protoc_gen_elixir_version: "0.12.0"

  field :stake_credential, 1,
    type: Utxorpc.V1alpha.Cardano.StakeCredential,
    json_name: "stakeCredential"

  field :pool_keyhash, 2, type: :bytes, json_name: "poolKeyhash"
end

defmodule Utxorpc.V1alpha.Cardano.PoolRegistrationCert do
  @moduledoc false

  use Protobuf, syntax: :proto3, protoc_gen_elixir_version: "0.12.0"

  field :operator, 1, type: :bytes
  field :vrf_keyhash, 2, type: :bytes, json_name: "vrfKeyhash"
  field :pledge, 3, type: :uint64
  field :cost, 4, type: :uint64
  field :margin, 5, type: Utxorpc.V1alpha.Cardano.RationalNumber
  field :reward_account, 6, type: :bytes, json_name: "rewardAccount"
  field :pool_owners, 7, repeated: true, type: :bytes, json_name: "poolOwners"
  field :relays, 8, repeated: true, type: Utxorpc.V1alpha.Cardano.Relay
  field :pool_metadata, 9, type: Utxorpc.V1alpha.Cardano.PoolMetadata, json_name: "poolMetadata"
end

defmodule Utxorpc.V1alpha.Cardano.PoolRetirementCert do
  @moduledoc false

  use Protobuf, syntax: :proto3, protoc_gen_elixir_version: "0.12.0"

  field :pool_keyhash, 1, type: :bytes, json_name: "poolKeyhash"
  field :epoch, 2, type: :uint64
end

defmodule Utxorpc.V1alpha.Cardano.GenesisKeyDelegationCert do
  @moduledoc false

  use Protobuf, syntax: :proto3, protoc_gen_elixir_version: "0.12.0"

  field :genesis_hash, 1, type: :bytes, json_name: "genesisHash"
  field :genesis_delegate_hash, 2, type: :bytes, json_name: "genesisDelegateHash"
  field :vrf_keyhash, 3, type: :bytes, json_name: "vrfKeyhash"
end

defmodule Utxorpc.V1alpha.Cardano.MirTarget do
  @moduledoc false

  use Protobuf, syntax: :proto3, protoc_gen_elixir_version: "0.12.0"

  field :stake_credential, 1,
    type: Utxorpc.V1alpha.Cardano.StakeCredential,
    json_name: "stakeCredential"

  field :delta_coin, 2, type: :int64, json_name: "deltaCoin"
end

defmodule Utxorpc.V1alpha.Cardano.MirCert do
  @moduledoc false

  use Protobuf, syntax: :proto3, protoc_gen_elixir_version: "0.12.0"

  field :from, 1, type: Utxorpc.V1alpha.Cardano.MirSource, enum: true
  field :to, 2, repeated: true, type: Utxorpc.V1alpha.Cardano.MirTarget
  field :other_pot, 3, type: :uint64, json_name: "otherPot"
end

defmodule Utxorpc.V1alpha.Cardano.AddressPattern do
  @moduledoc false

  use Protobuf, syntax: :proto3, protoc_gen_elixir_version: "0.12.0"

  field :exact_address, 1, type: :bytes, json_name: "exactAddress"
  field :payment_part, 2, type: :bytes, json_name: "paymentPart"
  field :delegation_part, 3, type: :bytes, json_name: "delegationPart"
end

defmodule Utxorpc.V1alpha.Cardano.AssetPattern do
  @moduledoc false

  use Protobuf, syntax: :proto3, protoc_gen_elixir_version: "0.12.0"

  field :policy_id, 1, type: :bytes, json_name: "policyId"
  field :asset_name, 2, type: :bytes, json_name: "assetName"
end

defmodule Utxorpc.V1alpha.Cardano.TxOutputPattern do
  @moduledoc false

  use Protobuf, syntax: :proto3, protoc_gen_elixir_version: "0.12.0"

  field :address, 1, type: Utxorpc.V1alpha.Cardano.AddressPattern
  field :asset, 2, type: Utxorpc.V1alpha.Cardano.AssetPattern
end

defmodule Utxorpc.V1alpha.Cardano.TxPattern do
  @moduledoc false

  use Protobuf, syntax: :proto3, protoc_gen_elixir_version: "0.12.0"

  field :consumes, 1, type: Utxorpc.V1alpha.Cardano.TxOutputPattern
  field :produces, 2, type: Utxorpc.V1alpha.Cardano.TxOutputPattern
  field :has_address, 3, type: Utxorpc.V1alpha.Cardano.AddressPattern, json_name: "hasAddress"
  field :moves_asset, 4, type: Utxorpc.V1alpha.Cardano.AssetPattern, json_name: "movesAsset"
  field :mints_asset, 5, type: Utxorpc.V1alpha.Cardano.AssetPattern, json_name: "mintsAsset"
end

defmodule Utxorpc.V1alpha.Cardano.Params do
  @moduledoc false

  use Protobuf, syntax: :proto3, protoc_gen_elixir_version: "0.12.0"
end