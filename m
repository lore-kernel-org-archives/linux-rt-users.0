From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RT] arm64: fpsimd: use a local_lock() in addition to
 local_bh_disable()
Date: Tue, 22 May 2018 13:10:04 -0400
Message-ID: <20180522131004.3012953c@gandalf.local.home>
References: <20180517124006.ohygrrpg7z2moqqt@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180517124006.ohygrrpg7z2moqqt@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Thu, 17 May 2018 14:40:06 +0200
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> +static DEFINE_LOCAL_IRQ_LOCK(fpsimd_lock);
>  /*
>   * Update current's FPSIMD/SVE registers from thread_struct.
>   *
> @@ -594,6 +595,7 @@ int sve_set_vector_length(struct task_struct *task,
>  	 * non-SVE thread.
>  	 */
>  	if (task == current) {
> +		local_lock(fpsimd_lock);
>  		local_bh_disable();

I'm surprised that we don't have a "local_lock_bh()"?

-- Steve

>  
>  		task_fpsimd_save();
