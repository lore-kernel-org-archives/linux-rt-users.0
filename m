Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ED54C433B4
	for <linux-rt-users@archiver.kernel.org>; Thu, 22 Apr 2021 04:04:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F64A6142B
	for <linux-rt-users@archiver.kernel.org>; Thu, 22 Apr 2021 04:04:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbhDVEEs convert rfc822-to-8bit (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 22 Apr 2021 00:04:48 -0400
Received: from esa3.mentor.iphmx.com ([68.232.137.180]:62298 "EHLO
        esa3.mentor.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbhDVEEr (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 22 Apr 2021 00:04:47 -0400
IronPort-SDR: qyCgpIKDDsvv9piarnWHWxQqpTgPyjNlk5tmUcwxVN5DAWfrOdgygjLgkDUXTZ3x2toH1mTo1W
 nrilSuAEdAcmjFwGzu2DrPT7ue05D7SY39nNQ6fQzmZx4n6Sr71R+14Zkp4dYhC2WT5uDONcdc
 Vd2dpZnA4Lzjg4VsYgdN8dhgoiAjAvCD8WrLs76okGCpFTG0HGrth/7Qndfjkcl+9owMEeCnaJ
 tDATi2UXA1acO3caQK5QLCLys8doEMV2hp4dZAq5iJcdKIU9/VxiMklRLQQvbgd7sye1LNi4Jt
 FjQ=
X-IronPort-AV: E=Sophos;i="5.82,241,1613462400"; 
   d="scan'208";a="60405817"
Received: from orw-gwy-02-in.mentorg.com ([192.94.38.167])
  by esa3.mentor.iphmx.com with ESMTP; 21 Apr 2021 20:04:10 -0800
IronPort-SDR: DTzJVoCAzI9ab4nnXsW0ahA9P6IHnhL1kKYX95vmW/blweGYPodC4FrajPDT75KFJxd0yBviVh
 tKOTp8nYp+AoIMyO7loVydhghvDOQZVPnfzBC8TG/jRVgvRE6f/8P64mKXtNM5UZt9nKPWHgO0
 SVyG0PBcozPrkxXy0K4Vep1aqCsHhcXKdrg8NuEjKY8ZOHo0Jd1xJYfMWfWtLPOcbxNgry41rH
 5bQo2A6NaE/T6LpyhDzO5GZ9sz2rNsM3F5dLVBmwc1OBMgI6JD8ZjNiwtL5atVIUWD/VY2WjsT
 YUY=
From:   "Deety, Venkata Sai Ganesh" <VenkataSaiGanesh_Deety@mentor.com>
To:     "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Krishnakar, Srikanth" <Srikanth_Krishnakar@mentor.com>
Subject: Blank screen after multiple reboots
Thread-Topic: Blank screen after multiple reboots
Thread-Index: Adc3LINk4txB0QumT72XX4ytQCXl6A==
Date:   Thu, 22 Apr 2021 04:04:07 +0000
Message-ID: <ddbbf9ee49e34e0883370695177e6bc0@svr-orw-mbx-02.mgc.mentorg.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [147.34.91.1]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi,

We are facing below issue:
Upon multiple reboots(~300) each with a duration of 15 seconds, display gets blank(stuck) and below crash is observed during boot with 4.19.165-cip41-rt18 kernel.
With non-RT kernel (4.19.165-cip41) no such blank screen/crash is observed when tested for more than 5000+ reboots

Pre-condition: GNOME(3.30.2) is installed.
Hardware: Intel(R) Core(TM) i3-6102E
Graphics: Intel(R) HD Graphics 530 (Skylake GT2)
Kernel: 4.19.165-cip41-rt18

[    6.917341] ------------[ cut here ]------------
[    6.917359] WARNING: CPU: 2 PID: 486 at kernel/softirq.c:1025 tasklet_action_common.isra.17.cold.25+0xc/0x4d
[    6.917361] Modules linked in: acpi_cpufreq(E+) mei_me(E+) mei(E) intel_pch_thermal(E+) i915(E+) drm_kms_helper(E) drm(E) fb_sys_fops(E) video(E) syscopyarea(E) pcc_cpufreq(E) sysfillrect(E) xt_recent(E) sysimgblt(E) acpi_pad(E) button(E) ip6t_REJECT(E) nf_reject_ipv6(E) xt_hl(E) ip6_tables(E) ip6t_rt(E) ipt_REJECT(E) nf_reject_ipv4(E) xt_comment(E) nft_limit(E) xt_limit(E) xt_addrtype(E) xt_tcpudp(E) xt_conntrack(E) nft_compat(E) nft_counter(E) nf_conntrack_netbios_ns(E) nf_conntrack_broadcast(E) nf_nat_ftp(E) nf_nat(E) nf_conntrack_ftp(E) nf_conntrack(E) nf_defrag_ipv6(E) nf_defrag_ipv4(E) nf_tables(E) nfnetlink(E) nvram(E) ipc4x7e_wdt(OE) ip_tables(E) x_tables(E) ext4(E) crc16(E) mbcache(E) jbd2(E) fscrypto(E) raid10(E) raid456(E) async_raid6_recov(E) async_memcpy(E) async_pq(E) async_xor(E) async_tx(E)
[    6.917409]  libcrc32c(E) crc32c_generic(E) xor(E) hid_generic(E) usbhid(E) hid(E) raid6_pq(E) raid1(E) raid0(E) multipath(E) linear(E) md_mod(E) sd_mod(E) ahci(E) libahci(E) libata(E) xhci_pci(E) igb(E) xhci_hcd(E) i2c_algo_bit(E) crc32c_intel(E) dca(E) e1000e(E) scsi_mod(E) i2c_i801(E) usbcore(E) psmouse(E)
[    6.917445] CPU: 2 PID: 486 Comm: irq/138-i915 Tainted: G           OE     4.19.165-cip41-rt18+ind1 #1
[    6.917447] Hardware name: SIEMENS AG SIMATIC IPC427E/A5E41334516, BIOS V21.01.12 10/23/2019
[    6.917453] RIP: 0010:tasklet_action_common.isra.17.cold.25+0xc/0x4d
[    6.917456] Code: c1 83 af e8 9a 3d 06 00 0f 0b e9 50 f2 ff ff 48 c7 c7 50 c1 83 af e8 87 3d 06 00 0f 0b c3 48 c7 c7 50 c1 83 af e8 78 3d 06 00 <0f> 0b e9 03 f7 ff ff 48 8b 75 08 48 c7 c7 5f 08 85 af e8 61 3d 06
[    6.917458] RSP: 0018:ffffb96c81cdfe18 EFLAGS: 00010246
[    6.917461] RAX: 0000000000000024 RBX: ffff9923f3a32380 RCX: 0000000000000000
[    6.917463] RDX: 0000000000000000 RSI: ffffffffaf883597 RDI: 00000000ffffffff
[    6.917464] RBP: ffff9923f3a32378 R08: 0000000000000034 R09: 0000000000000003
[    6.917465] R10: 0000000000000000 R11: 0000000000000001 R12: 00000000000f4240
[    6.917467] R13: 0000000000000000 R14: ffff9923f3a34378 R15: 0000000000000000
[    6.917469] FS:  0000000000000000(0000) GS:ffff9923f5b00000(0000) knlGS:0000000000000000
[    6.917471] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    6.917473] CR2: 000055a22e33c290 CR3: 00000001ec00e002 CR4: 00000000003606e0
[    6.917475] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[    6.917476] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[    6.917477] Call Trace:
[    6.917488]  do_current_softirqs+0x223/0x3f0
[    6.917496]  ? irq_finalize_oneshot.part.47+0xf0/0xf0
[    6.917501]  __local_bh_enable+0x55/0x60
[    6.917506]  irq_forced_thread_fn+0x5e/0x80
[    6.917511]  irq_thread+0xdd/0x180
[    6.917516]  ? wake_threads_waitq+0x30/0x30
[    6.917522]  ? irq_thread_check_affinity+0xc0/0xc0
[    6.917527]  kthread+0x159/0x170
[    6.917531]  ? kthread_create_worker_on_cpu+0x70/0x70
[    6.917535]  ret_from_fork+0x35/0x40
[    6.917542] ---[ end trace 0000000000000002 ]---

Can you please guide us regarding what might be causing this issue and how to fix it. Thank You.

Best Regards,
VenkataSaiGanesh D

