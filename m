From: Stanislav Meduna <stano@meduna.org>
Subject: Re: [PATCH] mm: fix up a spurious page fault whenever it happens
Date: Wed, 22 May 2013 20:21:31 +0200
Message-ID: <519D0CAB.7020800@meduna.org>
References: <5195ED8B.7060002@meduna.org>  <1369183168.6828.168.camel@gandalf.local.home>  <519CBB30.3060200@redhat.com>  <CA+55aFxMqvDvcVtLW-yD2PuU_CcjPOC30Zk07Kuk6S25WCzbHQ@mail.gmail.com>  <20130522134111.33a695c5@cuia.bos.redhat.com> <519D08B0.8050707@meduna.org> <1369246316.6828.176.camel@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Rik van Riel <riel@redhat.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	the arch/x86 maintainers <x86@kernel.org>,
	Hai Huang <hhuang@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1369246316.6828.176.camel@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 22.05.2013 20:11, Steven Rostedt wrote:

> Did you apply both patches? Without the first one, this one is
> meaningless.

Sure.

BTW, back when I tried to pinpoint it I also tried adding
  flush_tlb_page(vma, address)
at the beginning of handle_pte_fault, which as I read should
be basically the same. It did not not change anything.
I did mention it some in some previous mail but forgot
to include it again in the summary - sorry :/

-- 
                                        Stano
