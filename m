From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] arm64: convert patch_lock to raw lock
Date: Wed, 30 Sep 2015 15:04:27 -0400
Message-ID: <20150930150427.2212bf80@gandalf.local.home>
References: <1443637392-6679-1-git-send-email-yang.shi@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: bigeasy@linutronix.de, catalin.marinas@arm.com,
	will.deacon@arm.com, dave.long@linaro.org,
	linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
To: Yang Shi <yang.shi@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1443637392-6679-1-git-send-email-yang.shi@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Wed, 30 Sep 2015 11:23:12 -0700
Yang Shi <yang.shi@linaro.org> wrote:

> When running kprobe test on arm64 rt kernel, it reports the below warning:
> 
> root@qemu7:~# modprobe kprobe_example
> BUG: sleeping function called from invalid context at kernel/locking/rtmutex.c:917
> in_atomic(): 0, irqs_disabled(): 128, pid: 484, name: modprobe
> CPU: 0 PID: 484 Comm: modprobe Not tainted 4.1.6-rt5 #2
> Hardware name: linux,dummy-virt (DT)
> Call trace:
> [<ffffffc0000891b8>] dump_backtrace+0x0/0x128
> [<ffffffc000089300>] show_stack+0x20/0x30
> [<ffffffc00061dae8>] dump_stack+0x1c/0x28
> [<ffffffc0000bbad0>] ___might_sleep+0x120/0x198
> [<ffffffc0006223e8>] rt_spin_lock+0x28/0x40
> [<ffffffc000622b30>] __aarch64_insn_write+0x28/0x78
> [<ffffffc000622e48>] aarch64_insn_patch_text_nosync+0x18/0x48
> [<ffffffc000622ee8>] aarch64_insn_patch_text_cb+0x70/0xa0

OK, the above is called from stomp_machine().

> [<ffffffc000622f40>] aarch64_insn_patch_text_sync+0x28/0x48
> [<ffffffc0006236e0>] arch_arm_kprobe+0x38/0x48
> [<ffffffc00010e6f4>] arm_kprobe+0x34/0x50
> [<ffffffc000110374>] register_kprobe+0x4cc/0x5b8
> [<ffffffbffc002038>] kprobe_init+0x38/0x7c [kprobe_example]
> [<ffffffc000084240>] do_one_initcall+0x90/0x1b0
> [<ffffffc00061c498>] do_init_module+0x6c/0x1cc
> [<ffffffc0000fd0c0>] load_module+0x17f8/0x1db0
> [<ffffffc0000fd8cc>] SyS_finit_module+0xb4/0xc8
> 
> Convert patch_lock to raw loc kto avoid this issue.

Yeah, I don't see anything in that lock that can sleep, or should
take too much time (it's under stomp_machine). Looks like that should be
raw.

Acked-by: Steven Rostedt <rostedt@goodmis.org>

-- Steve

> 
> Although the problem is found on rt kernel, the fix should be applicable to
> mainline kernel too.
> 
> Signed-off-by: Yang Shi <yang.shi@linaro.org>
> ---
>  arch/arm64/kernel/insn.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/kernel/insn.c b/arch/arm64/kernel/insn.c
> index f341866..c08b9ad 100644
> --- a/arch/arm64/kernel/insn.c
> +++ b/arch/arm64/kernel/insn.c
> @@ -85,7 +85,7 @@ bool aarch64_insn_is_branch_imm(u32 insn)
>  		aarch64_insn_is_bcond(insn));
>  }
>  
> -static DEFINE_SPINLOCK(patch_lock);
> +static DEFINE_RAW_SPINLOCK(patch_lock);
>  
>  static void __kprobes *patch_map(void *addr, int fixmap)
>  {
> @@ -131,13 +131,13 @@ static int __kprobes __aarch64_insn_write(void *addr, u32 insn)
>  	unsigned long flags = 0;
>  	int ret;
>  
> -	spin_lock_irqsave(&patch_lock, flags);
> +	raw_spin_lock_irqsave(&patch_lock, flags);
>  	waddr = patch_map(addr, FIX_TEXT_POKE0);
>  
>  	ret = probe_kernel_write(waddr, &insn, AARCH64_INSN_SIZE);
>  
>  	patch_unmap(FIX_TEXT_POKE0);
> -	spin_unlock_irqrestore(&patch_lock, flags);
> +	raw_spin_unlock_irqrestore(&patch_lock, flags);
>  
>  	return ret;
>  }
