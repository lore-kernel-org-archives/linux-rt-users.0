From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: Got stacktrace "irq 17: nobody cared" on Intel GalileoGen2 with
 4.6.7-rt13
Date: Thu, 22 Sep 2016 10:24:26 +0200
Message-ID: <b8c6cd44-4a29-fe84-af0d-747584c04ad0@siemens.com>
References: <1474532371.10922.50.camel@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Claudius Heine <ch@denx.de>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from goliath.siemens.de ([192.35.17.28]:58124 "EHLO
        goliath.siemens.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756136AbcIVIeV (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 22 Sep 2016 04:34:21 -0400
In-Reply-To: <1474532371.10922.50.camel@denx.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 2016-09-22 10:19, Claudius Heine wrote:
> Hi everyone,
> 
> I am currently trying to get the current Linux 4.6.7-rt13 running on an
> Intel QUARK/GalileoGen2 Board and got the same repeating stacktrace 
> when booting. This does not happen in the vanilla kernel.
> 
> For 4.6.7-rt13 I used this Kernel commit:
> f1cf4c43c5ff76957459ea90dc39dcd93a5d0ebd
> 
> Also tried the 4.4.19-rt27 and 4.4.20-rt19 with the same result.
> 
> Does anyone know what could cause this and how to fix it?
> 
> Thanks and have a nice day,
> Claudius
> 
> Full bootlog: http://pastebin.com/qhSQdHYY
> Kernel config: http://pastebin.com/XFKihFr4
> 
> Stacktrace:
> 
> [    7.165722] irq 17: nobody cared (try booting with the "irqpoll"
> option)
> [    7.165752] CPU: 0 PID: 82 Comm: irq/17-pxa2xx-s Not tainted 4.6.7-
> rt13-yocto-preempt-rt #1
> [    7.165762] Hardware name: Intel Corp. QUARK/GalileoGen2, BIOS
> 0x01000400 01/01/2014
> [    7.165804]  cd65db78 cd65db78 cd433f4c c13a0c54 cd433f68 c10888cd
> c18829d8 00000011
> [    7.165839]  cd65db40 cd65db40 00000011 cd433f8c c1088c4f cd65db40
> 00000020 cd798a40
> [    7.165872]  cd433f84 cd65db40 00000020 00000000 cd433fd8 c10866c3
> 00000000 00000007
> [    7.165877] Call Trace:
> [    7.165921]  [<c13a0c54>] dump_stack+0x16/0x22
> [    7.165967]  [<c10888cd>] __report_bad_irq.isra.0+0x2d/0x110
> [    7.166008]  [<c1088c4f>] note_interrupt+0x22f/0x270
> [    7.166051]  [<c10866c3>] handle_irq_event_percpu+0xd3/0x240
> [    7.166091]  [<c10878b4>] ? irq_thread+0xc4/0x1b0
> [    7.166137]  [<c10894e0>] ? handle_edge_irq+0x170/0x170
> [    7.166173]  [<c1086870>] handle_irq_event+0x40/0x90
> [    7.166212]  [<c1089570>] handle_fasteoi_irq+0x90/0x190
> [    7.166251]  [<c101a6ae>] handle_irq+0x5e/0x70
> [    7.166299]  <IRQ>  [<c1755822>] do_IRQ+0x42/0xd0
> [    7.166334]  [<c1754f8c>] common_interrupt+0x2c/0x40
> [    7.166370]  [<c105043d>] ? __local_bh_enable+0xd/0x70
> [    7.166405]  [<c1080000>] ? wakeup_count_show+0x40/0x50
> [    7.166443]  [<c10878b4>] ? irq_thread+0xc4/0x1b0
> [    7.166485]  [<c1087680>] ? irq_finalize_oneshot.part.1+0x160/0x160
> [    7.166521]  [<c1087720>] ? irq_thread_fn+0x40/0x40
> [    7.166559]  [<c10877f0>] ? irq_thread_dtor+0xd0/0xd0
> [    7.166596]  [<c1066cba>] kthread+0x9a/0xb0
> [    7.166636]  [<c1754730>] ret_from_kernel_thread+0x20/0x40
> [    7.166666]  [<c1066c20>] ? kthread_worker_fn+0x130/0x130
> [    7.166689] handlers:
> [    7.166740] [<c10868c0>] irq_default_primary_handler threaded
> [<c14d0360>] ssp_int
> [    7.166749] Disabling IRQ #17
> 

One theory I was thinking about: Could - for whatever reason - disabling
of the interrupt line from the primary handler be broken / work
unreliably and cause this storm?

Jan

-- 
Siemens AG, Corporate Technology, CT RDA ITP SES-DE
Corporate Competence Center Embedded Linux
