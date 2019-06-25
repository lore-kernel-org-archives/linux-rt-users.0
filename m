Return-Path: <SRS0=Os7+=UY=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A881C48BD5
	for <linux-rt-users@archiver.kernel.org>; Tue, 25 Jun 2019 08:19:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 767D2215EA
	for <linux-rt-users@archiver.kernel.org>; Tue, 25 Jun 2019 08:19:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728789AbfFYITL convert rfc822-to-8bit (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 25 Jun 2019 04:19:11 -0400
Received: from smtp2-g21.free.fr ([212.27.42.2]:36493 "EHLO smtp2-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727887AbfFYITK (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 25 Jun 2019 04:19:10 -0400
Received: from zimbra35-e6.priv.proxad.net (unknown [172.20.243.185])
        by smtp2-g21.free.fr (Postfix) with ESMTP id 5D66E200381;
        Tue, 25 Jun 2019 10:19:06 +0200 (CEST)
Date:   Tue, 25 Jun 2019 10:19:06 +0200 (CEST)
From:   ycollette.nospam@free.fr
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-rt-users@vger.kernel.org
Message-ID: <2070199003.25338131.1561450746148.JavaMail.root@zimbra35-e6.priv.proxad.net>
In-Reply-To: <20190625080818.plcqwdhux5nhx3xg@linutronix.de>
Subject: Re: BUG kernel 5.0.21rt12
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [82.254.178.175]
X-Mailer: Zimbra 7.2.0-GA2598 (ZimbraWebClient - FF3.0 (Win)/7.2.0-GA2598)
X-Authenticated-User: ycollette.nospam@free.fr
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Thanks for the answer.

I will try to switch to the last 4.19.50 ... I remember I had no problems with the 4.19 branch ...
I will send some more informations once I have tested.

Best regards,

YC

----- Mail original -----
De: "Sebastian Andrzej Siewior" <bigeasy@linutronix.de>
À: "Yann COLLETTE" <ycollette.nospam@free.fr>
Cc: linux-rt-users@vger.kernel.org
Envoyé: Mardi 25 Juin 2019 10:08:18
Objet: Re: BUG kernel 5.0.21rt12

On 2019-06-24 20:29:14 [+0200], Yann COLLETTE wrote:
> Hello,
Hi,

> 
> I have compiled a vanilla kernel 5.0.21rt12 on Fedora 30 64 bits.
> 
> I use this kernel for music (jack-audio oriented).
> 
> I meet a bug with the last RT kernel.
> 
> I was just able to get a kernel oops (this is my first "bug report") ...

formatted:

> juin 24 18:38:08 localhost.localdomain kernel: BUG: scheduling while atomic: Xorg:rcs0/1129/0x00000003
> juin 24 18:38:08 localhost.localdomain kernel: Modules linked in: snd_seq_midi snd_seq_midi_event snd_seq_dummy fuse xt_CHECKSUM ipt_MASQUERADE tun bridge stp llc cc>
> juin 24 18:38:08 localhost.localdomain kernel:  wmi_bmof mac80211 snd_seq snd_seq_device snd_pcm cfg80211 sp5100_tco snd_timer rfkill pcc_cpufreq snd soundcore fam15>
> juin 24 18:38:08 localhost.localdomain kernel: Preemption disabled at:
> juin 24 18:38:08 localhost.localdomain kernel: [<ffffffff8267265e>] reservation_object_add_shared_fence+0x3e/0x1b0
> juin 24 18:38:08 localhost.localdomain kernel: CPU: 1 PID: 1129 Comm: Xorg:rcs0 Not tainted 5.0.21-rt12.fc30.x86_64 #1
> juin 24 18:38:08 localhost.localdomain kernel: Hardware name: HP 450-a121nf/2B29, BIOS A0.11 01/15/2016
> juin 24 18:38:08 localhost.localdomain kernel: Call Trace:
> juin 24 18:38:08 localhost.localdomain kernel: dump_stack+0x5c/0x80
> juin 24 18:38:08 localhost.localdomain kernel:  ? reservation_object_add_shared_fence+0x3e/0x1b0
> juin 24 18:38:08 localhost.localdomain kernel: __schedule_bug.cold+0x44/0x51
> juin 24 18:38:08 localhost.localdomain kernel: __schedule+0x5c6/0x6f0
> juin 24 18:38:08 localhost.localdomain kernel:  ? unpin_current_cpu+0x3a/0x80
> juin 24 18:38:08 localhost.localdomain kernel:  schedule+0x43/0xd0
> juin 24 18:38:08 localhost.localdomain kernel: rt_spin_lock_slowlock_locked+0x114/0x2b0
> juin 24 18:38:08 localhost.localdomain kernel: rt_spin_lock_slowlock+0x51/0x80
> juin 24 18:38:08 localhost.localdomain kernel: __wake_up_common_lock+0x61/0xb0

and there is the wake_up()

> juin 24 18:38:08 localhost.localdomain kernel: radeon_fence_is_signaled+0x74/0x90 [radeon]
> juin 24 18:38:08 localhost.localdomain kernel: reservation_object_add_shared_fence+0x97/0x1b0
This one does preempt_disable() + write_seqcount_begin()

I'm not yet sure what to do about this.

> juin 24 18:38:08 localhost.localdomain kernel: ttm_eu_fence_buffer_objects+0x49/0xa0 [ttm]
> juin 24 18:38:08 localhost.localdomain kernel: radeon_cs_parser_fini+0x10f/0x120 [radeon]
> juin 24 18:38:08 localhost.localdomain kernel: radeon_cs_ioctl+0x22b/0x800 [radeon]
> juin 24 18:38:08 localhost.localdomain kernel:  ? radeon_cs_parser_init+0x20/0x20 [radeon]
> juin 24 18:38:08 localhost.localdomain kernel: drm_ioctl_kernel+0xa7/0xf0 [drm]
> juin 24 18:38:08 localhost.localdomain kernel: drm_ioctl+0x208/0x390 [drm]
> juin 24 18:38:08 localhost.localdomain kernel:  ? radeon_cs_parser_init+0x20/0x20 [radeon]
> juin 24 18:38:08 localhost.localdomain kernel:  ? migrate_enable+0x235/0x400 
> juin 24 18:38:08 localhost.localdomain kernel:  ? _raw_spin_unlock_irqrestore+0x1f/0x60
> juin 24 18:38:08 localhost.localdomain kernel: radeon_drm_ioctl+0x49/0x80 [radeon]
> juin 24 18:38:08 localhost.localdomain kernel: do_vfs_ioctl+0x40c/0x670
> juin 24 18:38:08 localhost.localdomain kernel: ksys_ioctl+0x5e/0x90
> juin 24 18:38:08 localhost.localdomain kernel: __x64_sys_ioctl+0x16/0x20
> juin 24 18:38:08 localhost.localdomain kernel: do_syscall_64+0x5b/0x180 
> juin 24 18:38:08 localhost.localdomain kernel: entry_SYSCALL_64_after_hwframe+0x44/0xa9
> juin 24 18:38:08 localhost.localdomain kernel: RIP: 0033:0x7f9c10a221fb
> juin 24 18:38:08 localhost.localdomain kernel: Code: 0f 1e fa 48 8b 05 8d dc 0c 00 64 c7 00 26 00 00 00 48 c7 c0 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa b8 10 0>
> 
> Best regards,
> 
> 
> YC

Sebastian
