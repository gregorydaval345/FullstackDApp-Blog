// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

// Import this file to use console.log
import "hardhat/console.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract Blog {
    string public name;
    address public owner;

    using Counters for Counters.Counter;
    Counters.Counter private _postIds;

    struct Post {
        uint256 id;
        string title;
        string content;
        bool published;
    }

    // Lookups for finding things
    mapping(uint256 => Post) private idToPost;
    mapping(string => Post) private hashToPost;

    // Keep up with updates happening on the Smart Contract
    event PostCreated(uint256 id, string title, string hash);
    event PostUpdated(uint256 id, string title, string hash, bool published);

    // When the smart contract is deployed, give it a name
    // Set the creator as the owner of the contract
    constructor(string memory _name) {
        console.log("Deploying Blog with name:", _name);
        name = _name;
        owner = msg.sender;
    }

    // Updates the blog name
    function updateName(string memory _name) public {
        name = _name;
    }

    // Transfers ownership of the contract to another address
    function transferOwnership(address newOwner) public onlyOwner {
        owner = newOwner;
    }

    // Fetches an individual post by the content hash
    function fetchPost(string memory hash) public view returns (Post memory) {
        return hashToPost[hash];
    }

    function createPost(string memory title, string memory hash)
        public
        onlyOwner
    {
        _postIds.increment();
        uint256 postId = _postIds.current();
        Post storage post = idToPost[postId];
        post.id = postId;
        post.title = title;
        post.published = true;
        post.content = hash;
        hashToPost[hash] = post;
        emit PostCreated(postId, title, hash);
    }

    // Fetches all posts
    function fetchPosts() public view returns (Post[] memory) {
        uint256 itemCount = _postIds.current();

        Post[] memory posts = new Post[](itemCount);
        for (uint256 i = 0; i < itemCount; i++) {
            uint256 currentId = i + 1;
            Post storage currentItem = idToPost[currentId];
            posts[i] = currentItem;
        }
        return posts;
    }

    // This modifier means only the contract owner can invoke the function

    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }
}
