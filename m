From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [rfc patch-rt] posix_cpu_timers: Kill hotplug cpu notifier
Date: Fri, 20 Jan 2017 18:34:11 +0100
Message-ID: <20170120173411.usjgyql6xeqfb75h@linutronix.de>
References: <20161223163213.szj43nv7rnelkbty@linutronix.de>
 <1482735654.4476.62.camel@gmx.de>
 <20170120164608.2oorygs5nfpxgptj@linutronix.de>
 <1484933394.20890.5.camel@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
To: Mike Galbraith <efault@gmx.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1484933394.20890.5.camel@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 2017-01-20 18:29:54 [+0100], Mike Galbraith wrote:
> On Fri, 2017-01-20 at 17:46 +0100, Sebastian Andrzej Siewior wrote:
> > On 2016-12-26 08:00:54 [+0100], Mike Galbraith wrote:
> > > Shamelessly steal softirq.c thread initialization method.
> > What is the problem here?
> 
> There is no problem in 4.9.  I did that for upstream, thought it might 
> save someone a minute or two.

I see. The subject says RT so I assumed it is somehow RT related. But as
of now we should have this hotplug notifier removed, right?

> 	-Mike

Sebastian
