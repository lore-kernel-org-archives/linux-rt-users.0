Return-Path: <SRS0=uaKE=VO=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E88F5C76186
	for <linux-rt-users@archiver.kernel.org>; Wed, 17 Jul 2019 06:35:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A714A2173E
	for <linux-rt-users@archiver.kernel.org>; Wed, 17 Jul 2019 06:35:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sBgIS3ZG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbfGQGfG (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 17 Jul 2019 02:35:06 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45512 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbfGQGfF (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 17 Jul 2019 02:35:05 -0400
Received: by mail-wr1-f65.google.com with SMTP id f9so23375778wre.12;
        Tue, 16 Jul 2019 23:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4XebQ0f49Yy5q8IYJhpYbcY0E6K9JZ6GxX2Mpn0fMj4=;
        b=sBgIS3ZGF9wiNKJ9acaqaZ8z0aNFhvIJc+683vOPaN4oO8BOLGN63qm9Hm7x0dAdn1
         PzoIWoLt1maDIT3XxPhIS3xxk1Ek03yxTXF6vMUrnXpBFSN5aU9p7VWNIAKrW0G77BMy
         keQJZuAOyj8Z8kGJ2ynwvJkyPzYJXmqRk4RS5jgA6bE/qpjHa8j02lw/QqdulKADa0XA
         /lR0irdJMEaxmrVJMEoFu2UyUs+FaVfsj9nu6Z9i7Dzo3Yw+Nhh8lcan8YCgKqZ2IHFy
         y85JjaM1N9XWOJkgyLyYOsM2Zw6mI2BgbeDSvoBrsWRQufWUQ25OsM2wHH7dT+Rbkykr
         qOEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4XebQ0f49Yy5q8IYJhpYbcY0E6K9JZ6GxX2Mpn0fMj4=;
        b=ccrtH98VJ7Sqe740y9Nbii36W2j4uJjXiWDg/5JwewkxnQopbgTu9G/ekN7wlsUVOD
         TOzX8iDsbKQjlrLXeCMgaXMBdwrWILrvh8Wl6EjiOJaCKGnz1NBvMP8SupjYCKMeHvZ3
         dsncwmZ5povOAxoeS7UviKaZK0aLD8sSf8eCmKBdklavYCvc79LJyS6lEjatL7zmZXm2
         +H9HXzHbUxxeQBlyu4LdnjWmB/NfrkAaCS52IWcRquU85EjRlRDEXKsHpIOSu8cKna74
         8Iq4gfTLwZCAyQavPFpj/EI8gXXCBfngC4LjWxxRZPBqqiIdr5Q7OtTWSDOukOseoqsB
         xXQQ==
X-Gm-Message-State: APjAAAXSioXiSP5YXyCuA22wTDABJp6tzKIFHtmhpT9PByNmdbbL6HTC
        jUPLN1mOybLEmRs/MP0OUJtNqHZ7sSs=
X-Google-Smtp-Source: APXvYqxnyNHyEbGNaXQD2Er7btAWJsv/EJB6L63+SkspuUAY1lOR9tO9IidM0n2t38IM6Udqo+rzLQ==
X-Received: by 2002:adf:ce07:: with SMTP id p7mr39962069wrn.129.1563345302347;
        Tue, 16 Jul 2019 23:35:02 -0700 (PDT)
Received: from localhost.localdomain ([151.15.230.231])
        by smtp.gmail.com with ESMTPSA id f12sm24530404wrg.5.2019.07.16.23.35.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 16 Jul 2019 23:35:01 -0700 (PDT)
Date:   Wed, 17 Jul 2019 08:34:59 +0200
From:   Juri Lelli <juri.lelli@gmail.com>
To:     Clark Williams <williams@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        RT <linux-rt-users@vger.kernel.org>
Subject: Re: [PREEMPT_RT]  splat in v5.2-rt1:   r t_mutex_owner(lock) !=
 current
Message-ID: <20190717063459.GD13885@localhost.localdomain>
References: <20190716175509.17b03f1e@torg>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190716175509.17b03f1e@torg>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi Clark,

On 16/07/19 17:55, Clark Williams wrote:
> Saw this after applying my thermal lock to raw patch and the change in i915 for lockdep. The 
> splat occurred on boot when creating the kdump initramfs. System is an Intel NUC i7 with 32GB ram
> and 256GB SSD for rootfs. 
> 
> The booting kernel has rt_mutex debugging turned on as well as lockdep and lockup configs. 
> 
> Jul 16 14:41:48 theseus dracut[3082]: *** Creating initramfs image file '/boot/initramfs-5.2.0-rt1.fixes+kdump.img' done ***
> Jul 16 14:41:48 theseus kernel: ------------[ cut here ]------------
> Jul 16 14:41:48 theseus kernel: DEBUG_LOCKS_WARN_ON(rt_mutex_owner(lock) != current)
> Jul 16 14:41:48 theseus kernel: WARNING: CPU: 1 PID: 8349 at kernel/locking/rtmutex-debug.c:145 debug_rt_mutex_unlock+0x47/0x50
> Jul 16 14:41:48 theseus kernel: Modules linked in: rfcomm xt_CHECKSUM xt_MASQUERADE tun bridge stp llc fuse nf_conntrack_netbios_ns nf_conntrack_broadcast xt_CT ip6t_rpfilter ip6t_REJECT nf_reject_ipv6 ipt_REJECT nf_reject_ipv4 xt_conntrack ebtable_nat ip6table_nat ip6table_mangle ip6table_raw>
> Jul 16 14:41:48 theseus kernel:  snd_rawmidi snd_hda_core media snd_hwdep snd_seq btusb wmi_bmof snd_seq_device iwlwifi btrtl intel_wmi_thunderbolt btbcm snd_pcm iTCO_wdt btintel iTCO_vendor_support pcspkr bluetooth snd_timer rtsx_pci_ms cfg80211 snd memstick ecdh_generic i2c_i801 soundcore ec>
> Jul 16 14:41:48 theseus kernel: CPU: 1 PID: 8349 Comm: fsfreeze Not tainted 5.2.0-rt1.fixes+ #16
> Jul 16 14:41:48 theseus kernel: Hardware name: Intel Corporation NUC7i7BNH/NUC7i7BNB, BIOS BNKBL357.86A.0054.2017.1025.1822 10/25/2017
> Jul 16 14:41:48 theseus kernel: RIP: 0010:debug_rt_mutex_unlock+0x47/0x50
> Jul 16 14:41:48 theseus kernel: Code: c2 75 01 c3 e8 6a c1 3e 00 85 c0 74 f6 8b 05 30 3c 66 01 85 c0 75 ec 48 c7 c6 a0 b3 2e b1 48 c7 c7 48 bf 2c b1 e8 42 7d f8 ff <0f> 0b c3 66 0f 1f 44 00 00 c3 66 66 2e 0f 1f 84 00 00 00 00 00 0f
> Jul 16 14:41:48 theseus kernel: RSP: 0018:ffffc03c5b607dd0 EFLAGS: 00010086
> Jul 16 14:41:48 theseus kernel: RAX: 0000000000000000 RBX: ffff9a7d6deb0d98 RCX: 0000000000000000
> Jul 16 14:41:48 theseus kernel: RDX: ffffffffb167ce50 RSI: 00000000ffffffff RDI: 00000000ffffffff
> Jul 16 14:41:48 theseus kernel: RBP: ffff9a7d6deb0ab0 R08: 0000000000000000 R09: ffffffffb167cd20
> Jul 16 14:41:48 theseus kernel: R10: ffffc03c5b607d10 R11: ffffffffb2aa38eb R12: 0000000000000246
> Jul 16 14:41:48 theseus kernel: R13: ffffc03c5b607e00 R14: ffffc03c5b607e10 R15: ffffffffb034c53f
> Jul 16 14:41:48 theseus kernel: FS:  00007fd6e2f0e540(0000) GS:ffff9a7d9e600000(0000) knlGS:0000000000000000
> Jul 16 14:41:48 theseus kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> Jul 16 14:41:48 theseus kernel: CR2: 0000563557bc0178 CR3: 0000000792188006 CR4: 00000000003606e0
> Jul 16 14:41:48 theseus kernel: Call Trace:
> Jul 16 14:41:48 theseus kernel:  rt_mutex_slowunlock+0x25/0x80
> Jul 16 14:41:48 theseus kernel:  __rt_mutex_unlock+0x45/0x80
> Jul 16 14:41:48 theseus kernel:  percpu_up_write+0x1f/0x30
> Jul 16 14:41:48 theseus kernel:  thaw_super_locked+0xde/0x110
> Jul 16 14:41:48 theseus kernel:  do_vfs_ioctl+0x5de/0x720
> Jul 16 14:41:48 theseus kernel:  ksys_ioctl+0x5e/0x90
> Jul 16 14:41:48 theseus kernel:  __x64_sys_ioctl+0x16/0x20
> Jul 16 14:41:48 theseus kernel:  do_syscall_64+0x66/0xb0
> Jul 16 14:41:48 theseus kernel:  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> Jul 16 14:41:48 theseus kernel: RIP: 0033:0x7fd6e2e391fb
> Jul 16 14:41:48 theseus kernel: Code: 0f 1e fa 48 8b 05 8d dc 0c 00 64 c7 00 26 00 00 00 48 c7 c0 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 5d dc 0c 00 f7 d8 64 89 01 48
> Jul 16 14:41:48 theseus kernel: RSP: 002b:00007ffe61e2f498 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> Jul 16 14:41:48 theseus kernel: RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007fd6e2e391fb
> Jul 16 14:41:48 theseus kernel: RDX: 0000000000000000 RSI: 00000000c0045878 RDI: 0000000000000003
> Jul 16 14:41:48 theseus kernel: RBP: 0000000000000003 R08: 0000000000000001 R09: 0000000000000000
> Jul 16 14:41:48 theseus kernel: R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000002
> Jul 16 14:41:48 theseus kernel: R13: 00007ffe61e309fa R14: 0000000000000000 R15: 0000000000000000
> Jul 16 14:41:48 theseus kernel: irq event stamp: 6254
> Jul 16 14:41:48 theseus kernel: hardirqs last  enabled at (6253): [<ffffffffb0ac8590>] _raw_spin_unlock_irqrestore+0x60/0x90
> Jul 16 14:41:48 theseus kernel: hardirqs last disabled at (6254): [<ffffffffb0ac8713>] _raw_spin_lock_irqsave+0x23/0x90
> Jul 16 14:41:48 theseus kernel: softirqs last  enabled at (3330): [<ffffffffb003e4a8>] fpu__clear+0x88/0x200
> Jul 16 14:41:48 theseus kernel: softirqs last disabled at (3327): [<ffffffffb003e46b>] fpu__clear+0x4b/0x200
> Jul 16 14:41:48 theseus kernel: ---[ end trace 0000000000000002 ]---
> Jul 16 14:41:49 theseus kdumpctl[1500]: kexec: loaded kdump kernel
> Jul 16 14:41:49 theseus kdumpctl[1500]: Starting kdump: [OK]

Looks like this is the same percpu_rwsem problem Peter is chasing down:

https://lore.kernel.org/linux-rt-users/20190326093421.GA29508@localhost.localdomain/

Thanks,

Juri
