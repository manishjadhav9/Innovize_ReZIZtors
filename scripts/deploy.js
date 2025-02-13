async function main() {
    const [deployer] = await ethers.getSigners();

    console.log("Deploying contracts with the account:", deployer.address);

    const MusicRegistry = await ethers.getContractFactory("MusicRegistry");
    const musicRegistry = await MusicRegistry.deploy(deployer.address);
    console.log("MusicRegistry deployed to:", musicRegistry.address);

    const MusicNFT = await ethers.getContractFactory("MusicNFT");
    const musicNFT = await MusicNFT.deploy(deployer.address);
    console.log("MusicNFT deployed to:", musicNFT.address);

    const Marketplace = await ethers.getContractFactory("Marketplace");
    const marketplace = await Marketplace.deploy(musicNFT.address, deployer.address);
    console.log("Marketplace deployed to:", marketplace.address);

    const DisputeResolution = await ethers.getContractFactory("DisputeResolution");
    const disputeResolution = await DisputeResolution.deploy(deployer.address);
    console.log("DisputeResolution deployed to:", disputeResolution.address);

    const Copyright = await ethers.getContractFactory("Copyright");
    const copyright = await Copyright.deploy(deployer.address);
    console.log("Copyright deployed to:", copyright.address);
}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    }); 