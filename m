From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [ANNOUNCE] v4.14.15-rt12
Date: Mon, 29 Jan 2018 09:29:52 +0100
Message-ID: <20180129082952.snffiicxlfyuhxhs@linutronix.de>
References: <20180125151706.v6pgbeixt2jfpph2@linutronix.de>
 <20180128151051.m3b3snwjm3xpqjbn@lorien.valinor.li>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
To: Salvatore Bonaccorso <carnil@debian.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180128151051.m3b3snwjm3xpqjbn@lorien.valinor.li>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 2018-01-28 16:10:51 [+0100], Salvatore Bonaccorso wrote:
> Hi 
Hi,

> Just a small heads-up: Whilst ping-sysrq.patch was dropped the
> included series file still contains:
> 
> # NETWORK DEBUGGING AID
> ping-sysrq.patch 

so 'quilt push -a' aborts once it gets to it while 'git quiltimport'
continues:
| net-Have-__napi_schedule_irqoff-disable-interrupts-o.patch
| ping-sysrq.patch doesn't exist. Skipping.
| irqwork-push_most_work_into_softirq_context.patch

not sure if this is a bug or not.
Thanks for the report, will try to fix this soon.

> Regards,
> Salvatore

Sebastian
