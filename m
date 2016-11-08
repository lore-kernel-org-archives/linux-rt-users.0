From: Christoph Lameter <cl@linux.com>
Subject: Re: [PATCH] sched/rt: RT_RUNTIME_GREED sched feature
Date: Tue, 8 Nov 2016 17:42:38 -0600 (CST)
Message-ID: <alpine.DEB.2.20.1611081742180.22679@east.gentwo.org>
References: <fa5b1b55d8934c6a0e02e04a7ad6afdf4012c2e0.1478506194.git.bristot@redhat.com> <alpine.DEB.2.20.1611071054320.17809@east.gentwo.org> <20161107133207.4282de69@gandalf.local.home> <alpine.DEB.2.20.1611071328470.19249@east.gentwo.org>
 <20161107144738.4811a5dd@gandalf.local.home> <alpine.DEB.2.20.1611071353440.19543@east.gentwo.org> <20161107150003.66777b43@gandalf.local.home> <1e79f711-95f1-da2f-f572-1ac4329c8be7@bristot.me> <20161107151617.486b1b42@gandalf.local.home>
Content-Type: text/plain; charset=US-ASCII
Cc: Daniel Bristot de Oliveira <daniel@bristot.me>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from resqmta-ch2-11v.sys.comcast.net ([69.252.207.43]:48546 "EHLO
        resqmta-ch2-11v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750905AbcKHXmm (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 8 Nov 2016 18:42:42 -0500
In-Reply-To: <20161107151617.486b1b42@gandalf.local.home>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, 7 Nov 2016, Steven Rostedt wrote:

> On Mon, 7 Nov 2016 21:06:50 +0100
> Daniel Bristot de Oliveira <daniel@bristot.me> wrote:
>
> > The throttling allowed the kworker to run, but once the kworker went to
> > sleep, the RT tasks started to work again. In the previous behavior,
> > the system would either go idle, or the kworker would starve because
> > the runtime become infinity for RR tasks.
>
> I'm confused? Are you saying that RR tasks don't get throttled in the
> current code? That sounds like a bug to me.

Good. Thats what I wanted to hear after all these justifications that the
system is just behaving as designed.

