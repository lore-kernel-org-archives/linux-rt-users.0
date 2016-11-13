From: Christoph Lameter <cl@linux.com>
Subject: Re: [PATCH] sched/rt: RT_RUNTIME_GREED sched feature
Date: Sun, 13 Nov 2016 12:53:28 -0600 (CST)
Message-ID: <alpine.DEB.2.20.1611131253160.7920@east.gentwo.org>
References: <20161108115958.GO3142@twins.programming.kicks-ass.net> <20161108090740.4226ffc9@gandalf.local.home> <20161108165133.GI3117@twins.programming.kicks-ass.net> <20161108121710.3e7eb664@gandalf.local.home> <20161108180548.GN3117@twins.programming.kicks-ass.net>
 <f4095990-3fa0-ac2f-7277-3b8f0cdbc333@redhat.com> <20161108195015.GP3117@twins.programming.kicks-ass.net> <8a80c2c2-3803-5648-67b2-4dee7381d5a6@redhat.com> <CAA7rmPF0nQb9721MQWurRCy7E3X46hAy2qV=joK=z5U-t70NOg@mail.gmail.com> <alpine.DEB.2.20.1611111242270.23136@east.gentwo.org>
 <20161111225328.GB3142@twins.programming.kicks-ass.net>
Content-Type: text/plain; charset=US-ASCII
Cc: Daniel Vacek <neelx.g@gmail.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Tommaso Cucinotta <tommaso.cucinotta@sssup.it>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161111225328.GB3142@twins.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Fri, 11 Nov 2016, Peter Zijlstra wrote:

> On Fri, Nov 11, 2016 at 12:46:37PM -0600, Christoph Lameter wrote:
> > On Thu, 10 Nov 2016, Daniel Vacek wrote:
> >
> > > I believe Daniel's patches are the best thing we can do in current
> > > situation as the behavior now seems rather buggy and does not provide above
> > > mentioned expectations set when rt throttling was merged with default
> > > budget of 95% of CPU time. Nor if you configure so that it does (by
> > > disabling RT_RUNTIME_SHARE), it also forces CPUs to go idle needlessly when
> > > there still can be rt task running not really starving anyone. At least
> > > till a proper rework of rt scheduling with DL Server is implemented.
> >
> > This looks like a fix for a bug and the company I work for is suffering
> > as a result. Could we please merge that ASAP?
> >
>
> What bug? And no, the patch has as many technical issues as it has
> conceptual ones.

There is a deadlock, Peter!!!
