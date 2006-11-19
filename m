From: fche@redhat.com (Frank Ch. Eigler)
Subject: Re: RT Patch set, SystemTap, tcp test fails
Date: 19 Nov 2006 14:07:05 -0500
Message-ID: <y0mvelb1ciu.fsf@ton.toronto.redhat.com>
References: <1163934741.6306.20.camel@fc6-rt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: systemtap@sources.redhat.com, linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:15493 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S933022AbWKSTHQ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 19 Nov 2006 14:07:16 -0500
To: dave_sperry@ieee.org
In-Reply-To: <1163934741.6306.20.camel@fc6-rt>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Dave Sperry <dave_sperry@ieee.nospam.dot.org> writes:

> Hi I'm trying to get systemtap to work with Ingo Molnar's RT patch set
> and have run into a few problems. My test setup is a dual Xeon IBM
> intellistation with fc6 and 2.6.18-rt7 #1 SMP PREEMPT.
> [...]
> The the tcp test fails because the symbol HRTIMER_REL cannot be found.
> detail for the tcp tests is.

According to mingo's patch set, HRTIMER_REL and HRTIMER_ABS were
simply renamed to HRTIMER_MODE_REL and HRTIMER_MODE_ABS.  Since these
are enums instead of macros, a little #ifndef/#define hack would not
work.  Unless the RT patches identify themselves at compile time, it
may be tricky to generate code that works with both base and patched
kernel.

- FChE
