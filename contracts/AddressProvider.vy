# @version 0.3.1
"""
@title Ellipsis Registry Address Provider
@license MIT
@author Curve.Fi
"""

event NewAddressIdentifier:
    id: indexed(uint256)
    addr: address
    description: String[64]

event AddressModified:
    id: indexed(uint256)
    new_address: address
    version: uint256

event CommitNewOwner:
    new_owner: indexed(address)

event NewOwner:
    owner: indexed(address)


struct AddressInfo:
    addr: address
    is_active: bool
    version: uint256
    last_modified: uint256
    description: String[64]


registry: address
queue_length: uint256
get_id_info: public(HashMap[uint256, AddressInfo])

owner: public(address)
future_owner: public(address)


@external
def __init__():
    self.owner = msg.sender
    self.queue_length = 1
    self.get_id_info[0].description = "Main Registry"


@view
@external
def get_registry() -> address:
    """
    @notice Get the address of the main registry contract
    @dev This is a gas-efficient way of calling `AddressProvider.get_address(0)`
    @return address main registry contract
    """
    return self.registry


@view
@external
def max_id() -> uint256:
    """
    @notice Get the highest ID set within the address provider
    @return uint256 max ID
    """
    return self.queue_length - 1


@view
@external
def get_address(_id: uint256) -> address:
    """
    @notice Fetch the address associated with `_id`
    @dev Returns ZERO_ADDRESS if `_id` has not been defined, or has been unset
    @param _id Identifier to fetch an address for
    @return Current address associated to `_id`
    """
    return self.get_id_info[_id].addr


@external
def add_new_id(_address: address, _description: String[64]) -> uint256:
    """
    @notice Add a new identifier to the registry
    @dev ID is auto-incremented
    @param _address Initial address to assign to new identifier
    @param _description Human-readable description of the identifier
    @return uint256 identifier
    """
    assert msg.sender == self.owner  # dev: admin-only function
    assert _address.is_contract  # dev: not a contract

    id: uint256 = self.queue_length
    self.get_id_info[id] = AddressInfo({
        addr: _address,
        is_active: True,
        version: 1,
        last_modified: block.timestamp,
        description: _description
    })
    self.queue_length = id + 1

    log NewAddressIdentifier(id, _address, _description)

    return id


@external
def set_address(_id: uint256, _address: address) -> bool:
    """
    @notice Set a new address for an existing identifier
    @param _id Identifier to set the new address for
    @param _address Address to set
    @return bool success
    """
    assert msg.sender == self.owner  # dev: admin-only function
    assert _address.is_contract  # dev: not a contract
    assert self.queue_length > _id  # dev: id does not exist

    version: uint256 = self.get_id_info[_id].version + 1

    self.get_id_info[_id].addr = _address
    self.get_id_info[_id].is_active = True
    self.get_id_info[_id].version = version
    self.get_id_info[_id].last_modified = block.timestamp

    if _id == 0:
        self.registry = _address

    log AddressModified(_id, _address, version)

    return True


@external
def unset_address(_id: uint256) -> bool:
    """
    @notice Unset an existing identifier
    @dev An identifier cannot ever be removed, it can only have the
         address unset so that it returns ZERO_ADDRESS
    @param _id Identifier to unset
    @return bool success
    """
    assert msg.sender == self.owner  # dev: admin-only function
    assert self.get_id_info[_id].is_active  # dev: not active

    self.get_id_info[_id].is_active = False
    self.get_id_info[_id].addr = ZERO_ADDRESS
    self.get_id_info[_id].last_modified = block.timestamp

    if _id == 0:
        self.registry = ZERO_ADDRESS

    log AddressModified(_id, ZERO_ADDRESS, self.get_id_info[_id].version)

    return True


@external
def commit_transfer_ownership(_new_owner: address):
    assert msg.sender == self.owner  # dev: admin-only function
    self.future_owner = _new_owner
    log CommitNewOwner(_new_owner)


@external
def accept_transfer_ownership():
    assert msg.sender == self.future_owner  # dev: admin-only function
    self.owner = self.future_owner
    self.future_owner = ZERO_ADDRESS
    log NewOwner(msg.sender)
