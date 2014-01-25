From: Mike Galbraith <bitbucket@online.de>
Subject: Re: [ANNOUNCE] 3.12.8-rt11
Date: Sat, 25 Jan 2014 22:34:46 +0100
Message-ID: <1390685686.5522.21.camel@marge.simpson.net>
References: <20140125134519.GA9845@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, rostedt@goodmis.org,
	John Kacur <jkacur@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140125134519.GA9845@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Sat, 2014-01-25 at 14:45 +0100, Sebastian Andrzej Siewior wrote: 
> Dear RT folks!
> 
> I'm pleased to announce the v3.12.8-rt11 patch set.
> 
> Changes since v3.12.8-rt10
> - The "do not to raise the timer softirq unconditionally" resulted a few
>   boot lockups on a few boxes. Steven found the problem and sent a fix.
>   Thank you Steven.

That fix _appears_ to have fixed up the runtime lockups I was hitting on
64 core box as well.  I don't have nohz_full enabled atm, but the nmi
watchdog was reliably barking either way, and while box could remain up
for quite a while, it should have died by now.  I'll let it grind away
for the rest of the weekend.

-Mike
