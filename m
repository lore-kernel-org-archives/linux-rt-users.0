From: Stanislav Meduna <stano@meduna.org>
Subject: Re: [PATCH] mm: fix up a spurious page fault whenever it happens
Date: Thu, 20 Jun 2013 19:50:22 +0200
Message-ID: <51C340DE.30806@meduna.org>
References: <519D118B.6010306@zytor.com> <519D11BF.5000604@redhat.com> <519DCE2A.4010801@meduna.org> <519E095A.4000105@redhat.com> <519F24DD.5060700@meduna.org> <519F65DB.2020305@redhat.com> <51BE2F5C.8070408@meduna.org> <51C0B177.2000006@meduna.org> <CA+55aFwm-a0O-jvznYpXM4Ctf_jex+gcgELq_pqXL38Y6X-JPg@mail.gmail.com> <51C15F87.20100@meduna.org> <20130619080656.GF16094@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Rik van Riel <riel@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	the arch/x86 maintainers <x86@kernel.org>,
	Hai Huang <hhuang@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.meduna.org ([92.240.244.38]:47955 "EHLO meduna.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758294Ab3FTRvK (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 20 Jun 2013 13:51:10 -0400
In-Reply-To: <20130619080656.GF16094@twins.programming.kicks-ass.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 19.06.2013 10:06, Peter Zijlstra wrote:

>> On 19.06.2013 07:20, Linus Torvalds wrote:
>>> There's the fast_tlb race that Peter fixed in commit 29eb77825cc7
>>> ("arch, mm: Remove tlb_fast_mode()"). I'm not seeing how it would
>>> cause infinite TLB faults, but it definitely causes potentially
>>> incoherent TLB contents. And afaik it only happens with
>>> CONFIG_PREEMPT, and on UP systems. Which sounds like it might match
>>> your setup...

> The easiest way to test for your system is to ensure tlb_fast_mode()
> return an unconditional 0.

Nope. Got the faults also with tlb_fast_mode() returning 0, this time
after ~10 hours. So there still has to be something...

Regards
-- 
                                        Stano


