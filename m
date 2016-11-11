From: Christoph Lameter <cl@linux.com>
Subject: Re: [PATCH] sched/rt: RT_RUNTIME_GREED sched feature
Date: Fri, 11 Nov 2016 12:46:37 -0600 (CST)
Message-ID: <alpine.DEB.2.20.1611111242270.23136@east.gentwo.org>
References: <fa5b1b55d8934c6a0e02e04a7ad6afdf4012c2e0.1478506194.git.bristot@redhat.com> <20161108115958.GO3142@twins.programming.kicks-ass.net> <20161108090740.4226ffc9@gandalf.local.home> <20161108165133.GI3117@twins.programming.kicks-ass.net>
 <20161108121710.3e7eb664@gandalf.local.home> <20161108180548.GN3117@twins.programming.kicks-ass.net> <f4095990-3fa0-ac2f-7277-3b8f0cdbc333@redhat.com> <20161108195015.GP3117@twins.programming.kicks-ass.net> <8a80c2c2-3803-5648-67b2-4dee7381d5a6@redhat.com>
 <CAA7rmPF0nQb9721MQWurRCy7E3X46hAy2qV=joK=z5U-t70NOg@mail.gmail.com>
Content-Type: text/plain; charset=US-ASCII
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>,
        Tommaso Cucinotta <tommaso.cucinotta@sssup.it>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
To: Daniel Vacek <neelx.g@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from resqmta-ch2-06v.sys.comcast.net ([69.252.207.38]:58748 "EHLO
        resqmta-ch2-06v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754651AbcKKSqj (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 11 Nov 2016 13:46:39 -0500
In-Reply-To: <CAA7rmPF0nQb9721MQWurRCy7E3X46hAy2qV=joK=z5U-t70NOg@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, 10 Nov 2016, Daniel Vacek wrote:

> I believe Daniel's patches are the best thing we can do in current
> situation as the behavior now seems rather buggy and does not provide above
> mentioned expectations set when rt throttling was merged with default
> budget of 95% of CPU time. Nor if you configure so that it does (by
> disabling RT_RUNTIME_SHARE), it also forces CPUs to go idle needlessly when
> there still can be rt task running not really starving anyone. At least
> till a proper rework of rt scheduling with DL Server is implemented.

This looks like a fix for a bug and the company I work for is suffering
as a result. Could we please merge that ASAP?



