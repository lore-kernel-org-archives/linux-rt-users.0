From: Tim Sander <tim@krieglstein.org>
Subject: Re: 3.4.28-rt40 arm freescale imx35 pcm43 - patch 86236252d2449313bdbac790023cbc957bf6e426 is cause
Date: Wed, 13 Feb 2013 18:07:27 +0100
Message-ID: <3970144.HqS49ZSYWh@dabox>
References: <6003615.pRQnIgKCSn@dabox> <1525614.TvuV6qqnEF@dabox> <alpine.LFD.2.02.1302131301580.11905@ionos>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from lvps176-28-13-145.dedicated.hosteurope.de ([176.28.13.145]:56387
	"EHLO lvps176-28-13-145.dedicated.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760039Ab3BMRHa (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 13 Feb 2013 12:07:30 -0500
In-Reply-To: <alpine.LFD.2.02.1302131301580.11905@ionos>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Thomas
> > Just another update on this stuff. I noticed that there has been a patch
> > added* with spinlocks to the imx.c serial driver. I reverted this patch
> > and now my serialfuz programm "only" kills the serial port with a not so
> > nice oom condition. But at least it does not show the runaway interrupt
> > problem.
> That does not make any sense, really. The runnaway interrupt issue is
> completely unrelated to this commit.
One thing that puzzles me is the fact that it does! So removing the mentioned 
spinlock patch creates the same result as using your fixed patch.

As the other problem with the driver i posted shows the same interrupt runaway 
symptom as this i have a very bad gut feeling about this... 
Or probably its not a runnaway interrupt problem but a double 
spin_lock_irqsave.

Also the fact that my serialfuz program i posted is able to give the system an 
Out Of Memory condition is strange. I mean throwing random chars at a getty 
should'nt exhaust memory so fast.

> Though the commit in question introduces a recursive locking problem
> in imx_console_write().
> 
> imx_rxint()
> {
>   spin_lock_irqsave(&sport->port.lock,flags);
>   ...
>   uart_handle_sysrq_char();
>     sysrq_function();
>       printk();
>         imx_console_write();
> 	  spin_lock_irqsave(&sport->port.lock,flags); <--- BOOOM
> 
> Now the kernel cannot tell you, what happened because it's stuck dead.
> 
> Find below a completely untested patch which should fix that issue.
The patch didn't compile cleanly, so i removed the last or statment (albeit 
without knowing if its important (but it's not defined so it can't be ;-).

Below is a patch that compiles and survives as the undone 
86236252d2449313bdbac790023cbc957bf6e426 patch.

Thanks
Tim

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 0de7ed7..e1069b4 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -1225,8 +1225,12 @@ imx_console_write(struct console *co, const char *s, 
unsigned int count)
        struct imx_port_ucrs old_ucr;
        unsigned int ucr1;
        unsigned long flags;
+       int locked = 1;
 
-       spin_lock_irqsave(&sport->port.lock, flags);
+       if (sport->port.sysrq || oops_in_progress )
+               locked = spin_trylock_irqsave(&sport->port.lock, flags);
+       else
+               spin_lock_irqsave(&sport->port.lock, flags);
 
        /*
         *      First, save UCR1/2/3 and then disable interrupts
@@ -1253,7 +1257,8 @@ imx_console_write(struct console *co, const char *s, 
unsigned int count)
 
        imx_port_ucrs_restore(&sport->port, &old_ucr);
 
-       spin_unlock_irqrestore(&sport->port.lock, flags);
+       if (locked)
+               spin_unlock_irqrestore(&sport->port.lock, flags);
 }
 
 /*

