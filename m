From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RT] crypto: limit more FPU-enabled sections
Date: Thu, 30 Nov 2017 10:19:43 -0500
Message-ID: <20171130101943.15f7ade4@gandalf.local.home>
References: <20171130142216.GB12606@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, Peter Zijlstra <peterz@infradead.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171130142216.GB12606@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Thu, 30 Nov 2017 15:22:17 +0100
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> diff --git a/arch/x86/crypto/camellia_aesni_avx2_glue.c b/arch/x86/crypto/camellia_aesni_avx2_glue.c
> index 60907c139c4e..d7502c023475 100644
> --- a/arch/x86/crypto/camellia_aesni_avx2_glue.c
> +++ b/arch/x86/crypto/camellia_aesni_avx2_glue.c
> @@ -206,6 +206,32 @@ struct crypt_priv {
>  	bool fpu_enabled;
>  };
>  
> +static void camellia_fpu_end_rt(struct crypt_priv *ctx)
> +{
> +#if CONFIG_PREEMPT_RT_FULL
> +       bool fpu_enabled = ctx->fpu_enabled;
> +
> +       if (!fpu_enabled)
> +               return;
> +       camellia_fpu_end(fpu_enabled);
> +       ctx->fpu_enabled = false;
> +#endif
> +}
> +
> +static void camellia_fpu_sched_rt(struct crypt_priv *ctx)
> +{
> +#if CONFIG_PREEMPT_RT_FULL
> +       bool fpu_enabled = ctx->fpu_enabled;
> +
> +       if (!fpu_enabled || !tif_need_resched_now())
> +               return;
> +       camellia_fpu_end(fpu_enabled);
> +       kernel_fpu_end();
> +       /* schedule due to preemptible */
> +       kernel_fpu_begin();
> +#endif
> +}

I think it would be cleaner to do:

#ifdef CONFIG_PREEMPT_RT_FULL
static void camellia_fpu_end_rt(struct crypt_priv *ctx)
{
       bool fpu_enabled = ctx->fpu_enabled;

       if (!fpu_enabled)
               return;
       camellia_fpu_end(fpu_enabled);
       ctx->fpu_enabled = false;
}

static void camellia_fpu_sched_rt(struct crypt_priv *ctx)
{
       bool fpu_enabled = ctx->fpu_enabled;

       if (!fpu_enabled || !tif_need_resched_now())
               return;
       camellia_fpu_end(fpu_enabled);
       kernel_fpu_end();
       /* schedule due to preemptible */
       kernel_fpu_begin();
}
#else
static inline void camellia_fpu_end_rt(struct crypt_priv *ctx) { }
static void camellia_fpu_sched_rt(struct crypt_priv *ctx) { }
#endif

It really shows that these functions are only used by RT. IMO it's bad
taste to have functions with the entire body encapsulated in #ifdefs.

And the same goes for the other functions in this patch.

-- Steve
