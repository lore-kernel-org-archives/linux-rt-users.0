From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH] arm64: reenable interrupt when handling ptrace breakpoint
Date: Mon, 21 Dec 2015 10:48:18 +0000
Message-ID: <20151221104818.GF23092@arm.com>
References: <1450225088-2456-1-git-send-email-yang.shi@linaro.org>
 <20151216111316.GD4308@arm.com>
 <5671CD5B.9030907@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Catalin.Marinas@arm.com, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linaro-kernel@lists.linaro.org, linux-rt-users@vger.kernel.org
To: "Shi, Yang" <yang.shi@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5671CD5B.9030907@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Wed, Dec 16, 2015 at 12:45:15PM -0800, Shi, Yang wrote:
> On 12/16/2015 3:13 AM, Will Deacon wrote:
> >On Tue, Dec 15, 2015 at 04:18:08PM -0800, Yang Shi wrote:
> >>The kernel just send out a SIGTRAP signal when handling ptrace breakpoint in
> >>debug exception, so it sounds safe to have interrupt enabled if it is not
> >>disabled by the parent process.
> >
> >Is this actually fixing an issue you're seeing, or did you just spot this?
> >Given that force_sig_info disable interrupts, I don't think this is really
> >worth doing.
> 
> I should made more comments at the first place, sorry for the inconvenience.
> 
> I did run into some problems on -rt kernel with CRIU restore, please see the
> below kernel bug log:

Thanks.

> >My worry here is that we take an interrupt and, on the return path,
> >decide to reschedule due to CONFIG_PREEMPT. If we somehow end up back
> >in the debugger, I'm concerned that it could remove the breakpoint and
> >then later see an unexpected SIGTRAP from the child.
> >
> >Having said that, I've failed to construct a non-racy scenario in which
> >that can happen, but I'm just really uncomfortable making this change
> >unless there's a real problem being solved.
> 
> The patch is inspired by the similar code in other architectures, e.g. x86
> and powerpc which have hardware debug exception to handle breakpoint and
> single step like arm64. And, they have interrupt enabled in both breakpoint
> and single step. So, I'm supposed arm64 could do the same thing.
> 
> For the preempt case, it might be possible, but it sounds like a exception
> handling problem to me. The preempt should not be allowed in debug exception
> (current arm64 kernel does it), and in interrupt return path the code should
> check if debug is on or not. If debug is on, preempt should be just skipped.
> Or we could disable preempt in debug exception.

Yeah, disabling preemption during the debug handler and then enabling
interrupts if it came from userspace sounds like the best option. However,
that's a fairly invasive change to entry.S at this point, so maybe we're
better off with something like the patch below in the meantime?

Will

--->8

diff --git a/arch/arm64/kernel/debug-monitors.c b/arch/arm64/kernel/debug-monitors.c
index 8aee3aeec3e6..7f4913f2ea3c 100644
--- a/arch/arm64/kernel/debug-monitors.c
+++ b/arch/arm64/kernel/debug-monitors.c
@@ -226,11 +226,29 @@ static int call_step_hook(struct pt_regs *regs, unsigned int esr)
 	return retval;
 }
 
+static void send_user_sigtrap(int si_code)
+{
+	struct pt_regs *regs = current_pt_regs();
+	siginfo_t info = {
+		.si_signo	= SIGTRAP,
+		.si_errno	= 0,
+		.si_code	= si_code,
+		.si_addr	= (void __user *)instruction_pointer(regs),
+	};
+
+	if (WARN_ON(!user_mode(regs)))
+		return;
+
+	preempt_disable();
+	local_irq_enable();
+	force_sig_info(SIGTRAP, &info, current);
+	local_irq_disable();
+	preempt_enable();
+}
+
 static int single_step_handler(unsigned long addr, unsigned int esr,
 			       struct pt_regs *regs)
 {
-	siginfo_t info;
-
 	/*
 	 * If we are stepping a pending breakpoint, call the hw_breakpoint
 	 * handler first.
@@ -239,11 +257,7 @@ static int single_step_handler(unsigned long addr, unsigned int esr,
 		return 0;
 
 	if (user_mode(regs)) {
-		info.si_signo = SIGTRAP;
-		info.si_errno = 0;
-		info.si_code  = TRAP_HWBKPT;
-		info.si_addr  = (void __user *)instruction_pointer(regs);
-		force_sig_info(SIGTRAP, &info, current);
+		send_user_sigtrap(TRAP_HWBKPT);
 
 		/*
 		 * ptrace will disable single step unless explicitly
@@ -307,17 +321,8 @@ static int call_break_hook(struct pt_regs *regs, unsigned int esr)
 static int brk_handler(unsigned long addr, unsigned int esr,
 		       struct pt_regs *regs)
 {
-	siginfo_t info;
-
 	if (user_mode(regs)) {
-		info = (siginfo_t) {
-			.si_signo = SIGTRAP,
-			.si_errno = 0,
-			.si_code  = TRAP_BRKPT,
-			.si_addr  = (void __user *)instruction_pointer(regs),
-		};
-
-		force_sig_info(SIGTRAP, &info, current);
+		send_user_sigtrap(TRAP_BRKPT);
 	} else if (call_break_hook(regs, esr) != DBG_HOOK_HANDLED) {
 		pr_warning("Unexpected kernel BRK exception at EL1\n");
 		return -EFAULT;
@@ -328,7 +333,6 @@ static int brk_handler(unsigned long addr, unsigned int esr,
 
 int aarch32_break_handler(struct pt_regs *regs)
 {
-	siginfo_t info;
 	u32 arm_instr;
 	u16 thumb_instr;
 	bool bp = false;
@@ -359,14 +363,7 @@ int aarch32_break_handler(struct pt_regs *regs)
 	if (!bp)
 		return -EFAULT;
 
-	info = (siginfo_t) {
-		.si_signo = SIGTRAP,
-		.si_errno = 0,
-		.si_code  = TRAP_BRKPT,
-		.si_addr  = pc,
-	};
-
-	force_sig_info(SIGTRAP, &info, current);
+	send_user_sigtrap(TRAP_BRKPT);
 	return 0;
 }
 
