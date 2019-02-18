From: Julien Grall <julien.grall@arm.com>
Subject: Re: [RFC PATCH] arm64/fpsimd: Don't disable softirq when touching
 FPSIMD/SVE state
Date: Mon, 18 Feb 2019 16:32:14 +0000
Message-ID: <10464811-e050-5ea1-6763-4362cb1c7c7c@arm.com>
References: <20190208165513.8435-1-julien.grall@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: bigeasy@linutronix.de, Dave.Martin@arm.com,
        linux-rt-users@vger.kernel.org, catalin.marinas@arm.com,
        will.deacon@arm.com, ard.biesheuvel@linaro.org,
        linux-kernel@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190208165513.8435-1-julien.grall@arm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi all,

On 08/02/2019 16:55, Julien Grall wrote:
> @@ -1094,9 +1113,7 @@ void kernel_neon_begin(void)
>   	/* Invalidate any task state remaining in the fpsimd regs: */
>   	fpsimd_flush_cpu_state();
>   
> -	preempt_disable();
> -
> -	local_bh_enable();
> +	kernel_neon_enable();

I found one error in the patch. We should not re-enable NEON from 
kernel_neon_begin(). I will resend a patch once the thread settle down.

Cheers,

-- 
Julien Grall
