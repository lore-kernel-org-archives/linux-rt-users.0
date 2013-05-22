From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH - sort of] x86: Livelock in handle_pte_fault
Date: Wed, 22 May 2013 08:01:43 -0700
Message-ID: <CA+55aFxMqvDvcVtLW-yD2PuU_CcjPOC30Zk07Kuk6S25WCzbHQ@mail.gmail.com>
References: <5195ED8B.7060002@meduna.org>
	<1369183168.6828.168.camel@gandalf.local.home>
	<519CBB30.3060200@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Stanislav Meduna <stano@meduna.org>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"the arch/x86 maintainers" <x86@kernel.org>,
	Hai Huang <hhuang@redhat.com>
To: Rik van Riel <riel@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <519CBB30.3060200@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Wed, May 22, 2013 at 5:33 AM, Rik van Riel <riel@redhat.com> wrote:
>
> That sounds like maybe we DO want a TLB flush on spurious
> page faults, so we get rid of this problem.

Hmm. If it was just the Geode, I wouldn't be surprised. But with a Celeron too?

Anyway, worth testing..

> We can get flush_tlb_fix_spurious_fault to do a local TLB
> invalidate of just the address in question by removing the
> x86-specific dummy version, falling back to the asm-generic
> version that does something.
>
> Can you test the attached patch?

I think you should also remove the

        if (flags & FAULT_FLAG_WRITE)

test in handle_pte_fault(). Because if it's spurious, it might happen
on reads too, I think.

RT people - does RT do anything special with the page tables?

Stanislav, the patch you sent out may well work, but it's damned odd.
On UP, we don't do the leave_mm() optimization that makes that code
necessary. So I agree with Rik that it's more likely somewhere else
(and infinite page faults do imply the TLB not getting flushed by the
page fault exception), and your patch might just be working around it
by simply flushing the TLB at least when switching between threads,
which still happens.

                   Linus
