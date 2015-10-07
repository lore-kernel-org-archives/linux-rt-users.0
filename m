From: Will Deacon <will.deacon@arm.com>
Subject: Re: [v2 PATCH] arm64: convert patch_lock to raw lock
Date: Wed, 7 Oct 2015 10:28:23 +0100
Message-ID: <20151007092822.GB16065@arm.com>
References: <1444165951-26065-1-git-send-email-yang.shi@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: rostedt@goodmis.org, catalin.marinas@arm.com,
	linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linaro-kernel@lists.linaro.org
To: Yang Shi <yang.shi@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1444165951-26065-1-git-send-email-yang.shi@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tue, Oct 06, 2015 at 02:12:31PM -0700, Yang Shi wrote:
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
> Convert patch_lock to raw lock to avoid this issue.
> 
> Although the problem is found on rt kernel, the fix should be applicable to
> mainline kernel too.
> 
> Signed-off-by: Yang Shi <yang.shi@linaro.org>
> Acked-by: Steven Rostedt <rostedt@goodmis.org>
> ---
> v1 -> v2:
>  Add Steven's Acked-by
>  Fix subject (remove unnecessary "make")
>  Fix a typo error in commit log

I already queued with this Steve's Ack, so we'll just have to live with
the typos.

Will
