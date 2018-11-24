From: Oleksandr Natalenko <oleksandr@natalenko.name>
Subject: Re: WARN_ON() in netconsole with PREEMPT_RT
Date: Sat, 24 Nov 2018 20:15:45 +0100
Message-ID: <f479ed5153809ad643cbcf988d76585b@natalenko.name>
References: <f9111ab09dbc264c8ff8b3b79e9f4c06@natalenko.name>
 <a23ae3a8501d5c996d7a9dd2f27dd5fa@natalenko.name>
 <20181111210105.7f376c35@vmware.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Cc: "David S. Miller" <davem@davemloft.net>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Eric Dumazet <edumazet@google.com>,
        Dave Jones <davej@codemonkey.org.uk>, netdev@vger.kernel.org,
        linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20181111210105.7f376c35@vmware.local.home>
Sender: netdev-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi.

On 12.11.2018 03:01, Steven Rostedt wrote:
> On Sun, 11 Nov 2018 21:16:00 +0100
> Oleksandr Natalenko <oleksandr@natalenko.name> wrote:
>> Oh, I see that write_msg() calls netpoll_send_udp() under
>> spin_lock_irqsave(), but in PREEMPT_RT this, AFAIK, does not disable
>> interrupts.
>> 
>> So, the real question here is whether the interrupts should be indeed
>> disabled. And if so, -rt should replace spin_lock_irqsave() call there
>> with what? local_irq_save()? and get rid of the warning?
>> 
> 
> Why do we care if interrupts are disabled with PREEMPT_RT here?

I don't know, if you ask me. But the check was added intentionally with 
c9fd56b34efd0, so the author had definitely something on his mind. 
Cc'ing him.

> printk() itself has a lot of issues with PREEMPT_RT that we are working
> on dealing with. Right now netconsole is actually at the end of that
> todo list.

OK, I see.

-- 
   Oleksandr Natalenko (post-factum)
