const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("MusicRegistry", function () {
    let MusicRegistry, musicRegistry, owner, addr1;

    beforeEach(async function () {
        [owner, addr1] = await ethers.getSigners();
        MusicRegistry = await ethers.getContractFactory("MusicRegistry");
        musicRegistry = await MusicRegistry.deploy(owner.address);
    });

    it("Should register music", async function () {
        await musicRegistry.registerMusic("Song Title", "Artist Name", "hash123");
        const music = await musicRegistry.getMusic(1);
        expect(music.title).to.equal("Song Title");
    });

    it("Should not allow non-owner to register music", async function () {
        await expect(
            musicRegistry.connect(addr1).registerMusic("Song Title", "Artist Name", "hash123")
        ).to.be.revertedWith("Ownable: caller is not the owner");
    });
});

describe("MusicNFT", function () {
    let MusicNFT, musicNFT, owner, addr1;

    beforeEach(async function () {
        [owner, addr1] = await ethers.getSigners();
        MusicNFT = await ethers.getContractFactory("MusicNFT");
        musicNFT = await MusicNFT.deploy(owner.address);
    });

    it("Should mint NFT", async function () {
        await musicNFT.mint(addr1.address, 1, "uri123");
        expect(await musicNFT.tokenURI(1)).to.equal("uri123");
    });

    it("Should not allow non-owner to mint NFT", async function () {
        await expect(
            musicNFT.connect(addr1).mint(addr1.address, 1, "uri123")
        ).to.be.revertedWith("Ownable: caller is not the owner");
    });
});

describe("Marketplace", function () {
    let Marketplace, marketplace, MusicNFT, musicNFT, owner, addr1;

    beforeEach(async function () {
        [owner, addr1] = await ethers.getSigners();
        MusicNFT = await ethers.getContractFactory("MusicNFT");
        musicNFT = await MusicNFT.deploy(owner.address);
        Marketplace = await ethers.getContractFactory("Marketplace");
        marketplace = await Marketplace.deploy(musicNFT.address, owner.address);
    });

    it("Should list and buy NFT", async function () {
        await musicNFT.mint(owner.address, 1, "uri123");
        await musicNFT.approve(marketplace.address, 1);
        await marketplace.listForSale(1, ethers.utils.parseEther("1"));

        await marketplace.connect(addr1).buyMusic(1, { value: ethers.utils.parseEther("1") });
        expect(await musicNFT.ownerOf(1)).to.equal(addr1.address);
    });
});

describe("DisputeResolution", function () {
    let DisputeResolution, disputeResolution, owner, addr1;

    beforeEach(async function () {
        [owner, addr1] = await ethers.getSigners();
        DisputeResolution = await ethers.getContractFactory("DisputeResolution");
        disputeResolution = await DisputeResolution.deploy(owner.address);
    });

    it("Should file and resolve dispute", async function () {
        await disputeResolution.connect(addr1).fileDispute(1, "Dispute description");
        const dispute = await disputeResolution.disputes(1);
        expect(dispute.description).to.equal("Dispute description");

        await disputeResolution.resolveDispute(1);
        const resolvedDispute = await disputeResolution.disputes(1);
        expect(resolvedDispute.resolved).to.be.true;
    });
});

describe("Copyright", function () {
    let Copyright, copyright, owner, addr1;

    beforeEach(async function () {
        [owner, addr1] = await ethers.getSigners();
        Copyright = await ethers.getContractFactory("Copyright");
        copyright = await Copyright.deploy(owner.address);
    });

    it("Should register and transfer copyright", async function () {
        await copyright.registerCopyright("Title", "Artist", "hash123");
        const info = await copyright.verifyOwnership(1);
        expect(info.title).to.equal("Title");

        await copyright.transferCopyright(1, addr1.address);
        const newInfo = await copyright.verifyOwnership(1);
        expect(newInfo.owner).to.equal(addr1.address);
    });
});