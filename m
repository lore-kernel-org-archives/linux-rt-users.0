Return-Path: <SRS0=uaKE=VO=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 813BAC76186
	for <linux-rt-users@archiver.kernel.org>; Wed, 17 Jul 2019 13:51:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 641B7208C0
	for <linux-rt-users@archiver.kernel.org>; Wed, 17 Jul 2019 13:51:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726085AbfGQNvV (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 17 Jul 2019 09:51:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49706 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725873AbfGQNvV (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 17 Jul 2019 09:51:21 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B00E73001469;
        Wed, 17 Jul 2019 13:51:20 +0000 (UTC)
Received: from torg (ovpn-120-120.rdu2.redhat.com [10.10.120.120])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B5341607C4;
        Wed, 17 Jul 2019 13:51:19 +0000 (UTC)
Date:   Wed, 17 Jul 2019 08:51:16 -0500
From:   Clark Williams <williams@redhat.com>
To:     Juri Lelli <juri.lelli@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        RT <linux-rt-users@vger.kernel.org>
Subject: Re: [PREEMPT_RT]  splat in v5.2-rt1:   r t_mutex_owner(lock) !=
 current
Message-ID: <20190717085116.3618a857@torg>
In-Reply-To: <20190717063459.GD13885@localhost.localdomain>
References: <20190716175509.17b03f1e@torg>
        <20190717063459.GD13885@localhost.localdomain>
Organization: Red Hat, Inc
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Wed, 17 Jul 2019 13:51:20 +0000 (UTC)
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Wed, 17 Jul 2019 08:34:59 +0200
Juri Lelli <juri.lelli@gmail.com> wrote:

> Hi Clark,
> 
> On 16/07/19 17:55, Clark Williams wrote:
> > Saw this after applying my thermal lock to raw patch and the change in i915 for lockdep. The 
> > splat occurred on boot when creating the kdump initramfs. System is an Intel NUC i7 with 32GB ram
> > and 256GB SSD for rootfs. 
> > 
> > The booting kernel has rt_mutex debugging turned on as well as lockdep and lockup configs. 
> > 
> > Jul 16 14:41:48 theseus dracut[3082]: *** Creating initramfs image file '/boot/initramfs-5.2.0-rt1.fixes+kdump.img' done ***
> > Jul 16 14:41:48 theseus kernel: ------------[ cut here ]------------
> > Jul 16 14:41:48 theseus kernel: DEBUG_LOCKS_WARN_ON(rt_mutex_owner(lock) != current)
> > Jul 16 14:41:48 theseus kernel: WARNING: CPU: 1 PID: 8349 at kernel/locking/rtmutex-debug.c:145 debug_rt_mutex_unlock+0x47/0x50
> > Jul 16 14:41:48 theseus kernel: Modules linked in: rfcomm xt_CHECKSUM xt_MASQUERADE tun bridge stp llc fuse nf_conntrack_netbios_ns nf_conntrack_broadcast xt_CT ip6t_rpfilter ip6t_REJECT nf_reject_ipv6 ipt_REJECT nf_reject_ipv4 xt_conntrack ebtable_nat ip6table_nat ip6table_mangle ip6table_raw>
> > Jul 16 14:41:48 theseus kernel:  snd_rawmidi snd_hda_core media snd_hwdep snd_seq btusb wmi_bmof snd_seq_device iwlwifi btrtl intel_wmi_thunderbolt btbcm snd_pcm iTCO_wdt btintel iTCO_vendor_support pcspkr bluetooth snd_timer rtsx_pci_ms cfg80211 snd memstick ecdh_generic i2c_i801 soundcore ec>
> > Jul 16 14:41:48 theseus kernel: CPU: 1 PID: 8349 Comm: fsfreeze Not tainted 5.2.0-rt1.fixes+ #16
> > Jul 16 14:41:48 theseus kernel: Hardware name: Intel Corporation NUC7i7BNH/NUC7i7BNB, BIOS BNKBL357.86A.0054.2017.1025.1822 10/25/2017
> > Jul 16 14:41:48 theseus kernel: RIP: 0010:debug_rt_mutex_unlock+0x47/0x50
> > Jul 16 14:41:48 theseus kernel: Code: c2 75 01 c3 e8 6a c1 3e 00 85 c0 74 f6 8b 05 30 3c 66 01 85 c0 75 ec 48 c7 c6 a0 b3 2e b1 48 c7 c7 48 bf 2c b1 e8 42 7d f8 ff <0f> 0b c3 66 0f 1f 44 00 00 c3 66 66 2e 0f 1f 84 00 00 00 00 00 0f
> > Jul 16 14:41:48 theseus kernel: RSP: 0018:ffffc03c5b607dd0 EFLAGS: 00010086
> > Jul 16 14:41:48 theseus kernel: RAX: 0000000000000000 RBX: ffff9a7d6deb0d98 RCX: 0000000000000000
> > Jul 16 14:41:48 theseus kernel: RDX: ffffffffb167ce50 RSI: 00000000ffffffff RDI: 00000000ffffffff
> > Jul 16 14:41:48 theseus kernel: RBP: ffff9a7d6deb0ab0 R08: 0000000000000000 R09: ffffffffb167cd20
> > Jul 16 14:41:48 theseus kernel: R10: ffffc03c5b607d10 R11: ffffffffb2aa38eb R12: 0000000000000246
> > Jul 16 14:41:48 theseus kernel: R13: ffffc03c5b607e00 R14: ffffc03c5b607e10 R15: ffffffffb034c53f
> > Jul 16 14:41:48 theseus kernel: FS:  00007fd6e2f0e540(0000) GS:ffff9a7d9e600000(0000) knlGS:0000000000000000
> > Jul 16 14:41:48 theseus kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > Jul 16 14:41:48 theseus kernel: CR2: 0000563557bc0178 CR3: 0000000792188006 CR4: 00000000003606e0
> > Jul 16 14:41:48 theseus kernel: Call Trace:
> > Jul 16 14:41:48 theseus kernel:  rt_mutex_slowunlock+0x25/0x80
> > Jul 16 14:41:48 theseus kernel:  __rt_mutex_unlock+0x45/0x80
> > Jul 16 14:41:48 theseus kernel:  percpu_up_write+0x1f/0x30
> > Jul 16 14:41:48 theseus kernel:  thaw_super_locked+0xde/0x110
> > Jul 16 14:41:48 theseus kernel:  do_vfs_ioctl+0x5de/0x720
> > Jul 16 14:41:48 theseus kernel:  ksys_ioctl+0x5e/0x90
> > Jul 16 14:41:48 theseus kernel:  __x64_sys_ioctl+0x16/0x20
> > Jul 16 14:41:48 theseus kernel:  do_syscall_64+0x66/0xb0
> > Jul 16 14:41:48 theseus kernel:  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> > Jul 16 14:41:48 theseus kernel: RIP: 0033:0x7fd6e2e391fb
> > Jul 16 14:41:48 theseus kernel: Code: 0f 1e fa 48 8b 05 8d dc 0c 00 64 c7 00 26 00 00 00 48 c7 c0 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 5d dc 0c 00 f7 d8 64 89 01 48
> > Jul 16 14:41:48 theseus kernel: RSP: 002b:00007ffe61e2f498 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> > Jul 16 14:41:48 theseus kernel: RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007fd6e2e391fb
> > Jul 16 14:41:48 theseus kernel: RDX: 0000000000000000 RSI: 00000000c0045878 RDI: 0000000000000003
> > Jul 16 14:41:48 theseus kernel: RBP: 0000000000000003 R08: 0000000000000001 R09: 0000000000000000
> > Jul 16 14:41:48 theseus kernel: R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000002
> > Jul 16 14:41:48 theseus kernel: R13: 00007ffe61e309fa R14: 0000000000000000 R15: 0000000000000000
> > Jul 16 14:41:48 theseus kernel: irq event stamp: 6254
> > Jul 16 14:41:48 theseus kernel: hardirqs last  enabled at (6253): [<ffffffffb0ac8590>] _raw_spin_unlock_irqrestore+0x60/0x90
> > Jul 16 14:41:48 theseus kernel: hardirqs last disabled at (6254): [<ffffffffb0ac8713>] _raw_spin_lock_irqsave+0x23/0x90
> > Jul 16 14:41:48 theseus kernel: softirqs last  enabled at (3330): [<ffffffffb003e4a8>] fpu__clear+0x88/0x200
> > Jul 16 14:41:48 theseus kernel: softirqs last disabled at (3327): [<ffffffffb003e46b>] fpu__clear+0x4b/0x200
> > Jul 16 14:41:48 theseus kernel: ---[ end trace 0000000000000002 ]---
> > Jul 16 14:41:49 theseus kdumpctl[1500]: kexec: loaded kdump kernel
> > Jul 16 14:41:49 theseus kdumpctl[1500]: Starting kdump: [OK]  
> 
> Looks like this is the same percpu_rwsem problem Peter is chasing down:
> 
> https://lore.kernel.org/linux-rt-users/20190326093421.GA29508@localhost.localdomain/
> 
> Thanks,
> 
> Juri

Yep, that's it. Interesting that he had to run a reproducer and mine just happens on boot. 

-- 
The United States Coast Guard
Ruining Natural Selection since 1790
