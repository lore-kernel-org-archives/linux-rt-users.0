From: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [PATCH RT] printk: Shortcut out of waiter spinning on PREEMPT_RT
Date: Wed, 16 Jan 2019 20:43:40 +0900
Message-ID: <20190116114340.GA6322@tigerII.localdomain>
References: <20190115123910.2b18df54@gandalf.local.home>
 <20190115185433.e7hmlpmjvpyqdyhc@linutronix.de>
 <20190115145815.13713791@gandalf.local.home>
 <20190116100751.2glxadlpco7a46o5@pathway.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To: Petr Mladek <pmladek@suse.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190116100751.2glxadlpco7a46o5@pathway.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On (01/16/19 11:07), Petr Mladek wrote:
> The patch makes perfect sense. But it is not ready for upstream
> because CONFIG_PREEMPT_RT_FULL is not there yet. Do I get it
> correctly, please?

Yes. Hence Cc linux-rt-users.

	-ss
