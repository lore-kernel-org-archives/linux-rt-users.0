From: Stanislav Meduna <stano@meduna.org>
Subject: Re: [PATCH] mm: fix up a spurious page fault whenever it happens
Date: Thu, 23 May 2013 10:07:06 +0200
Message-ID: <519DCE2A.4010801@meduna.org>
References: <5195ED8B.7060002@meduna.org>  <1369183168.6828.168.camel@gandalf.local.home>  <519CBB30.3060200@redhat.com>  <CA+55aFxMqvDvcVtLW-yD2PuU_CcjPOC30Zk07Kuk6S25WCzbHQ@mail.gmail.com>  <20130522134111.33a695c5@cuia.bos.redhat.com> <519D08B0.8050707@meduna.org> <1369246316.6828.176.camel@gandalf.local.home> <519D0CAB.7020800@meduna.org> <519D0FF8.5080200@redhat.com> <519D118B.6010306@zytor.com> <519D11BF.5000604@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	the arch/x86 maintainers <x86@kernel.org>,
	Hai Huang <hhuang@redhat.com>
To: Rik van Riel <riel@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <519D11BF.5000604@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 22.05.2013 20:43, Rik van Riel wrote:

>> Some CPUs have had errata when it comes to flushing large pages that
>> have been split into small pages by hardware, e.g. due to MTRR
>> conflicts.  In that case, fragments of the large page may have been left
>> in the TLB.

Can I somehow find if this is the case? The memory mapping
for the failing process has two regions slightly larger than
4 MB - code and heap.

The process also does not access any funny memory regions
from userspace - it is basically networking (both TCP/IP
and raw sockets) and crunching of the data received.
No mmapped devices or something like that.

> static inline void __native_flush_tlb_single(unsigned long addr)
> {
>         __flush_tlb();
> }
> 
> This on top of the other two patches.

It did not crash overnight, but it also does not show any
minor fault counted for the threads, so I'm afraid the situation
just did not happen - there should be at least one visible in
the ps -o min_flt output, right?

I will give it some more testing time.

Thanks
-- 
                                             Stano
