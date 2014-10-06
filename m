From: Armin Steinhoff <armin@steinhoff.de>
Subject: Re: Operation not permitted / pthread_setschedparam
Date: Mon, 06 Oct 2014 15:34:03 +0200
Message-ID: <54329A4B.7080706@steinhoff.de>
References: <542A88A8.7060800@steinhoff.de> <alpine.DEB.2.11.1410010058160.4455@nanos> <542BACF1.3090405@steinhoff.de> <CAA7pwKPcT_YvQx9_nvSXCq3sFB3aCRZ-mGWTk4GOvLn0k7c3_w@mail.gmail.com> <542D0689.8050602@steinhoff.de> <542FD0BE.10508@osadl.org> <542FE9B4.3060708@steinhoff.de> <alpine.DEB.2.11.1410042312440.4383@nanos> <54312C88.8060609@steinhoff.de> <alpine.DEB.2.11.1410051453590.4383@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8BIT
Cc: rt-users <linux-rt-users@vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.130]:61249 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752330AbaJFNeI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 6 Oct 2014 09:34:08 -0400
In-Reply-To: <alpine.DEB.2.11.1410051453590.4383@nanos>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Sorry ... I got now time to read your test code and results in detail.
Your test shows only the absence of failures in your "test" scenario.

My bug report provided in Bugzilla shows all informations about the facts.
I could upload my test app to the bug report ... so you get a chance to
replicate these problems and get out of your "realty distortion".

Asking question for a confusing failure situation has nothing to with
"abusing the community!
Yes, I got 3 good hints ... no statement about the arrogant "hint" from you.
It's quite normal to "have theories about a failures" as long as I
verify these in order to find the real problem.

Are you trying to kidding me with this statement: "Why should we be
bothered to solve your business problems,"

Do you really believe I have a business problem ?  There is simpy absolute no business with PREEMPT_RT!
I do only some strategic work for a potential usage of PREEMP_RT ... hope this solves your problem.

I'm working since 25 years wit QNX and other classical real-time operation systems. I did also operating system development for many years ... but before the first LINUX version was released. So be careful to tell me something about "incompetence" ...

--Armin



Thomas Gleixner schrieb:
> On Sun, 5 Oct 2014, Armin Steinhoff wrote:
>> But this doesn't explain why pthread_schedparam had problems with an
>> earlier PREEMPT_RT kernel!
>> And pointing out such a problem and problems of "ps" is for you:
> Lets look at the problems.
>
> I built the random kernel version which you used for testing and
> against which you reported a bug.
>
> # uname -a
> # Linux fuzz 3.4.0-rc7-rt7+ #42 SMP PREEMPT RT Sun Oct 5 15:52:24 CEST 2014 x86_64 GNU/Linux
>
> Using the following test program:
>
> #include <unistd.h>
> #include <stdlib.h>
> #include <string.h>
> #include <stdio.h>
> #include <pthread.h>
>
> static void *fn(void *p)
> {
> 	while (1) sleep(1);
> 	return NULL;
> }
>
> int main(void)
> {
> 	struct sched_param sp;
> 	pthread_t t;
>
> 	if (pthread_create(&t, NULL, fn, NULL) != 0)
> 	   exit(1);
>
> 	memset(&sp, 0, sizeof(sp));
> 	sp.__sched_priority = 80;
> 	if (pthread_setschedparam(t, SCHED_FIFO, &sp) != 0)
> 	      exit(1);
>
> 	printf("OK\n");
> 	sleep(60);
> 	exit(0);
> }
>
> Which is exactly what you claim to be broken.
>
> # ./sp
> OK
> # strace ./sp 2>&1 | grep sched
> sched_setscheduler(2197, SCHED_FIFO, { 80 }) = 0
> #
>
> Strange. It works.
>
> Now lets verify the latest 3.4 version.
>
> # uname -a
> # Linux fuzz 3.4.97-rt121+ #43 SMP PREEMPT RT Sun Oct 5 15:57:30 CEST 2014 x86_64 GNU/Linux
>
> Your claim now is that the priorities of random other programs are
> modified after the first thread is started and its priority is set. So
> the issue should be observable with the above test program as well.
>
> # ps -elLf >a.txt
> # cat a.txt | awk '{ print $7; }' | grep 99
> # cat a.txt | awk '{ print $8; }' | grep 19
> # ./sp &
> OK
> # ps -elLf >b.txt
> # cat b.txt | awk '{ print $7; }' | grep 99
> # cat b.txt | awk '{ print $8; }' | grep 19
> # diff -u a.txt b.txt
> --- a.txt      2014-10-05 16:02:08.994360001 +0200
> +++ b.txt      2014-10-05 16:02:17.518360000 +0200
> @@ -102,4 +102,6 @@
>  0 S tglx      1892  1891  1892  0    1  80   0 -  5250 wait   15:59 pts/0    00:00:00 -bash
>  4 S root      1973  1892  1973  0    1  80   0 - 10497 wait   15:59 pts/0    00:00:00 su
>  4 S root      1974  1973  1974  0    1  80   0 -  4928 wait   15:59 pts/0    00:00:00 bash
> -4 R root      2005  1974  2005  0    1  80   0 -  4770 -      16:02 pts/0    00:00:00 ps -elLf
> +4 S root      2006  1974  2006  0    2  80   0 -  3638 hrtime 16:02 pts/0    00:00:00 ./sp
> +1 S root      2006  1974  2007  0    2 -21   - -  3638 hrtime 16:02 pts/0    00:00:00 ./sp
> +4 R root      2008  1974  2008  0    1  80   0 -  4770 -      16:02 pts/0    00:00:00 ps -elLf
>
> Even more strange. Works as well. And the output of 'ps -elLf' for
> 'sp' is exactly matching the above program.
>
> Now I really had to switch my brain off for this excercise because
> with brain on, I already knew that neither sys_setschedparam() is or
> was broken, nor the kernel randomly modifies priorities nor ps gives
> randomized output.
>
> I asked you at the beginning of this very thread to read
> linux/Documentation/REPORTING-BUGS. You ignored that and came back
> with more theories about kernel bugs and ps being broken.
>
> Then despite the fact, that you failed to provide a proper bug report,
> Carsten gave you enough hints to decode the issue.
>
> But you insist on reporting bugs and problems and come up with more
> theories about broken kernels and tools.
>
> So you really expect the people who are willing to help you for free
> and who gave you perfectly fine hints how to decode your problem,
> should accept that you ignore their hints and advice? 
>
> That's blatant abuse. Abuse of those who try to guide you and those
> who provided you with the technology on which you build products in
> the first place. This is not how community support works.
>
> Do you really expect, that we waste our time with someone who seeks
> help and responds to hints and advise with:
>
>> I have two version of the "man ps" ... the statement of man page 1p
>> isn't applicable for SCHED_FIFO/SCHED_RR because 99 is right here the
>> highest prio for the scheduling.
> So after carefully studying man ps, you came to that conclusion and
> certainly have fully understood how all that works.
>
>> Sorry for not bothering about the confusing handling of priorities
>> within LINUX ..."
> Or perhaps not?
>
> So you make claims about priorities and cannot be bothered to figure
> out how the priority handling of Linux works?
>
> Why should we be bothered to solve your business problems, if you are
> outright refusing to do your homework before stealing everyones time?
>
> While I surely could have responded more politely, you might
> understand that there are limits of patience and limits on tolerating
> abusive behaviour.
>
> Now back to your original question.
>
>> And pointing out such a problem and problems of "ps" is for you:
> A very good reason to ignore any further posts from you.
>
> Thanks,
>
> 	tglx
>


