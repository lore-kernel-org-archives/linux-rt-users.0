From: Michal Schmidt <mschmidt@redhat.com>
Subject: Re: sched_yield() needed for pthread_cond_signal(..) to work?
Date: Tue, 19 Feb 2008 01:35:13 +0100
Message-ID: <20080219013513.5eb25b97@hammerfall>
References: <2accc2ff0802181016q26eb8b8cm88f45a0162ae21a0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org,
	"=?UTF-8?B?QW5kcsOpcyBDYWxkZXLDs24=?=" <andres.calderon@emqbit.com>
To: "Nelson Castillo" <nelsoneci@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:51420 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751272AbYBSAfT (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 18 Feb 2008 19:35:19 -0500
In-Reply-To: <2accc2ff0802181016q26eb8b8cm88f45a0162ae21a0@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Dne Mon, 18 Feb 2008 13:16:16 -0500
"Nelson Castillo" <nelsoneci@gmail.com> napsal(a):

>   http://svn.arhuaco.org/svn/src/junk/trunk/threads/cond-signal-test.c
> 
> In a PC (Debian 2.6.24 686 with no RT patches) it prints 1000. In the
> realtime system it prints 1 or 0.
> 
> # ./a.out
> 1
> # ./a.out
> 0
> # ./a.out
> 1

Your test program is flawed. The result can be anything between 0 and
1000. (Theoretically even more, because spurious wakeups are
possible from pthread_cond_wait).

I ran the program without sched_yield() on my Fedora 8 system
(2.6.23.15-137.fc8 kernel, non-RT, only voluntary preemption). I got
1000 most of the time, but quite often the result was less than that.

> If I do a sched_yield() right after releasing the mutex associated
> with the condition, the program prints 1000 as expected.

You should not rely on that. There's no guarantee it will work. You've
just been lucky so far.

> void
> dosignal (void)
> {
>   pthread_mutex_lock (&cond_mutex);
>   pthread_cond_signal(&cond);
>   pthread_mutex_unlock (&cond_mutex);
>    sched_yield(); //  without this I get 0! with Linux and RT patches
> }

And you're doing:
  for (i = 0; i < 1000; ++i)
    dosignal ();

pthread_cond_signal() will wake the other thread up, but you don't know
if it will be scheduled to run immediately. It is perfectly valid for
the scheduler to keep the main thread on the CPU and let it finish all
the 1000 iterations first.

Michal
