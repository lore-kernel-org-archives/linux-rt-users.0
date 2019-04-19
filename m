Return-Path: <SRS0=CW9N=SV=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5DEBC282DF
	for <linux-rt-users@archiver.kernel.org>; Fri, 19 Apr 2019 20:35:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 609FD20869
	for <linux-rt-users@archiver.kernel.org>; Fri, 19 Apr 2019 20:35:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbfDSUfL (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 19 Apr 2019 16:35:11 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54928 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726163AbfDSUfL (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 19 Apr 2019 16:35:11 -0400
Received: by mail-wm1-f67.google.com with SMTP id c1so7292629wml.4
        for <linux-rt-users@vger.kernel.org>; Fri, 19 Apr 2019 13:35:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Gq8hrkPNbHWoyzDv0kmkxXLrs8YRr4oIOG6+6ZQxoEI=;
        b=GKwD/yOBjNNYftIjYj0A1TUok5QK+SUy68LLcqb/2eesuP4gWAnq/VK5KfalZQp8S0
         usMgeLPgD8+8mx90J29cpBZGNdQ+6ik0VNV06hslfbul2NCQ41czn0sNgMRJ006CaYuC
         ze39Cuj8qgbtTGim2S+lYecKVnBRZTallkJxdrDs+Dzh7uiQ4C++C8rOnBwEt/wfZRVc
         URUlf99vA6+kIHt6sXuVmVLWBR7ZRZlH4lf1I5jFDmEnKkuuWML2FMWOt66leUQiBgEh
         voiLQhjMD8WdFZL/s9l5loNdi3C203xrzNWg9fXtsF1VLpS4oCIEXqruP4fuwoFakDTi
         rhLQ==
X-Gm-Message-State: APjAAAWzjIpm3KNxwCYhoHwnDKLauZvRSRIl9SkA5MnP4+nt/8shZ+vi
        OBU4c/hCG4fWgTctyrh9oVqsxaSMPg8=
X-Google-Smtp-Source: APXvYqxM2jbHMtajlorqfhMeosbjqV9HlKhYhMr3ty7SVxUCb/HTPxWxJhKHv0AP5EfFvhs6ctB0Ag==
X-Received: by 2002:a1c:730c:: with SMTP id d12mr1803615wmb.47.1555664190278;
        Fri, 19 Apr 2019 01:56:30 -0700 (PDT)
Received: from localhost.localdomain ([151.29.174.33])
        by smtp.gmail.com with ESMTPSA id d7sm4289455wmf.31.2019.04.19.01.56.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 19 Apr 2019 01:56:29 -0700 (PDT)
Date:   Fri, 19 Apr 2019 10:56:27 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     linux-rt-users <linux-rt-users@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Clark Williams <williams@redhat.com>
Subject: Re: [RT WARNING] DEBUG_LOCKS_WARN_ON(rt_mutex_owner(lock) !=
 current) with fsfreeze (4.19.25-rt16)
Message-ID: <20190419085627.GI4742@localhost.localdomain>
References: <20190326093421.GA29508@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190326093421.GA29508@localhost.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 26/03/19 10:34, Juri Lelli wrote:
> Hi,
> 
> Running this reproducer on a 4.19.25-rt16 kernel (with lock debugging
> turned on) produces warning below.

And I now think this might lead to an actual crash.

I've got what below while running xfstest suite [1] on 4.19.31-rt18.
generic/390 test seems able to reliable reproduce it
https://github.com/kdave/xfstests/blob/master/tests/generic/390

--->8---
[  275.798877] run fstests generic/390 at 2019-04-19 08:31:44
[  276.538394] XFS (loop1): Unmounting Filesystem
[  277.309404] ------------[ cut here ]------------
[  277.309406] DEBUG_LOCKS_WARN_ON(rt_mutex_owner(lock) != current)
[  277.309421] WARNING: CPU: 4 PID: 2012 at kernel/locking/rtmutex-debug.c:145 debug_rt_mutex_unlock+0x47/0x50
[  277.309422] Modules linked in: loop xfs ip6t_rpfilter ip6t_REJECT nf_reject_ipv6 xt_conntrack ebtable_nat ip6table_nat nf_nat_ipv6 ip6table_mangle ip6table_raw ip6table_security iptable_nat nf_nat_ipv4 nf_nat iptable_mangle iptable_raw iptable_security nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 libcrc32c ip_set nfnetlink ebtable_filter ebtables ip6table_filter ip6_tables sunrpc intel_rapl sb_edac intel_powerclamp coretemp kvm_intel kvm irqbypass crct10dif_pclmul crc32_pclmul ghash_clmulni_intel intel_cstate intel_uncore intel_rapl_perf iwlwifi wmi_bmof intel_wmi_thunderbolt pcspkr joydev cfg80211 btusb btrtl btbcm i2c_i801 btintel snd_hda_codec_hdmi snd_hda_codec_realtek bluetooth iTCO_wdt snd_hda_codec_generic rtsx_usb_ms iTCO_vendor_support memstick mei_wdt lpc_ich ecdh_generic rfkill snd_hda_intel
[  277.309467]  snd_hda_codec mei_me mei snd_hda_core snd_hwdep snd_pcm snd_timer snd soundcore pcc_cpufreq nouveau crc32c_intel video drm_kms_helper rtsx_usb_sdmmc igb ttm mmc_core dca i2c_algo_bit drm e1000e rtsx_usb ata_generic pata_acpi r8169 realtek mxm_wmi wmi
[  277.309491] CPU: 4 PID: 2012 Comm: xfs_io Not tainted 4.19.31-rt18 #1
[  277.309492] Hardware name: LENOVO 30B6S2F900/1030, BIOS S01KT61A 09/28/2018
[  277.309495] RIP: 0010:debug_rt_mutex_unlock+0x47/0x50
[  277.309497] Code: c2 75 01 c3 e8 ca b8 3c 00 85 c0 74 f6 8b 05 80 bc a6 02 85 c0 75 ec 48 c7 c6 70 ba 2d 82 48 c7 c7 7b d8 2b 82 e8 5d e6 f8 ff <0f> 0b c3 66 0f 1f 44 00 00 c3 66 66 2e 0f 1f 84 00 00 00 00 00 0f
[  277.309498] RSP: 0018:ffffb07dea287dd8 EFLAGS: 00010086
[  277.309500] RAX: 0000000000000000 RBX: ffff906d43c33920 RCX: 0000000000000000
[  277.309501] RDX: 0000000000000007 RSI: ffffffff8231935a RDI: 00000000ffffffff
[  277.309502] RBP: 0000000000000246 R08: 0000000000000000 R09: 0000000000024200
[  277.309503] R10: 0000000000000000 R11: 0000000000000000 R12: ffffb07dea287e08
[  277.309504] R13: ffffb07dea287e18 R14: ffff906d43c33478 R15: ffffffff8130757d
[  277.309506] FS:  00007f586dd06880(0000) GS:ffff906d5fb00000(0000) knlGS:0000000000000000
[  277.309507] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  277.309509] CR2: 000055aee375c088 CR3: 0000000844b90005 CR4: 00000000001606e0
[  277.309510] Call Trace:
[  277.309516]  rt_mutex_slowunlock+0x24/0x70
[  277.309521]  __rt_mutex_unlock+0x45/0x80
[  277.309527]  percpu_up_write+0x1f/0x30
[  277.309533]  thaw_super_locked+0xdb/0x110
[  277.309538]  do_vfs_ioctl+0x647/0x6f0
[  277.309544]  ksys_ioctl+0x60/0x90
[  277.309547]  __x64_sys_ioctl+0x16/0x20
[  277.309552]  do_syscall_64+0x60/0x1f0
[  277.309556]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
[  277.309558] RIP: 0033:0x7f586e22804b
[  277.309560] Code: 0f 1e fa 48 8b 05 3d be 0c 00 64 c7 00 26 00 00 00 48 c7 c0 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 0d be 0c 00 f7 d8 64 89 01 48
[  277.309561] RSP: 002b:00007ffd7b70b378 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
[  277.309563] RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007f586e22804b
[  277.309564] RDX: 00007ffd7b70b384 RSI: ffffffffc0045878 RDI: 0000000000000003
[  277.309565] RBP: 000055aee375be90 R08: 00007f586e2f4c60 R09: 000055aee375c080
[  277.309567] R10: 000055aee3759010 R11: 0000000000000246 R12: 0000000000000001
[  277.309568] R13: 000055aee375be70 R14: 000055aee375be70 R15: 000055aee375bd20
[  277.309575] irq event stamp: 24666
[  277.309578] hardirqs last  enabled at (24665): [<ffffffff81a27201>] _raw_spin_unlock_irqrestore+0x81/0x90
[  277.309581] hardirqs last disabled at (24666): [<ffffffff81a27320>] _raw_spin_lock_irqsave+0x20/0x60
[  277.309586] softirqs last  enabled at (0): [<ffffffff810c04ed>] copy_process.part.36+0x89d/0x2170
[  277.309588] softirqs last disabled at (0): [<0000000000000000>]           (null)
[  277.309589] ---[ end trace 0000000000000002 ]---
[  277.654909] XFS (loop1): Mounting V5 Filesystem
[  277.665152] XFS (loop1): Ending clean mount
[  279.932112] BUG: unable to handle kernel NULL pointer dereference at 000000000000008e
[  279.932114] PGD 0 P4D 0
[  279.932118] Oops: 0000 [#1] PREEMPT SMP PTI
[  279.932122] CPU: 10 PID: 2262 Comm: sh Tainted: G        W         4.19.31-rt18 #1
[  279.932123] Hardware name: LENOVO 30B6S2F900/1030, BIOS S01KT61A 09/28/2018
[  279.932133] RIP: 0010:rt_mutex_enqueue_pi+0x35/0x70
[  279.932135] Code: 00 0a 00 00 ba 01 00 00 00 45 31 c9 48 89 f1 eb 0d 85 c9 78 40 48 8d 48 08 31 d2 49 89 c1 48 8b 01 48 85 c0 74 0f 41 8b 48 60 <3b> 48 48 7d e2 48 8d 48 10 eb e6 49 8d 78 18 4d 89 48 18 49 c7 40
[  279.932136] RSP: 0018:ffffb07dea3cfaf8 EFLAGS: 00010002
[  279.932138] RAX: 0000000000000046 RBX: ffff9075450e5380 RCX: 0000000000000082
[  279.932139] RDX: 0000000000000001 RSI: ffff90753f658a00 RDI: ffff90753f658000
[  279.932140] RBP: ffffb07dea3cfba0 R08: ffffb07dea3cfba0 R09: ffffb07dea83bd30
[  279.932141] R10: 0000000000000000 R11: 0000000000000000 R12: ffff90753f658000
[  279.932142] R13: ffff90753f6589b8 R14: ffffb07dea3cfba0 R15: ffff90754b235590
[  279.932144] FS:  0000000000000000(0000) GS:ffff90755fb00000(0000) knlGS:0000000000000000
[  279.932145] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  279.932146] CR2: 000000000000008e CR3: 0000001045326006 CR4: 00000000001606e0
[  279.932147] Call Trace:
[  279.932154]  task_blocks_on_rt_mutex+0x1e2/0x240
[  279.932164]  rt_mutex_slowlock_locked+0xb8/0x300
[  279.932170]  rt_mutex_slowlock+0x78/0xd0
[  279.932178]  __down_write_common+0x24/0x170
[  279.932185]  __vma_adjust+0x124/0x970
[  279.932192]  __split_vma+0xf4/0x1a0
[  279.932196]  do_munmap+0xf7/0x430
[  279.932200]  mmap_region+0xb2/0x650
[  279.932208]  ? selinux_file_mprotect+0x140/0x140
[  279.932212]  do_mmap+0x38e/0x510
[  279.932218]  vm_mmap_pgoff+0xd5/0x130
[  279.932225]  ksys_mmap_pgoff+0x1b8/0x270
[  279.932231]  ? trace_hardirqs_off_thunk+0x1a/0x1c
[  279.932235]  do_syscall_64+0x60/0x1f0
[  279.932240]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
[  279.932243] RIP: 0033:0x7f79b2d6dd87
[  279.932244] Code: 54 41 89 d4 55 48 89 fd 53 4c 89 cb 48 85 ff 74 4a 49 89 d9 45 89 f8 45 89 f2 44 89 e2 4c 89 ee 48 89 ef b8 09 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 61 5b 5d 41 5c 41 5d 41 5e 41 5f c3 66 0f 1f
[  279.932246] RSP: 002b:00007ffcc293a098 EFLAGS: 00000206 ORIG_RAX: 0000000000000009
[  279.932248] RAX: ffffffffffffffda RBX: 0000000000029000 RCX: 00007f79b2d6dd87
[  279.932249] RDX: 0000000000000003 RSI: 0000000000005000 RDI: 00007f79b2d40000
[  279.932250] RBP: 00007f79b2d40000 R08: 0000000000000003 R09: 0000000000029000
[  279.932251] R10: 0000000000000812 R11: 0000000000000206 R12: 0000000000000003
[  279.932252] R13: 0000000000005000 R14: 0000000000000812 R15: 0000000000000003
[  279.932259] Modules linked in: loop xfs ip6t_rpfilter ip6t_REJECT nf_reject_ipv6 xt_conntrack ebtable_nat ip6table_nat nf_nat_ipv6 ip6table_mangle ip6table_raw ip6table_security iptable_nat nf_nat_ipv4 nf_nat iptable_mangle iptable_raw iptable_security nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 libcrc32c ip_set nfnetlink ebtable_filter ebtables ip6table_filter ip6_tables sunrpc intel_rapl sb_edac intel_powerclamp coretemp kvm_intel kvm irqbypass crct10dif_pclmul crc32_pclmul ghash_clmulni_intel intel_cstate intel_uncore intel_rapl_perf iwlwifi wmi_bmof intel_wmi_thunderbolt pcspkr joydev cfg80211 btusb btrtl btbcm i2c_i801 btintel snd_hda_codec_hdmi snd_hda_codec_realtek bluetooth iTCO_wdt snd_hda_codec_generic rtsx_usb_ms iTCO_vendor_support memstick mei_wdt lpc_ich ecdh_generic rfkill snd_hda_intel
[  279.932306]  snd_hda_codec mei_me mei snd_hda_core snd_hwdep snd_pcm snd_timer snd soundcore pcc_cpufreq nouveau crc32c_intel video drm_kms_helper rtsx_usb_sdmmc igb ttm mmc_core dca i2c_algo_bit drm e1000e rtsx_usb ata_generic pata_acpi r8169 realtek mxm_wmi wmi
[  279.932328] CR2: 000000000000008e
[  280.273956] ---[ end trace 0000000000000003 ]---
[  280.273959] RIP: 0010:rt_mutex_enqueue_pi+0x35/0x70
[  280.273960] Code: 00 0a 00 00 ba 01 00 00 00 45 31 c9 48 89 f1 eb 0d 85 c9 78 40 48 8d 48 08 31 d2 49 89 c1 48 8b 01 48 85 c0 74 0f 41 8b 48 60 <3b> 48 48 7d e2 48 8d 48 10 eb e6 49 8d 78 18 4d 89 48 18 49 c7 40
[  280.273961] RSP: 0018:ffffb07dea3cfaf8 EFLAGS: 00010002
[  280.273963] RAX: 0000000000000046 RBX: ffff9075450e5380 RCX: 0000000000000082
[  280.273964] RDX: 0000000000000001 RSI: ffff90753f658a00 RDI: ffff90753f658000
[  280.273965] RBP: ffffb07dea3cfba0 R08: ffffb07dea3cfba0 R09: ffffb07dea83bd30
[  280.273966] R10: 0000000000000000 R11: 0000000000000000 R12: ffff90753f658000
[  280.273967] R13: ffff90753f6589b8 R14: ffffb07dea3cfba0 R15: ffff90754b235590
[  280.273968] FS:  0000000000000000(0000) GS:ffff90755fb00000(0000) knlGS:0000000000000000
[  280.273970] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  280.273971] CR2: 000000000000008e CR3: 0000001045326006 CR4: 00000000001606e0
[  280.273972] ------------[ cut here ]------------
--->8---

Since AFAIU generic/390 performs a multi-thread freeze/unfreeze loop, the
warning and the actual crash looks related to me.

Best,

- Juri

1 - https://github.com/kdave/xfstests
