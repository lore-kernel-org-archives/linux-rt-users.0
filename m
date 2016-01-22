From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [ANNOUNCE] 4.4-rc6-rt1
Date: Fri, 22 Jan 2016 16:48:09 +0100
Message-ID: <56A24F39.2050606@linutronix.de>
References: <20151223225755.GA21121@linutronix.de> <56A24C58.8060209@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
To: Grygorii Strashko <grygorii.strashko@ti.com>,
	Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <56A24C58.8060209@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 01/22/2016 04:35 PM, Grygorii Strashko wrote:
> Additional note: RCU_BOOST now depends on RCU_EXPERT, so commit
> 3da4cab "rcu: make RCU_BOOST default on RT" is nop now.
> 
> config RCU_BOOST
>     bool "Enable RCU priority boosting"
>     depends on RT_MUTEXES && PREEMPT_RCU && RCU_EXPERT
>     default y if PREEMPT_RT_FULL

yeah, I've been thinking about giving the experts menu item an y on RT
as well.

Sebastian
