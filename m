Return-Path: <SRS0=zqoB=AT=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B97BC433E0
	for <linux-rt-users@archiver.kernel.org>; Wed,  8 Jul 2020 06:48:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A3D8206E2
	for <linux-rt-users@archiver.kernel.org>; Wed,  8 Jul 2020 06:48:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=trumpf.onmicrosoft.com header.i=@trumpf.onmicrosoft.com header.b="gZQR1tLG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729801AbgGHGsf (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 8 Jul 2020 02:48:35 -0400
Received: from mail-eopbgr140045.outbound.protection.outlook.com ([40.107.14.45]:55109
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726171AbgGHGse (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 8 Jul 2020 02:48:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MqkABRPmAzE5G7xnFXA1pnUAhQ+z62vEP427WvGQrnpKabyfLYe6q3ucM+s45LAgykfP3fwLgKUV9PKDdHCfnUT4K5QRFKpGHlPbftB/V2kFxdE9pjZaJGBNZSsruYTCzOki+xO/QmyJfxyvJ4YKjzfPkAAVys9LJkYpvx5lDIeA091FxngZXW/qX96H0V4nj/jVtq90r59D4JW9ptPZ3f/gglCAVR71wdiYHPcZfwf/HKdkDiW3jxZQrd/aMMZbsAc6n67dcSYE3KuastORbUz2wTEkoQdhhqvt9bgaWUy59Jgr2mvoWiEt4AlqxoBx4lY7j4jHc9ZMDEtkl0gI0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rFTYKnRyShn9LICXCMCRGZgWxVBfjvor9wd2LFoLXlQ=;
 b=XcJxr0hk0QsUcjUSjovCvXETasOD0GIPKgITmKZTqyBRN5Rt1o7hkw0PhaCwFxk6XS6VSo7Vc2gxReLfCFdj6r14+q485Oa2POqsQVOOy/vW67XuIzGdShseH/E+mQ114k8F93POAYUZoMX4j7cWWN0LCt42BeXB44wDJe3C+iKXnRnwaJSzahjAcs5Ub+dBgq9dtGe97PAklsGTJ+fh2Vd/u69uwsILcxbVe0rCj8fur2BrXyMLrYJacdE/Ii8FN8eX3uyCZvn+3nijSenLTduwgfeGNOzRMbLg1eATpk3qudqUyjCc07XUe1n2r6IkAYLVam2EU9fSDi7wIpEUyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=trumpf.com; dmarc=pass action=none header.from=trumpf.com;
 dkim=pass header.d=trumpf.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=trumpf.onmicrosoft.com; s=selector2-trumpf-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rFTYKnRyShn9LICXCMCRGZgWxVBfjvor9wd2LFoLXlQ=;
 b=gZQR1tLGRJqwbhXv45cGv1M36nHPbUXk2U2CS5voP+XhuHRqduTE36byo7p3vzjJnkP8xDenMsNyq0lBZL+HxeOxZzFYMqDQmXmoQv+ITwG8be+lhJF5gOPg8eNiV0J5M4o5/dbihwIFyKvrLyohYvfVTuKUaeKosPn3jS5k6b4=
Received: from AM0PR0302MB3220.eurprd03.prod.outlook.com (2603:10a6:208:a::11)
 by AM0PR03MB5028.eurprd03.prod.outlook.com (2603:10a6:208:fb::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.24; Wed, 8 Jul
 2020 06:48:29 +0000
Received: from AM0PR0302MB3220.eurprd03.prod.outlook.com
 ([fe80::744b:e287:24e0:77b3]) by AM0PR0302MB3220.eurprd03.prod.outlook.com
 ([fe80::744b:e287:24e0:77b3%7]) with mapi id 15.20.3153.029; Wed, 8 Jul 2020
 06:48:29 +0000
From:   "Buehler, Matthias" <Matthias.Buehler@trumpf.com>
To:     "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Subject: possible use after free in 4.9.228-rt147
Thread-Topic: possible use after free in 4.9.228-rt147
Thread-Index: AdZU86az+gnRgQnWT5Wv/cPQGbAIFw==
Date:   Wed, 8 Jul 2020 06:48:29 +0000
Message-ID: <AM0PR0302MB3220EBAD8D7ED10FCA23DF1EED670@AM0PR0302MB3220.eurprd03.prod.outlook.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=trumpf.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 86f6d63f-ef4d-416b-bbcc-08d8230aec6a
x-ms-traffictypediagnostic: AM0PR03MB5028:
x-microsoft-antispam-prvs: <AM0PR03MB5028DE51578D6E63B0811F8FED670@AM0PR03MB5028.eurprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 04583CED1A
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /I3xL4fvw4ng2agVI973Kmcmyre9+JOCrKwAtMHKldRF0g78VJLn5X1xOV+fNpQtOw7RzZBuEsI6z9yu3p7MzBKe9mnXdvt9QzCBnCc/49PzLed422vxDoHThBhZ7zgy5mPy8828PWdpJ0d5/5qr14n/jTHDFkPIFCDBqH6OSfzsDZB/d3NjcXP7EXCHB4zsa2rsigkq8xOlQ3RZdzYEFb/YgTMHdhMz18RxGR1nLYWgx8luJkN/h88U+ZHWBRNwXmJ1EMQUnOmQ4u4rvpnLN5DmSs+EGqEyo7CDGiE2TMUMQTqRfGQGIvhHeFxoLlCgnuPSD+HxYAT1aciJykEoSw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR0302MB3220.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(136003)(366004)(39850400004)(376002)(346002)(8936002)(86362001)(186003)(45080400002)(66446008)(2906002)(66556008)(64756008)(66476007)(316002)(7696005)(6506007)(33656002)(52536014)(8676002)(76116006)(71200400001)(5660300002)(9686003)(478600001)(26005)(6916009)(55016002)(66946007)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 0AMuwvAHKpKls0feaY/42QCQFSNdS/xYeNDWYzFrdxw9RZRPTiEimh275shnUs11cG0iAGBSb+MDL+vVxF+UMQC3cuhyGuxathZLeZ1GLRz3NaKe5B5hb1FAVufcgpAnNLe85ORg7d9ShB6eJOpMBXmhpBl83ayiDpWYJqulMz86basI3byB5KPeklSbTXoIZQqY96+D5tL1zwzHh/LpFJZqotc7VA7UW2Rr2V4RZT8mZawamGC+BlACOTMrnnwItevcQ0zgtq1DV0Qjtxv+Dms3IlWaWBchKcu2u4ITkijlQnMzYN32LzENHRPJw6xLDUzsp2BDunkv/B20hkHLOACg8hAbFYrg61hvgKknUyQ26zvn6jAt786Zwb6sgf4famUR0weDRi74z3xo6fOgToN01DwwKE35zFWQG+/0eC4Urg3pn60Inzd8npc8muOYhDaKiANyUgRWlvyTQV51zYgDxBVCondIZBI7Agm2lSc=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: trumpf.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR0302MB3220.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86f6d63f-ef4d-416b-bbcc-08d8230aec6a
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2020 06:48:29.4888
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: db4cfc4c-4ec7-41df-8bfe-b9f4983df1dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 24bTwvwoOKPhVCLKDKq5ry+FiAU5rFK2OwckOYpluJ8axbk1TWHyejBkP+JEBJmneNSX434t4NhqklUahrbRBYglgh49/qWmLw3/hF5bUeo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR03MB5028
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hello,

I found these bugs in 4.9.228-rt147:=20

[  665.048394] BUG: unable to handle kernel NULL pointer dereference at 000=
0000000000001
[  665.048404] IP: [<ffffffff81197daf>] kmem_cache_alloc+0x6f/0x1d0
[  665.048406] PGD 0=20
[  665.048406]=20
[  665.048409] Oops: 0000 [#1] PREEMPT SMP
[  665.048435] Modules linked in: ipt_MASQUERADE nf_nat_masquerade_ipv4 xt_=
nat nfsd=20
iptable_nat nf_nat_ipv4 nf_nat xt_hl nf_conntrack_ipv6 nf_defrag_ipv6 ip6ta=
ble_filter=20
ip6_tables nf_conntrack_ipv4 nf_defrag_ipv4 iptable_filter ip_tables rtc_pc=
f8563=20
coretemp rtc_cmos lm75 max6650 i2c_i801 i2c_smbus uio_cif uvcvideo videobuf=
2_vmalloc=20
videobuf2_memops videobuf2_v4l2 videobuf2_core videodev fuse ipv6 autofs4 w=
hiteheat=20
ti_usb_3410_5052 spcp8x5 safe_serial pl2303 oti6858 option usb_wwan mos7840=
 mos7720=20
mct_u232 keyspan_pda keyspan ezusb iuu_phoenix io_ti io_edgeport ftdi_sio f=
81232=20
empeg digi_acceleport cypress_m8 ch341 belkin_sa ark3116 aircable radeon tt=
m i915
[  665.048439] CPU: 0 PID: 4794 Comm: nmbd Not tainted 4.9.228-rt147cpx+ #1=
72
[  665.048440] Hardware name: VMware, Inc. VMware Virtual Platform/440BX De=
sktop=20
Reference Platform, BIOS 6.00 07/02/2015
[  665.048441] task: ffff88003a1063c0 task.stack: ffffc900038a8000
[  665.048445] RIP: 0010:[<ffffffff81197daf>]  [<ffffffff81197daf>] kmem_ca=
che_alloc+0x6f/0x1d0
[  665.048447] RSP: 0018:ffffc900038abb40  EFLAGS: 00010202
[  665.048448] RAX: 0000000000000000 RBX: ffff880037810e00 RCX: 00000000002=
6ebb0
[  665.048449] RDX: 000000000026eba8 RSI: 000000000026eba8 RDI: ffff8800000=
90700
[  665.048450] RBP: ffffc900038abb70 R08: 0000000000041fe0 R09: ffffffff816=
a21f2
[  665.048450] R10: ffffc900038abd18 R11: 0000000000000000 R12: 00000000020=
80020
[  665.048451] R13: 0000000000000001 R14: ffff880000090700 R15: ffff8800000=
90700
[  665.048453] FS:  00007fd37700f700(0000) GS:ffff88003fc00000(0000) knlGS:=
0000000000000000
[  665.048500] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  665.048514] CR2: 0000000000000001 CR3: 000000003dae6000 CR4: 00000000003=
606f0
[  665.048550] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000000=
00000
[  665.048551] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000000000=
00400
[  665.048552] Stack:
[  665.048555]  ffffc900038abb68 ffff880037810e00 0000000002080020 ffffffff=
81d11240
[  665.048557]  ffff880039cea300 0000000000004b00 ffffc900038abb90 ffffffff=
816a21f2
[  665.048559]  ffff880037810e00 ffff880037810f00 ffffc900038abc10 ffffffff=
817031c5
[  665.048560] Call Trace:
[  665.048571]  [<ffffffff816a21f2>] skb_clone+0x52/0xa0
[  665.048578]  [<ffffffff817031c5>] ip_mc_output+0x155/0x2a0
[  665.048581]  [<ffffffff81702a3c>] ? __ip_local_out+0xdc/0x140
[  665.048583]  [<ffffffff81700a10>] ? ip_forward_options+0x1b0/0x1b0
[  665.048586]  [<ffffffff81702ad5>] ip_local_out+0x35/0x40
[  665.048589]  [<ffffffff81703d39>] ip_send_skb+0x19/0x40
[  665.048592]  [<ffffffff8172bb54>] udp_send_skb+0x114/0x2b0
[  665.048594]  [<ffffffff8172de17>] udp_sendmsg+0x4f7/0x9b0
[  665.048597]  [<ffffffff81701a20>] ? ip_reply_glue_bits+0x50/0x50
[  665.048601]  [<ffffffff8173883f>] inet_sendmsg+0x7f/0xb0
[  665.048604]  [<ffffffff81699288>] sock_sendmsg+0x38/0x50
[  665.048606]  [<ffffffff8169a793>] SyS_sendto+0xf3/0x140
[  665.048612]  [<ffffffff810d3449>] ? ktime_get_ts64+0x49/0xf0
[  665.048615]  [<ffffffff81002bab>] do_syscall_64+0x5b/0xd0
[  665.048621]  [<ffffffff817aec7e>] entry_SYSCALL_64_after_swapgs+0x58/0xc=
6
[  665.048645] Code: 48 8b 51 08 48 89 c8 65 48 03 05 b5 53 e7 7e 48 8b 70 =
08 48=20
39 f2 75 e7 4c 8b 28 4d 85 ed 74 6d 49 63 46 20 4d 8b 06 48 8d 4a 08 <49> 8=
b 5c 05=20
00 4c 89 e8 65 49 0f c7 08 0f 94 c0 84 c0 74 bd 49=20
[  665.048647] RIP  [<ffffffff81197daf>] kmem_cache_alloc+0x6f/0x1d0
[  665.048648]  RSP <ffffc900038abb40>
[  665.048649] CR2: 0000000000000001
[  665.243152] ---[ end trace 0000000000000002 ]---

and=20

[  576.690934] general protection fault: 0000 [#1] PREEMPT SMP
[  576.690960] Modules linked in: ipt_MASQUERADE nf_nat_masquerade_ipv4 xt_=
nat nfsd=20
iptable_nat nf_nat_ipv4 nf_nat xt_hl nf_conntrack_ipv6 nf_defrag_ipv6 ip6ta=
ble_filter=20
ip6_tables nf_conntrack_ipv4 nf_defrag_ipv4 iptable_filter ip_tables rtc_pc=
f8563=20
coretemp rtc_cmos lm75 max6650 i2c_i801 i2c_smbus uio_cif uvcvideo videobuf=
2_vmalloc=20
videobuf2_memops videobuf2_v4l2 videobuf2_core videodev fuse ipv6 autofs4 w=
hiteheat=20
ti_usb_3410_5052 spcp8x5 safe_serial pl2303 oti6858 option usb_wwan mos7840=
 mos7720=20
mct_u232 keyspan_pda keyspan ezusb iuu_phoenix io_ti io_edgeport ftdi_sio f=
81232=20
empeg digi_acceleport cypress_m8 ch341 belkin_sa ark3116 aircable radeon tt=
m i915
[  576.690963] CPU: 0 PID: 11963 Comm: kworker/0:0 Not tainted 4.9.228-rt14=
7cpx+=20
#170
[  576.690965] Hardware name: VMware, Inc. VMware Virtual Platform/440BX De=
sktop=20
Reference Platform, BIOS 6.00 07/02/2015
[  576.690975] Workqueue: events key_garbage_collector
[  576.690977] task: ffff8800397663c0 task.stack: ffffc90004000000
[  576.690985] RIP: 0010:[<ffffffff8139ccfa>]  [<ffffffff8139ccfa>] rb_next=
+0x1a/0x50
[  576.690986] RSP: 0018:ffffc90004003dd8  EFLAGS: 00010286
[  576.690987] RAX: ff880039484308ff RBX: 7fffffffffffffff RCX: 00000000000=
00000
[  576.690988] RDX: ff88003781050914 RSI: ffff8800397663c0 RDI: ffff8800378=
10f08
[  576.690989] RBP: ffffc90004003dd8 R08: ffff88003ca61100 R09: 00000000000=
00000
[  576.690990] R10: ffff8800370ee080 R11: 0000000000000000 R12: ffff8800397=
663c0
[  576.690991] R13: ffff8800397663c0 R14: 000000005efc6657 R15: ffff8800378=
10f08
[  576.690993] FS:  0000000000000000(0000) GS:ffff88003fc00000(0000) knlGS:=
0000000000000000
[  576.691036] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  576.691050] CR2: 00007f2113b2c000 CR3: 000000003a5bd000 CR4: 00000000003=
606f0
[  576.691088] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000000=
00000
[  576.691089] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000000000=
00400
[  576.691090] Stack:
[  576.691093]  ffffc90004003e28 ffffffff8133bef3 ffff880039766970 ffff8800=
370e0000
[  576.691095]  ffffc90004003e40 ffff88003d5236c0 ffff88003fc3e340 00000000=
00000000
[  576.691097]  ffff88003fc42b00 ffffffff81cc3e60 ffffc90004003e68 ffffffff=
8107b035
[  576.691098] Call Trace:
[  576.691104]  [<ffffffff8133bef3>] key_garbage_collector+0xa3/0x3d0
[  576.691112]  [<ffffffff8107b035>] process_one_work+0x145/0x450
[  576.691114]  [<ffffffff8107b3a9>] worker_thread+0x69/0x4f0
[  576.691117]  [<ffffffff8107b340>] ? process_one_work+0x450/0x450
[  576.691120]  [<ffffffff810806ac>] kthread+0xec/0x110
[  576.691122]  [<ffffffff810805c0>] ? kthread_park+0x60/0x60
[  576.691128]  [<ffffffff817aed8e>] ret_from_fork+0x3e/0x50
[  576.691151] Code: 52 08 48 85 d2 75 eb 5d c3 31 c0 5d c3 0f 1f 40 00 55 =
48 8b=20
17 48 89 e5 48 39 d7 74 35 48 8b 47 08 48 85 c0 75 05 eb 1a 48 89 d0 <48> 8=
b 50 10=20
48 85 d2 75 f4 5d c3 48 3b 79 08 75 11 48 8b 11 48=20
[  576.691154] RIP  [<ffffffff8139ccfa>] rb_next+0x1a/0x50
[  576.691155]  RSP <ffffc90004003dd8>
[  576.832119] ---[ end trace 0000000000000002 ]---

Digging into this showed that this happens when sending rt signals to rt pr=
ocesses.
When sending rt signals to a rt process and at the same time connecting mul=
tiple
times via ssh triggered the bug within minutes.

When searching for a reason I stumbled over a this commit by Linus:

4306259ff6b8b682322d9aeb0c12b27c61c4a548
signal: avoid double atomic counter increments for user accounting
[ Upstream commit fda31c50292a5062332fa0343c084bd9f46604d9 ]

These changes were not back ported to the following rt patch by Thomas whic=
h=20
resulted in a possible use after free:

bbe92cd3d383dafe071b0f1c45b3603b8666fb88
signals: Allow rt tasks to cache one sigqueue struct
To avoid allocation allow rt tasks to cache one sigqueue struct in
task struct.

So with the following changes I could not reproduce the bugs:

diff --git a/kernel/signal.c b/kernel/signal.c
index aca4b4cd11a2..1f335772615c 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -456,8 +456,8 @@ static void sigqueue_free_current(struct sigqueue *q)
=20
        up =3D q->user;
        if (rt_prio(current->normal_prio) && !put_task_cache(current, q)) {
-               atomic_dec(&up->sigpending);
-               free_uid(up);
+               if (atomic_dec_and_test(&q->user->sigpending))
+                 free_uid(up);
        } else
                  __sigqueue_free(q);
 }

When answering to this mail could you please cc me for I am not subscribed =
to=20
linux-rt-users list.

Thanks and kind regards,
Matthias
