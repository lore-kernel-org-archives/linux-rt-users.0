From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH RT] net: Have __napi_schedule_irqoff() disable interrupts
 on RT
Date: Wed, 7 Dec 2016 16:32:27 +0100
Message-ID: <20161207153227.l2ou4rmlb564ume2@linutronix.de>
References: <20161206175030.636989f0@gandalf.local.home>
 <20161207091040.qnx3znzpffobli7c@linutronix.de>
 <20161207075326.1ac592f3@gandalf.local.home>
 <20161207102834.76aaf294@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Clark Williams <williams@redhat.com>,
        "Luis Claudio R. Goncalves" <lclaudio@uudg.org>,
        John Kacur <jkacur@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161207102834.76aaf294@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 2016-12-07 10:28:34 [-0500], Steven Rostedt wrote:
> Actually, I was hoping that the change log explained this. Should I
> reword it better?
> 
> "poll_list, which is protected by disabling interrupts (disabling
>  preemption is enough when all interrupts are threaded and
>  local_bh_disable() can't preempt)."

That is fine, I merge it and add this piece. Thank you Steven.

> -- Steve

Sebastian
