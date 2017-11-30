From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RT] crypto: limit more FPU-enabled sections
Date: Thu, 30 Nov 2017 10:29:48 -0500
Message-ID: <20171130102948.22d451cd@gandalf.local.home>
References: <20171130142216.GB12606@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Cc: linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, Peter Zijlstra <peterz@infradead.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171130142216.GB12606@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Thu, 30 Nov 2017 15:22:17 +0100
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> Those crypto drivers use SSE/AVX/… for their crypto work and in order to
> do so in kernel they need to enable the "FPU" in kernel mode which
> disables preemption.
> There are two problems with the way they are used:
> - the while loop which processes X bytes may create latency spikes and
>   should be avoided or limited.
> - the cipher-walk-next part may allocate/free memory and may use
>   kmap_atomic().
> 
> The whole kernel_fpu_begin()/end() processing isn't probably that cheap.
> It most likely makes sense to prcess as much of those as possible in one

s/prcess/process/

> go. The new *_fpu_sched_rt() shedules only if a RT task is pending.
> 
> Probably we should meassure the performance those ciphers in pure SW
> mode and with this optimisations to see if it makes sense to keep them
> for RT.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>



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
> +


> +static void camellia_fpu_end_rt(struct crypt_priv *ctx)
> +{
> +#if CONFIG_PREEMPT_RT_FULL
> +	bool fpu_enabled = ctx->fpu_enabled;
> +
> +	if (!fpu_enabled)
> +		return;
> +	camellia_fpu_end(fpu_enabled);
> +	ctx->fpu_enabled = false;
> +#endif
> +}
> +
> +static void camellia_fpu_sched_rt(struct crypt_priv *ctx)
> +{
> +#if CONFIG_PREEMPT_RT_FULL
> +	bool fpu_enabled = ctx->fpu_enabled;
> +
> +	if (!fpu_enabled || !tif_need_resched_now())
> +		return;
> +	camellia_fpu_end(fpu_enabled);

I haven't looked deeply, but why does this call the camellia_fpu_end()
but other *_fpu_sched_rt() do not call the equivalent?

> +	kernel_fpu_end();
> +	/* schedule due to preemptible */
> +	kernel_fpu_begin();
> +#endif
> +}
> +

These are duplicate functions. Shouldn't they go into a header file?

Also, they are very similar:

static inline void camellia_fpu_end(bool fpu_enabled)
{
	glue_fpu_end(fpu_enabled);
}

static inline void cast6_fpu_end(bool fpu_enabled)
{
	glue_fpu_end(fpu_enabled);
}

static inline void serpent_fpu_end(bool fpu_enabled)
{
	glue_fpu_end(fpu_enabled);
}

static inline void twofish_fpu_end(bool fpu_enabled)
{
	glue_fpu_end(fpu_enabled);
}

-- Steve

>

> +static void cast6_fpu_end_rt(struct crypt_priv *ctx)
> +{
> +#if CONFIG_PREEMPT_RT_FULL
> +	bool fpu_enabled = ctx->fpu_enabled;
> +
> +	if (!fpu_enabled)
> +		return;
> +	cast6_fpu_end(fpu_enabled);
> +	ctx->fpu_enabled = false;
> +#endif
> +}
>

> +static void serpent_fpu_end_rt(struct crypt_priv *ctx)
> +{
> +#if CONFIG_PREEMPT_RT_FULL
> +       bool fpu_enabled = ctx->fpu_enabled;
> +
> +       if (!fpu_enabled)
> +               return;
> +       serpent_fpu_end(fpu_enabled);
> +       ctx->fpu_enabled = false;
> +#endif
> +}
> +
> +static void serpent_fpu_sched_rt(struct crypt_priv *ctx)
> +{
> +#if CONFIG_PREEMPT_RT_FULL
> +	bool fpu_enabled = ctx->fpu_enabled;
> +
> +	if (!fpu_enabled || !tif_need_resched_now())
> +		return;
> +	kernel_fpu_end();
> +	/* schedule due to preemptible */
> +	kernel_fpu_begin();
> +#endif
> +}
> +
>  static void encrypt_callback(void *priv, u8 *srcdst, unsigned int nbytes)
>

> +static void serpent_fpu_end_rt(struct crypt_priv *ctx)
> +{
> +#if CONFIG_PREEMPT_RT_FULL
> +	bool fpu_enabled = ctx->fpu_enabled;
> +
> +	if (!fpu_enabled)
> +		return;
> +	serpent_fpu_end(fpu_enabled);
> +	ctx->fpu_enabled = false;
> +#endif
> +}
> +
>

> diff --git a/arch/x86/crypto/serpent_sse2_glue.c b/arch/x86/crypto/serpent_sse2_glue.c
> index ac0e831943f5..66fd2a51836f 100644
> --- a/arch/x86/crypto/serpent_sse2_glue.c
> +++ b/arch/x86/crypto/serpent_sse2_glue.c
> @@ -187,16 +187,28 @@ struct crypt_priv {
>  	bool fpu_enabled;
>  };
>  
> +static void serpent_fpu_end_rt(struct crypt_priv *ctx)
> +{
> +#if CONFIG_PREEMPT_RT_FULL
> +	bool fpu_enabled = ctx->fpu_enabled;
> +
> +	if (!fpu_enabled)
> +		return;
> +	serpent_fpu_end(fpu_enabled);
> +	ctx->fpu_enabled = false;
> +#endif
> +}
> +
> 

> +static void twofish_fpu_end_rt(struct crypt_priv *ctx)
> +{
> +#if CONFIG_PREEMPT_RT_FULL
> +	bool fpu_enabled = ctx->fpu_enabled;
> +
> +	if (!fpu_enabled)
> +		return;
> +	twofish_fpu_end(fpu_enabled);
> +	ctx->fpu_enabled = false;
> +#endif
> +}
> +
> +static void twofish_fpu_sched_rt(struct crypt_priv *ctx)
> +{
> +#if CONFIG_PREEMPT_RT_FULL
> +	bool fpu_enabled = ctx->fpu_enabled;
> +
> +	if (!fpu_enabled || !tif_need_resched_now())
> +		return;
> +	kernel_fpu_end();
> +	/* schedule due to preemptible */
> +	kernel_fpu_begin();
> +#endif
> +}
> +
> 
