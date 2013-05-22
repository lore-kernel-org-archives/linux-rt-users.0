From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] mm: fix up a spurious page fault whenever it happens
Date: Wed, 22 May 2013 11:42:19 -0700
Message-ID: <519D118B.6010306@zytor.com>
References: <5195ED8B.7060002@meduna.org>  <1369183168.6828.168.camel@gandalf.local.home>  <519CBB30.3060200@redhat.com>  <CA+55aFxMqvDvcVtLW-yD2PuU_CcjPOC30Zk07Kuk6S25WCzbHQ@mail.gmail.com>  <20130522134111.33a695c5@cuia.bos.redhat.com> <519D08B0.8050707@meduna.org> <1369246316.6828.176.camel@gandalf.local.home> <519D0CAB.7020800@meduna.org> <519D0FF8.5080200@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Stanislav Meduna <stano@meduna.org>,
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
In-Reply-To: <519D0FF8.5080200@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 05/22/2013 11:35 AM, Rik van Riel wrote:
> On 05/22/2013 02:21 PM, Stanislav Meduna wrote:
>> On 22.05.2013 20:11, Steven Rostedt wrote:
>>
>>> Did you apply both patches? Without the first one, this one is
>>> meaningless.
>>
>> Sure.
>>
>> BTW, back when I tried to pinpoint it I also tried adding
>>    flush_tlb_page(vma, address)
>> at the beginning of handle_pte_fault, which as I read should
>> be basically the same. It did not not change anything.
> 
> I'm stumped.
> 
> If the Geode knows how to flush single TLB entries, it
> should do that when flush_tlb_page is called.
> 
> If it does not know, it should throw an invalid instruction
> exception, and not quietly complete the instruction without
> doing anything.
> 

Some CPUs have had errata when it comes to flushing large pages that
have been split into small pages by hardware, e.g. due to MTRR
conflicts.  In that case, fragments of the large page may have been left
in the TLB.

Could that explain what you are seeing?

	-hpa
