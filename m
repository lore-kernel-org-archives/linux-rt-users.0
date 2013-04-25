From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [ANNOUNCE] 3.4.41-rt55-feat1
Date: Thu, 25 Apr 2013 18:23:20 -0400
Message-ID: <1366928600.10248.20.camel@gandalf.local.home>
References: <1366760662.9609.176.camel@gandalf.local.home>
	 <2156546.QlsX0XyPQz@dabox> <51792277.8000205@linutronix.de>
	 <3603730.i3rZKahVeu@dabox> <alpine.LFD.2.02.1304260018470.21884@ionos>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Tim Sander <tim.sander@hbm.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>,
	Carsten Emde <C.Emde@osadl.org>, John Kacur <jkacur@redhat.com>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:12415 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933104Ab3DYWXX (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 25 Apr 2013 18:23:23 -0400
In-Reply-To: <alpine.LFD.2.02.1304260018470.21884@ionos>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, 2013-04-26 at 00:20 +0200, Thomas Gleixner wrote:
> Tim,
> 
> On Thu, 25 Apr 2013, Tim Sander wrote:
> > handler. But normally the HR_TIMER is set. So we switched it off on this very 
> > purpose. As we also have also PREEMPT_RT_FULL set the proposed solution to 
> > allow only PREEMPT_RT_FULL with PREEMPT_RT_FULL set is not an option for us.
> 
> -ENOPARSE

I think he made a typo and was referring to my post. I think he meant
that they require not having high res timers set when PREEMPT_RT_FULL is
set. As you stated to me before.

-- Steve


