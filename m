From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: 3.2-rc1 and nvidia drivers
Date: Fri, 02 Dec 2011 14:37:22 -0500
Message-ID: <1322854643.30977.53.camel@frodo>
References: <CAOLSsAysHCVAHsSRMTXUpXm_qjK5D5DRagHCS0ZYrxGQ8mDkfw@mail.gmail.com>
	 <4EC384FD.1040106@tum.de> <alpine.LFD.2.02.1111161605580.4902@ionos>
	 <4ED35D9A.7090401@tum.de>
	 <CAONaPpE7Jgz0GhFUB41ZKoa8dUKOqKVFKj6jHfi3EAnPX0SRbQ@mail.gmail.com>
	 <alpine.LFD.2.00.1111291528590.5855@localhost6.localdomain6>
	 <1322620613.17003.110.camel@frodo>
	 <CAONaPpEp=bBJWZ4DzAem0TE+_2q5t+G=99_jdJxVsCwXZ4Mk9g@mail.gmail.com>
	 <1322651681.2921.247.camel@twins> <1322662465.17003.117.camel@frodo>
	 <1322662578.2921.275.camel@twins> <1322663502.17003.121.camel@frodo>
	 <4ED646B1.4020508@tum.de> <1322666431.24563.2.camel@frodo>
	 <4ED90DC9.9090206@tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Peter Zijlstra <peterz@infradead.org>,
	John Kacur <jkacur@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	RT <linux-rt-users@vger.kernel.org>
To: Thomas Schauss <schauss@tum.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.125]:58355 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753228Ab1LBTh3 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 2 Dec 2011 14:37:29 -0500
In-Reply-To: <4ED90DC9.9090206@tum.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, 2011-12-02 at 18:41 +0100, Thomas Schauss wrote:

> this patch does indeed get rid of the lockdep-splat.
> 
> Regarding the original subject of the post:
> 
> Running startx with the nvidia binary driver fails on 3.0.9-rt25 and 
> 3.2-rc2-rt3 when CONFIG_PREEMPT_RT_FULL=y and works fine for 
> CONFIG_PREEMPT_RTB=y. There is no lockdep-warning, kernel oops/bug, 
> etc., neither in any log-files nor on the serial console.
> 
> This happens on several machines which ran fine with 2.6.33-rt29.
> 
> I know many people here are no big fans of the nvidia driver (and 
> rightly so). Unfortunately we really need this.

The biggest problem with nvidia is that it's a black box for us. We have
no idea what's happening behind the scenes. Once the nvidia drive takes
over, we're in the dark and can't do much about it. If you depend on
nvidia so much, perhaps you could contact them. Their engineers may be
able to help you here.

> 
> If anyone has any further ideas on debugging this issue I would be 
> really thankful.

Perhaps kick off nmi_watchdog and hope that it produces something?

-- Steve


