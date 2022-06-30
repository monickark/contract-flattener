// SPDX-License-Identifier: MIT
// OpenZeppelin Contracts v4.4.1 (utils/introspection/IERC165.sol)

pragma solidity ^0.8.0;

/**
 * @dev Interface of the ERC165 standard, as defined in the
 * https://eips.ethereum.org/EIPS/eip-165[EIP].
 *
 * Implementers can declare support of contract interfaces, which can then be
 * queried by others ({ERC165Checker}).
 *
 * For an implementation, see {ERC165}.
 */
interface IERC165Upgradeable {
    /**
     * @dev Returns true if this contract implements the interface defined by
     * `interfaceId`. See the corresponding
     * https://eips.ethereum.org/EIPS/eip-165#how-interfaces-are-identified[EIP section]
     * to learn more about how these ids are created.
     *
     * This function call must use less than 30 000 gas.
     */
    function supportsInterface(bytes4 interfaceId) external view returns (bool);
}
// SPDX-License-Identifier: MIT
// OpenZeppelin Contracts (last updated v4.6.0) (proxy/utils/Initializable.sol)

pragma solidity ^0.8.2;

// SPDX-License-Identifier: MIT
// OpenZeppelin Contracts (last updated v4.5.0) (utils/Address.sol)

pragma solidity ^0.8.1;

/**
 * @dev Collection of functions related to the address type
 */
