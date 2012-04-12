From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: File I/O in a Realtime Process
Date: Thu, 12 Apr 2012 21:41:43 +0200 (CEST)
Message-ID: <alpine.LFD.2.02.1204122128260.2542@ionos>
References: <7B6FE55CD594D7478CED8A39DF3BFC0A02B4FE@UT40SEM2.atk.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: "Moore, Thomas (FtWorth)" <Thomas.Moore2@ATK.COM>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:38364 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753801Ab2DLTlq (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 12 Apr 2012 15:41:46 -0400
In-Reply-To: <7B6FE55CD594D7478CED8A39DF3BFC0A02B4FE@UT40SEM2.atk.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, 12 Apr 2012, Moore, Thomas (FtWorth) wrote:
> In reviewing the documentation for the PREEMPT_RT patch, it's made
> pretty clear that performing file I/O (or page faults in general)
> will degrade realtime performance. The "HOWTO: Build an
> RT-application" on the wiki also states that page faults from one
> application will not interfere with the realtime performance of an
> application. Based on this understanding, if a system utilizing the
> PREEMPT_RT patch had requirements to perform file I/O, would it be
> required to have a separate non-realtime process that performs this
> task or would it be possible to use a low priority thread in the
> realtime process?

The point is, that file I/O is not deterministic by any means, so it's
not recommended to use file operations in your high priority task.

So if you do file I/O form a non-rt thread in the same process it does
not affect the rt-task except for the following:

 - TLB shootdown interrupts might interfere minimally (you probably
   won't notice)

 - page faults processing can hold mmap semaphore of the process for
   some time, which might affect your rt task if it uses
   pthread_mutexes which are shared and not marked private or some
   other form of process shared memory which requires mmap sem to be
   held.

Aside of that, it's pretty much safe to do the file I/O from a non-rt
task within the same process.

Thanks,

	tglx
