Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F086DC433EF
	for <linux-rt-users@archiver.kernel.org>; Tue,  7 Jun 2022 13:24:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242377AbiFGNYO (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 7 Jun 2022 09:24:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233373AbiFGNYL (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 7 Jun 2022 09:24:11 -0400
Received: from GBR01-CWL-obe.outbound.protection.outlook.com (mail-cwlgbr01on2066.outbound.protection.outlook.com [40.107.11.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 375EEBE154
        for <linux-rt-users@vger.kernel.org>; Tue,  7 Jun 2022 06:24:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E2SBJB1PiztEH2uNgNToTDI6pmN+k9HXTWp7z5HJH3ORc2SQH//4etkY15BfmXflSfnl6Vl8s9ovBTUKvyuc0pi/1BpQEad42gcafF8DYkjmoVAd6/N8/BoZhp06RcEuluIReQsVboVlCAGeu3S9UJN6XTt+IrRAmmfvDQeftYscB4MEzIsnLEJJES9PwddFRVrk1zRzcNf9a4yZeuJz7MWFVGGj2CSvSpVn449TWjMBqdpe1DE1NpuXi3NfY5rnUVQDyzBqrur596nZmhuPmcVsJpdQZIjA/NJo/WT9qvQvi1THd3bouwk4WlMzANyJjE5IZ7A0Q5AFdfVvDWBTIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=59ypODWiTUUyMFcJXTpuPIvaiFbkcUKtsubQzMDrz94=;
 b=V8mCyX+gozIMC2YemWVd+xeu2sXZ21A/NoZ8YHo5FqihM2J4RuXk1AUYcVtvTuaw/xMquBojCxwcFd8/kFK27zBjARLw1t/JE66CkNGD2xUsqJUm/OFdeeuTzwTRjG8AkAV5n6MeFLh1Tc+lwDnN6viyED4sz1x4YQKHJHeWekuS57Ohle5eydj1Ue3XMi8d/DJhhvuYVjJH+Do+jivh9eH4bxKo4FtPRUPAcAZmsDJW0OEHOKtc8moWnSa+NPwADO88APpXfxJW5Z2IhE8MV/ScIhLFCX42j8A15YyX7hbY3JW/eQokof0DJpqH7Ur0Lu4QXzCitz4r3jHgjLjO0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=outlook.cardiffmet.ac.uk; dmarc=pass action=none
 header.from=outlook.cardiffmet.ac.uk; dkim=pass
 header.d=outlook.cardiffmet.ac.uk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outlook.cardiffmet.ac.uk; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=59ypODWiTUUyMFcJXTpuPIvaiFbkcUKtsubQzMDrz94=;
 b=R41i7le3geIC8pj7BmToJnJI5T7+IljoZEG+IigVtky0/BwRcOGp7BguFEy3hCEXtbT8mFYRiQXKapuxIDlH/3ogLbtSsbYU3Wvi/IDWQ61hB6O8ypIylm4rOr41S0O5hFnKKtx8onn/c6vh5rhbhqxuS3xO8GRe9cprJKTIo75AJrmorNwLw9FHCsbgCngfLVTWKiwjLozjO4j+G6fbcoqQrvkLUUxgJOkS24Lc5hL7TVJAH2s0SwmwQvwxBLCihvkiTUh9WNmJsl8eYDtfXM0uVtZfibGWZKolYGK2lqcBedacXxyLGFZ8HynlcqljiKdq1yexGGjA0PcpEr3NFQ==
Received: from CWXP265MB5011.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:198::6)
 by CWLP265MB5689.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1a5::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12; Tue, 7 Jun
 2022 13:24:06 +0000
Received: from CWXP265MB5011.GBRP265.PROD.OUTLOOK.COM
 ([fe80::196d:d663:2ecd:e8a3]) by CWXP265MB5011.GBRP265.PROD.OUTLOOK.COM
 ([fe80::196d:d663:2ecd:e8a3%5]) with mapi id 15.20.5314.019; Tue, 7 Jun 2022
 13:24:06 +0000
From:   "Willett, Tony" <st20214513@outlook.cardiffmet.ac.uk>
To:     "'linux-rt-users@vger.kernel.org'" <linux-rt-users@vger.kernel.org>
Subject: Problems installing a real time kernel.
Thread-Topic: Problems installing a real time kernel.
Thread-Index: Adh6cRdKblElwL5lRH+2dhGJ9mq92A==
Date:   Tue, 7 Jun 2022 13:24:06 +0000
Message-ID: <CWXP265MB501198E1F104B6044E93E188A5A59@CWXP265MB5011.GBRP265.PROD.OUTLOOK.COM>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=outlook.cardiffmet.ac.uk;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 99b81cc8-5da9-4c4f-1c99-08da4888ff9c
x-ms-traffictypediagnostic: CWLP265MB5689:EE_
x-microsoft-antispam-prvs: <CWLP265MB568996EE9C6D01A36F5C239FA5A59@CWLP265MB5689.GBRP265.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: flFXMg9Jf6sa4SNLhnPhz7GuAFfX5CoO22Pf58FFwoPfVe3H2xcpa8l4xtBeaRb2WbIaYpXzILArhMvHGp+SDBDQBhu51h+rz3BCLi3ZP80taviesmVQB9ZhYgcqYo5aTRPQhSUlOyOo93NyAZmMHV4etVtx7ZH11Wg2uaF2ln/a5mQWVPmcFtXlbFVXiT/SNlPOmInApe/KqbTwZo2sorE63WzJQo45MvVf/Rl2i3tmziYkvULbn+DhiPccnLyMngMYul0M0yPC5C19UshLrmR/n9WoIBu0Sz6mE+QJtXTFuX84nrLwgQziBNUqOYJhD88T2jAVVTMqlAUfWRxyEeL5N0AfOtDTpSz+EJ4j1v/JOPrrVfKOxYoqM/D3jvrJJBz7+aZcO9T4ZTU4ezY1wBNMe6Xj4jA4A/StikMHVqoaWHZorHizowZ9PdfVPgIUa79buJX6Eb0NTMTxkEc/AFCkI9I7l4SNJGlR1r9zGrq7f+Ps+iBXLfmCMX8TvvKlQ2Lh7Vk9Lt9Sa80CQqt3cupmmZnKi21i3jyPBOGs9R19WbU8eRgDQXeCeiPi/wO5Esrk1EgMdcIWt11AtbIoiruHQiASnbWlhdf97bXnR2rEQ4jk8WFo4cbC4S7HQiG7uZAPAozpB3e0KyGdM474EZLHABd/BwqTBFevatz7bKo27GNGf1nzy9X1kCXKq4XHUzwCKR9DbVmdPHeaWM/tMoY/AeZIdq5tL24lUnI/iS6p0i/JlxFfDa+zfoqXQ8WHo86IeK9Gm93BTLq1Y1yX0mrfd/e16qn8q1+MPtwYwgMYHxt/CgDv45Wlfekyl6/p
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWXP265MB5011.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(5660300002)(7696005)(316002)(786003)(76116006)(6916009)(55016003)(186003)(8676002)(122000001)(9686003)(71200400001)(38070700005)(66556008)(83380400001)(64756008)(33656002)(86362001)(66446008)(66476007)(66946007)(26005)(6506007)(966005)(38100700002)(8936002)(52536014)(508600001)(2906002)(491001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hyZqt0CiRBH87WuBlxN7NGMYJJEUc5lpnRzqopmS2rcH++YBBUoH+MsKqqLU?=
 =?us-ascii?Q?0hI+14WTIaUOyTbyYvkFcR94yA41NtTqdnwuJagDq2N+q4LI+pmVJb2YIRgV?=
 =?us-ascii?Q?VjjPU5a7Vucl8kCanyYDVKPl80CgTflB19S942/Vhe5GnrEkir4dtLx2IOJ1?=
 =?us-ascii?Q?N/kfDiCLlYXBm1ErNvjH/kxdnRm0I99ld7SaQoybeXLr7M+6Eil7ofS3p0aL?=
 =?us-ascii?Q?PMbcPw/SOXoG2JRYLAdmrIT9o5A6c3fxGukYyyF1dZtLYnDDxtwJ3PlpO0Lx?=
 =?us-ascii?Q?yPQuxO49mPPKijSBS6cZFJKXYhqZ9HTEFomPiV1Y6rZ+QxXKsSWZH5ja1ZZe?=
 =?us-ascii?Q?TMnqKclBiHVoPATispeksABVD3Tw1rQtY1DjovhGLTc23qh5qmlYIl6aR9Kz?=
 =?us-ascii?Q?rthjID9whLDgx9DGg2P0Xhk8Nyvdb+NJziU9GeUFScceFqf3cQp6wfG0/k9V?=
 =?us-ascii?Q?EKDsCA5SBZV7KZJJktf6SMNkJJ0WxP3gSAl4fC/bQz/OdPFlll5W6DO21JKw?=
 =?us-ascii?Q?7PCI7N8mx4Rsri67C2G5DR3vIt7i/0JqRipencRrxX3D9TB7x8L+YfrI6E+m?=
 =?us-ascii?Q?ErKVqgPcCVcWzSEwkE28Ni/lP9r2Q2k0MluQbaRgAwGskjDNeAxf+Bsmcz5/?=
 =?us-ascii?Q?Xty8a0ZsS8kWYHCnfXZA1BONoqYvURi6r/qPYqrrkDkuP6hC3ycWau3oFonb?=
 =?us-ascii?Q?cNj2QhgIfkHsLmS0YWIDGPeE32GflcXYGv86AAYp5xSTzVuOSIJaP93Agd0s?=
 =?us-ascii?Q?3MrWRDuAwSnCj90lVeZrM0wFvCdtp+7uuL8UYUHtb8Vh84OXhCbwnBAlAX1E?=
 =?us-ascii?Q?CaD+5qWz0J4tID5iFQg2UrY8OycdBK5HxbUVDopxlLjRKM6hhwRwTaNLGCxa?=
 =?us-ascii?Q?9xwLF6E9BfQFkcTsuegOcTL/lzK58Fpn0Y5zX/glU088mqPKJ3SKuX1BoPyd?=
 =?us-ascii?Q?F2VaoPlXi8FRT24IBnHhXyMZgGF2qZAI/2qe3f35mSrfGsQXV8zz3Mu3JwFE?=
 =?us-ascii?Q?pLRxBl4Kvh9KXZxb06FhOPOxdKohWftGSKbMP+KKu7I//5joQ2wqiAtf9hoy?=
 =?us-ascii?Q?w5Z5NCIZy6bqjgJwB9lhvu+9BIpFN7/ceuH6zteYNiEfKxhmLecyOwuq0Br+?=
 =?us-ascii?Q?xhryZx5JW9Z5NzbIn+YgkEgCJQwIwYkkF4FSYN/8j6bd6qBxPpslPglCyPY5?=
 =?us-ascii?Q?gPvSUNEIxRj5mpIbgz3G8vJLx5modRm89VmJU39g/feVJB5S0P7fbb7ldsRD?=
 =?us-ascii?Q?YLf2YdA5Do9C7IO0ur3eXv4QWbq1YcXYu47+A3FztRxB8qDxIeGrsDv4gI9w?=
 =?us-ascii?Q?USmYxclXPvcr4XIS7WXxH+XJNFn6XddbJtZxNwrM8iHKkVeb3qvyaR+r0AF1?=
 =?us-ascii?Q?5qFrchhREuHG5MS8fwW1kXgmMCsatnAwB9+ivKmXYvi+2XQGfVt6MeK0IoDk?=
 =?us-ascii?Q?b/edlDjUO5ClmRingm17JAwNW8Ihj2np/ZFEZnwiEiVNLZhYzgeKSIt+jMLq?=
 =?us-ascii?Q?0iR0c/+1CoiSOEuhX0fgjSBEm6rz7SipiB/jBD6SpQWPRALCKn0eK3xmaOuB?=
 =?us-ascii?Q?sAy0MIzxcKqcb+Ihk2vWNRKpXjQH9AFfQ24ETCRLbjsII8q72iPn40PWZIkD?=
 =?us-ascii?Q?9dEe0T/eFYnR3cabJn1hwg4Lz+ZQDRI2LBmpW9OEtpvfVZ7rmqP93vNuTF71?=
 =?us-ascii?Q?i/eaJPG9dCUM/Q9yYhk5jzKjPjkrYWgJbnIzNrAFIAfixmexT35/DMLmcFNo?=
 =?us-ascii?Q?zJll08nqn+3CmC9Yz8Sw8vn9IgL/ED0Msv4NPNDoZEM+1vqS0YUn?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: outlook.cardiffmet.ac.uk
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CWXP265MB5011.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 99b81cc8-5da9-4c4f-1c99-08da4888ff9c
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2022 13:24:06.7050
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 189dc61c-769b-4048-8b0f-6de074bba26c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MFAxDyZ+6JRYE7g3pCvKxIB9GmkXWacQeeqqFfXCWvA5xt7VmLathoQZXBJZ5PDQvD2mOPIWtzm1VhyHrkNDfuZoQgtcRp5W2OOAB/RN1qt0Sr3nKZKFq7ecg+aF4fvd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB5689
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hello.

I am trying to work with a Franka Emika Panda Robot Arm and to do so I need=
 to run a real time kernel on my Linux PC.
This tutorial/walkthrough is my primary source of information-
https://frankaemika.github.io/docs/installation_linux.html#setting-up-the-r=
eal-time-kernel

I installed kernel 5.9.1 and added a rt patch which went fine but it did no=
t seem to run when chosen from the grub menu the screen went blank and noth=
ing seemed to happen.
I found that a rt patch existed for the current kernel 5.13. - uname -r ret=
urns 5.13.0-44-generic.
I remove the 5.9.1 files (possibly poorly as I failed to use --purge).
I then download and verify the new kernel and patch files.
Patch the kernel and set up .config file to choose Preemptable kernel (Real=
-Time).
Then I compile it, it produces linux-upstream files which I did not expect.
Making the kernel looked good and then fails with the following error-
Initially it gives the following warnings-

dpkg-source: warning: source directory 'linux-5.13' is not <sourcepackage>-=
<upstreamversion> 'linux-upstream-5.13.0-rt1'
dpkg-source: warning: .orig directory name linux-5.13.orig is not <package>=
-<upstreamversion> (wanted linux-upstream-5.13.0-rt1.orig)
dpkg-source: info: building linux-upstream using existing linux-upstream_5.=
13.0-rt1.orig.tar.gz
dpkg-source: info: building linux-upstream in linux-upstream_5.13.0-rt1-1.d=
iff.gz
dpkg-source: warning: ignoring deletion of file .scmversion
dpkg-source: warning: the diff modifies the following upstream files:

and then fails-

make[2]: *** [debian/rules:7: build-arch] Error 2
dpkg-buildpackage: error: debian/rules binary subprocess returned exit stat=
us 2
make[1]: *** [scripts/Makefile.package:77: deb-pkg] Error 2
make: *** [Makefile:1565: deb-pkg] Error 2

I re-did the command hoping it would just work, unsurprisingly it didn't an=
d gave the following output-
mailto:lab@panda:~/linux-5.13$ make -j8 deb-pkg
make clean
  CLEAN   arch/x86/crypto
  CLEAN   arch/x86/entry/vdso
  CLEAN   arch/x86/purgatory
  CLEAN   arch/x86/realmode/rm
  CLEAN   arch/x86/kernel/cpu
  CLEAN   arch/x86/kernel
  CLEAN   certs
  CLEAN   kernel/debug/kdb
  CLEAN   kernel
  CLEAN   usr
  CLEAN   fs/unicode
  CLEAN   arch/x86/tools
  CLEAN    resolve_btfids
sh ./scripts/package/mkdebian
  TAR     linux-upstream.tar.gz
origversion=3D$(dpkg-parsechangelog -SVersion |sed 's/-[^-]*$//');\
        mv linux-upstream.tar.gz ../linux-upstream_${origversion}.orig.tar.=
gz
dpkg-buildpackage -r"fakeroot -u" -a$(cat debian/arch)  -i.git -us -uc
dpkg-buildpackage: info: source package linux-upstream
dpkg-buildpackage: info: source version 5.13.0-rt1-1
dpkg-buildpackage: info: source distribution focal
dpkg-buildpackage: info: source changed by lab <lab@panda>
dpkg-buildpackage: info: host architecture amd64
 dpkg-source -i.git --before-build .
 debian/rules clean
rm -rf debian/*tmp debian/files
make clean
 dpkg-source -i.git -b .
dpkg-source: info: using source format '1.0'
dpkg-source: warning: source directory 'linux-5.13' is not <sourcepackage>-=
<upstreamversion> 'linux-upstream-5.13.0-rt1'
dpkg-source: warning: .orig directory name linux-5.13.orig is not <package>=
-<upstreamversion> (wanted linux-upstream-5.13.0-rt1.orig)
dpkg-source: info: building linux-upstream using existing linux-upstream_5.=
13.0-rt1.orig.tar.gz
dpkg-source: info: building linux-upstream in linux-upstream_5.13.0-rt1-1.d=
iff.gz
dpkg-source: error: cannot represent change to vmlinux-gdb.py:
dpkg-source: error:   new version is symlink to /home/lab/linux-5.13/script=
s/gdb/vmlinux-gdb.py
dpkg-source: error:   old version is nonexistent
dpkg-source: warning: ignoring deletion of file .scmversion
dpkg-source: warning: the diff modifies the following upstream files:
 .clang-format
 .cocciconfig
 .config.old
 .get_maintainer.ignore
 .mailmap
 CREDITS
 MAINTAINERS
 README
dpkg-source: info: use the '3.0 (quilt)' format to have separate and docume=
nted changes to upstream files, see dpkg-source(1)
dpkg-source: error: unrepresentable changes to source
dpkg-buildpackage: error: dpkg-source -i.git -b . subprocess returned exit =
status 1
make[1]: *** [scripts/Makefile.package:77: deb-pkg] Error 1
make: *** [Makefile:1565: deb-pkg] Error 2

I suspect I am having problems because I am making another kernel which is =
similar/identical to the current default.
Any help would be gratefully received.
Kind regards
Tony


[THE]
