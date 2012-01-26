From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RT 1/2 v2] x86: Do not disable preemption in int3 on
 32bit
Date: Thu, 26 Jan 2012 08:33:31 -0500
Message-ID: <1327584811.22710.80.camel@gandalf.stny.rr.com>
References: <20120125143231.196670014@goodmis.org>
	 <20120125143520.086175333@goodmis.org> <4F211126.1090204@hitachi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	John Kacur <jkacur@redhat.com>, Ingo Molnar <mingo@elte.hu>,
	Andrew Morton <akpm@linux-foundation.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Alexander van Heukelum <heukelum@fastmail.fm>,
	Andi Kleen <ak@linux.intel.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Clark Williams <williams@redhat.com>,
	Luis Goncalves <lgoncalv@redhat.com>
To: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.124]:50155 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751258Ab2AZNde (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 26 Jan 2012 08:33:34 -0500
In-Reply-To: <4F211126.1090204@hitachi.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, 2012-01-26 at 17:39 +0900, Masami Hiramatsu wrote:
> (2012/01/25 23:32), Steven Rostedt wrote:
> > Preemption must be disabled before enabling interrupts in do_trap
> > on x86_64 because the stack in use for int3 and debug is a per CPU
> > stack set by th IST. But in 32bit, the stack still belongs to the
> > current task and there is no problem in scheduling out the task.
> > 
> > Keep preemption enabled on X86_32 when enabling interrupts for
> > do_trap().
> > 
> > Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
> 
> Hmm, I think you'd better change caller side, because the
> function itself has "preempt" in its name. I think it can
> easily mislead other people.

How about if we rename it to

conditional_preempt_sti/cli() ?

Then it can be both a conditional preempt as well as interrupts being
disabled. The condition on preempt is "is 32 bits? don't preempt :
preempt";

-- Steve


