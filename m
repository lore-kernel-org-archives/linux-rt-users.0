From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Protection of critical section in PREEMPT_RT
Date: Mon, 4 Feb 2013 11:40:53 +0100 (CET)
Message-ID: <alpine.LFD.2.02.1302041138400.11905@ionos>
References: <CAHX1yNTSObcxNrvsBnPw8QzUWTb4zzs_faZZ1bbGU1L8xzgpsQ@mail.gmail.com> <50FE68EF.8060909@meduna.org> <CAHX1yNTKw8vr2v01Eft1tVV5YrP-7Zw=3fk9iF6YJYfbnBJ9LQ@mail.gmail.com> <510ACB87.3080007@am.sony.com>
 <CAHX1yNQgJXM292q1DWXLdQiR_BK5jZ-d+QHVoEEgksQm04YU6g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: frank.rowand@am.sony.com, Stanislav Meduna <stano@meduna.org>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: Jacky Lam <lamshuyin@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:42959 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751085Ab3BDKlA (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 4 Feb 2013 05:41:00 -0500
In-Reply-To: <CAHX1yNQgJXM292q1DWXLdQiR_BK5jZ-d+QHVoEEgksQm04YU6g@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Jacky,

On Mon, 4 Feb 2013, Jacky Lam wrote:

> Thanks.

Please stop top posting!
 
> I finally find that if I disable interrupt during ata_qc_issue() in
> libata-scsi.c, my sata driver works without any problem.

This is wrong. Which driver are you taling about ?
 
> But I find USB EHCI driver is more complicated. Kernel crashes every
> where when RT is turned on. It seems whenever the stack  spin_lock
> ehci->lock and interrupt comes at that moment, kernel will be crashes.
> The reason is EHCI interrupt handler will also take the same lock. If
> my point of view, USB stack seems no PREEMPT_RT safe. Is it correct?
> Am I miss anything?

Probably. First of all you don't tell us which driver you are
using. And w/o seing the code and the output of the kernel crash, we
can't help you at all.

Thanks,

	tglx
