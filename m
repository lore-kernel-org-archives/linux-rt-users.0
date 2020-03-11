Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by archive.lwn.net (Postfix) with ESMTP id 05C007D910
	for <lwn-linux-rt-users@archive.lwn.net>; Wed, 11 Mar 2020 16:32:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730096AbgCKQcO (ORCPT
        <rfc822;lwn-linux-rt-users@archive.lwn.net>);
        Wed, 11 Mar 2020 12:32:14 -0400
Received: from mail-eopbgr140045.outbound.protection.outlook.com ([40.107.14.45]:58109
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730052AbgCKQcO (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 11 Mar 2020 12:32:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mKZerbnfM8fok4pPBK8oR6oWRHjoBMcmrnvCef0eKAQ8FJMp/JXGTh0ZT8N08w2jiCXy4GBb0SD0YwH5PqD8BLa1rvNTv9C3MYjYWT15agMDnzWLN/OGt/uuubVNAOsNfXETQnXQGLJGtHsGZC2Vg38Lc648OiWL/gDtgT1uFmstCiukx8g144uAwHt50JOEFMho8Kh5YolWaDigEfFJGizbsdHLC5WT3N4UCKV6WhMjidnMot3lVYIxI3taI18oPafcMe+q9WRFfCYGZra+OP6NvPQutE4m/cbMdbOGswMC0i0L17ojsaDRMzCuQOCmGl6AUdH60hr/cSi6ftzLzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p3aSb2P2Krp3lIJuPGDBDrpcchwcBTBR+142W5LSTcU=;
 b=NgT4D02QhDzLnwayPwfh4XSWf9SKY2mrMdZuvOTpgR4dcEcRaMlD2C/UbFn7rf7mVvITY6lYnrBMUvrfGwDdfqL+qQFPTdOOTAI3wTpUNLYpSS4et76Oy5WzQc8iPY8BlfZY2GYNiPDH6fZvVfL1g//B2Q1EqSw+8K1MSSaZm4wvvQJalTRYyoYW5IHOovAe87nNSTlasbijxeOPQeiaS8U9lBieGOJPkVO4qOSktx9apRNkZz67dB7c9+Xz7HoLJwhElQfR0x8s7mbnjsNps+RlFfCxxi+5gFamG8vREpZ7eBm9UijIS73NhTDUhiosxpwizbp/8NSHpeRXT8ybTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p3aSb2P2Krp3lIJuPGDBDrpcchwcBTBR+142W5LSTcU=;
 b=p/UL85iEt4hYkNyxr7wKS/WodJxkNgVEnjpbAaRKQBXHgEpvNGjTuTH3NkM8IseNgch0v+P4n/T8OmHfpuImqgCbBw90IwpYqvT27RU4CLPqEu7Rx+KErMuQIHM77mmQ2vBLxtmQfB+cIctpl629E+oeLgSMqLXZys4ZnSIswgQ=
Received: from DB3PR0402MB3708.eurprd04.prod.outlook.com (52.134.70.139) by
 DB3PR0402MB3755.eurprd04.prod.outlook.com (52.134.71.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.17; Wed, 11 Mar 2020 16:32:04 +0000
Received: from DB3PR0402MB3708.eurprd04.prod.outlook.com
 ([fe80::9c7:bde0:8d1d:e6ce]) by DB3PR0402MB3708.eurprd04.prod.outlook.com
 ([fe80::9c7:bde0:8d1d:e6ce%4]) with mapi id 15.20.2793.013; Wed, 11 Mar 2020
 16:32:04 +0000
From:   Marouen Ghodhbane <marouen.ghodhbane@nxp.com>
To:     "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Subject: complete_all warning with 3 waiters
Thread-Topic: complete_all warning with 3 waiters
Thread-Index: AdX3wkCZEtHecTYWRr+nbNN5fw+/fQ==
Date:   Wed, 11 Mar 2020 16:32:03 +0000
Message-ID: <DB3PR0402MB3708A4D019B384FE29CBDD96F6FC0@DB3PR0402MB3708.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=marouen.ghodhbane@nxp.com; 
x-originating-ip: [37.71.179.194]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: cfbd9319-7d9a-44d4-1f7e-08d7c5d9bb83
x-ms-traffictypediagnostic: DB3PR0402MB3755:
x-microsoft-antispam-prvs: <DB3PR0402MB3755013F5B6555637CB70C27F6FC0@DB3PR0402MB3755.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:459;
x-forefront-prvs: 0339F89554
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(39860400002)(136003)(396003)(346002)(376002)(199004)(5660300002)(66946007)(66446008)(33656002)(64756008)(6506007)(86362001)(66556008)(76116006)(55016002)(52536014)(7696005)(66476007)(44832011)(71200400001)(9686003)(8676002)(2906002)(81156014)(478600001)(26005)(81166006)(6916009)(316002)(8936002)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3755;H:DB3PR0402MB3708.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: I8thQk7zxoZRmAf7v4xuzaWY6CUC4aJ3KnFrxEDPMlNuNpqhHamjqjai0Zeh0ccl8yRWy+7/p9ct1YspdWzbBwPK2gvA08l6jiWknsZAw7Uw34KfwYVzuvoPAwq3aS4I28wl49bcO6ozVX6X18Ux+H5Gu+5jPfLshxx44JgHnj/iugM0d2h3a9rwcPqcZI+8ZjTVGoslxAIaWktPohNmxEntKGKA6TJn3Lhi6E8CunzjwftCVal9hT7f/vv9Uoa5fA3fPa2DgKs0FYYwIZ+c526ZZU1cYL5hzuU9qC007hAnazE6s1JwOSLzIm1XLOMes1B8WsBVx1QdqwS992lrsdJc8514I5XQvATioY90Quv6lerEvIbaDEOdvZYl0vVUhslhRNvftxCtL3kw/f4t5DZwvYx+LymVIYIMQnbjvWRULvjxpDzPhS//WMGHL1FM
x-ms-exchange-antispam-messagedata: fs+P0xB1L3730NDClhSFDlutxV+61ghz31trKuh87ocKUUkPlNPQQRLvw/QNWH54FB/RBtuFpa0b6GOZ2uXbKvMVC3iS45Kh9UvybjEhpKZVS18IQypVZz2GQH37t0Wf+8TmIMp8oBVymYM5Hdubtg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfbd9319-7d9a-44d4-1f7e-08d7c5d9bb83
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2020 16:32:03.9742
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LnEjGjUjC3TfCbxfvOTPk8dM6wG/pUH0RFnX+kMiLNqrzj5kC2JKIdLfFel08ugxNZpQcLLFOkOP4bBFkVsNv+Hb7e+nIvlvC5MQVaEvzXc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3755
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org
Archived-At: <http://archive.lwn.net:8080/linux-rt-users/DB3PR0402MB3708A4D019B384FE29CBDD96F6FC0@DB3PR0402MB3708.eurprd04.prod.outlook.com/>
List-Archive: <http://archive.lwn.net:8080/linux-rt-users/>
List-Post: <mailto:linux-rt-users@vger.kernel.org>

Hello everyone,

I am running the Linux RT kernel 4.14.78-rt47 on an i.MX8MMini when i encou=
ntered the swake_up_all_locked() warning with "complete_all() with 3 waiter=
s" on the sdma controller probe.


[ 9.455488] complete_all() with 3 waiters
[ 9.455498] -----------[ cut here ]-----------
[ 9.455515] WARNING: CPU: 1 PID: 3450 at /usr/src/kernel/kernel/sched/swait=
.c:49 swake_up_all_locked+0xa4/0xb8
[ 9.455529] CPU: 1 PID: 3450 Comm: systemd-udevd Tainted: G O 4.14.78-rt47+=
g66620c3 #1
[ 9.455531] Hardware name: FSL i.MX8MM EVK board (DT)
[ 9.455534] task: ffff800072895a00 task.stack: ffff00001a5f0000
[ 9.455539] PC is at swake_up_all_locked+0xa4/0xb8
[ 9.455543] LR is at swake_up_all_locked+0xa4/0xb8
[ 9.455548] pc : [<ffff0000081095bc>] lr : [<ffff0000081095bc>] pstate: 800=
001c5
[ 9.455550] sp : ffff00001a5f3cc0
[ 9.455552] x29: ffff00001a5f3cc0 x28: ffff800072895a00
[ 9.455559] x27: ffff000008d81000 x26: 0000000000000040
[ 9.455562] x25: 0000000000000124 x24: 0000000000000015
[ 9.455568] x23: 0000000000000002 x22: ffff800076c73430
[ 9.455572] x21: 0000000000000003 x20: ffff800076c73428
[ 9.455576] x19: ffff000009eabce0 x18: 0000000000000001
[ 9.455580] x17: 0000ffffb547bcb0 x16: ffff000008209700
[ 9.455584] x15: ffff0000094c3000 x14: 00000000fffffff0
[ 9.455588] x13: ffff000009651b18 x12: ffff0000094c3000
[ 9.455591] x11: 0000000000000000 x10: ffff000009651000
[ 9.455595] x9 : 0000000000000000 x8 : ffff0000096610a3
[ 9.455599] x7 : 0000000000000000 x6 : 0000000005ca3ab7
[ 9.455602] x5 : 0000000000000000 x4 : 0000000000000000
[ 9.455606] x3 : ffffffffffffffff x2 : 0000800074ae6000
[ 9.455610] x1 : ffff800072895a00 x0 : 000000000000001d
[ 9.455616] Call trace:
[ 9.455620] Exception stack(0xffff00001a5f3b80 to 0xffff00001a5f3cc0)
[ 9.455624] 3b80: 000000000000001d ffff800072895a00 0000800074ae6000 ffffff=
ffffffffff
[ 9.455628] 3ba0: 0000000000000000 0000000000000000 0000000005ca3ab7 000000=
0000000000
[ 9.455632] 3bc0: ffff0000096610a3 0000000000000000 ffff000009651000 000000=
0000000000
[ 9.455637] 3be0: ffff0000094c3000 ffff000009651b18 00000000fffffff0 ffff00=
00094c3000
[ 9.455641] 3c00: ffff000008209700 0000ffffb547bcb0 0000000000000001 ffff00=
0009eabce0
[ 9.455646] 3c20: ffff800076c73428 0000000000000003 ffff800076c73430 000000=
0000000002
[ 9.455652] 3c40: 0000000000000015 0000000000000124 0000000000000040 ffff00=
0008d81000
[ 9.455657] 3c60: ffff800072895a00 ffff00001a5f3cc0 ffff0000081095bc ffff00=
001a5f3cc0
[ 9.455663] 3c80: ffff0000081095bc 00000000800001c5 ffff800076c73430 000000=
0000000000
[ 9.455668] 3ca0: 0000ffffffffffff 0000000000000004 ffff00001a5f3cc0 ffff00=
00081095bc
[ 9.455674] [<ffff0000081095bc>] swake_up_all_locked+0xa4/0xb8
[ 9.455681] [<ffff000008109bcc>] complete_all+0x34/0x50
[ 9.455690] [<ffff0000086cc338>] firmware_loading_store+0x168/0x218
[ 9.455696] [<ffff0000086ab7a0>] dev_attr_store+0x18/0x28
[ 9.455704] [<ffff000008288f6c>] sysfs_kf_write+0x3c/0x50
[ 9.455709] [<ffff000008288208>] kernfs_fop_write+0x118/0x1e8
[ 9.455714] [<ffff000008209190>] __vfs_write+0x18/0x118
[ 9.455718] [<ffff000008209484>] vfs_write+0xa4/0x1b0
[ 9.455724] [<ffff000008209748>] SyS_write+0x48/0xb0
[ 9.455729] Exception stack(0xffff00001a5f3ec0 to 0xffff00001a5f4000)
[ 9.455733] 3ec0: 000000000000000f 0000aaab040673f0 0000000000000002 0000ff=
ffb556e190
[ 9.455738] 3ee0: 0000000000000040 0000000000000000 0000000000000000 000000=
000000000a
[ 9.455742] 3f00: 0000000000000040 0000ffffb53c8c90 0000000000000040 000000=
0000000000
[ 9.455746] 3f20: 0000000000000001 000000000000270f 0000000000000000 000000=
0000000000
[ 9.455750] 3f40: 0000aaaad73f9948 0000ffffb547bcb0 0000ffffb5569a70 000000=
000000000f
[ 9.455754] 3f60: 0000aaab040673f0 0000aaab0406a6e0 0000000000000002 0000aa=
ab040673f0
[ 9.455758] 3f80: 0000000000000002 0000aaab040418c0 0000000000000001 000000=
0000000b12
[ 9.455763] 3fa0: 0000aaaad73b85a8 0000ffffcaab8510 0000ffffb54884dc 0000ff=
ffcaab8510
[ 9.455767] 3fc0: 0000ffffb54dbd4c 0000000020000000 000000000000000f 000000=
0000000040
[ 9.455771] 3fe0: 0000000000000000 0000000000000000 0000000000000000 000000=
0000000000
[ 9.455776] [<ffff000008083b58>] __sys_trace_return+0x0/0x4
[ 9.455779] --[ end trace 0000000000000002 ]--
[ 9.457052] imx-sdma 302b0000.dma-controller: loaded firmware 4.4
[ 9.458193] imx-sdma 302c0000.dma-controller: loaded firmware 4.4
[ 9.481511] imx-sdma 30bd0000.dma-controller: loaded firmware 4.4

In fact, there is 3 sdma controller devices on the target pointing to the s=
ame firmware file and the imx-sdma driver is requesting the firmware asynch=
ronously with request_firmware_nowait(). The request_firmware API in linux =
is making all waiters, requesting the same firmware file, wait on the same =
completion which triggers this warning.
I checked the linux-5.4.y-rt branch but the same warning is there.
My question is: is there any good reason for the value of 2 in the warning =
condition ? It seems to me like a warning put earlier to check if we trigge=
r this condition and work on some unresolved issues. Do we need another fil=
ter like the pm_in_action ?=20
Any idea/suggestion is definitely appreciated

Best Regards,
Marouen.
