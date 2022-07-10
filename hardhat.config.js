require("@nomicfoundation/hardhat-toolbox");
require("@nomicfoundation/hardhat-chai-matchers");

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.9",
  networks: {
    hardhat: {
      chainId: 1337,
    },
    // mumbai: {
    //   url: "",
    //   accounts: [process.env.pk]
    // },
    polygon: {
      url: "https://polygon-mainnet.infura.io/v3/583d04c136d14aeba43edcb97aee2059",
      accounts: [process.env.pk],
    },
  },
};
