Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62B67C47094
	for <linux-rt-users@archiver.kernel.org>; Thu, 10 Jun 2021 07:28:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E685613FE
	for <linux-rt-users@archiver.kernel.org>; Thu, 10 Jun 2021 07:28:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230074AbhFJHa0 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 10 Jun 2021 03:30:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbhFJHaZ (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 10 Jun 2021 03:30:25 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3234C061574
        for <linux-rt-users@vger.kernel.org>; Thu, 10 Jun 2021 00:28:27 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a11so41818725ejf.3
        for <linux-rt-users@vger.kernel.org>; Thu, 10 Jun 2021 00:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=B6L6Z3on7ZguRT8UU57TJp7j1EU9Dy+aLgC+zglOPak=;
        b=RL8IUmALwf6V/dzCoM5gvueWd1gCqKvJhpRgQD84sxlFHq9NYvrrpUWAz3k56tzlsc
         nYvLiSCJoH5yKiKhLEuP2WOabQH57pmkSbYlRbv3ekTjmNx+d4NQT8dsSJVLpyUqAy7B
         WCLBRYzDVP9XcISUmY+gjX+yGBthlLvFtUmLyn08YioL/UDLBZbDYgDBYksYyj1yGqWM
         Yn5IczE4vIT9mNGgre/bORn6y8cnr7goTwdYXMkL6GCe8n8Hdy3pW7/6hKUyEeoaZUUN
         UxTnZgrFuE94C0OOuYouDs9M8t79kag+D2obGUBQKiZjWYQNfkWDRslrDvbmydKo0xi6
         yN3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=B6L6Z3on7ZguRT8UU57TJp7j1EU9Dy+aLgC+zglOPak=;
        b=pyOY5qeEzNdudXFseMjvz96DIYMuvT6q4QNhm71y5ISYstbRa0Zf2G38XKTxuVHBZt
         7Y5PB0PY5QCH2onu7EN5VTJIR/YWSgxnY9ZgpV/00I1P2Dz30tAfpscsM1gqlrWi3qhs
         hYAIjBRO4KhqUBPfj7xEXboPdQiO1x9rY1jlIsvRmX5YUdw/DVxv9VzsGYZl22EJIaFX
         1gGKPbBLcNOv7XvJK0SD1B9rgZ+C99YozKnO0Hv3F4pN/bQiErb3pBnAAK0mLfly8yZ3
         Vcbf/XyOTiYuqOFgy3DGYUpdtOl+L59/HAJUZvmU+NKzAy8ded0Fz7emF2QznxML+/9l
         oaow==
X-Gm-Message-State: AOAM532ETB784kd/otssi5/8NgqSU7lXz/FkzxqHzcnGHbXBTki48zEJ
        Zrl3EThJ+96soytCbUTI2y0QZ2rtQQJV6A==
X-Google-Smtp-Source: ABdhPJxCGmfe+zGJpn7h6HcfjCbLiIjT6YdvNekjWM1TqR6mrEFlalpDnuYo/YbYzeb8JXl00NaQOw==
X-Received: by 2002:a17:907:f9b:: with SMTP id kb27mr3272241ejc.44.1623310106385;
        Thu, 10 Jun 2021 00:28:26 -0700 (PDT)
Received: from [192.168.1.11] (46-22-16-76-dynamic-cgnat.cust.swissbackbone.net. [46.22.16.76])
        by smtp.gmail.com with ESMTPSA id y10sm651835ejq.50.2021.06.10.00.28.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Jun 2021 00:28:26 -0700 (PDT)
Subject: Re: Hung task in 4.9 using kvm 5.2
From:   Christoph Mathys <eraserix@gmail.com>
To:     Luis Goncalves <lgoncalv@redhat.com>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>
Cc:     Linux RT Users <linux-rt-users@vger.kernel.org>
References: <CALqGcGpVOTGK+WDwqvX=W9140p8xrdAWn01vB8zb_6=mATSjHw@mail.gmail.com>
 <YL842Rg3yRcTpW2r@lx-t490>
 <CAD8J--9oKRQ2Fb9Q6Rtnfg21iU0NHYk-u8oVN-Rn=HqsEu93gQ@mail.gmail.com>
 <b7b5a1d2-472c-5202-6b10-d1e8bcfcf58b@gmail.com>
Message-ID: <0d6485d8-62d2-0e28-fb30-b52883dc0ecf@gmail.com>
Date:   Thu, 10 Jun 2021 09:28:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <b7b5a1d2-472c-5202-6b10-d1e8bcfcf58b@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

I think the "hung task" problem is caused by a combination
of flags to the -blockdev argument of kvm:

aio=native and cache.direct=true

When I remove this two settings and just use the kvm default
I'm no longer able to reproduce the problem.

However, a bit later in the test, another problem occurs:

Jun 09 17:23:28 hostname kernel: BUG: unable to handle kernel paging request at fffffffffffffe5a
Jun 09 17:23:28 hostname kernel: IP: [<ffffffff811d6a27>] kmem_cache_alloc+0x77/0x290
Jun 09 17:23:28 hostname kernel: PGD 1e15067
Jun 09 17:23:28 hostname kernel: PUD 1e17067
Jun 09 17:23:28 hostname kernel: PMD 0
Jun 09 17:23:28 hostname kernel:
Jun 09 17:23:28 hostname kernel: Oops: 0000 [#1] PREEMPT SMP
Jun 09 17:23:28 hostname kernel: Modules linked in: cmac arc4 md4 nls_utf8 nft_meta nft_compat nft_chain_nat_ipv6 nf_tables_ipv6 nft_chain_nat_ipv4 nft_counter nf_tables_ipv4 nf_tables binfmt_misc veth ip6table_nat nf_conntrack_ipv6 nf_defrag_ipv6 nf_nat_ipv6 xt_comment nf_conntrack_netlink nfnetlink xfrm_user xfrm_algo xt_addrtype br_netfilter xt_CHECKSUM iptable_mangle ipt_MASQUERADE nf_nat_masquerade_ipv4 iptable_nat nf_nat_ipv4 nf_nat nf_conntrack_ipv4 nf_defrag_ipv4 xt_conntrack nf_conntrack ipt_REJECT nf_reject_ipv4 xt_tcpudp bridge stp llc ebtable_filter ebtables ip6table_filter ip6_tables iptable_filter overlay joydev snd_usb_audio snd_usbmidi_lib coretemp ghash_clmulni_intel aesni_intel snd_hda_codec_hdmi aes_x86_64 lrw gf128mul glue_helper ablk_helper snd_hda_codec_realtek cryptd snd_hda_codec_generic snd_hda_intel
Jun 09 17:23:28 hostname kernel:  snd_hda_codec snd_hda_core snd_hwdep snd_pcm snd_seq_midi snd_seq_midi_event snd_rawmidi i915 snd_seq snd_seq_device drm_kms_helper snd_timer drm fb_sys_fops snd syscopyarea sysfillrect soundcore sysimgblt shpchp video mac_hid acpi_pad tpm_tis tpm_tis_core kvm_intel kvm irqbypass squashfs sch_fq_codel cifs fscache parport_pc ppdev lp parport ip_tables x_tables autofs4 btrfs xor raid6_pq hid_generic hid_cherry usbhid hid igb e1000e i2c_algo_bit nvme dca nvme_core ptp pps_core
Jun 09 17:23:28 hostname kernel: CPU: 5 PID: 1137 Comm: RTController Tainted: G     U          4.9.271-realtime-1-prove-rt182 #1
Jun 09 17:23:28 hostname kernel: Hardware name: Komax AG, Dierikon Komax-PC/KMX-Q170-24V, BIOS D05K1-1L 03/19/2018
Jun 09 17:23:28 hostname kernel: task: ffff8804fb908000 task.stack: ffffc90015fdc000
Jun 09 17:23:28 hostname kernel: RIP: 0010:[<ffffffff811d6a27>]  [<ffffffff811d6a27>] kmem_cache_alloc+0x77/0x290
Jun 09 17:23:28 hostname kernel: RSP: 0018:ffffc90015fdfe40  EFLAGS: 00010286
Jun 09 17:23:28 hostname kernel: RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000368895
Jun 09 17:23:28 hostname kernel: RDX: 0000000000368885 RSI: 0000000000368885 RDI: 000000000006c190
Jun 09 17:23:28 hostname kernel: RBP: ffffc90015fdfe70 R08: ffff8804fb908000 R09: ffffc90015fdfda0
Jun 09 17:23:28 hostname kernel: R10: 0000000000000000 R11: 000000000000003d R12: ffff88087dc03900
Jun 09 17:23:28 hostname kernel: R13: ffffffff81238ff1 R14: fffffffffffffe5a R15: 00000000024000c0
Jun 09 17:23:28 hostname kernel: FS:  00007fca5bfff700(0000) GS:ffff88087e480000(0000) knlGS:0000000000000000
Jun 09 17:23:28 hostname kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
Jun 09 17:23:28 hostname kernel: CR2: fffffffffffffe5a CR3: 00000005a6c74000 CR4: 0000000000362670
Jun 09 17:23:28 hostname kernel: DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
Jun 09 17:23:28 hostname kernel: DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Jun 09 17:23:28 hostname kernel: Stack:
Jun 09 17:23:28 hostname kernel:  ffffffff8182ec6e 0000000000000001 ffff8805a787d341 ffff8805a787f440
Jun 09 17:23:28 hostname kernel:  ffffffffffffffea ffff8805a787d340 ffffc90015fdff20 ffffffff81238ff1
Jun 09 17:23:28 hostname kernel:  0000000000000320 00000000000000e9 0000000000000000 0000000000000000
Jun 09 17:23:28 hostname kernel: Call Trace:
Jun 09 17:23:28 hostname kernel:  [<ffffffff8182ec6e>] ? rt_mutex_lock+0x5e/0x80
Jun 09 17:23:28 hostname kernel:  [<ffffffff81238ff1>] SyS_epoll_ctl+0x2d1/0xcc0
Jun 09 17:23:28 hostname kernel:  [<ffffffff81001e0b>] do_syscall_64+0x7b/0x160
Jun 09 17:23:28 hostname kernel:  [<ffffffff81831943>] entry_SYSCALL_64_after_swapgs+0x5d/0xdb
Jun 09 17:23:28 hostname kernel: Code: 70 08 48 39 f2 75 e7 48 83 78 10 00 4c 8b 30 0f 84 d7 00 00 00 4d 85 f6 0f 84 ce 00 00 00 49 63 44 24 20 49 8b 3c 24 48 8d 4a 10 <49> 8b 1c 06 4c 89 f0 65 48 0f c7 0f 0f 94 c0 84 c0 74 ac 49 63
Jun 09 17:23:28 hostname kernel: RIP  [<ffffffff811d6a27>] kmem_cache_alloc+0x77/0x290
Jun 09 17:23:28 hostname kernel:  RSP <ffffc90015fdfe40>
Jun 09 17:23:28 hostname kernel: CR2: fffffffffffffe5a
Jun 09 17:23:28 hostname kernel: ---[ end trace 0000000000000002 ]---
Jun 09 17:23:28 hostname kernel: BUG: unable to handle kernel paging request at ffff87faa787cafd
Jun 09 17:23:28 hostname kernel: IP: [<ffffffff810d53c8>] rcu_cpu_kthread+0x2e8/0x690
Jun 09 17:23:28 hostname kernel: PGD 0
Jun 09 17:23:28 hostname kernel:
Jun 09 17:23:28 hostname kernel: Oops: 0000 [#2] PREEMPT SMP
Jun 09 17:23:28 hostname kernel: Modules linked in: cmac arc4 md4 nls_utf8 nft_meta nft_compat nft_chain_nat_ipv6 nf_tables_ipv6 nft_chain_nat_ipv4 nft_counter nf_tables_ipv4 nf_tables binfmt_misc veth ip6table_nat nf_conntrack_ipv6 nf_defrag_ipv6 nf_nat_ipv6 xt_comment nf_conntrack_netlink nfnetlink xfrm_user xfrm_algo xt_addrtype br_netfilter xt_CHECKSUM iptable_mangle ipt_MASQUERADE nf_nat_masquerade_ipv4 iptable_nat nf_nat_ipv4 nf_nat nf_conntrack_ipv4 nf_defrag_ipv4 xt_conntrack nf_conntrack ipt_REJECT nf_reject_ipv4 xt_tcpudp bridge stp llc ebtable_filter ebtables ip6table_filter ip6_tables iptable_filter overlay joydev snd_usb_audio snd_usbmidi_lib coretemp ghash_clmulni_intel aesni_intel snd_hda_codec_hdmi aes_x86_64 lrw gf128mul glue_helper ablk_helper snd_hda_codec_realtek cryptd snd_hda_codec_generic snd_hda_intel
Jun 09 17:23:28 hostname kernel:  snd_hda_codec snd_hda_core snd_hwdep snd_pcm snd_seq_midi snd_seq_midi_event snd_rawmidi i915 snd_seq snd_seq_device drm_kms_helper snd_timer drm fb_sys_fops snd syscopyarea sysfillrect soundcore sysimgblt shpchp video mac_hid acpi_pad tpm_tis tpm_tis_core kvm_intel kvm irqbypass squashfs sch_fq_codel cifs fscache parport_pc ppdev lp parport ip_tables x_tables autofs4 btrfs xor raid6_pq hid_generic hid_cherry usbhid hid igb e1000e i2c_algo_bit nvme dca nvme_core ptp pps_core
Jun 09 17:23:28 hostname kernel: CPU: 5 PID: 55 Comm: rcuc/5 Tainted: G     UD         4.9.271-realtime-1-prove-rt182 #1
Jun 09 17:23:28 hostname kernel: Hardware name: Komax AG, Dierikon Komax-PC/KMX-Q170-24V, BIOS D05K1-1L 03/19/2018
Jun 09 17:23:28 hostname kernel: task: ffff88086c3a2800 task.stack: ffffc900113c8000
Jun 09 17:23:28 hostname kernel: RIP: 0010:[<ffffffff810d53c8>]  [<ffffffff810d53c8>] rcu_cpu_kthread+0x2e8/0x690
Jun 09 17:23:28 hostname kernel: RSP: 0018:ffffc900113cbdb0  EFLAGS: 00010282
Jun 09 17:23:28 hostname kernel: RAX: ffff88086c3a2800 RBX: ffffffff812371a0 RCX: 0000000000000000
Jun 09 17:23:28 hostname kernel: RDX: ffffffff810d536e RSI: 0000000000000001 RDI: ffffffff81e67360
Jun 09 17:23:28 hostname kernel: RBP: ffffc900113cbe30 R08: 0000000000000000 R09: 0000000000000000
Jun 09 17:23:28 hostname kernel: R10: 0000000000000000 R11: 0000000000000001 R12: 0000000000000005
Jun 09 17:23:28 hostname kernel: R13: ffff88086c3a2800 R14: ffff87faa787cafd R15: ffff87faa787cafd
Jun 09 17:23:28 hostname kernel: FS:  0000000000000000(0000) GS:ffff88087e480000(0000) knlGS:0000000000000000
Jun 09 17:23:28 hostname kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
Jun 09 17:23:28 hostname kernel: CR2: ffff87faa787cafd CR3: 0000000572896000 CR4: 0000000000362670
Jun 09 17:23:28 hostname kernel: DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
Jun 09 17:23:28 hostname kernel: DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Jun 09 17:23:28 hostname kernel: Stack:
Jun 09 17:23:28 hostname kernel:  ffffffff810d53c5 ffff88086c3a2800 ffff8807deff38c0 0000000a00000000
Jun 09 17:23:28 hostname kernel:  ffff88087e4920bc ffff88087e4e9480 ffffffff81e67500 ffff88087e4920b4
Jun 09 17:23:28 hostname kernel:  0000000000000002 ffff88087e4e94b8 000000000000000a ffff88086c3a2800
Jun 09 17:23:28 hostname kernel: Call Trace:
Jun 09 17:23:28 hostname kernel:  [<ffffffff810d53c5>] ? rcu_cpu_kthread+0x2e5/0x690
Jun 09 17:23:28 hostname kernel:  [<ffffffff8108ccf0>] ? smpboot_register_percpu_thread_cpumask+0xf0/0xf0
Jun 09 17:23:28 hostname kernel:  [<ffffffff8108ce10>] smpboot_thread_fn+0x120/0x250
Jun 09 17:23:28 hostname kernel:  [<ffffffff810884e0>] kthread+0xe0/0x100
Jun 09 17:23:28 hostname kernel:  [<ffffffff81088400>] ? kthread_create_on_node+0x40/0x40
Jun 09 17:23:28 hostname kernel:  [<ffffffff81831af9>] ret_from_fork+0x59/0x70
Jun 09 17:23:28 hostname kernel: Code: 8b 55 00 83 e2 08 0f 85 87 00 00 00 49 8b 55 00 f7 c2 00 00 04 00 75 7b 41 8b 85 a8 04 00 00 85 c0 75 70 4d 85 f6 74 6b 4d 89 f7 <4d> 8b 36 45 31 c9 45 31 c0 49 8b 5f 08 31 d2 31 f6 b9 02 00 00
Jun 09 17:23:28 hostname kernel: RIP  [<ffffffff810d53c8>] rcu_cpu_kthread+0x2e8/0x690
Jun 09 17:23:28 hostname kernel:  RSP <ffffc900113cbdb0>
Jun 09 17:23:28 hostname kernel: CR2: ffff87faa787cafd
Jun 09 17:23:28 hostname kernel: ---[ end trace 0000000000000003 ]---
Jun 09 17:23:28 hostname kernel: BUG: unable to handle kernel paging request at ffffffff81443890
Jun 09 17:23:28 hostname kernel: IP: [<ffffffff810b99d9>] queued_spin_lock_slowpath+0x149/0x190
Jun 09 17:23:28 hostname kernel: PGD 1e15067
Jun 09 17:23:28 hostname kernel: PUD 1e16063
Jun 09 17:23:28 hostname kernel: PMD 14000e1
Jun 09 17:23:28 hostname kernel:
Jun 09 17:23:28 hostname kernel: Oops: 0003 [#3] PREEMPT SMP
Jun 09 17:23:28 hostname kernel: Modules linked in: cmac arc4 md4 nls_utf8 nft_meta nft_compat nft_chain_nat_ipv6 nf_tables_ipv6 nft_chain_nat_ipv4 nft_counter nf_tables_ipv4 nf_tables binfmt_misc veth ip6table_nat nf_conntrack_ipv6 nf_defrag_ipv6 nf_nat_ipv6 xt_comment nf_conntrack_netlink nfnetlink xfrm_user xfrm_algo xt_addrtype br_netfilter xt_CHECKSUM iptable_mangle ipt_MASQUERADE nf_nat_masquerade_ipv4 iptable_nat nf_nat_ipv4 nf_nat nf_conntrack_ipv4 nf_defrag_ipv4 xt_conntrack nf_conntrack ipt_REJECT nf_reject_ipv4 xt_tcpudp bridge stp llc ebtable_filter ebtables ip6table_filter ip6_tables iptable_filter overlay joydev snd_usb_audio snd_usbmidi_lib coretemp ghash_clmulni_intel aesni_intel snd_hda_codec_hdmi aes_x86_64 lrw gf128mul glue_helper ablk_helper snd_hda_codec_realtek cryptd snd_hda_codec_generic snd_hda_intel
Jun 09 17:23:28 hostname kernel:  snd_hda_codec snd_hda_core snd_hwdep snd_pcm snd_seq_midi snd_seq_midi_event snd_rawmidi i915 snd_seq snd_seq_device drm_kms_helper snd_timer drm fb_sys_fops snd syscopyarea sysfillrect soundcore sysimgblt shpchp video mac_hid acpi_pad tpm_tis tpm_tis_core kvm_intel kvm irqbypass squashfs sch_fq_codel cifs fscache parport_pc ppdev lp parport ip_tables x_tables autofs4 btrfs xor raid6_pq hid_generic hid_cherry usbhid hid igb e1000e i2c_algo_bit nvme dca nvme_core ptp pps_core
Jun 09 17:23:28 hostname kernel: CPU: 5 PID: 55 Comm: rcuc/5 Tainted: G     UD         4.9.271-realtime-1-prove-rt182 #1
Jun 09 17:23:28 hostname kernel: Hardware name: Komax AG, Dierikon Komax-PC/KMX-Q170-24V, BIOS D05K1-1L 03/19/2018
Jun 09 17:23:28 hostname kernel: task: ffff88086c3a2800 task.stack: ffffc900113c8000
Jun 09 17:23:28 hostname kernel: RIP: 0010:[<ffffffff810b99d9>]  [<ffffffff810b99d9>] queued_spin_lock_slowpath+0x149/0x190
Jun 09 17:23:28 hostname kernel: RSP: 0018:ffffc900113cbe28  EFLAGS: 00010086
Jun 09 17:23:28 hostname kernel: RAX: ffffffff81443890 RBX: ffffc900113cbee0 RCX: ffff88087e4e9440
Jun 09 17:23:28 hostname kernel: RDX: 0000000000002040 RSI: 0000000000180000 RDI: ffffc900113cbee0
Jun 09 17:23:28 hostname kernel: RBP: ffffc900113cbe28 R08: 0000000000000000 R09: 0000000000000001
Jun 09 17:23:28 hostname kernel: R10: 0000000000000000 R11: 0000000000000000 R12: ffffc900113cbee0
Jun 09 17:23:28 hostname kernel: R13: 0000000000000286 R14: 0000000000000001 R15: 0000000000000001
Jun 09 17:23:28 hostname kernel: FS:  0000000000000000(0000) GS:ffff88087e480000(0000) knlGS:0000000000000000
Jun 09 17:23:28 hostname kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
Jun 09 17:23:28 hostname kernel: CR2: ffffffff81443890 CR3: 00000005a6d9a000 CR4: 0000000000362670
Jun 09 17:23:28 hostname kernel: DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
Jun 09 17:23:28 hostname kernel: DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Jun 09 17:23:28 hostname kernel: Stack:
Jun 09 17:23:28 hostname kernel:  ffffc900113cbe40 ffffffff810bb72d ffffc900113cbed8 ffffc900113cbe68
Jun 09 17:23:28 hostname kernel:  ffffffff81830b2d ffffffff810adc4d ffffc900113cbee0 ffff88086c3a2ff8
Jun 09 17:23:28 hostname kernel:  ffffc900113cbe90 ffffffff810adc4d ffff88086c3a2800 ffff88086c3a2800
Jun 09 17:23:28 hostname kernel: Call Trace:
Jun 09 17:23:28 hostname kernel:  [<ffffffff810bb72d>] do_raw_spin_lock+0x9d/0xa0
Jun 09 17:23:28 hostname kernel:  [<ffffffff81830b2d>] _raw_spin_lock_irqsave+0x4d/0x60
Jun 09 17:23:28 hostname kernel:  [<ffffffff810adc4d>] ? complete+0x1d/0x40
Jun 09 17:23:28 hostname kernel:  [<ffffffff810adc4d>] complete+0x1d/0x40
Jun 09 17:23:28 hostname kernel:  [<ffffffff8105cfd4>] mm_release+0x84/0xe0
Jun 09 17:23:28 hostname kernel:  [<ffffffff8105dc13>] exit_mm_release+0x23/0x30
Jun 09 17:23:28 hostname kernel:  [<ffffffff81832ea7>] ? rewind_stack_do_exit+0x17/0x20
Jun 09 17:23:28 hostname kernel: Code: 01 00 00 74 ef 40 30 f6 e9 ed fe ff ff c1 ea 12 83 e0 03 83 ea 01 48 c1 e0 04 48 63 d2 48 05 40 94 06 00 48 03 04 d5 20 c4 cd 81 <48> 89 08 8b 41 08 85 c0 75 09 f3 90 8b 41 08 85 c0 74 f7 48 8b
Jun 09 17:23:28 hostname kernel: RIP  [<ffffffff810b99d9>] queued_spin_lock_slowpath+0x149/0x190
Jun 09 17:23:28 hostname kernel:  RSP <ffffc900113cbe28>
Jun 09 17:23:28 hostname kernel: CR2: ffffffff81443890
Jun 09 17:23:28 hostname kernel: ---[ end trace 0000000000000004 ]---
Jun 09 17:23:28 hostname kernel: note: rcuc/5[55] exited with preempt_count 1
Jun 09 17:23:28 hostname kernel: Fixing recursive fault but reboot is needed!
Jun 09 17:23:28 hostname kernel: ------------[ cut here ]------------
Jun 09 17:23:28 hostname kernel: kernel BUG at kernel/locking/rtmutex.c:1070!
Jun 09 17:23:28 hostname kernel: invalid opcode: 0000 [#4] PREEMPT SMP
Jun 09 17:23:28 hostname kernel: Modules linked in: cmac arc4 md4 nls_utf8 nft_meta nft_compat nft_chain_nat_ipv6 nf_tables_ipv6 nft_chain_nat_ipv4 nft_counter nf_tables_ipv4 nf_tables binfmt_misc veth ip6table_nat nf_conntrack_ipv6 nf_defrag_ipv6 nf_nat_ipv6 xt_comment nf_conntrack_netlink nfnetlink xfrm_user xfrm_algo xt_addrtype br_netfilter xt_CHECKSUM iptable_mangle ipt_MASQUERADE nf_nat_masquerade_ipv4 iptable_nat nf_nat_ipv4 nf_nat nf_conntrack_ipv4 nf_defrag_ipv4 xt_conntrack nf_conntrack ipt_REJECT nf_reject_ipv4 xt_tcpudp bridge stp llc ebtable_filter ebtables ip6table_filter ip6_tables iptable_filter overlay joydev snd_usb_audio snd_usbmidi_lib coretemp ghash_clmulni_intel aesni_intel snd_hda_codec_hdmi aes_x86_64 lrw gf128mul glue_helper ablk_helper snd_hda_codec_realtek cryptd snd_hda_codec_generic snd_hda_intel
Jun 09 17:23:28 hostname kernel:  snd_hda_codec snd_hda_core snd_hwdep snd_pcm snd_seq_midi snd_seq_midi_event snd_rawmidi i915 snd_seq snd_seq_device drm_kms_helper snd_timer drm fb_sys_fops snd syscopyarea sysfillrect soundcore sysimgblt shpchp video mac_hid acpi_pad tpm_tis tpm_tis_core kvm_intel kvm irqbypass squashfs sch_fq_codel cifs fscache parport_pc ppdev lp parport ip_tables x_tables autofs4 btrfs xor raid6_pq hid_generic hid_cherry usbhid hid igb e1000e i2c_algo_bit nvme dca nvme_core ptp pps_core
Jun 09 17:23:28 hostname kernel: CPU: 5 PID: 55 Comm: rcuc/5 Tainted: G     UD         4.9.271-realtime-1-prove-rt182 #1
Jun 09 17:23:28 hostname kernel: Hardware name: Komax AG, Dierikon Komax-PC/KMX-Q170-24V, BIOS D05K1-1L 03/19/2018
Jun 09 17:23:28 hostname kernel: task: ffff88086c3a2800 task.stack: ffffc900113c8000
Jun 09 17:23:28 hostname kernel: RIP: 0010:[<ffffffff8182e775>]  [<ffffffff8182e775>] rt_spin_lock_slowlock+0x325/0x350
Jun 09 17:23:28 hostname kernel: RSP: 0018:ffffc900113cbdd8  EFLAGS: 00010046
Jun 09 17:23:28 hostname kernel: RAX: ffff88086c3a2800 RBX: ffff88086c3a2ff8 RCX: 0000000000000001
Jun 09 17:23:28 hostname kernel: RDX: 0000000000000000 RSI: ffff88086c3a2800 RDI: ffff88086c3a2ff8
Jun 09 17:23:28 hostname kernel: RBP: ffffc900113cbe90 R08: 0000000000000000 R09: 0000000000000001
Jun 09 17:23:28 hostname kernel: R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000282
Jun 09 17:23:28 hostname kernel: R13: ffffc900113cbdf8 R14: ffff88086c3a2800 R15: 0000000000000000
Jun 09 17:23:28 hostname kernel: FS:  0000000000000000(0000) GS:ffff88087e480000(0000) knlGS:0000000000000000
Jun 09 17:23:28 hostname kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
Jun 09 17:23:28 hostname kernel: CR2: ffffffff81443890 CR3: 00000004e72d0000 CR4: 0000000000362670
Jun 09 17:23:28 hostname kernel: DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
Jun 09 17:23:28 hostname kernel: DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Jun 09 17:23:28 hostname kernel: Stack:
Jun 09 17:23:28 hostname kernel:  ffff88086c3a2800 0000000000000282 ffff8808013a39f0 0000000000000282
Jun 09 17:23:28 hostname kernel:  ffffc900113cbdf8 1111111111111111 1111111111111111 ffffc900113cbe10
Jun 09 17:23:28 hostname kernel:  1111111111111111 1111111111111111 0000000000000000 1111111111111111
Jun 09 17:23:28 hostname kernel: Call Trace:
Jun 09 17:23:28 hostname kernel:  [<ffffffff81831043>] rt_spin_lock+0x23/0x50
Jun 09 17:23:28 hostname kernel:  [<ffffffff8120b35c>] exit_files+0x2c/0x50
Jun 09 17:23:28 hostname kernel:  [<ffffffff81065034>] do_exit+0x2d4/0xb10
Jun 09 17:23:28 hostname kernel:  [<ffffffff81832ea7>] rewind_stack_do_exit+0x17/0x20
Jun 09 17:23:28 hostname kernel: Code: c0 0f 85 f9 fe ff ff 48 c7 c2 68 1c c2 81 be 80 03 00 00 48 c7 c7 60 17 c2 81 c6 05 7e ab 71 00 01 e8 50 6c 88 ff e9 d5 fe ff ff <0f> 0b 0f 0b 48 8b 43 40 48 3b 58 38 0f 85 31 ff ff ff 4c 39 e8
Jun 09 17:23:28 hostname kernel: RIP  [<ffffffff8182e775>] rt_spin_lock_slowlock+0x325/0x350
Jun 09 17:23:28 hostname kernel:  RSP <ffffc900113cbdd8>
Jun 09 17:23:29 hostname kernel: ---[ end trace 0000000000000005 ]---
Jun 09 17:23:29 hostname kernel: note: rcuc/5[55] exited with preempt_count 1
Jun 09 17:23:29 hostname kernel: Fixing recursive fault but reboot is needed!
