From: Stanislav Meduna <stano@meduna.org>
Subject: Re: [PATCH] mm: fix up a spurious page fault whenever it happens
Date: Wed, 22 May 2013 20:47:01 +0200
Message-ID: <519D12A5.6090804@meduna.org>
References: <5195ED8B.7060002@meduna.org>  <1369183168.6828.168.camel@gandalf.local.home>  <519CBB30.3060200@redhat.com>  <CA+55aFxMqvDvcVtLW-yD2PuU_CcjPOC30Zk07Kuk6S25WCzbHQ@mail.gmail.com>  <20130522134111.33a695c5@cuia.bos.redhat.com> <519D08B0.8050707@meduna.org> <1369246316.6828.176.camel@gandalf.local.home> <519D0CAB.7020800@meduna.org> <519D0FF8.5080200@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	the arch/x86 maintainers <x86@kernel.org>,
	Hai Huang <hhuang@redhat.com>
To: Rik van Riel <riel@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <519D0FF8.5080200@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 22.05.2013 20:35, Rik van Riel wrote:

> I'm stumped.
> 
> If the Geode knows how to flush single TLB entries, it
> should do that when flush_tlb_page is called.
> 
> If it does not know, it should throw an invalid instruction
> exception, and not quietly complete the instruction without
> doing anything.

Could it be that the problem is not stale TLB, but a page directory
that is somehow invalid, e.g. belonging to the previous modprobe
(or whatever) instead of the running process?

My patch does load_cr3(next->pgd); so it explicitely loads something
there.

> In other words, make the code look like this, for testing:
>
> static inline void __native_flush_tlb_single(unsigned long addr)
> {
>         __flush_tlb();
> }

Yup, will try it.

Thanks
-- 
                                           Stano
