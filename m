From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: WARN_ON() in netconsole with PREEMPT_RT
Date: Fri, 30 Nov 2018 19:04:43 +0100
Message-ID: <20181130180443.o2kjcpweaglmsmx6@linutronix.de>
References: <f9111ab09dbc264c8ff8b3b79e9f4c06@natalenko.name>
 <a23ae3a8501d5c996d7a9dd2f27dd5fa@natalenko.name>
 <20181111210105.7f376c35@vmware.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Oleksandr Natalenko <oleksandr@natalenko.name>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Eric Dumazet <edumazet@google.com>,
        Dave Jones <davej@codemonkey.org.uk>, netdev@vger.kernel.org,
        linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>,
        Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181111210105.7f376c35@vmware.local.home>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 2018-11-11 21:01:05 [-0500], Steven Rostedt wrote:
> On Sun, 11 Nov 2018 21:16:00 +0100
> Oleksandr Natalenko <oleksandr@natalenko.name> wrote:
> > Oh, I see that write_msg() calls netpoll_send_udp() under 
> > spin_lock_irqsave(), but in PREEMPT_RT this, AFAIK, does not disable 
> > interrupts.
> > 
> > So, the real question here is whether the interrupts should be indeed 
> > disabled. And if so, -rt should replace spin_lock_irqsave() call there 
> > with what? local_irq_save()? and get rid of the warning?
> > 
> 
> Why do we care if interrupts are disabled with PREEMPT_RT here?

We don't actually. It was broken before for some reason and disabled on
RT. Later people asked for NETCONSOLE on RT and it seemed to have worked
so I allowed it again starting with v3.14.3-rt5.
A year later (v4.3-rc1) commit c9fd56b34efd0 ("netpoll: warn on
netpoll_send_udp users who haven't disabled irqs") introduced that
warning. 
It seems the only reason why netpoll_send_udp() is invoked with disabled
interrupts is because the caller acquired `target_list_lock' with
disabled interrupts. I remember that earlier there was some
local_irq_save() based locking but all this is gone now.

Nikolay could you please explain why interrupts have to be disabled at
this point? It looks to me that this check could be dropped.

> -- Steve

Sebastian
