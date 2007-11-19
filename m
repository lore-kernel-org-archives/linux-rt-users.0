From: "Remy Bohmer" <linux@bohmer.net>
Subject: Re: [BUG on PREEMPT_RT, 2.6.23.1-rt5] in rt-mutex code and signals
Date: Mon, 19 Nov 2007 13:55:45 +0100
Message-ID: <3efb10970711190455n5e635823t40a320c4b444fa57@mail.gmail.com>
References: <3efb10970711160751l279fe99dl9f3a130a4373a449@mail.gmail.com>
	 <Pine.LNX.4.58.0711161516580.25989@gandalf.stny.rr.com>
	 <3efb10970711161502m6216bf5rc19a34184b4f3a2b@mail.gmail.com>
	 <Pine.LNX.4.58.0711161830570.28002@gandalf.stny.rr.com>
	 <3efb10970711170344n670d8b69w6679d494922c5bb@mail.gmail.com>
	 <Pine.LNX.4.58.0711170840130.4453@gandalf.stny.rr.com>
	 <3efb10970711170736u469bbbc5p8c227ca2a12657dd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Ingo Molnar" <mingo@elte.hu>,
	"Thomas Gleixner" <tglx@linutronix.de>,
	RT <linux-rt-users@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	"Daniel Walker" <dwalker@mvista.com>
To: "Steven Rostedt" <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.183]:2167 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754850AbXKSMzq (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 19 Nov 2007 07:55:46 -0500
Received: by py-out-1112.google.com with SMTP id u77so5757331pyb
        for <linux-rt-users@vger.kernel.org>; Mon, 19 Nov 2007 04:55:45 -0800 (PST)
In-Reply-To: <3efb10970711170736u469bbbc5p8c227ca2a12657dd@mail.gmail.com>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hello Steven,

> > OK, I wont be able to work on this this weekend, but I'll try to get to it
> > on Monday.  A better example to show the bug you are looking for is simply
> > create a mutex and create a thread that grabs that mutex and goes to
> > sleep. Have your driver read grab that mutex with
> > mutex_lock_interruptible. And if the signal code is broken with this, then
> > you definitely got a point that the inerruptible code is broken.

I removed the 'struct semaphore' completely from my driver, using real
mutexes now instead, replace the signalling semaphores by 'struct
completion' mechanisms and got rid of the possible race I saw with the
completions in a different way, and now the problem is completely
gone!

Posix Signals work properly now (no OOPS anymore), so the problem was
likely related to the way I used the 'struct semaphore' types, which
is thus different compared to the non-RT kernel and therefor quite
confusing.

So, thank you (and Daniel) for pointing me into the right direction.

Now lets get rid of the 'struct semaphore' completely in the kernel :-))


Kind Regards,

Remy Bohmer