library AddressUpgradeable {
    /**
     * @dev Returns true if `account` is a contract.
     *
     * [IMPORTANT]
     * ====
     * It is unsafe to assume that an address for which this function returns
     * false is an externally-owned account (EOA) and not a contract.
     *
     * Among others, `isContract` will return false for the following
     * types of addresses:
     *
     *  - an externally-owned account
     *  - a contract in construction
     *  - an address where a contract will be created
     *  - an address where a contract lived, but was destroyed
     * ====
     *
     * [IMPORTANT]
     * ====
     * You shouldn't rely on `isContract` to protect against flash loan attacks!
     *
     * Preventing calls from contracts is highly discouraged. It breaks composability, breaks support for smart wallets
     * like Gnosis Safe, and does not provide security since it can be circumvented by calling from a contract
     * constructor.
     * ====
     */
    function isContract(address account) internal view returns (bool) {
        // This method relies on extcodesize/address.code.length, which returns 0
        // for contracts in construction, since the code is only stored at the end
        // of the constructor execution.

        return account.code.length > 0;
    }

    /**
     * @dev Replacement for Solidity's `transfer`: sends `amount` wei to
     * `recipient`, forwarding all available gas and reverting on errors.
     *
     * https://eips.ethereum.org/EIPS/eip-1884[EIP1884] increases the gas cost
     * of certain opcodes, possibly making contracts go over the 2300 gas limit
     * imposed by `transfer`, making them unable to receive funds via
     * `transfer`. {sendValue} removes this limitation.
     *
     * https://diligence.consensys.net/posts/2019/09/stop-using-soliditys-transfer-now/[Learn more].
     *
     * IMPORTANT: because control is transferred to `recipient`, care must be
     * taken to not create reentrancy vulnerabilities. Consider using
     * {ReentrancyGuard} or the
     * https://solidity.readthedocs.io/en/v0.5.11/security-considerations.html#use-the-checks-effects-interactions-pattern[checks-effects-interactions pattern].
     */
    function sendValue(address payable recipient, uint256 amount) internal {
        require(address(this).balance >= amount, "Address: insufficient balance");

        (bool success, ) = recipient.call{value: amount}("");
        require(success, "Address: unable to send value, recipient may have reverted");
    }

    /**
     * @dev Performs a Solidity function call using a low level `call`. A
     * plain `call` is an unsafe replacement for a function call: use this
     * function instead.
     *
     * If `target` reverts with a revert reason, it is bubbled up by this
     * function (like regular Solidity function calls).
     *
     * Returns the raw returned data. To convert to the expected return value,
     * use https://solidity.readthedocs.io/en/latest/units-and-global-variables.html?highlight=abi.decode#abi-encoding-and-decoding-functions[`abi.decode`].
     *
     * Requirements:
     *
     * - `target` must be a contract.
     * - calling `target` with `data` must not revert.
     *
     * _Available since v3.1._
     */
    function functionCall(address target, bytes memory data) internal returns (bytes memory) {
        return functionCall(target, data, "Address: low-level call failed");
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-}[`functionCall`], but with
     * `errorMessage` as a fallback revert reason when `target` reverts.
     *
     * _Available since v3.1._
     */
    function functionCall(
        address target,
        bytes memory data,
        string memory errorMessage
    ) internal returns (bytes memory) {
        return functionCallWithValue(target, data, 0, errorMessage);
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-}[`functionCall`],
     * but also transferring `value` wei to `target`.
     *
     * Requirements:
     *
     * - the calling contract must have an ETH balance of at least `value`.
     * - the called Solidity function must be `payable`.
     *
     * _Available since v3.1._
     */
    function functionCallWithValue(
        address target,
        bytes memory data,
        uint256 value
    ) internal returns (bytes memory) {
        return functionCallWithValue(target, data, value, "Address: low-level call with value failed");
    }

    /**
     * @dev Same as {xref-Address-functionCallWithValue-address-bytes-uint256-}[`functionCallWithValue`], but
     * with `errorMessage` as a fallback revert reason when `target` reverts.
     *
     * _Available since v3.1._
     */
    function functionCallWithValue(
        address target,
        bytes memory data,
        uint256 value,
        string memory errorMessage
    ) internal returns (bytes memory) {
        require(address(this).balance >= value, "Address: insufficient balance for call");
        require(isContract(target), "Address: call to non-contract");

        (bool success, bytes memory returndata) = target.call{value: value}(data);
        return verifyCallResult(success, returndata, errorMessage);
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-}[`functionCall`],
     * but performing a static call.
     *
     * _Available since v3.3._
     */
    function functionStaticCall(address target, bytes memory data) internal view returns (bytes memory) {
        return functionStaticCall(target, data, "Address: low-level static call failed");
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-string-}[`functionCall`],
     * but performing a static call.
     *
     * _Available since v3.3._
     */
    function functionStaticCall(
        address target,
        bytes memory data,
        string memory errorMessage
    ) internal view returns (bytes memory) {
        require(isContract(target), "Address: static call to non-contract");

        (bool success, bytes memory returndata) = target.staticcall(data);
        return verifyCallResult(success, returndata, errorMessage);
    }

    /**
     * @dev Tool to verifies that a low level call was successful, and revert if it wasn't, either by bubbling the
     * revert reason using the provided one.
     *
     * _Available since v4.3._
     */
    function verifyCallResult(
        bool success,
        bytes memory returndata,
        string memory errorMessage
    ) internal pure returns (bytes memory) {
        if (success) {
            return returndata;
        } else {
            // Look for revert reason and bubble it up if present
            if (returndata.length > 0) {
                // The easiest way to bubble the revert reason is using memory via assembly

                assembly {
                    let returndata_size := mload(returndata)
                    revert(add(32, returndata), returndata_size)
                }
            } else {
                revert(errorMessage);
            }
        }
    }
}


