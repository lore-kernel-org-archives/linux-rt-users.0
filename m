From: Stanislav Meduna <stano@meduna.org>
Subject: Re: Protection of critical section in PREEMPT_RT
Date: Tue, 22 Jan 2013 11:24:47 +0100
Message-ID: <50FE68EF.8060909@meduna.org>
References: <CAHX1yNTSObcxNrvsBnPw8QzUWTb4zzs_faZZ1bbGU1L8xzgpsQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: Jacky Lam <lamshuyin@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.meduna.org ([92.240.244.38]:33674 "EHLO meduna.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751090Ab3AVKY4 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 22 Jan 2013 05:24:56 -0500
In-Reply-To: <CAHX1yNTSObcxNrvsBnPw8QzUWTb4zzs_faZZ1bbGU1L8xzgpsQ@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 22.01.2013 04:29, Jacky Lam wrote:

> I have a kernel driver needed to do a indirect register access
> to a hardware interface. In past, I use spinlock to protect
> those code. After turning on PREEMPT_RT, the driver doesn't
> work anymore.

I'm not an expert but AFAIK the spinlock still does the protection,
it just can be preempted. If your driver does not work, there
is either a timing issue as well (i.e. you have time constraints
that are not met when the spinlock is preempted) or there is
a bug that is triggered by the preemption (such as unprotected
access in the code that preempts your spinlock).

> I know spinlock is now preemptible, but how can I protect a "really"
> critical section in PREEMPT_RT? If it is a bad design, could give me
> some tutorial/readings on how to modify my driver?

https://rt.wiki.kernel.org/index.php/RT_PREEMPT_HOWTO

says

Critical sections protected by i.e. spinlock_t and rwlock_t are now
preemptible. The creation of non-preemptible sections (in kernel) is
still possible with raw_spinlock_t (same APIs like spinlock_t)

However, try to identify the real culprit first.

--
                                          Stano

