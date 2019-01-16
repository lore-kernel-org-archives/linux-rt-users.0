From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RT] printk: Shortcut out of waiter spinning on
 PREEMPT_RT
Date: Wed, 16 Jan 2019 07:27:28 -0500
Message-ID: <20190116072728.1fcc54d0@gandalf.local.home>
References: <20190115123910.2b18df54@gandalf.local.home>
        <20190115185433.e7hmlpmjvpyqdyhc@linutronix.de>
        <20190115145815.13713791@gandalf.local.home>
        <20190116100751.2glxadlpco7a46o5@pathway.suse.cz>
        <20190116114340.GA6322@tigerII.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Petr Mladek <pmladek@suse.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
To: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190116114340.GA6322@tigerII.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Wed, 16 Jan 2019 20:43:40 +0900
Sergey Senozhatsky <sergey.senozhatsky@gmail.com> wrote:

> On (01/16/19 11:07), Petr Mladek wrote:
> > The patch makes perfect sense. But it is not ready for upstream
> > because CONFIG_PREEMPT_RT_FULL is not there yet. Do I get it
> > correctly, please?  
> 
> Yes. Hence Cc linux-rt-users.
> 
>

Actually it's the Subject line. We use "[PATCH RT]" to denote changes
caused by PREEMPT_RT existing.

-- Steve
