From: Daniel Walker <dwalker@mvista.com>
Subject: Re: [BUG on PREEMPT_RT, 2.6.23.1-rt5] in rt-mutex code and signals
Date: Sat, 17 Nov 2007 09:29:29 -0800
Message-ID: <1195320569.25393.38.camel@imap.mvista.com>
References: <3efb10970711160751l279fe99dl9f3a130a4373a449@mail.gmail.com>
	 <Pine.LNX.4.58.0711161516580.25989@gandalf.stny.rr.com>
	 <3efb10970711161502m6216bf5rc19a34184b4f3a2b@mail.gmail.com>
	 <Pine.LNX.4.58.0711161830570.28002@gandalf.stny.rr.com>
	 <3efb10970711170344n670d8b69w6679d494922c5bb@mail.gmail.com>
	 <1195316550.25393.21.camel@imap.mvista.com>
	 <3efb10970711170909n3acca605j70525e36faf8da7f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@elte.hu>,
	Thomas Gleixner <tglx@linutronix.de>,
	RT <linux-rt-users@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>
To: Remy Bohmer <linux@bohmer.net>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from homer.mvista.com ([63.81.120.158]:40843 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1752299AbXKQRdq (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 17 Nov 2007 12:33:46 -0500
In-Reply-To: <3efb10970711170909n3acca605j70525e36faf8da7f@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Sat, 2007-11-17 at 18:09 +0100, Remy Bohmer wrote:

> Actually, IMO, compat_semaphores behave like semaphores should behave,
> and thus the same as they behave on a non-RT kernel, and at the
> locations where the semaphores are now misused as mutexes on RT, we
> should replace them by differently-named-mutex-type-semaphores, or
> better: real-RT-mutexes..

The vast majority of semaphore are actually binary semaphores in the
Linux kernel .. So it's easier to mass convert semaphores to mutexes,
then address the ones that don't conform.. Usually they are converted to
the complete API in mainline..

> IMO this wrong usage of semaphores is solved by modifying the code
> that actually made proper use of the semaphores, and I think that if
> the naming matches the mainline kernel, we only need to patch the
> files that really need to be patched during the integration in
> mainline of the RT-patch.

As I say above, it's happen already.. Code is slowly getting converted
to the complete API or the code gets converted to use a binary semaphore
(or a mutex)..

Daniel
