From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH] arm64: reenable interrupt when handling ptrace breakpoint
Date: Wed, 13 Jan 2016 10:26:23 +0000
Message-ID: <20160113102622.GC25458@arm.com>
References: <1450225088-2456-1-git-send-email-yang.shi@linaro.org>
 <20151216111316.GD4308@arm.com> <5671CD5B.9030907@linaro.org>
 <20151221104818.GF23092@arm.com>
 <alpine.DEB.2.11.1512211749180.28591@nanos>
 <20151221170028.GT23092@arm.com> <56955B3A.5010303@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: linaro-kernel@lists.linaro.org, linux-rt-users@vger.kernel.org,
 Catalin.Marinas@arm.com, linux-kernel@vger.kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org
To: "Shi, Yang" <yang.shi@linaro.org>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <56955B3A.5010303@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Id: linux-rt-users.vger.kernel.org

On Tue, Jan 12, 2016 at 11:59:54AM -0800, Shi, Yang wrote:
> On 12/21/2015 9:00 AM, Will Deacon wrote:
> >On Mon, Dec 21, 2015 at 05:51:22PM +0100, Thomas Gleixner wrote:
> >>On Mon, 21 Dec 2015, Will Deacon wrote:
> >>>+static void send_user_sigtrap(int si_code)
> >>>+{
> >>>+	struct pt_regs *regs = current_pt_regs();
> >>>+	siginfo_t info = {
> >>>+		.si_signo	= SIGTRAP,
> >>>+		.si_errno	= 0,
> >>>+		.si_code	= si_code,
> >>>+		.si_addr	= (void __user *)instruction_pointer(regs),
> >>>+	};
> >>>+
> >>>+	if (WARN_ON(!user_mode(regs)))
> >>>+		return;
> >>>+
> >>>+	preempt_disable();
> >>
> >>That doesn't work on RT either. force_sig_info() takes task->sighand->siglock,
> >>which is a 'sleeping' spinlock on RT.
> >
> >Ah, I missed that :/
> >
> >>Why would we need to disable preemption here at all? What's the problem of
> >>being preempted or even migrated?
> >
> >There *might* not be a problem, I'm just really nervous about changing
> >the behaviour on the debug path and subtly changing how ptrace behaves.
> >
> >My worry was that you could somehow get back into the tracer, and it
> >could remove a software breakpoint in the knowledge that it wouldn't
> >see any future (spurious) SIGTRAPs for that location.
> >
> >Without a concrete example, however, I guess I'll bite the bullet and
> >enable irqs across the call to force_sig_info, since there is clearly a
> >real issue here on RT.
> 
> This might be buried in email storm during the holiday. Just want to double
> check the status. I'm supposed there is no objection for getting it merged
> in upstream?

Sorry, when you replied with:

> I think we could just extend the "signal delay send" approach from x86-64
> to arm64, which is currently used by x86-64 on -rt kernel only.

I understood that you were going to fix -rt, so I dropped this pending
anything more from you.

What's the plan?

Will
