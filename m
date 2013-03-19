From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: entry_32.S ret_from_intr and invocation of scheduler, v3.2-rt
Date: Tue, 19 Mar 2013 14:30:40 -0400
Message-ID: <1363717840.5938.43.camel@gandalf.local.home>
References: <CAO2z5Zi52q94xfmqRDwq5XSgD-VaVitnJ_JNnEpGOr9Spi4cWA@mail.gmail.com>
	 <alpine.LFD.2.02.1303152225250.22263@ionos>
	 <CAO2z5ZjDLdyrXJ-LsE_8VauwXuntTb4-51Gka3aLykYiBuNaVQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
	linux-rt-users@vger.kernel.org
To: notgeorge burns <not.george.burns@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:33730 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754702Ab3CSSam (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 19 Mar 2013 14:30:42 -0400
In-Reply-To: <CAO2z5ZjDLdyrXJ-LsE_8VauwXuntTb4-51Gka3aLykYiBuNaVQ@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Sat, 2013-03-16 at 17:10 -0700, notgeorge burns wrote:
> Just curious, what is the rationale for irq_default_primary_handler()
> not to invoke set_need_resched()?  Drivers that set up with plain-old
> request_irq() will have a scheduled softirq handler, but the hardirq
> will return to wherever it was without the priority of the softirq
> task coming into play.  For my drivers I can work around it with
> request_threaded_irq() but is the potential inversion for
> request_irq()-installed handlers really the expected behavior?  Sorry
> if this question has been gone over before, I couldn't find anything
> with a quick search of the archives.

Why should it invoke set_need_resched(), I hope your driver isn't doing
that, as it may not get scheduled, and you just added the extra overhead
of a unnecessary schedule() call.

If a hardirq wakes up its thread, and that thread happens to be of a
higher priority than the currently running task, the act of waking up
will set need_resched for you. But it can certainly be possible for the
current userspace thread to be running at a higher priority than the
interrupt thread, and we don't want to call schedule in that case.

This is the point of -rt in the first place. Its OK to have some
userspace tasks higher priority than interrupts.

-- Steve


