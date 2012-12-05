From: Frank Rowand <frank.rowand@am.sony.com>
Subject: Re: [PATCH RT 0/2][RFC] fix RCU stall warning on ARM
Date: Tue, 4 Dec 2012 21:05:29 -0800
Message-ID: <50BED619.8060102@am.sony.com>
References: <50BED1DA.7070907@am.sony.com>
Reply-To: <frank.rowand@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"paulmck@linux.vnet.ibm.com" <paulmck@linux.vnet.ibm.com>,
	"dipankar@in.ibm.com" <dipankar@in.ibm.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from tx2ehsobe003.messaging.microsoft.com ([65.55.88.13]:55328 "EHLO
	tx2outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751148Ab2LEFFb (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 5 Dec 2012 00:05:31 -0500
In-Reply-To: <50BED1DA.7070907@am.sony.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 12/04/12 20:47, Frank Rowand wrote:
> The RCU stall warning functions call trigger_all_cpu_backtrace()
> to print a backtrace on each cpu.  This function is only
> implemented for x86.  Add a version for ARM.
> 
> With CONFIG_PREEMPT_RT_FULL enabled, flushing the output from
> printk() is inhibited in some contexts to avoid increasing
> real time latencies.  The RCU stall warnings are inhibited
> on ARM due to this feature.  (I have not tested whether this
> is also the case on other architectures.)  Add back the
> oops_in_progress flag to allow the RCU stall warnings to
> print immediately.

When I first implemented these patches on a locally modified
3.0.27-rt67, the call to "bust_spinlocks(0)" that I added to
print_cpu_stall() led to LOCKDEP warning of inconsistent
lock state from a trylock in serial_omap_console_write():

        else if (oops_in_progress)
                locked = spin_trylock_irqsave(&up->port.lock, flags);

If I understand correctly, the warning is triggered on the
slow lock path.  Some more of the warning is:

   inconsistent {HARDIRQ-ON-W} -> {IN-HARDIRQ-W} usage.
   swapper/1/0 [HC1[1]:SC0[0]:HE0:SE1] takes:
    (&(&(&port->lock)->lock)->wait_lock){?.+...}, at: [<c0478ed0>] rt_spin_trylock_irqsave+0x24/0xe0

   ...

   other info that might help us debug this:
    Possible unsafe locking scenario:

          CPU0
          ----
     lock(&(&(&port->lock)->lock)->wait_lock);
     <Interrupt>
       lock(&(&(&port->lock)->lock)->wait_lock);


I have not been able to trigger the warning on recent versions
of the patches, but I suspect the latent problem might still
exist.

-Frank

