From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RT 11/22] irqchip/gic-v3-its: Move ITS ->pend_page
 allocation into an early CPU up hook
Date: Fri, 7 Sep 2018 15:28:29 -0400
Message-ID: <20180907152829.70b68155@gandalf.local.home>
References: <20180905122754.443196118@goodmis.org>
        <20180905122836.102034908@goodmis.org>
        <20180906074054.bur3ulx5bv6rjojt@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Julia Cartwright <julia@ni.com>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        tom.zanussi@linux.intel.com
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180906074054.bur3ulx5bv6rjojt@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Thu, 6 Sep 2018 09:40:54 +0200
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> On 2018-09-05 08:28:05 [-0400], Steven Rostedt wrote:
> > 4.14.63-rt41-rc1 stable review patch.
> > If anyone has any objections, please let me know.  
> 
> could you please take commit d6914631a84f4 ("irqchip/gic-v3-its: Move
> pending table allocation to init time")
>   https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git/commit/?h=linux-4.16.y-rt-rebase&id=d6914631a84f47eaf5647da3bb09d58eca156b3f
> 
> instead? This was just an intermediate step and was replaced with Marc's
> patch (which is either went upstream or is going to).

That doesn't apply without this patch. Should I apply this patch and
that one?

-- Steve
