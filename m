From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RT] seqlock/rt: Prevent livelocks with seqlocks in RT
Date: Tue, 06 Mar 2012 07:47:28 -0500
Message-ID: <1331038048.25686.368.camel@gandalf.stny.rr.com>
References: <1331006584.25686.362.camel@gandalf.stny.rr.com>
	 <alpine.LFD.2.02.1203060911000.2742@ionos>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>,
	Clark Williams <clark@redhat.com>,
	John Kacur <jkacur@redhat.com>, Carsten Emde <cbe@osadl.org>,
	Peter Zijlstra <peterz@infradead.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:19197 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751163Ab2CFMr3 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 6 Mar 2012 07:47:29 -0500
In-Reply-To: <alpine.LFD.2.02.1203060911000.2742@ionos>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, 2012-03-06 at 09:18 +0100, Thomas Gleixner wrote:

> > Because read_seqlocks are used in the VDSO area, a raw_read_seqcount_begin()
> > was created to allow userspace tasks to access read_seqcount().
> > As the grabbing of the write_lock() is not allowed in VDSO, nor
> > is even referencing it.
> 
> This is completely bogus. The VDSO update write side runs with
> interrupts disabled, so it cannot be preempted at all.
> 
> > Note, a live lock can still happen if the userspace task that
> > does the read_seqlock is of higher priority than a user doing
> > the write_lock, so userspace needs to be careful.
> 
> What the hell are you smoking?

Cherries.


I forgot I still had that in my changelog. I wrote this code before I
had your changes. I noticed later that the vdso seqlocks were raw
spinlocks and shouldn't be an issue. As you told me that you had this
fixed, I never bothered to change the log.

Then last night when I hit this bug, I simply cherry picked this fixed
and posted it.

-- Steve


