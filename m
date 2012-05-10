From: Christophe Huriaux <c.huriaux@gmail.com>
Subject: Re: BUG - "scheduling while atomic" on a irq handler (s3c-mci)
Date: Thu, 10 May 2012 15:17:17 +0200
Message-ID: <CAEOomG9FZD9TEQZZKhCrNrq8SNXi3otWB2mDX69i3tWh5YQenw@mail.gmail.com>
References: <CAEOomG9NEoQKqp=pMx0NpzGaFpHBimALwhemnZL4F-8g7XURkA@mail.gmail.com>
 <20120509174931.GB31844@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org
To: =?ISO-8859-1?Q?Uwe_Kleine=2DK=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wg0-f42.google.com ([74.125.82.42]:64270 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752730Ab2EJNRk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 10 May 2012 09:17:40 -0400
Received: by wgbds11 with SMTP id ds11so440447wgb.1
        for <linux-rt-users@vger.kernel.org>; Thu, 10 May 2012 06:17:38 -0700 (PDT)
In-Reply-To: <20120509174931.GB31844@pengutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

2012/5/9 Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>:
> If you enable CONFIG_KALLSYMS you get a more usable backtrace.
> Alternatively you can use
>
> =A0 =A0 =A0 =A0$CROSS_COMPILE-addr2line -e vmlinux 0xc000e90c
>
> to get the file and line that resulted in the code at that address.
>

  Thanks, I was wondering which config option would enable that. The
complete backtrace is much more usable :

BUG: scheduling while atomic: irq/37-s3c-mci/253/0x00000102
Modules linked in:
[<c000e9fc>] (unwind_backtrace+0x0/0x12c) from [<c029b82c>]
(__schedule+0x58/0x2c0)
[<c029b82c>] (__schedule+0x58/0x2c0) from [<c029bc10>] (schedule+0x8c/0=
xb0)
[<c029bc10>] (schedule+0x8c/0xb0) from [<c0055614>] (synchronize_irq+0x=
bc/0xd8)
[<c0055614>] (synchronize_irq+0xbc/0xd8) from [<c01db6b0>]
(pio_tasklet+0x34/0x11c)
[<c01db6b0>] (pio_tasklet+0x34/0x11c) from [<c0024914>]
(__tasklet_action+0x68/0x80)
[<c0024914>] (__tasklet_action+0x68/0x80) from [<c0024ca4>]
(__do_softirq+0x88/0x130)
[<c0024ca4>] (__do_softirq+0x88/0x130) from [<c0024ef0>] (do_softirq+0x=
48/0x54)
[<c0024ef0>] (do_softirq+0x48/0x54) from [<c0025048>]
(local_bh_enable+0x8c/0xc0)
[<c0025048>] (local_bh_enable+0x8c/0xc0) from [<c0054678>]
(irq_forced_thread_fn+0x4c/0x54)
[<c0054678>] (irq_forced_thread_fn+0x4c/0x54) from [<c0054454>]
(irq_thread+0xa0/0x1c0)
[<c0054454>] (irq_thread+0xa0/0x1c0) from [<c0038628>] (kthread+0x84/0x=
8c)
[<c0038628>] (kthread+0x84/0x8c) from [<c000a100>] (kernel_thread_exit+=
0x0/0x8)


> My guess is that for PREEMPT_RT_FULL the printk just doesn't make it =
to
> your console driver because the data would only be given to it when t=
he
> atomic block is done.

  Indeed : after tracing printk calls in GDB while in PREEMPT_RT_FULL
I can see that there is a lot more data sent than what the serial
driver handles.

  I'm able to fix this problem by replacing disable_irq() calls by
disable_irq_nosync() in s3cmci_enable_irq() and s3cmci_disable_irq()
(see patch below), which does not trigger a schedule. I don't see any
problem so far (at least I can boot !).


=46rom: Christophe Huriaux <c.huriaux@gmail.com>
Subject: [PATCH] Fix scheduling while atomic bug in pio_tasklet
Signed-off-by: Christophe Huriaux <c.huriaux@gmail.com>
---
 drivers/mmc/host/s3cmci.c |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/mmc/host/s3cmci.c b/drivers/mmc/host/s3cmci.c
index 720f993..9978ad6 100644
--- a/drivers/mmc/host/s3cmci.c
+++ b/drivers/mmc/host/s3cmci.c
@@ -329,7 +329,11 @@ static void s3cmci_enable_irq(struct s3cmci_host
*host, bool more)
                if (enable)
                        enable_irq(host->irq);
                else
+#ifdef CONFIG_PREEMPT_RT_BASE
+                       disable_irq_nosync(host->irq);
+#else
                        disable_irq(host->irq);
+#endif
        }

        local_irq_restore(flags);
@@ -350,7 +354,11 @@ static void s3cmci_disable_irq(struct s3cmci_host
*host, bool transfer)

        if (transfer && host->irq_state) {
                host->irq_state =3D false;
+#ifdef CONFIG_PREEMPT_RT_BASE
+               disable_irq_nosync(host->irq);
+#else
                disable_irq(host->irq);
+#endif
        }

        local_irq_restore(flags);
--=20
1.7.9.5


Regards,
Christophe Huriaux
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
