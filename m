From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v2] ASoC: Intel: sst: use ; instead of , at the of a C
 statement
Date: Fri, 12 Jun 2015 12:52:50 +0530
Message-ID: <20150612072250.GB28601@localhost>
References: <20150519213923.GA26363@linutronix.de>
 <55623BC2.80307@localhost>
 <20150611122227.GF16115@linutronix.de>
 <55798759.8000607@gmail.com>
 <20150611131434.GI16115@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mats Karrman <mats.dev.list@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, rostedt@goodmis.org,
	John Kacur <jkacur@redhat.com>,
	Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
	alsa-devel@alsa-project.org, Jie Yang <yang.jie@intel.com>,
	patches.audio@intel.com
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150611131434.GI16115@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Thu, Jun 11, 2015 at 03:14:34PM +0200, Sebastian Andrzej Siewior wrote:
> This was spotted by Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
> while he tried to compile a -RT kernel with this driver enabled.
> "make C=2" would also warn about this. This is is based on his patch.
> 
> Reported-by: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Acked-by: Vinod Koul <vinod.koul@intel.com>

-- 
~Vinod
> ---
> * Mats Karrman | 2015-06-11 15:04:25 [+0200]:
> 
> >>+	sst_shim_write64(shim, SST_IMRX, shim_regs->imrx):
> >Don't you mean ';' and not ':'?
> Interresting, yes I do. Thanks.
> 
>  sound/soc/intel/atom/sst/sst.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/intel/atom/sst/sst.c b/sound/soc/intel/atom/sst/sst.c
> index 96c2e420cce6..a4b458e77089 100644
> --- a/sound/soc/intel/atom/sst/sst.c
> +++ b/sound/soc/intel/atom/sst/sst.c
> @@ -368,8 +368,8 @@ static inline void sst_restore_shim64(struct intel_sst_drv *ctx,
>  	 * initialize by FW or driver when firmware is loaded
>  	 */
>  	spin_lock_irqsave(&ctx->ipc_spin_lock, irq_flags);
> -	sst_shim_write64(shim, SST_IMRX, shim_regs->imrx),
> -	sst_shim_write64(shim, SST_CSR, shim_regs->csr),
> +	sst_shim_write64(shim, SST_IMRX, shim_regs->imrx);
> +	sst_shim_write64(shim, SST_CSR, shim_regs->csr);
>  	spin_unlock_irqrestore(&ctx->ipc_spin_lock, irq_flags);
>  }
>  
> -- 
> 2.1.4

-- 
