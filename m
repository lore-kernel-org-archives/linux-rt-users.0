From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: BUG: scheduling while atomic: swapper/0/0/0x00010002
Date: Fri, 11 Dec 2015 18:10:32 +0100
Message-ID: <20151211171032.GI6720@linutronix.de>
References: <CAOLSsAzRBCJN+sWuzm51fAF4XVkbhPvKTMtqXOVkw_nRV28ibg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: RT <linux-rt-users@vger.kernel.org>
To: Javier Sanz <jsanza@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:48982 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752970AbbLKRKd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 11 Dec 2015 12:10:33 -0500
Content-Disposition: inline
In-Reply-To: <CAOLSsAzRBCJN+sWuzm51fAF4XVkbhPvKTMtqXOVkw_nRV28ibg@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Javier Sanz | 2015-10-26 11:59:56 [+0100]:

>The dmesg shows :
=E2=80=A6
>[   15.947514] vboxdrv: Found 4 processor cores
>[   15.963261] BUG: scheduling while atomic: swapper/0/0/0x00010002
>[   15.963297]  <IRQ>  [<ffffffff8160f5c2>] dump_stack+0x4a/0x61
>[   15.963302]  [<ffffffff81095983>] __schedule_bug+0x43/0x60
>[   15.963305]  [<ffffffff81611005>] __schedule+0x4a5/0x7f0
>[   15.963309]  [<ffffffff810b20bb>] ? task_blocks_on_rt_mutex+0x19b/0=
x240
>[   15.963312]  [<ffffffff8161138a>] schedule+0x3a/0xc0
>[   15.963315]  [<ffffffff81612db5>] rt_spin_lock_slowlock+0xc5/0x260
>[   15.963319]  [<ffffffff81614109>] rt_spin_lock+0x29/0x30
>[   15.963338]  [<ffffffffa0290487>]
>VBoxHost_RTSpinlockAcquire+0x57/0x70 [vboxdrv]
>[   15.963349]  [<ffffffffa02822c4>]
>supdrvGipMpEventOnlineOrInitOnCpu+0x64/0x2e0 [vboxdrv]
>[   15.963361]  [<ffffffffa028e320>] ?
>VBoxHost_RTMpGetOnlineSet+0x50/0x50 [vboxdrv]
>[   15.963371]  [<ffffffffa0282550>] supdrvGipInitOnCpu+0x10/0x20 [vbo=
xdrv]
>[   15.963384]  [<ffffffffa028e355>] rtmpLinuxAllWrapper+0x35/0x40 [vb=
oxdrv]
>[   15.963387]  [<ffffffff810e2385>] flush_smp_call_function_queue+0x5=
5/0x160
>[   15.963390]  [<ffffffff810e2f2e>]
=E2=80=A6
>Virtualbox is enable on boot :(

This is third party code. Nothing I can do about it.

>Thank you

Sebastian
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
