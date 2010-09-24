From: "Gregory Haskins" <ghaskins@novell.com>
Subject: Re: Regarding interrupt task latency
Date: Thu, 23 Sep 2010 18:05:12 -0600
Message-ID: <4C9BB2F80200005A00072A37@soto.provo.novell.com>
References: <AANLkTi=EmZJrC+Dmq_-Oijew2uUQ8Xo1y_xzeAZsaS01@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
To: "Sri Ram Vemulpali" <sri.ram.gmu06@gmail.com>,
	"Linux-rt-users" <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
In-Reply-To: <AANLkTi=EmZJrC+Dmq_-Oijew2uUQ8Xo1y_xzeAZsaS01@mail.gmail.com>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Sri,

>>> On 9/23/2010 at 07:00 PM, in message
<AANLkTi=EmZJrC+Dmq_-Oijew2uUQ8Xo1y_xzeAZsaS01@mail.gmail.com>, Sri Ram
Vemulpali <sri.ram.gmu06@gmail.com> wrote: 
> Hi all,
> 
>        I have a doubt regarding interrupt task latency.
>        I know that whenever interrupt context and its associated BH
> are finished, then need_resch is checked whether to call schedule
>        In such case then the latency is deterministic

How?  In a way, you answered your own question:  Assume top-half takes X microseconds, bottom-half takes Y, and the needs_resched()+schedule takes Z.  So in your scenario, you have a latency of X+Y+Z.  What makes you so sure that X and Y are constants for all possible TH+BH combinations?  It doesn't take much imagination to think of common scenarios that are non-deterministic in this context:  Think of things like a netif napi_poll operation dequeuing a variable number of packets and you get the idea.

In addition, what makes you sure that X and Y are reasonably short?  RT isn't simply about "determinism".  Its about "deterministically low latency".  If I told you that X and Y are fixed constants equal to 20 seconds each, that would be deterministic but yet result in a completely useless system ;)

What RT does, in essence, is try to make as many things as possible a scheduleable task so that a task priority may be assigned and a scheduling policy may be employed against that priority constraint.  The corollary to that is that RT also tries to minimize the number of places that are _not_ scheduleable tasks by getting rid of most in_atomic() sections, etc with various tricks.  The net result is that the time spent in_atomic() is deterministically very short, allowing your task priority policy to govern what code is the most critical to run next.  This means much much more than the fact that your scenario above _eventually_ checked if it needed to reschedule after some potentially arbitrarily long critical section.

HTH
-Greg


>and one need not
> to bother about this latency. Why is that rt still considers this as
>        bottle neck on this issue.
> 
>        Any explanation is appreciated. Thanks.
> 
> -- 
> Regards,
> Sri.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



