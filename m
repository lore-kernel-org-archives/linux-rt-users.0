From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [ANNOUNCE] v4.11.5-rt1
Date: Mon, 19 Jun 2017 10:52:06 +0200
Message-ID: <20170619085206.n2n22lpdfsoqbp5m@linutronix.de>
References: <20170616105610.rbc6itylcrsla56l@linutronix.de>
 <1497687277.6908.31.camel@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Cc: Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
To: Mike Galbraith <efault@gmx.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1497687277.6908.31.camel@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 2017-06-17 10:14:37 [+0200], Mike Galbraith wrote:
> Hi Sebastian,
Hi Mike,

> 
> I noticed a couple things wrt migrate_disable() changes...
> 
> During that rebase, migrate_disable() was changed to no longer map to
> preempt_disable() for nonrt, but some patches still assume it does.  It
> now depends upon PREEMPT_COUNT, the RT workaround in futex.c induces
> grumbling in nonrt builds with PREEMPT_COUNT enabled.

argh, right. It was planned to get it merged upstream but due to
$reasons we never got that far. For that reason I would simply revert
that change and let migrate_disable() map to preempt_disable() as it did
earlier.

> 	-Mike

Sebastian
