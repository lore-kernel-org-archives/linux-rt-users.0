Return-Path: <SRS0=ig4c=ZQ=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E280C432C0
	for <linux-rt-users@archiver.kernel.org>; Sun, 24 Nov 2019 06:46:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02AAD2071A
	for <linux-rt-users@archiver.kernel.org>; Sun, 24 Nov 2019 06:46:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725890AbfKXGqt (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sun, 24 Nov 2019 01:46:49 -0500
Received: from pindarots.xs4all.nl ([82.161.210.87]:45272 "EHLO
        pindarots.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725813AbfKXGqt (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Sun, 24 Nov 2019 01:46:49 -0500
X-Greylist: delayed 2282 seconds by postgrey-1.27 at vger.kernel.org; Sun, 24 Nov 2019 01:46:49 EST
Received: from surfplank2.hierzo (localhost.localdomain [127.0.0.1])
        by pindarots.xs4all.nl (8.15.2/8.14.5) with ESMTPS id xAO68kgK366987
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Sun, 24 Nov 2019 07:08:46 +0100
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        RT <linux-rt-users@vger.kernel.org>
From:   Udo van den Heuvel <udovdh@xs4all.nl>
Subject: 5.2.21-rt13 WARN_ON(rt_mutex_owner(lock) != current)
Autocrypt: addr=udovdh@xs4all.nl; prefer-encrypt=mutual; keydata=
 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
 JjyRAfO8kEkwCkTZ6/Mnrxsunx9VNLGDEw==
Organization: hierzo
Message-ID: <1dd8d3b0-1fb3-c9fd-a4c3-935d60f0b034@xs4all.nl>
Date:   Sun, 24 Nov 2019 07:08:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hello,

Is the WARNING below rt-specific or what is happening here?
Please advise...


[  600.401576] ------------[ cut here ]------------
[  600.401583] DEBUG_LOCKS_WARN_ON(rt_mutex_owner(lock) != current)
[  600.401592] WARNING: CPU: 3 PID: 23306 at
kernel/locking/rtmutex-debug.c:145 debug_rt_mutex_unlock+0x48/0x50
[  600.401606] Modules linked in: act_police sch_ingress cls_u32 sch_sfq
sch_cbq pppoe pppox ip6table_raw nf_log_ipv6 ip6table_mangle xt_u32
xt_CT xt_nat nf_log_ipv4 nf_log_common xt_statistic nf_nat_sip
nf_conntrack_sip xt_recent xt_string xt_lscan(O) xt_TARPIT(O)
iptable_raw nf_nat_h323 nf_conn
track_h323 xt_TCPMSS xt_length xt_hl xt_tcpmss xt_owner xt_mac xt_mark
xt_multiport xt_limit nf_nat_irc nf_conntrack_irc xt_LOG xt_DSCP
xt_REDIRECT xt_MASQUERADE xt_dscp nf_nat_ftp nf_conntrack_ftp
iptable_mangle iptable_nat mq_deadline 8021q ipt_REJECT nf_reject_ipv4
iptable_filter ip6t_REJECT n
f_reject_ipv6 xt_state xt_conntrack ip6table_filter nct6775 ip6_tables
sunrpc amd_freq_sensitivity aesni_intel pl2303 aes_x86_64 amdgpu
snd_hda_codec_realtek glue_helper mfd_core snd_hda_codec_generic
crypto_simd cryptd gpu_sched drm_kms_helper syscopyarea sysfillrect
sysimgblt i2c_piix4 fb_sys_f
ops snd_hda_codec_hdmi ttm drm drm_panel_orientation_quirks cfbfillrect
snd_hda_intel cfbimgblt snd_hda_codec
[  600.401695]  cfbcopyarea snd_hda_core i2c_algo_bit snd_pcm fb fbdev
snd_timer backlight snd acpi_cpufreq sr_mod cdrom sd_mod autofs4
[  600.401710] CPU: 3 PID: 23306 Comm: fsfreeze Tainted: G           O
   5.2.21-rt13 #9
[  600.401714] Hardware name: To Be Filled By O.E.M. To Be Filled By
O.E.M./QC5000M-ITX/PH, BIOS P1.10 05/06/2015
[  600.401716] RIP: 0010:debug_rt_mutex_unlock+0x48/0x50
[  600.401721] Code: 75 02 f3 c3 e8 99 47 21 00 85 c0 74 f5 8b 05 ef 08
04 01 85 c0 75 eb 48 c7 c6 50 f9 d7 81 48 c7 c7 48 06 d7 81 e8 a9 29 fb
ff <0f> 0b c3 0f 1f 44 00 00 f3 c3 66 66 2e 0f 1f 84 00 00 00 00 00 0f
[  600.401726] RSP: 0018:ffffc900027d3d80 EFLAGS: 00010082
[  600.401727] RAX: 0000000000000000 RBX: ffff888136d6eb80 RCX:
ffffffff820708d8
[  600.401730] RDX: ffffffff82070a00 RSI: 0000000000000000 RDI:
ffffffff82070c50
[  600.401732] RBP: ffff888136d6e918 R08: ffffffff820708c0 R09:
0000000000000001
[  600.401734] R10: ffffffff82070900 R11: ffffc900027d3cc0 R12:
0000000000000292
[  600.401735] R13: ffffc900027d3d98 R14: ffff888136d6e470 R15:
ffffffff81162a0a
[  600.401738] FS:  00007f6b80d9d540(0000) GS:ffff88813b380000(0000)
knlGS:0000000000000000
[  600.401740] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  600.401742] CR2: 00007fc4a87fe430 CR3: 000000006382c000 CR4:
00000000000406a0
[  600.401745] Call Trace:
[  600.401750]  __rt_mutex_unlock+0x56/0xd0
[  600.401758]  percpu_up_write+0x1a/0x30
[  600.401763]  thaw_super_locked+0x10a/0x140
[  600.401769]  ? thaw_super_locked+0xaa/0x140
[  600.401773]  do_vfs_ioctl+0x5a4/0x6a0
[  600.401778]  ? __se_sys_newfstat+0x5a/0x70
[  600.401782]  ksys_ioctl+0x7b/0xa0
[  600.401785]  __x64_sys_ioctl+0x11/0x20
[  600.401788]  do_syscall_64+0x6d/0x310
[  600.401794]  ? __do_page_fault+0x242/0x510
[  600.401798]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  600.401803] RIP: 0033:0x7f6b80ccb34b
[  600.401806] Code: 0f 1e fa 48 8b 05 3d 9b 0c 00 64 c7 00 26 00 00 00
48 c7 c0 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa b8 10 00 00 00 0f
05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 0d 9b 0c 00 f7 d8 64 89 01 48
[  600.401811] RSP: 002b:00007ffecbbd7c48 EFLAGS: 00000246 ORIG_RAX:
0000000000000010
[  600.401812] RAX: ffffffffffffffda RBX: 0000000000000003 RCX:
00007f6b80ccb34b
[  600.401814] RDX: 0000000000000000 RSI: 00000000c0045878 RDI:
0000000000000003
[  600.401816] RBP: 0000000000000003 R08: 0000000000000001 R09:
0000000000000000
[  600.401817] R10: 0000000000000000 R11: 0000000000000246 R12:
0000000000000002
[  600.401819] R13: 00007ffecbbda0fe R14: 0000000000000000 R15:
0000000000000000
[  600.401822] ---[ end trace 0000000000000002 ]---


Kind regards,
Udo
