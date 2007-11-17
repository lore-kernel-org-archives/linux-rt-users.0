From: "Remy Bohmer" <linux@bohmer.net>
Subject: Re: [BUG on PREEMPT_RT, 2.6.23.1-rt5] in rt-mutex code and signals
Date: Sat, 17 Nov 2007 18:09:15 +0100
Message-ID: <3efb10970711170909n3acca605j70525e36faf8da7f@mail.gmail.com>
References: <3efb10970711160751l279fe99dl9f3a130a4373a449@mail.gmail.com>
	 <Pine.LNX.4.58.0711161516580.25989@gandalf.stny.rr.com>
	 <3efb10970711161502m6216bf5rc19a34184b4f3a2b@mail.gmail.com>
	 <Pine.LNX.4.58.0711161830570.28002@gandalf.stny.rr.com>
	 <3efb10970711170344n670d8b69w6679d494922c5bb@mail.gmail.com>
	 <1195316550.25393.21.camel@imap.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Steven Rostedt" <rostedt@goodmis.org>,
	"Ingo Molnar" <mingo@elte.hu>,
	"Thomas Gleixner" <tglx@linutronix.de>,
	RT <linux-rt-users@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>
To: "Daniel Walker" <dwalker@mvista.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.181]:20223 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751332AbXKQRJQ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 17 Nov 2007 12:09:16 -0500
Received: by py-out-1112.google.com with SMTP id u77so4842301pyb
        for <linux-rt-users@vger.kernel.org>; Sat, 17 Nov 2007 09:09:15 -0800 (PST)
In-Reply-To: <1195316550.25393.21.camel@imap.mvista.com>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hello Daniel,

Thanks for looking into it also.
Steven already made clear to me that the 'struct semaphore' type on
the RT-kernel should not be used as a counting-semaphore, but as some
sort of legacy-mutex... (The confusion that this will cause is clear
by now...)

I still do not understand the problems I had with the
interruptible-waits on a real rt-mutex, but I have to figure that out
again on Monday. Maybe one confusion let to another...

(Note, A completion will not work for me, because they are not
designed for reuse across several threads. The read/write runs in user
context and as such it can be called by different threads, which would
require a init of a completion before waiting on it, but that would be
racy, I could miss the awake by the init)

> So I converted your code to use a compat_semaphore, and no oops
> happens.. Which makes sense because compat_semaphores are designed to
> work the way your using them.

Actually, IMO, compat_semaphores behave like semaphores should behave,
and thus the same as they behave on a non-RT kernel, and at the
locations where the semaphores are now misused as mutexes on RT, we
should replace them by differently-named-mutex-type-semaphores, or
better: real-RT-mutexes..
IMO this wrong usage of semaphores is solved by modifying the code
that actually made proper use of the semaphores, and I think that if
the naming matches the mainline kernel, we only need to patch the
files that really need to be patched during the integration in
mainline of the RT-patch.

Kind Regards,

Remy Bohmer
