From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH] arm64: replace read_lock to rcu lock in call_step_hook
Date: Tue, 9 Feb 2016 14:54:26 +0000
Message-ID: <20160209145426.GR22874@arm.com>
References: <1454971764-30720-1-git-send-email-yang.shi@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: rostedt@goodmis.org, catalin.marinas@arm.com,
	bigeasy@linutronix.de, linux-kernel@vger.kernel.org,
	linux-rt-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linaro-kernel@lists.linaro.org
To: Yang Shi <yang.shi@linaro.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:40751 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752934AbcBIOyY (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 9 Feb 2016 09:54:24 -0500
Content-Disposition: inline
In-Reply-To: <1454971764-30720-1-git-send-email-yang.shi@linaro.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, Feb 08, 2016 at 02:49:24PM -0800, Yang Shi wrote:
> BUG: sleeping function called from invalid context at kernel/locking/rtmutex.c:917
> in_atomic(): 1, irqs_disabled(): 128, pid: 383, name: sh
> Preemption disabled at:[<ffff800000124c18>] kgdb_cpu_enter+0x158/0x6b8
> 
> CPU: 3 PID: 383 Comm: sh Tainted: G        W       4.1.13-rt13 #2
> Hardware name: Freescale Layerscape 2085a RDB Board (DT)
> Call trace:
> [<ffff8000000885e8>] dump_backtrace+0x0/0x128
> [<ffff800000088734>] show_stack+0x24/0x30
> [<ffff80000079a7c4>] dump_stack+0x80/0xa0
> [<ffff8000000bd324>] ___might_sleep+0x18c/0x1a0
> [<ffff8000007a20ac>] __rt_spin_lock+0x2c/0x40
> [<ffff8000007a2268>] rt_read_lock+0x40/0x58
> [<ffff800000085328>] single_step_handler+0x38/0xd8
> [<ffff800000082368>] do_debug_exception+0x58/0xb8
> Exception stack(0xffff80834a1e7c80 to 0xffff80834a1e7da0)
> 7c80: ffffff9c ffffffff 92c23ba0 0000ffff 4a1e7e40 ffff8083 001bfcc4 ffff8000
> 7ca0: f2000400 00000000 00000000 00000000 4a1e7d80 ffff8083 0049501c ffff8000
> 7cc0: 00005402 00000000 00aaa210 ffff8000 4a1e7ea0 ffff8083 000833f4 ffff8000
> 7ce0: ffffff9c ffffffff 92c23ba0 0000ffff 4a1e7ea0 ffff8083 001bfcc0 ffff8000
> 7d00: 4a0fc400 ffff8083 00005402 00000000 4a1e7d40 ffff8083 00490324 ffff8000
> 7d20: ffffff9c 00000000 92c23ba0 0000ffff 000a0000 00000000 00000000 00000000
> 7d40: 00000008 00000000 00080000 00000000 92c23b8b 0000ffff 92c23b8e 0000ffff
> 7d60: 00000038 00000000 00001cb2 00000000 00000005 00000000 92d7b498 0000ffff
> 7d80: 01010101 01010101 92be9000 0000ffff 00000000 00000000 00000030 00000000
> [<ffff8000000833f4>] el1_dbg+0x18/0x6c
> 
> This issue is similar with 62c6c61("arm64: replace read_lock to rcu lock in
> call_break_hook"), but comes to single_step_handler.
> 
> This also solves kgdbts boot test silent hang issue on 4.4 -rt kernel.
> 
> Signed-off-by: Yang Shi <yang.shi@linaro.org>

Acked-by: Will Deacon <will.deacon@arm.com>

Will
