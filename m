From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH] sched: don't clear PF_THREAD_BOUND in
 select_fallback_rq
Date: Fri, 21 Jun 2013 12:48:02 +0200
Message-ID: <20130621104802.GA21228@linutronix.de>
References: <5178F0DE.8030808@huawei.com>
 <20130514130821.GA4591@uudg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Qiang Huang <h.huangqiang@huawei.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Li Zefan <lizefan@huawei.com>,
	zhangwei <jovi.zhangwei@huawei.com>
To: "Luis Claudio R. Goncalves" <lclaudio@uudg.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:38415 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751505Ab3FUKsH (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 21 Jun 2013 06:48:07 -0400
Content-Disposition: inline
In-Reply-To: <20130514130821.GA4591@uudg.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Luis Claudio R. Goncalves | 2013-05-14 10:08:21 [-0300]:

>Sorry for the late post on this thread, but I just saw two occurrences of
>the Warning below (pretty close to the original report on this thread) on
>3.8.11-rt8. As this patch solved/mitigated the issue on my 3.6-rt kernel, I
>am trying it on 3.8.11-rt8.
>
>The funny thing is that I was not running the cgroups_fj nor the shell
>script reproducer, just using the box to browse the web and listen to
>_good_ music.

Could you please play some good music on latest RT? I somehow hope that
is gone.

Sebastian
