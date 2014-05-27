From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] arm: Set hardirq tracing to on when idling
Date: Tue, 27 May 2014 21:39:22 +0200
Message-ID: <10128642.DD2TJ8Ps9I@wuerfel>
References: <1401045323-7116-1-git-send-email-minyard@acm.org> <6082113.tHepRBe99K@wuerfel> <5384E892.90808@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: linux-arm-kernel@lists.infradead.org,
	Corey Minyard <cminyard@mvista.com>,
	linux-rt-users@vger.kernel.org, minyard@acm.org,
	linux-kernel@vger.kernel.org, Stanislav Meduna <stano@meduna.org>
To: Stephen Boyd <sboyd@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5384E892.90808@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tuesday 27 May 2014 12:33:38 Stephen Boyd wrote:
> On 05/27/14 12:27, Arnd Bergmann wrote:
> > On Tuesday 27 May 2014 11:53:59 Stephen Boyd wrote:
> >> On 05/27/14 11:49, Arnd Bergmann wrote:
> >>> You also commented in that thread about stop_critical_timings()/
> >>> start_critical_timings(). Corey, can you look at that, too? I
> >>> think it's designed to avoid the issue you are seeing but
> >>> for some reason doesn't.
> >> I sent a patch last week to "solve" this problem. I'm not sure if it's
> >> right but it works for me.
> >>
> >> https://lkml.org/lkml/2014/5/19/607
> > I think that one was also wrong, as the intention of the existing
> > stop_critical_timings() function is already to do the same that
> > Corey's patch does, i.e. stop the trace before we go to idle as
> > if we were turning IRQs on.
> 
> stop_critical_timings() is called in the generic idle loop. It looks
> like stop_critical_timings() just isn't written correctly. All it does
> is turn off the tracer, but it doesn't prevent future calls to
> spinlocks, etc. from causing the tracer to turn on again between calls
> to stop/start_critical_timings(). It seems better to prevent any more
> tracing from happening between a call to stop_critical_timings() and
> start_critical_timings() so we don't have to litter calls to that
> function throughout the idle path.

But are there any such calls in the idle function? I understand what
you are doing in your patch, but I don't see why you have to actually
do it.

	Arnd
