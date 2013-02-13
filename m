From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: 3.4.28-rt40 arm freescale imx35 pcm43 - patch
 86236252d2449313bdbac790023cbc957bf6e426 is cause
Date: Wed, 13 Feb 2013 13:13:53 +0100 (CET)
Message-ID: <alpine.LFD.2.02.1302131301580.11905@ionos>
References: <6003615.pRQnIgKCSn@dabox> <5977343.5KpmQXLB4x@dabox> <1525614.TvuV6qqnEF@dabox>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: Tim Sander <tim@krieglstein.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:58430 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933821Ab3BMMNz (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 13 Feb 2013 07:13:55 -0500
In-Reply-To: <1525614.TvuV6qqnEF@dabox>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, 7 Feb 2013, Tim Sander wrote:

> Hi
> 
> Just another update on this stuff. I noticed that there has been a patch added* 
> with spinlocks to the imx.c serial driver. I reverted this patch and now my 
> serialfuz programm "only" kills the serial port with a not so nice oom 
> condition. But at least it does not show the runaway interrupt problem.

That does not make any sense, really. The runnaway interrupt issue is
completely unrelated to this commit.

Though the commit in question introduces a recursive locking problem
in imx_console_write().

imx_rxint()
{
  spin_lock_irqsave(&sport->port.lock,flags);
  ...
  uart_handle_sysrq_char();
    sysrq_function();
      printk();
        imx_console_write();
	  spin_lock_irqsave(&sport->port.lock,flags); <--- BOOOM

Now the kernel cannot tell you, what happened because it's stuck dead.

Find below a completely untested patch which should fix that issue.

Thanks,

	tglx

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 0de7ed7..e1069b4 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -1225,8 +1225,12 @@ imx_console_write(struct console *co, const char *s, unsigned int count)
 	struct imx_port_ucrs old_ucr;
 	unsigned int ucr1;
 	unsigned long flags;
+	int locked = 1;
 
-	spin_lock_irqsave(&sport->port.lock, flags);
+	if (sport->port.sysrq || oops_in_progress || in_kdb_printk())
+		locked = spin_trylock_irqsave(&sport->port.lock, flags);
+	else
+		spin_lock_irqsave(&sport->port.lock, flags);
 
 	/*
 	 *	First, save UCR1/2/3 and then disable interrupts
@@ -1253,7 +1257,8 @@ imx_console_write(struct console *co, const char *s, unsigned int count)
 
 	imx_port_ucrs_restore(&sport->port, &old_ucr);
 
-	spin_unlock_irqrestore(&sport->port.lock, flags);
+	if (locked)
+		spin_unlock_irqrestore(&sport->port.lock, flags);
 }
 
 /*