/**
 * @dev This is a base contract to aid in writing upgradeable contracts, or any kind of contract that will be deployed
 * behind a proxy. Since proxied contracts do not make use of a constructor, it's common to move constructor logic to an
 * external initializer function, usually called `initialize`. It then becomes necessary to protect this initializer
 * function so it can only be called once. The {initializer} modifier provided by this contract will have this effect.
 *
 * The initialization functions use a version number. Once a version number is used, it is consumed and cannot be
 * reused. This mechanism prevents re-execution of each "step" but allows the creation of new initialization steps in
 * case an upgrade adds a module that needs to be initialized.
 *
 * For example:
 *
 * [.hljs-theme-light.nopadding]
 * ```
 * contract MyToken is ERC20Upgradeable {
 *     function initialize() initializer public {
 *         __ERC20_init("MyToken", "MTK");
 *     }
 * }
 * contract MyTokenV2 is MyToken, ERC20PermitUpgradeable {
 *     function initializeV2() reinitializer(2) public {
 *         __ERC20Permit_init("MyToken");
 *     }
 * }
 * ```
 *
 * TIP: To avoid leaving the proxy in an uninitialized state, the initializer function should be called as early as
 * possible by providing the encoded function call as the `_data` argument to {ERC1967Proxy-constructor}.
 *
 * CAUTION: When used with inheritance, manual care must be taken to not invoke a parent initializer twice, or to ensure
 * that all initializers are idempotent. This is not verified automatically as constructors are by Solidity.
 *
 * [CAUTION]
 * ====
 * Avoid leaving a contract uninitialized.
 *
 * An uninitialized contract can be taken over by an attacker. This applies to both a proxy and its implementation
 * contract, which may impact the proxy. To prevent the implementation contract from being used, you should invoke
 * the {_disableInitializers} function in the constructor to automatically lock it when it is deployed:
 *
 * [.hljs-theme-light.nopadding]
 * ```
 * /// @custom:oz-upgrades-unsafe-allow constructor
 * constructor() {
 *     _disableInitializers();
 * }
 * ```
 * ====
 */
abstract contract Initializable {
    /**
     * @dev Indicates that the contract has been initialized.
     * @custom:oz-retyped-from bool
     */
    uint8 private _initialized;

    /**
     * @dev Indicates that the contract is in the process of being initialized.
     */
    bool private _initializing;

    /**
     * @dev Triggered when the contract has been initialized or reinitialized.
     */
    event Initialized(uint8 version);

    /**
     * @dev A modifier that defines a protected initializer function that can be invoked at most once. In its scope,
     * `onlyInitializing` functions can be used to initialize parent contracts. Equivalent to `reinitializer(1)`.
     */
    modifier initializer() {
        bool isTopLevelCall = _setInitializedVersion(1);
        if (isTopLevelCall) {
            _initializing = true;
        }
        _;
        if (isTopLevelCall) {
            _initializing = false;
            emit Initialized(1);
        }
    }

    /**
     * @dev A modifier that defines a protected reinitializer function that can be invoked at most once, and only if the
     * contract hasn't been initialized to a greater version before. In its scope, `onlyInitializing` functions can be
     * used to initialize parent contracts.
     *
     * `initializer` is equivalent to `reinitializer(1)`, so a reinitializer may be used after the original
     * initialization step. This is essential to configure modules that are added through upgrades and that require
     * initialization.
     *
     * Note that versions can jump in increments greater than 1; this implies that if multiple reinitializers coexist in
     * a contract, executing them in the right order is up to the developer or operator.
     */
    modifier reinitializer(uint8 version) {
        bool isTopLevelCall = _setInitializedVersion(version);
        if (isTopLevelCall) {
            _initializing = true;
        }
        _;
        if (isTopLevelCall) {
            _initializing = false;
            emit Initialized(version);
        }
    }

    /**
     * @dev Modifier to protect an initialization function so that it can only be invoked by functions with the
     * {initializer} and {reinitializer} modifiers, directly or indirectly.
     */
    modifier onlyInitializing() {
        require(_initializing, "Initializable: contract is not initializing");
        _;
    }

    /**
     * @dev Locks the contract, preventing any future reinitialization. This cannot be part of an initializer call.
     * Calling this in the constructor of a contract will prevent that contract from being initialized or reinitialized
     * to any version. It is recommended to use this to lock implementation contracts that are designed to be called
     * through proxies.
     */
    function _disableInitializers() internal virtual {
        _setInitializedVersion(type(uint8).max);
    }

    function _setInitializedVersion(uint8 version) private returns (bool) {
        // If the contract is initializing we ignore whether _initialized is set in order to support multiple
        // inheritance patterns, but we only do this in the context of a constructor, and for the lowest level
        // of initializers, because in other contexts the contract may have been reentered.
        if (_initializing) {
            require(
                version == 1 && !AddressUpgradeable.isContract(address(this)),
                "Initializable: contract is already initialized"
            );
            return false;
        } else {
            require(_initialized < version, "Initializable: contract is already initialized");
            _initialized = version;
            return true;
        }
    }
}
// SPDX-License-Identifier: MIT










