From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH RT v2] crypto: limit more FPU-enabled sections
Date: Fri, 1 Dec 2017 12:32:35 +0100
Message-ID: <20171201113235.6tmkwtov5cg2locv@hirez.programming.kicks-ass.net>
References: <20171130142216.GB12606@linutronix.de>
 <20171130101943.15f7ade4@gandalf.local.home>
 <20171130152236.GA11362@linutronix.de>
 <20171201104422.GC1612@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steven Rostedt <rostedt@goodmis.org>,
        linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:51104 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752197AbdLALcm (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 1 Dec 2017 06:32:42 -0500
Content-Disposition: inline
In-Reply-To: <20171201104422.GC1612@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, Dec 01, 2017 at 11:44:22AM +0100, Sebastian Andrzej Siewior wrote:
> --- a/arch/x86/crypto/camellia_aesni_avx2_glue.c
> +++ b/arch/x86/crypto/camellia_aesni_avx2_glue.c
> @@ -206,6 +206,34 @@ struct crypt_priv {
>  	bool fpu_enabled;
>  };
>  
> +#ifdef CONFIG_PREEMPT_RT_FULL
> +static void camellia_fpu_end_rt(struct crypt_priv *ctx)
> +{
> +       bool fpu_enabled = ctx->fpu_enabled;
> +
> +       if (!fpu_enabled)
> +               return;
> +       camellia_fpu_end(fpu_enabled);
> +       ctx->fpu_enabled = false;
> +}
> +
> +static void camellia_fpu_sched_rt(struct crypt_priv *ctx)
> +{
> +       bool fpu_enabled = ctx->fpu_enabled;
> +
> +       if (!fpu_enabled || !tif_need_resched_now())
> +               return;
> +       camellia_fpu_end(fpu_enabled);
> +       kernel_fpu_end();
> +       /* schedule due to preemptible */
> +       kernel_fpu_begin();
> +}

There's a ton of duplication in there; you're not nearly lazy enough.

Why can't we do something simple like kernel_fpu_resched() ?

diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index f92a6593de1e..05321b98a55a 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -130,6 +130,18 @@ void kernel_fpu_begin(void)
 }
 EXPORT_SYMBOL_GPL(kernel_fpu_begin);
 
+void kernel_fpu_resched(void)
+{
+	WARN_ON_FPU(!this_cpu_read(in_kernel_fpu));
+
+	if (should_resched(PREEMPT_OFFSET)) {
+		kernel_fpu_end();
+		cond_resched();
+		kernel_fpu_begin();
+	}
+}
+EXPORT_SYMBOL_GPL(kernel_fpu_resched);
+
 void kernel_fpu_end(void)
 {
 	__kernel_fpu_end();
