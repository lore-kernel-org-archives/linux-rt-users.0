From: Alexander Fyodorov <halcy@yandex.ru>
Subject: Re: [PATCH rt] Fix races in ptrace
Date: Tue, 13 Aug 2013 01:13:56 +0400
Message-ID: <393831376342036@web15d.yandex.ru>
References: <102271374683007@web8f.yandex.ru> <20130812164145.GJ23040@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from forward4.mail.yandex.net ([77.88.46.9]:35368 "EHLO
	forward4.mail.yandex.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753010Ab3HLVTT (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 12 Aug 2013 17:19:19 -0400
In-Reply-To: <20130812164145.GJ23040@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

12.08.2013, 20:41, "Sebastian Andrzej Siewior" <bigeasy@linutronix.de>:
> * Alexander Fyodorov | 2013-07-24 20:23:27 [+0400]:
> Hi Alexander,

Hi Sebastian,

>> I ran into a race on 2.6.33-rt kernel which I think still exists in =
the latest RT patches. The following patch fixes it but it may be incom=
plete: probably spinlock should be taken in all other places that check=
 saved_state too. =9AI only compile-tested this patch for 3.6-rt.
>
> It looks interresting, thanks for the report. Do you have maybe a
> test-case which can provoke the bug?

I can't publish the test but essentially it was doing the following: on=
e process (application) has 20 threads sending signals to each other (c=
reating contention for tasklist_lock and profiling events), and another=
 one (profiler) attaches to the application and then does:
	for (;;) {
		pid =3D wait();
		ptrace(PTRACE_CONT, pid);
	}
Is there a need to write a test?
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
