From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V3 3/7] workqueue: Add helpers to schedule work on any cpu
Date: Fri, 29 Mar 2013 08:09:49 +0530
Message-ID: <CAKohpom1wbrfOgPr4n-HzQjdUS=BcHwbrd=gemVKr1QqEO0L9A@mail.gmail.com>
References: <cover.1363617402.git.viresh.kumar@linaro.org>
	<fb2e721fc43fbc3517a7ebb905aa573b12bb83a5.1363617402.git.viresh.kumar@linaro.org>
	<20130321001211.GC31256@htj.dyndns.org>
	<CAKohponKUGbwEZ_edu353Y7YVZKgFOhZunTSUi04FGYWveftkw@mail.gmail.com>
	<20130321182937.GB20500@htj.dyndns.org>
	<20130328181332.GD14088@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: pjt@google.com, paul.mckenney@linaro.org, tglx@linutronix.de,
	suresh.b.siddha@intel.com, venki@google.com, mingo@redhat.com,
	peterz@infradead.org, rostedt@goodmis.org,
	linaro-kernel@lists.linaro.org, robin.randhawa@arm.com,
	Steve.Bannister@arm.com, Liviu.Dudau@arm.com,
	charles.garcia-tobin@arm.com, Arvind.Chauhan@arm.com,
	linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ob0-f170.google.com ([209.85.214.170]:52083 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753662Ab3C2Cju (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 28 Mar 2013 22:39:50 -0400
Received: by mail-ob0-f170.google.com with SMTP id wc20so131881obb.1
        for <linux-rt-users@vger.kernel.org>; Thu, 28 Mar 2013 19:39:50 -0700 (PDT)
In-Reply-To: <20130328181332.GD14088@htj.dyndns.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 28 March 2013 23:43, Tejun Heo <tj@kernel.org> wrote:
> Ping.  Peter, Ingo?

Thanks for your ping, even i was thinking of it since sometime :)

> Viresh, would it be difficult to make another measurement of the same
> workload with the said workqueues converted to unbound?  I think that
> would at least provide a nice reference point.

I will try.
