From: Rik van Riel <riel@redhat.com>
Subject: Re: [PATCH] mm: fix up a spurious page fault whenever it happens
Date: Fri, 24 May 2013 09:06:35 -0400
Message-ID: <519F65DB.2020305@redhat.com>
References: <5195ED8B.7060002@meduna.org>  <1369183168.6828.168.camel@gandalf.local.home>  <519CBB30.3060200@redhat.com>  <CA+55aFxMqvDvcVtLW-yD2PuU_CcjPOC30Zk07Kuk6S25WCzbHQ@mail.gmail.com>  <20130522134111.33a695c5@cuia.bos.redhat.com> <519D08B0.8050707@meduna.org> <1369246316.6828.176.camel@gandalf.local.home> <519D0CAB.7020800@meduna.org> <519D0FF8.5080200@redhat.com> <519D118B.6010306@zytor.com> <519D11BF.5000604@redhat.com> <519DCE2A.4010801@meduna.org> <519E095A.4000105@redhat.com> <519F24DD.5060700@meduna.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
To: Stanislav Meduna <stano@meduna.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <519F24DD.5060700@meduna.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 05/24/2013 04:29 AM, Stanislav Meduna wrote:
> On 23.05.2013 14:19, Rik van Riel wrote:
>
>>>> static inline void __native_flush_tlb_single(unsigned long addr)
>>>> {
>>>>           __flush_tlb();
>>>> }
>>
>>> I will give it some more testing time.
>>
>> That is a good idea.
>
> Still no crash, so this one indeed seems to change things.
>
> If I understand it correctly, these patches fix the problem
> when it happens and we still don't know why the TLB is stale
> in the first place - whether there is (also) a genuine bug
> or whether we are hitting some chip errata, right?

Just to rule something out, are you using
transparent huge pages on those systems?

That could result in a mix of 4MB and 4kB
mappings, sometimes of the same memory.
The page tables would only ever contain
one of those mappings, but if we have some
kind of TLB problem, we might preserve a
large mapping across a page breakup, or
a small one across a page collapse...