contract MetaLicensePlates is
    ERC721AUpgradeable,
    ERC2981Upgradeable,
    ReentrancyGuardUpgradeable,
    OwnableUpgradeable
{
    using Strings for uint256;

    bytes32 public merkleRoot;
    mapping(address => bool) public whitelistClaimed;

    string public uri;

    uint256 public mintPrice;
    uint256 public maxSupply;
    uint256 public maxPerWallet;

    bool public paused;
    bool public whitelistMintEnabled;
    bool public publicMintEnabled;
    bool public privateMintEnabled;

    address payable public withdrawWallet;
    address payable public royaltyOwner;

    uint96 revenueShareInBips;

    /**
     * @dev Emitted when while mint `quantity` no of token 
     * from `tokenId` to `tokenOwner`.
     */
    event TokenMinted(uint256 quantity, uint256 indexed tokenId, address tokenOwner);

    /**
     * @dev Emitted when owner mint `quantity` no of token 
     * from `tokenId` to `tokenOwner`.
     */
    event TokenMintedForAddress(uint256 quantity, uint256 indexed tokenId, address tokenOwner);

    /**
     * @dev Emitted when admin mint `quantity` no of token from `
     * tokenId` to whitelisted users `tokenOwner`.
     */
    event WhitelistedTokenMinted(uint256 quantity, uint256 indexed tokenId, address tokenOwner);

    /**
     * @dev Emitted when admin mint `quantity` no of token from 
     * `tokenId` to whitelisted users `tokenOwner`.
     */
    event TokenTransferred(uint256 indexed tokenId, address sender, address receiver);
  
    /**
     * @dev Emitted when Revenue share transferred while transfer token for token `tokenId` 
     * to `tokenOwner`.
     */
    event RevenueShareTransferred(
        uint256 _tokenId,
        uint256 saleAmt,
        uint256 revenueShare,
        address _receiver
    );  

    /**
     * @dev Initializes the contract 
     * ***PARAMETERS***
     *  token name
     *  token symbol
     *  mint price
     *  max token supply
     *  maximum token per wallet
     *  withdrawl wallet adddress
     *  token url,
     *  revenue share percentage in bips
     *  royalty fee percentage in bips 
     *
     *  initialize default values
     *  Set royalty info and transfer ownership
     */
    function initialize(
        string memory _tokenName,
        string memory _tokenSymbol,
        uint256 _mintPrice,
        uint256 _maxSupply,
        uint256 _maxPerWallet,
        address payable _withdrawWallet,
        string memory _uri,
        uint96 _revenueShareInBips,
        uint96 _royaltyFeesInBips,
        address payable _royaltyOwner
    ) public initializerERC721A initializer {
        __ERC721A_init(_tokenName, _tokenSymbol);
        __Ownable_init();
        setMintPrice(_mintPrice);
        seturi(_uri);
        transferOwnership(_msgSender());
        maxSupply = _maxSupply;
        maxPerWallet = _maxPerWallet;
        withdrawWallet = _withdrawWallet;
        paused = false;
        whitelistMintEnabled = true;
        publicMintEnabled = false;
        privateMintEnabled = true;
        revenueShareInBips = _revenueShareInBips;
        royaltyOwner = _royaltyOwner;
        setRoyaltyInfo(_royaltyOwner, _royaltyFeesInBips);
    }
    
     /**
     * @dev to check the provided quantity is exceeded with already minted nfts
     */
    modifier mintCompliance(uint256 _quantity) {
        require(
            totalSupply() + _quantity <= maxSupply,
            "Max supply exceeded, Sold out!"
        );
        _;
    }

    /**
     * @dev to check the msg.value is enough to mint token by multiplying mint price & quantity
     */
    modifier mintPriceCompliance(uint256 _quantity) {
        require(msg.value >= mintPrice * _quantity, "Wrong value!");
        _;
    }

    /**
     * @dev mint `_quantity` amount of token to caller `_msgSender()`.
     *
     * check the `quantity` not exceeded total supply using `mintComplier` modifier
     * check the `msg.value` ia greater than than price to mint uding `mintPriceCompliance` modifier
     *
     * Emits a {TokenMinted} event.
     */
    function mint(uint256 _quantity)
        external
        payable
        mintCompliance(_quantity)
        mintPriceCompliance(_quantity)
    {
        require(!paused, "The contract is paused!");
        require(publicMintEnabled, "minting not enabled");
        require(
            (balanceOf(_msgSender()) + _quantity) <= maxPerWallet,
            "Exceed max per wallet"
        );
        _safeMint(_msgSender(), _quantity);
        emit TokenMinted(_quantity, _nextTokenId(), _msgSender());
    }

    /**
     * @dev mint `_quantity` amount of token to a address `_receiver` from owner .
     *
     * check the `quantity` not exceeded total supply using `mintComplier` modifier
     *
     * add receiver in _tokenOwnerList & mint token
     * Emits a {TokenMintedForAddress} event.
     */
    function mintForAddress(uint256 _quantity, address _receiver)
        external
        mintCompliance(_quantity)
        onlyOwner
    {
        require(privateMintEnabled, "private minting not enabled");
        require(
            balanceOf(_receiver) + _quantity < maxPerWallet,
            "Exceed max per wallet"
        );
        _safeMint(_receiver, _quantity);        
        emit TokenMintedForAddress(_quantity, _nextTokenId(), _msgSender());
    }

    /**
     * @dev mint `_quantity` amount of token to a whitelist address `_msgSender()` .
     *
     * Note: `_merkleProof` is the proof of merkle tree to identify the caller is whitelisted using merkle root.
     * Emits a {WhitelistedTokenMinted} event.
     */
    function whitelistMint(uint256 _quantity, bytes32[] calldata _merkleProof)
        external
        payable
        mintCompliance(_quantity)
        mintPriceCompliance(_quantity)
    {
        // Verify whitelist requirements
        require(whitelistMintEnabled, "whitelist sale is not enabled!");
        require(!whitelistClaimed[_msgSender()], "Already claimed!");
        bytes32 leaf = keccak256(abi.encodePacked(_msgSender()));
        require(
            MerkleProofUpgradeable.verify(_merkleProof, merkleRoot, leaf),
            "Invalid proof!"
        );
        whitelistClaimed[_msgSender()] = true;
        _safeMint(_msgSender(), _quantity);
        emit WhitelistedTokenMinted(_quantity, _nextTokenId(), _msgSender());
    }

    /**
     * @dev transfers `tokenId` token from `_msgSender()` to `_receiver`.
     *
     * Emits a {TokenTransferred} event.
     */
    function transfer(uint256 _tokenId, address _receiver) external {
        require(_exists(_tokenId), "Token not existed");
        safeTransferFrom(_msgSender(), _receiver, _tokenId);
        emit TokenTransferred(_tokenId, _msgSender(), _receiver);
    }

    /**
     * @dev transfer revenue share amount to the owner of the token
     * token `_tokenId` using sale amount `_saleAmt` from caller.
     *
     * Emits a {RevenueShareTransferred} event.
     */
    function transferRevenueShare(uint256 _tokenId, uint256 _saleAmt)
        external
        payable
    {      
        require(_msgSender() == royaltyOwner, "Invalid royalty owner.");
        uint256 _revenueShare = calcRevenueShare(_tokenId, _saleAmt);
        require(_revenueShare == msg.value, "Invalid Revenue share");        
        address user = ownerOf(_tokenId);
        (bool success, ) = payable(user).call{value: _revenueShare}("");
        require(success, "Transfer failed");
        emit RevenueShareTransferred(
            _tokenId,
            _saleAmt,
            _revenueShare,
            user
        );
    }

     /**
     * @dev withdraw contract balance to `withdrawWallet`.
     */   
    function withdraw() external onlyOwner nonReentrant {
        (bool success, ) = withdrawWallet.call{value: address(this).balance}("");
        require(success, "withdraw failed");
    }   

    /**
     * @dev set mint price for token.
     **/
    function setMintPrice(uint256 _mintPrice) public onlyOwner {
        mintPrice = _mintPrice;
    }

    /**
     * @dev set url for token.
     **/
    function seturi(string memory _uri) public onlyOwner {
        uri = _uri;
    }

    /*** VIEW FUNCTIONS ***/

     /**
     * @dev calculate & returns revenue share amount for token id `_tokenId` using sale amount `_saleAmt`.
     *
     * Note: Check token id already minted and return revenue share amount
     */
    function calcRevenueShare(uint256 _tokenId, uint256 _saleAmt)
        public
        view
        returns (uint256)
    {
        require(_exists(_tokenId), "Token not existed");
        return (_saleAmt * revenueShareInBips) / _feeDenominator();
    }

    /**
     * @dev get balance of the contract.
     **/
    function getBalance() external view onlyOwner returns (uint256) {
        return address(this).balance;
    }
    
    /**
     * @dev toggle the pause/unpause for nft minting.
     **/
    function setPaused(bool _state) external onlyOwner {
        paused = _state;
    }

    /**
     * @dev set merkle root hash.
     **/
    function setMerkleRoot(bytes32 _merkleRoot) external onlyOwner {
        merkleRoot = _merkleRoot;
    }

    /**
     * @dev toggle the whitelist minting enable or not for nft minting.
     **/
    function setWhitelistMintEnabled(bool _state) external onlyOwner {
        whitelistMintEnabled = _state;
    }

     /**
     * @dev toggle the public minting enable or not for nft minting.
     **/
    function setPublicMintEnabled(bool _publicMintEnabled_) external onlyOwner {
        publicMintEnabled = _publicMintEnabled_;
    }

    /**
     * @dev toggle the private minting enable or not for nft minting.
     **/
    function setPrivateMintEnabled(bool _privateMintEnabled_)
        external
        onlyOwner
    {
        privateMintEnabled = _privateMintEnabled_;
    }

    /**
     * @dev set maximum no of token can mint using this contract.
     **/
    function updateMaxSupply(uint256 _maxSupply) external onlyOwner {
        maxSupply = _maxSupply;
    }

    /**
     * @dev update wallet of the amount withdrawl account from contract.
     **/
    function updateWithdraWallet(address payable _withdrawWallet)
        external
        onlyOwner
    {
        withdrawWallet = _withdrawWallet;
    }

    /**
     * @dev update How many tokens maximum a wallet can mint.
     **/
    function updateMaxPerWallet(uint256 _maxPerWallet) external onlyOwner {
        maxPerWallet = _maxPerWallet;
    }

    /**
     * @dev get token URI of the specified token `_tokenId`.
     **/
    function tokenURI(uint256 _tokenId)
        public
        view
        virtual
        override
        returns (string memory)
    {
        require(
            _exists(_tokenId),
            "ERC721Metadata: URI query for nonexistent token"
        );

        string memory currentBaseURI = _baseURI();
        return
            bytes(currentBaseURI).length > 0
                ? string(
                    abi.encodePacked(
                        currentBaseURI,
                        _tokenId.toString(),
                        ".json"
                    )
                )
                : "";
    }    

    /**
     * @dev set royalty percentage to the royalty owner.
     **/
    function setRoyaltyInfo(address _receiver, uint96 _royaltyFeesInBips)
        public
        onlyOwner
    {
        _setDefaultRoyalty(_receiver, _royaltyFeesInBips);
        royaltyOwner = payable(_receiver);
    }

    /**
     * @dev view base url of the tokens.
     **/
    function _baseURI() internal view virtual override returns (string memory) {
        return uri;
    }

     /**
     * @dev See {IERC2981-supportsInterface}.
     */

    function supportsInterface(bytes4 interfaceId)
        public
        view
        virtual
        override(ERC721AUpgradeable, ERC2981Upgradeable)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }
}



