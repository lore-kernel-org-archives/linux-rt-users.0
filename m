From: Luiz Capitulino <lcapitulino@redhat.com>
Subject: Re: cyclictest abstime vs. reltime
Date: Thu, 18 Dec 2014 09:33:57 -0500
Message-ID: <20141218093357.1fa51822@redhat.com>
References: <20141217151650.6ee5649c@redhat.com>
	<87fvcd9suh.fsf@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org,
	Marcelo Tosatti <mtosatti@redhat.com>, williams@redhat.com,
	riel@redhat.com
To: John Ogness <john.ogness@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:60109 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751470AbaLROeH (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 18 Dec 2014 09:34:07 -0500
In-Reply-To: <87fvcd9suh.fsf@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, 18 Dec 2014 11:04:38 +0100
John Ogness <john.ogness@linutronix.de> wrote:

> On 2014-12-17, Luiz Capitulino <lcapitulino@redhat.com> wrote:
> > We're doing some scheduling latency measurements with KVM. While
> > analyzing some traces and reading cyclictest code in the process, I
> > found out that by default cyclictest uses the absolute time algorithm,
> > which basically does:
> >
> > clock_gettime(&now)
> > next = now + interval   /* interval == 1000us */
> > /* do some quick stuff */
> > while() {
> >     clock_nanosleep(&next) /* ie. sleeps until now + 1000us, 'next' is abs */
> >     clock_gettime(&now)
> >     diff = calcdiff(now, next)
> >     /* update a bunch of stats and the histogram data, also
> >        check if we're finished */
> >     next += interval
> > }
> >
> > Now, doesn't this mean that the timerthread will actually sleep less
> > than interval?
> 
> Correct. In cyclictest you are not specifying sleep time. You are
> specifing the wake interval.
> 
> > This is so because we have fixed sleeping points which don't take into
> > consideration the sleeping latency
> 
> Sleep latency is taken into account. That is exactly what cyclictest
> measures.
> 
> > nor the bunch of things the timerthread does (eg. update histogram).
> 
> cyclictest does not (and should not) care about this.
> 
> > If I'm making sense, won't this behavior cause better numbers to be
> > reported?
> 
> Using _relative_ mode causes _worse_ numbers to be reported because it
> assumes that a new relative time can be prepared and set
> instantaneously, which is not correct. So you are not only measuring
> sleep latency, but also mixing in timer setup duration. I think these
> numbers would be misleading, since I would expect real-world RT projects
> to be using absolute time.

This makes sense. Thanks a lot for your answers!

> 
> Absolute (and relative) mode mixes in timer interrupt handling
> duration. But that is appropriate here since we are not only interested
> in how good the hardware timer is, but also how fast PREEMPT_RT can
> allow software to respond to it.
> 
> John Ogness
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

