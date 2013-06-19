From: Stanislav Meduna <stano@meduna.org>
Subject: Re: [PATCH] mm: fix up a spurious page fault whenever it happens
Date: Wed, 19 Jun 2013 09:36:39 +0200
Message-ID: <51C15F87.20100@meduna.org>
References: <5195ED8B.7060002@meduna.org> <1369183168.6828.168.camel@gandalf.local.home> <519CBB30.3060200@redhat.com> <CA+55aFxMqvDvcVtLW-yD2PuU_CcjPOC30Zk07Kuk6S25WCzbHQ@mail.gmail.com> <20130522134111.33a695c5@cuia.bos.redhat.com> <519D08B0.8050707@meduna.org> <1369246316.6828.176.camel@gandalf.local.home> <519D0CAB.7020800@meduna.org> <519D0FF8.5080200@redhat.com> <519D118B.6010306@zytor.com> <519D11BF.5000604@redhat.com> <519DCE2A.4010801@meduna.org> <519E095A.4000105@redhat.com> <519F24DD.5060700@meduna.org> <519F65DB.2020305@redhat.com> <51BE2F5C.8070408@meduna.org> <51C0B177.2000006@meduna.org> <CA+55aFwm-a0O-jvznYpXM4Ctf_jex+gcgELq_pqXL38Y6X-JPg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Rik van Riel <riel@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	the arch/x86 maintainers <x86@kernel.org>,
	Hai Huang <hhuang@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.meduna.org ([92.240.244.38]:44467 "EHLO meduna.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755576Ab3FSHgy (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 19 Jun 2013 03:36:54 -0400
In-Reply-To: <CA+55aFwm-a0O-jvznYpXM4Ctf_jex+gcgELq_pqXL38Y6X-JPg@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 19.06.2013 07:20, Linus Torvalds wrote:

>> No crash in 2 days running with preempt none...
> 
> Is this UP?

Yes it is.

> There's the fast_tlb race that Peter fixed in commit 29eb77825cc7
> ("arch, mm: Remove tlb_fast_mode()"). I'm not seeing how it would
> cause infinite TLB faults, but it definitely causes potentially
> incoherent TLB contents. And afaik it only happens with
> CONFIG_PREEMPT, and on UP systems. Which sounds like it might match
> your setup...

Oh, thank you for the pointer, this indeed looks interesting.

Unfortunately the patch massively does not apply to 3.4 which
I am using and I know too little what all is involved here
to backport it. I will test it when (if) it gets to the 3.4(-rt)
(or when I find some spare time to play with the newer kernel
on that system).

Thanks
-- 
                                     Stano

