From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [patch-rt] sched,fair: Fix CFS bandwidth control  lockdep
 DEADLOCK report
Date: Tue, 15 May 2018 18:45:39 +0200
Message-ID: <20180515164538.w4nnuqkkjj6lnp5c@linutronix.de>
References: <20180503162934.b2ly6jz4a5tydaag@linutronix.de>
 <1525414478.6761.5.camel@gmx.de>
 <20180504104802.33e9a52f@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Cc: Mike Galbraith <efault@gmx.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180504104802.33e9a52f@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 2018-05-04 10:48:02 [-0400], Steven Rostedt wrote:
> On Fri, 04 May 2018 08:14:38 +0200
> Mike Galbraith <efault@gmx.de> wrote:
> 
…
> Looks good to me.
> 
> Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

trimmed commit message, tagged stable, applied.

> -- Steve

Sebastian
