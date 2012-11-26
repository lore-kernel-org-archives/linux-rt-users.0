From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V2 Resend 0/4] Create sched_select_cpu() and use it for
 workqueues and timers
Date: Mon, 26 Nov 2012 20:30:56 +0530
Message-ID: <CAKohponTxs983vVQV=6Q8zyesC1W1FhFkzfmpAVeEwU-cQXohA@mail.gmail.com>
References: <cover.1352196505.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Arvind.Chauhan@arm.com, linaro-dev@lists.linaro.org,
	patches@linaro.org, pdsw-power-team@arm.com,
	linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
	Viresh Kumar <viresh.kumar@linaro.org>
To: pjt@google.com, paul.mckenney@linaro.org, tglx@linutronix.de,
	tj@kernel.org, suresh.b.siddha@intel.com, venki@google.com,
	mingo@redhat.com, peterz@infradead.org, rostedt@goodmis.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:40421 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753249Ab2KZPA4 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 26 Nov 2012 10:00:56 -0500
Received: by mail-ie0-f174.google.com with SMTP id k11so6423166iea.19
        for <linux-rt-users@vger.kernel.org>; Mon, 26 Nov 2012 07:00:56 -0800 (PST)
In-Reply-To: <cover.1352196505.git.viresh.kumar@linaro.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 6 November 2012 16:08, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> This is V2 Resend of my sched_select_cpu() work. Resend because didn't got much
> attention on V2. Including more guys now in cc :)
>
> In order to save power, it would be useful to schedule work onto non-IDLE cpus
> instead of waking up an IDLE one.
>
> To achieve this, we need scheduler to guide kernel frameworks (like: timers &
> workqueues) on which is the most preferred CPU that must be used for these
> tasks.
>
> This patchset is about implementing this concept.
>
> - The first patch adds sched_select_cpu() routine which returns the preferred
>   cpu which is non-idle.
> - Second patch removes idle_cpu() calls from timer & hrtimer.
> - Third patch is about adapting this change in workqueue framework.
> - Fourth patch add migration capability in running timer
>
> Earlier discussions over v1 can be found here:
> http://www.mail-archive.com/linaro-dev@lists.linaro.org/msg13342.html
>
> Earlier discussions over this concept were done at last LPC:
> http://summit.linuxplumbersconf.org/lpc-2012/meeting/90/lpc2012-sched-timer-workqueue/
>
> Module created for testing this behavior is present here:
> http://git.linaro.org/gitweb?p=people/vireshk/module.git;a=summary

Ping!!

--
viresh
