From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH RT] x86/mm/pat: disable preemption __split_large_page()
 after spin_lock()
Date: Wed, 9 Jan 2019 09:48:38 +0100
Message-ID: <20190109084837.yxj6f2aigdkafgkh@linutronix.de>
References: <20181213164430.mggilzfjgr5retz6@linutronix.de>
 <1546994355.3632.15.camel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>, stable-rt@vger.kernel.org
To: Scott Wood <swood@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1546994355.3632.15.camel@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 2019-01-08 18:39:15 [-0600], Scott Wood wrote:
> On Thu, 2018-12-13 at 17:44 +0100, Sebastian Andrzej Siewior wrote:
> > Commit "x86/mm/pat: Disable preemption around __flush_tlb_all()" added a
> > warning if __flush_tlb_all() is invoked in preemptible context. On !RT
> > the warning does not trigger because a spin lock is acquired which
> > disables preemption. On RT the spin lock does not disable preemption and
> > so the warning is seen.
> > 
> > Disable preemption to avoid the warning in __flush_tlb_all().
> > 
> > Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> 
> FWIW, that __flush_tlb_all() can probably just be removed.  It was added as
> a partial workaround for an erratum, but since it didn't completely solve
> the problem, hugepages were disabled on the affected chips in commit
> 7a0fc404ae66377 ("x86: Disable large pages on CPUs with Atom erratum
> AAE44").  I was going to send a (non-RT) patch removing the flush but in
> 4.20 commit c0a759abf5a68 ("x86/mm/cpa: Move flush_tlb_all()") reworked the
> code to make it moot.

Let me make a note for next major version.

> -Scott

Sebastian
