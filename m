Return-Path: <SRS0=WSWX=2K=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4247DC43603
	for <linux-rt-users@archiver.kernel.org>; Fri, 20 Dec 2019 08:04:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DD6320716
	for <linux-rt-users@archiver.kernel.org>; Fri, 20 Dec 2019 08:04:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbfLTIEi (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 20 Dec 2019 03:04:38 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:33040 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbfLTIEi (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 20 Dec 2019 03:04:38 -0500
Received: from localhost ([127.0.0.1] helo=vostro.local)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <john.ogness@linutronix.de>)
        id 1iiDGz-00008p-Qn; Fri, 20 Dec 2019 09:04:33 +0100
From:   John Ogness <john.ogness@linutronix.de>
To:     Dick Hollenbeck <dick@softplc.com>
Cc:     linux-rt-users <linux-rt-users@vger.kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: 8250: set_ier(), clear_ier() and the concept of atomic console writes
References: <6e0f459a-d3dc-73cb-679f-6e86008048e1@softplc.com>
Date:   Fri, 20 Dec 2019 09:04:32 +0100
In-Reply-To: <6e0f459a-d3dc-73cb-679f-6e86008048e1@softplc.com> (Dick
        Hollenbeck's message of "Thu, 19 Dec 2019 11:47:19 -0600")
Message-ID: <87woarjucv.fsf@linutronix.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

(added printk maintainers CC)

Hi Dick,

On 2019-12-19, Dick Hollenbeck <dick@softplc.com> wrote:
> Let's talk serially:
>
> When using serial port debug printing, I have always dedicated a
> serial port for that.  In contrast, I have never tried to dovetail
> debug messages with actual other use of the serial port.  I don't
> understand the use case for changing to polled mode on the fly and
> then changing back.  I could not disconnect the normal use (interrupt
> driven) serial cable and then rapidly attach another serial cable
> intended for capturing debug messages in time to see a polled debug
> message interleaved with normal port usage.  So I think the use case
> contemplated by the current code is rare if non-existent.  And the
> result is that the code is super ugly.

In Linux there are consoles, which I dare say is a common use case for
UARTs (i.e debug messages interleaved with normal port usage is not rare
and definitely exists).

> In fact the serial port code is getting uglier by the month. Its
> gotten too complex and bulkier for weird apparent requirements.  When
> those corner case requirements are met such that concurrent use is
> mandated, the solution is always more complex than if requirements can
> be considered mutually exclusive.  (e.g. Who prints debug statements
> onto a serial cable that is already in use for a MODBUS driver?  How
> would you see those print statements easily?)
>
> But for now, I drill down to a specific complaint.
>
> I am looking at branch linux-5.2.y-rt-rebase, file:
>   drivers/tty/serial/8250/8250_core.c
>   commit 82dfc28946eacceae by John Ogness.
>
>
> Here is a belated partial patch review, and would be some of the
> reasons I could not accept this patch if I was in charge of mainline:

Thanks. I've been waiting nearly a year for feedback on these patches.

> 1) The mutual exclusion used in set_eir() clear_ier() feels like the
> big kernel lock all over again.  All ports using the same lock....

Yes, this is a problem. Only consoles should be using the cpu-lock. I
will address this.

> 2) Those functions are in an 8250 specific area but do not have 8250
> specific names, and they are public.

So you would like to see them renamed to:

   serial8250_set_ier()
   serial8250_clear_ier()
   serial8250_restore_ier()

> 3) The lock used in set_eir() & clear_eir() puts the CPU into atomic
> mode and then calls serial_port_out().  This assumes that we know
> everything there will ever be to know about serial_port_out(), even
> though it is an abstraction, with multiple implementations now and
> more in the future.

Mainline serial8250_console_write() calls serial_port_out() in atomic
context as well. So this is already a requirement of serial_port_out(),
at least for consoles. And if the cpu-lock is only taken for consoles
(see my response to #1), then this should not introduce any new issues.

> In fact, the future is now.  I have expanded serial_port_out() to use
> a spinlock because my UART is in an FPGA, along with other peripherals
> which share a common FPGA interface.  The spinlock gets remapped to
> rt_mutex.  When there is a collision on that mutex somebody must get
> suspended, and then I see the kernel report of:
>
> BUG: scheduling while atomic: irq/56-ttyS5/592/0x00000002

If your FPGA-UART should be a console, then it is a bug in your
implementation (for mainline as well). I don't know if non-consoles also
have atomic requirements.

> fpga_write() is where the rt_mutex is, aka spinlock in true source
> representation.  I can run a couple million bytes through that
> function for UARTs and other peripherals, but you know RT, if can go
> wrong it will, and it eventually does.
>
> The atomic mode was entered in the common (shared_by_all_ports) serial
> lock in console_atomic_lock().  This is because the author was trying
> to provide mutual exclusion between debug messages and actual normal
> serial port use.  I think that is fool's gold.  I have no problem with
> serial port debug messages, but I don't share a port when I am using
> them.

You don't use your debug serial port as a console. That is a wise
choice that unfortunately most people will not make.

> So the next question is, do I go to a raw spin lock in my
> fpga_write(), or do I try and fix the usage of console_atomic_lock()
> in set_eir() and clear_eir()?

- I will change the functions to only take the cpu-lock if the 8250 is a
  console.

- I will rename the functions to serial8250_*.

I believe that will address your main points. However, if you want to
use your FPGA-UART as a console, you will need to change to a raw spin
lock (even for mainline).

Thanks for the feedback.

John Ogness
