From: Jacky Lam <lamshuyin@gmail.com>
Subject: Re: Protection of critical section in PREEMPT_RT
Date: Tue, 5 Feb 2013 09:40:07 +0800
Message-ID: <CAHX1yNTb92NMAi+9F0QCXqyvwEmerGOar5t4J1tLGznF2jD8Tg@mail.gmail.com>
References: <CAHX1yNTSObcxNrvsBnPw8QzUWTb4zzs_faZZ1bbGU1L8xzgpsQ@mail.gmail.com>
	<50FE68EF.8060909@meduna.org>
	<CAHX1yNTKw8vr2v01Eft1tVV5YrP-7Zw=3fk9iF6YJYfbnBJ9LQ@mail.gmail.com>
	<510ACB87.3080007@am.sony.com>
	<CAHX1yNQgJXM292q1DWXLdQiR_BK5jZ-d+QHVoEEgksQm04YU6g@mail.gmail.com>
	<alpine.LFD.2.02.1302041138400.11905@ionos>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: frank.rowand@am.sony.com, Stanislav Meduna <stano@meduna.org>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ia0-f172.google.com ([209.85.210.172]:61045 "EHLO
	mail-ia0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754410Ab3BEBkI (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 4 Feb 2013 20:40:08 -0500
Received: by mail-ia0-f172.google.com with SMTP id u8so8741700iag.17
        for <linux-rt-users@vger.kernel.org>; Mon, 04 Feb 2013 17:40:07 -0800 (PST)
In-Reply-To: <alpine.LFD.2.02.1302041138400.11905@ionos>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Thomas,

On Mon, Feb 4, 2013 at 6:40 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
> Jacky,
>
> On Mon, 4 Feb 2013, Jacky Lam wrote:
>
>> Thanks.
>
> Please stop top posting!
>

Thanks for reminding.

>> I finally find that if I disable interrupt during ata_qc_issue() in
>> libata-scsi.c, my sata driver works without any problem.
>
> This is wrong. Which driver are you taling about ?
>
>> But I find USB EHCI driver is more complicated. Kernel crashes every
>> where when RT is turned on. It seems whenever the stack  spin_lock
>> ehci->lock and interrupt comes at that moment, kernel will be crashes.
>> The reason is EHCI interrupt handler will also take the same lock. If
>> my point of view, USB stack seems no PREEMPT_RT safe. Is it correct?
>> Am I miss anything?
>
> Probably. First of all you don't tell us which driver you are
> using. And w/o seing the code and the output of the kernel crash, we
> can't help you at all.
>

I am sorry for that. But it is a driver for our in-house hardware. It
seems meaningless even I post the source here. Please tell me if it
did help. From your statement above, it seems PREEMPT_RT patch do not
work with USB stack. Is it true? I am happy to post the fix here if I
can fix that.

While I am porting my drivers to PREEMPT_RT patched kernel, I find a
common problem. In stock kernel, whenever I need to touch some data
structures in driver code and also in interrupt handler, we can
protect them by spin_lock_irqsave(). But in PREEMT_RT kernel, while
the driver code touching the data structures, interrupt can still come
in. If I don't protect the data structure by spinlcok, the data
structures will corrupt. If I put it, rt_spin_lock function will cause
a kernel dump. Of course, I can use raw_spin_lock_irqsave() instead.
But for the case like USB stack and SATA stack, if I disable the
interrupt just like what I did for ata_qc_issue(). It seems not very
good idea.

Is there any rule to resolve such conflict?

> Thanks,
>
>         tglx
