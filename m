From: Yong Zhang <yong.zhang0@gmail.com>
Subject: Re: lockdep splat with 3.2-rc2-rt3+
Date: Wed, 30 Nov 2011 16:33:24 +0800
Message-ID: <20111130083324.GA1632@zhy>
References: <20111120113621.7d738d55@gmail.com>
 <CAONaPpEdxdZLTDzf11ojT7tqHoVqsp3YFwx_UJafvRpyKHCjrQ@mail.gmail.com>
 <CAONaPpHnu8VADg_EGQNrqsyhrVsJ2oOFMB4FyK-94qu5n-NEEQ@mail.gmail.com>
Reply-To: Yong Zhang <yong.zhang0@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Clark Williams <clark.williams@gmail.com>,
	RT <linux-rt-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
To: John Kacur <jkacur@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:56219 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751774Ab1K3Idf (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 30 Nov 2011 03:33:35 -0500
Content-Disposition: inline
In-Reply-To: <CAONaPpHnu8VADg_EGQNrqsyhrVsJ2oOFMB4FyK-94qu5n-NEEQ@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, Nov 24, 2011 at 11:50:06PM +0100, John Kacur wrote:
> So, as a little experiment, on v3.2.0-rc2-rt3
> I redefined MAX_LOCKDEP_ENTRIES from 16384UL to 32768UL
> 
> Then from /proc/lockdep_stats
> 
> I got
>  direct dependencies:                 18026 [max: 32768]
> 
> The fact that 18026 is only a little larger than the normal max (by 1642)
> to me is another indication that, this is not a case of something in
> lockdep going out of control that needs to be fixed, but just another
> indication that in some circumstances it would be legitimate to raise
> the value.

Yeah, seems the reason is in RT we have no dedicated softirq-context
anymore, IOW, both process-context and softirq-context are taken as
process-context. That will increase the usage of lockdep entries
because we expand the scope of process-context.

Thanks,
Yong
