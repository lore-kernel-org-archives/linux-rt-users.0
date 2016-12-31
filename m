From: Jason Cooper <jason@lakedaemon.net>
Subject: Re: [PATCH] irqchip: keystone: Fix "scheduling while atomic" on rt
Date: Sat, 31 Dec 2016 19:04:49 +0000
Message-ID: <20161231190449.GG30137@io.lakedaemon.net>
References: <20161208233310.10329-1-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Santosh Shilimkar <ssantosh@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Suman Anna <s-anna@ti.com>, linux-rt-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sam Nelson <sam.nelson@ti.com>,
        bigeasy@linutronix.de
To: Grygorii Strashko <grygorii.strashko@ti.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161208233310.10329-1-grygorii.strashko@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi Grygorii,

On Thu, Dec 08, 2016 at 05:33:10PM -0600, Grygorii Strashko wrote:
> From: "Strashko, Grygorii" <grygorii.strashko@ti.com>
> 
> The below call chain generates "scheduling while atomic" backtrace and
> causes system crash when Keystone 2 IRQ chip driver is used with RT-kernel:
> 
> gic_handle_irq()
>  |-__handle_domain_irq()
>   |-generic_handle_irq()
>    |-keystone_irq_handler()
>     |-regmap_read()
>      |-regmap_lock_spinlock()
>       |-rt_spin_lock()
> 
> The reason is that Keystone driver dispatches IRQ using chained IRQ handler
> and accesses I/O memory through syscon->regmap(mmio) which is implemented
> as fast_io regmap and uses regular spinlocks for synchronization, but
> spinlocks transformed to rt_mutexes on RT.
> 
> Hence, convert Keystone 2 IRQ driver to use generic irq handler instead of
> chained IRQ handler. This way it will be compatible with RT kernel where it
> will be forced thread IRQ handler while in non-RT kernel it still will be
> executed in HW IRQ context.
> 
> Cc: Suman Anna <s-anna@ti.com>
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
> ---
> Hi,
> 
> In general, there is an option to convert this driver to use nested threaded
> irq handlers (this should not affect our current user of these irqs from
> performance point of view), but that will affect on our current remoteproc and
> UIO based drivers (including uio core) which do not expect to use threaded
> irq and use request_irq(). These drivers and UIO core might require to be
> updated to use threaded irqs and (or) request_any_context_irq().
> 
> Suman, what do you think?
> 
>  drivers/irqchip/irq-keystone.c | 28 +++++++++++++++++++---------
>  1 file changed, 19 insertions(+), 9 deletions(-)

Applied to irqchip/urgent with Suman's Tested-by.

thx,

Jason.
