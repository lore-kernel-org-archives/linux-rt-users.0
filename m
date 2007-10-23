From: "Paul Menage" <menage@google.com>
Subject: Re: [PATCH -v2 4/7] RT overloaded runqueues accounting
Date: Mon, 22 Oct 2007 23:11:54 -0700
Message-ID: <6599ad830710222311x402c3d1agcc458742fb5e219c@mail.gmail.com>
References: <20071023025900.927578809@goodmis.org>
	 <20071023032916.651749224@goodmis.org>
	 <20071022211709.7be79fea.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Steven Rostedt" <rostedt@goodmis.org>,
	linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
	torvalds@linux-foundation.org, akpm@linux-foundation.org,
	mingo@elte.hu, dmitry.adamushko@gmail.com, ghaskins@novell.com,
	a.p.zijlstra@chello.nl
To: "Paul Jackson" <pj@sgi.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.33.17]:15336 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752065AbXJWGMC (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 23 Oct 2007 02:12:02 -0400
Received: from zps75.corp.google.com (zps75.corp.google.com [172.25.146.75])
	by smtp-out.google.com with ESMTP id l9N6BtRB003925
	for <linux-rt-users@vger.kernel.org>; Tue, 23 Oct 2007 07:11:56 +0100
Received: from py-out-1112.google.com (pybp76.prod.google.com [10.34.92.76])
	by zps75.corp.google.com with ESMTP id l9N6AgU1003200
	for <linux-rt-users@vger.kernel.org>; Mon, 22 Oct 2007 23:11:54 -0700
Received: by py-out-1112.google.com with SMTP id p76so2949263pyb
        for <linux-rt-users@vger.kernel.org>; Mon, 22 Oct 2007 23:11:54 -0700 (PDT)
In-Reply-To: <20071022211709.7be79fea.pj@sgi.com>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 10/22/07, Paul Jackson <pj@sgi.com> wrote:
> Steven wrote:
> > +void cpuset_rt_set_overload(struct task_struct *tsk, int cpu)
> > +{
> > +     cpu_set(cpu, task_cs(tsk)->rt_overload);
> > +}
>
> Question for Steven:
>
>   What locks are held when cpuset_rt_set_overload() is called?
>
> Questions for Paul Menage:
>
>   Does 'tsk' need to be locked for the above task_cs() call?

Cgroups doesn't change the locking rules for accessing a cpuset from a
task - you have to have one of:

- task_lock(task)

- callback_mutex

- be in an RCU section from the point when you call task_cs to the
point when you stop using its result. (Additionally, in this case
there's no guarantee that the task stays in this cpuset for the
duration of the RCU section).

Paul
