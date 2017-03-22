From: Julia Cartwright <julia@ni.com>
Subject: Re: [PATCH v2 1/9] Coccinelle: locks: identify callers of
 spin_lock{, _irq, _irqsave}() in irqchip implementations
Date: Wed, 22 Mar 2017 11:18:56 -0500
Message-ID: <20170322161856.GJ10423@jcartwri.amer.corp.natinst.com>
References: <cover.1490135047.git.julia@ni.com>
 <48a11ad61edb4bec130f2ae0d46fc4e7d4855044.1490135047.git.julia@ni.com>
 <alpine.DEB.2.20.1703221053550.3413@hadrien>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Nicolas Palix <nicolas.palix@imag.fr>, linux-kernel@vger.kernel.org,
        cocci@systeme.lip6.fr, Michal Marek <mmarek@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>
To: Julia Lawall <julia.lawall@lip6.fr>
Return-path: <cocci-bounces@systeme.lip6.fr>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1703221053550.3413@hadrien>
List-Unsubscribe: <https://systeme.lip6.fr/mailman/options/cocci>,
 <mailto:cocci-request@systeme.lip6.fr?subject=unsubscribe>
List-Archive: <https://systeme.lip6.fr/pipermail/cocci>
List-Post: <mailto:cocci@systeme.lip6.fr>
List-Help: <mailto:cocci-request@systeme.lip6.fr?subject=help>
List-Subscribe: <https://systeme.lip6.fr/mailman/listinfo/cocci>,
 <mailto:cocci-request@systeme.lip6.fr?subject=subscribe>
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr
List-Id: linux-rt-users.vger.kernel.org

On Wed, Mar 22, 2017 at 10:54:15AM +0100, Julia Lawall wrote:
> On Tue, 21 Mar 2017, Julia Cartwright wrote:
> > On PREEMPT_RT, the spinlock_t type becomes an object which sleeps under
> > contention.  The codepaths used to support scheduling (irq dispatching, arch
> > code, the scheduler, timers) therefore must make use of the
> > raw_spin_lock{,_irq,_irqsave}() variations which preserve the non-sleeping
> > spinlock behavior.
> >
> > Because the irq_chip callbacks are invoked in the process of interrupt
> > dispatch, they cannot therefore make use of spin_lock_t type.  Instead, the
> > usage of raw_spinlock_t is appropriate.
> >
> > Provide a spatch to identify (and attempt to patch) such problematic irqchip
> > implementations.
> >
> > Note to those generating patches using this spatch; in order to maintain
> > correct semantics w/ PREEMPT_RT, it is necessary to audit the
> > raw_spinlock_t-protected codepaths to ensure their execution is bounded and
> > minimal.  This is a manual audit process.
> >
> > See commit 47b03ca903fb0 ("pinctrl: qcom: Use raw spinlock variants") as an
> > example of _one_ such instance, which fixed a real bug seen in the field.
> >
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > Cc: Linus Walleij <linus.walleij@linaro.org>
> > Signed-off-by: Julia Cartwright <julia@ni.com>
> 
> Acked-by: Julia Lawall <julia.lawall@lip6.fr>

Thanks, Julia.

How do these semantic patches normally land?  It looks like they quite a
few have gone through the kbuild tree, is this the norm?

Thanks,
   Other Julia
