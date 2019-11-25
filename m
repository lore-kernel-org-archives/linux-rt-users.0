Return-Path: <SRS0=qZJ4=ZR=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6F88C432C0
	for <linux-rt-users@archiver.kernel.org>; Mon, 25 Nov 2019 07:17:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E6292071A
	for <linux-rt-users@archiver.kernel.org>; Mon, 25 Nov 2019 07:17:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tl+5vF2g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725871AbfKYHRf (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 25 Nov 2019 02:17:35 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:34792 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725535AbfKYHRf (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 25 Nov 2019 02:17:35 -0500
Received: by mail-wm1-f68.google.com with SMTP id j18so15436896wmk.1;
        Sun, 24 Nov 2019 23:17:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uzRCfPeTz0gBcCiC0Hif632WkAr4819/Gi0Tif/F2e4=;
        b=Tl+5vF2gB0tpNJt7K1MlV7b6JM92L7GAbQA/ssb+MjyeuaDWn5msMyMBXjU5lVLP1p
         NnxEi1+uATDvXqYNZZOYcBzB4Oom539vMenAbBg6tGr7f56M1k8Hwv9OeDXIu/E9vZFM
         OMPYb7w8mYP5MWdgYEQ7ZEPOaDm33PO8VZiceJVioYrYZ1OtLOy55gspHh3lf3uHBZYA
         3ZVOOk7OQtSAARjdSaocVqDMGZ9AXiIBHgwzZFwA5R4NWom5Ddmn4BJzCKxkli+evLSb
         XxGtrjTC7k3HM8IPM3CnLVlvKQOhg8Z3FoRuTdqmOwi2xsFibwSlQJUBthuheaey2ba4
         9lDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uzRCfPeTz0gBcCiC0Hif632WkAr4819/Gi0Tif/F2e4=;
        b=uPi5cMeWcez2DDKGTYEH9hu6/OO15DDto2zvaDB6SlY/r88IoZ/LEcwcMIkm3ctaD0
         oXxXSTFG/SEWpE0sgatHLrBOWq2CLprx1+oPooH6ORKIhvyCbHsLdAXzT91Zih2qyCiU
         e04G1WV9y8h3dKYD3eB0KgxGb/A8cVgH3x8kFfoGjXMX8ErXBS/cZs2KVdmoo+6RzyJ0
         xLht4+roa4sFegRMg5b+JfCKheqxP/WxFiriNvc6voHPMAl0LH9zwQDoHhMLYou9KEQ+
         KrgjOR2iUQyA0w6Y1xXP3bbIfgNfcRzcXC7Hd6ngzxsB86MY2oEEZN/KBmrokCqCWEHm
         t4hQ==
X-Gm-Message-State: APjAAAX24/Pe8LIHrZhPndaL5zwIjySoF92hAC9XLeGtqHrPFBxdBw1o
        ujRPRzg1u5YfVDBr7WLRni4=
X-Google-Smtp-Source: APXvYqwW8PqIVwK+nmsPgVVdEpYjGRA5gJXLp7mU4oK1FHVYGo3VNe00rwW1CQULkIUt2fxaT/llng==
X-Received: by 2002:a7b:c004:: with SMTP id c4mr9099641wmb.45.1574666251973;
        Sun, 24 Nov 2019 23:17:31 -0800 (PST)
Received: from localhost.localdomain ([151.29.0.26])
        by smtp.gmail.com with ESMTPSA id k14sm9507855wrw.46.2019.11.24.23.17.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 24 Nov 2019 23:17:31 -0800 (PST)
Date:   Mon, 25 Nov 2019 08:17:29 +0100
From:   Juri Lelli <juri.lelli@gmail.com>
To:     Udo van den Heuvel <udovdh@xs4all.nl>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        RT <linux-rt-users@vger.kernel.org>
Subject: Re: 5.2.21-rt13 WARN_ON(rt_mutex_owner(lock) != current)
Message-ID: <20191125071729.GH23227@localhost.localdomain>
References: <1dd8d3b0-1fb3-c9fd-a4c3-935d60f0b034@xs4all.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1dd8d3b0-1fb3-c9fd-a4c3-935d60f0b034@xs4all.nl>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi,

On 24/11/19 07:08, Udo van den Heuvel wrote:
> Hello,
> 
> Is the WARNING below rt-specific or what is happening here?
> Please advise...
> 
> 
> [  600.401576] ------------[ cut here ]------------
> [  600.401583] DEBUG_LOCKS_WARN_ON(rt_mutex_owner(lock) != current)
> [  600.401592] WARNING: CPU: 3 PID: 23306 at
> kernel/locking/rtmutex-debug.c:145 debug_rt_mutex_unlock+0x48/0x50
> [  600.401606] Modules linked in: act_police sch_ingress cls_u32 sch_sfq
> sch_cbq pppoe pppox ip6table_raw nf_log_ipv6 ip6table_mangle xt_u32
> xt_CT xt_nat nf_log_ipv4 nf_log_common xt_statistic nf_nat_sip
> nf_conntrack_sip xt_recent xt_string xt_lscan(O) xt_TARPIT(O)
> iptable_raw nf_nat_h323 nf_conn
> track_h323 xt_TCPMSS xt_length xt_hl xt_tcpmss xt_owner xt_mac xt_mark
> xt_multiport xt_limit nf_nat_irc nf_conntrack_irc xt_LOG xt_DSCP
> xt_REDIRECT xt_MASQUERADE xt_dscp nf_nat_ftp nf_conntrack_ftp
> iptable_mangle iptable_nat mq_deadline 8021q ipt_REJECT nf_reject_ipv4
> iptable_filter ip6t_REJECT n
> f_reject_ipv6 xt_state xt_conntrack ip6table_filter nct6775 ip6_tables
> sunrpc amd_freq_sensitivity aesni_intel pl2303 aes_x86_64 amdgpu
> snd_hda_codec_realtek glue_helper mfd_core snd_hda_codec_generic
> crypto_simd cryptd gpu_sched drm_kms_helper syscopyarea sysfillrect
> sysimgblt i2c_piix4 fb_sys_f
> ops snd_hda_codec_hdmi ttm drm drm_panel_orientation_quirks cfbfillrect
> snd_hda_intel cfbimgblt snd_hda_codec
> [  600.401695]  cfbcopyarea snd_hda_core i2c_algo_bit snd_pcm fb fbdev
> snd_timer backlight snd acpi_cpufreq sr_mod cdrom sd_mod autofs4
> [  600.401710] CPU: 3 PID: 23306 Comm: fsfreeze Tainted: G           O
>    5.2.21-rt13 #9
> [  600.401714] Hardware name: To Be Filled By O.E.M. To Be Filled By
> O.E.M./QC5000M-ITX/PH, BIOS P1.10 05/06/2015
> [  600.401716] RIP: 0010:debug_rt_mutex_unlock+0x48/0x50
> [  600.401721] Code: 75 02 f3 c3 e8 99 47 21 00 85 c0 74 f5 8b 05 ef 08
> 04 01 85 c0 75 eb 48 c7 c6 50 f9 d7 81 48 c7 c7 48 06 d7 81 e8 a9 29 fb
> ff <0f> 0b c3 0f 1f 44 00 00 f3 c3 66 66 2e 0f 1f 84 00 00 00 00 00 0f
> [  600.401726] RSP: 0018:ffffc900027d3d80 EFLAGS: 00010082
> [  600.401727] RAX: 0000000000000000 RBX: ffff888136d6eb80 RCX:
> ffffffff820708d8
> [  600.401730] RDX: ffffffff82070a00 RSI: 0000000000000000 RDI:
> ffffffff82070c50
> [  600.401732] RBP: ffff888136d6e918 R08: ffffffff820708c0 R09:
> 0000000000000001
> [  600.401734] R10: ffffffff82070900 R11: ffffc900027d3cc0 R12:
> 0000000000000292
> [  600.401735] R13: ffffc900027d3d98 R14: ffff888136d6e470 R15:
> ffffffff81162a0a
> [  600.401738] FS:  00007f6b80d9d540(0000) GS:ffff88813b380000(0000)
> knlGS:0000000000000000
> [  600.401740] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  600.401742] CR2: 00007fc4a87fe430 CR3: 000000006382c000 CR4:
> 00000000000406a0
> [  600.401745] Call Trace:
> [  600.401750]  __rt_mutex_unlock+0x56/0xd0
> [  600.401758]  percpu_up_write+0x1a/0x30
> [  600.401763]  thaw_super_locked+0x10a/0x140
> [  600.401769]  ? thaw_super_locked+0xaa/0x140
> [  600.401773]  do_vfs_ioctl+0x5a4/0x6a0
> [  600.401778]  ? __se_sys_newfstat+0x5a/0x70
> [  600.401782]  ksys_ioctl+0x7b/0xa0
> [  600.401785]  __x64_sys_ioctl+0x11/0x20
> [  600.401788]  do_syscall_64+0x6d/0x310
> [  600.401794]  ? __do_page_fault+0x242/0x510
> [  600.401798]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [  600.401803] RIP: 0033:0x7f6b80ccb34b
> [  600.401806] Code: 0f 1e fa 48 8b 05 3d 9b 0c 00 64 c7 00 26 00 00 00
> 48 c7 c0 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa b8 10 00 00 00 0f
> 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 0d 9b 0c 00 f7 d8 64 89 01 48
> [  600.401811] RSP: 002b:00007ffecbbd7c48 EFLAGS: 00000246 ORIG_RAX:
> 0000000000000010
> [  600.401812] RAX: ffffffffffffffda RBX: 0000000000000003 RCX:
> 00007f6b80ccb34b
> [  600.401814] RDX: 0000000000000000 RSI: 00000000c0045878 RDI:
> 0000000000000003
> [  600.401816] RBP: 0000000000000003 R08: 0000000000000001 R09:
> 0000000000000000
> [  600.401817] R10: 0000000000000000 R11: 0000000000000246 R12:
> 0000000000000002
> [  600.401819] R13: 00007ffecbbda0fe R14: 0000000000000000 R15:
> 0000000000000000
> [  600.401822] ---[ end trace 0000000000000002 ]---

This looks similar to what I already reported (originally on 4.19-rt).

https://lore.kernel.org/lkml/20190326093421.GA29508@localhost.localdomain/

Peter is working on rewriting percpu_rwsem implementation to fix it.

https://lore.kernel.org/lkml/20191113102115.116470462@infradead.org/

Best,

Juri
