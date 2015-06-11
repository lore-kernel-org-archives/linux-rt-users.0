From: Mats Karrman <mats.dev.list@gmail.com>
Subject: Re: [PATCH] ASoC: Intel: sst: use ; instead of , at the of a C statement
Date: Thu, 11 Jun 2015 15:04:25 +0200
Message-ID: <55798759.8000607@gmail.com>
References: <20150519213923.GA26363@linutronix.de> <55623BC2.80307@localhost> <20150611122227.GF16115@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, rostedt@goodmis.org,
	John Kacur <jkacur@redhat.com>,
	Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
	alsa-devel@alsa-project.org, Jie Yang <yang.jie@intel.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Vinod Koul <vinod.koul@intel.com>,
	Mark Brown <broonie@kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-la0-f66.google.com ([209.85.215.66]:35417 "EHLO
	mail-la0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754636AbbFKNE2 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 11 Jun 2015 09:04:28 -0400
In-Reply-To: <20150611122227.GF16115@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



On 2015-06-11 14:22, Sebastian Andrzej Siewior wrote:
> This was spotted by Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
> while he tried to compile a -RT kernel with this driver enabled.
> "make C=2" would also warn about this. This is is based on his patch.
>
> Reported-by: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>   sound/soc/intel/atom/sst/sst.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/sound/soc/intel/atom/sst/sst.c b/sound/soc/intel/atom/sst/sst.c
> index 96c2e420cce6..b0c3e0e56302 100644
> --- a/sound/soc/intel/atom/sst/sst.c
> +++ b/sound/soc/intel/atom/sst/sst.c
> @@ -368,8 +368,8 @@ static inline void sst_restore_shim64(struct intel_sst_drv *ctx,
>   	 * initialize by FW or driver when firmware is loaded
>   	 */
>   	spin_lock_irqsave(&ctx->ipc_spin_lock, irq_flags);
> -	sst_shim_write64(shim, SST_IMRX, shim_regs->imrx),
> -	sst_shim_write64(shim, SST_CSR, shim_regs->csr),
> +	sst_shim_write64(shim, SST_IMRX, shim_regs->imrx):
Don't you mean ';' and not ':'?
> +	sst_shim_write64(shim, SST_CSR, shim_regs->csr);
>   	spin_unlock_irqrestore(&ctx->ipc_spin_lock, irq_flags);
>   }
>   

