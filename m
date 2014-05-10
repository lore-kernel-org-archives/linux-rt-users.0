From: Mike Galbraith <umgwanakikbuti@gmail.com>
Subject: Re: [ANNOUNCE] 3.14.3-rt5
Date: Sat, 10 May 2014 06:15:03 +0200
Message-ID: <1399695303.5146.21.camel@marge.simpson.net>
References: <20140509181214.GK29014@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, rostedt@goodmis.org,
	John Kacur <jkacur@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140509181214.GK29014@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Fri, 2014-05-09 at 20:12 +0200, Sebastian Andrzej Siewior wrote:

> Known issues:
> 
>       - bcache is disabled.
> 
>       - lazy preempt on x86_64 leads to a crash with some load.

That is only with NO_HZ_FUL enabled here.  Box blows the stack during
task exit, eyeballing hasn't spotted the why.

> - CPU hotplug works in general. Steven's test script however
>         deadlocks usually on the second invocation.

My 64 core box runs for up to 14 hours, and never deadlocks.. it
explodes in what looks like it should be an impossible manner instead.

-Mike
