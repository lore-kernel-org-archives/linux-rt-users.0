From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [patch RT 0/3] Stable rt updates - part II
Date: Mon, 16 Jul 2012 09:14:35 -0400
Message-ID: <1342444475.21617.2.camel@gandalf.stny.rr.com>
References: <20120715090141.942753287@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
	RT-users <linux-rt-users@vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20120715090141.942753287@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Mon, 2012-07-16 at 08:07 +0000, Thomas Gleixner wrote:
> Steven,
> 
> please pick the following three patches which address the CPU hotplug
> nightmare on RT.

OK, I'll process this after releasing v3.2.22-rt35 and v3.2.23-rt36.

> 
> I still hate them, but we want to have that addressed in the stable
> series.

I'm glad they were useful.

> 
> Aside of that there are the outstanding issues with btrfs and io unplug.

Right, I was holding off releasing a 3.0 series because of this.

> 
> The missing spin_lock_init() fix should reach you via mainline stable
> updates. Mike and Chris are looking into that interesting locking
> features.
> 
> The io unplug thing stays mysterious, but as I just wrote in that
> thread, my patch to address it is fundamentally wrong. :(
> 
> I'm off for a week of vacation, so do not expect any further updates
> from my side. If Mike and Chris come up with an agreed solution for
> the locking issue, please pick it up yourself.

OK, but I'll be hounding you when you get back. Although I'll be off
next week.

-- Steve
