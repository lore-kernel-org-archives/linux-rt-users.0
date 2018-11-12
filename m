From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: WARN_ON() in netconsole with PREEMPT_RT
Date: Sun, 11 Nov 2018 21:01:05 -0500
Message-ID: <20181111210105.7f376c35@vmware.local.home>
References: <f9111ab09dbc264c8ff8b3b79e9f4c06@natalenko.name>
        <a23ae3a8501d5c996d7a9dd2f27dd5fa@natalenko.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Cc: "David S. Miller" <davem@davemloft.net>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Eric Dumazet <edumazet@google.com>,
        Dave Jones <davej@codemonkey.org.uk>, netdev@vger.kernel.org,
        linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
To: Oleksandr Natalenko <oleksandr@natalenko.name>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <a23ae3a8501d5c996d7a9dd2f27dd5fa@natalenko.name>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Sun, 11 Nov 2018 21:16:00 +0100
Oleksandr Natalenko <oleksandr@natalenko.name> wrote:


> > This is a v4.19.1-rt3-based kernel.
> > 
> > The WARN_ON() is:
> > 
> > 362 void netpoll_send_udp(struct netpoll *np, const char *msg, int len)
> > 363 {
> > …
> > 372     WARN_ON_ONCE(!irqs_disabled());
> > …
> > 
> > If that matters, I have "threadirqs" passed to the kernel.
> > 
> > Netconsole seems to work even after this warning. Is this OK/expected?
> > 
> > Thanks.  
> 
> Oh, I see that write_msg() calls netpoll_send_udp() under 
> spin_lock_irqsave(), but in PREEMPT_RT this, AFAIK, does not disable 
> interrupts.
> 
> So, the real question here is whether the interrupts should be indeed 
> disabled. And if so, -rt should replace spin_lock_irqsave() call there 
> with what? local_irq_save()? and get rid of the warning?
> 

Why do we care if interrupts are disabled with PREEMPT_RT here?

printk() itself has a lot of issues with PREEMPT_RT that we are working
on dealing with. Right now netconsole is actually at the end of that
todo list.

-- Steve
