From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] mm: fix up a spurious page fault whenever it happens
Date: Thu, 23 May 2013 07:45:09 -0700
Message-ID: <CA+55aFwzedGVew7CCSqZ-Z=2ELt+A4L--mEQGjtALbMSB3LFoQ@mail.gmail.com>
References: <5195ED8B.7060002@meduna.org>
	<1369183168.6828.168.camel@gandalf.local.home>
	<519CBB30.3060200@redhat.com>
	<CA+55aFxMqvDvcVtLW-yD2PuU_CcjPOC30Zk07Kuk6S25WCzbHQ@mail.gmail.com>
	<20130522134111.33a695c5@cuia.bos.redhat.com>
	<519D08B0.8050707@meduna.org>
	<1369246316.6828.176.camel@gandalf.local.home>
	<519D0CAB.7020800@meduna.org>
	<519D0FF8.5080200@redhat.com>
	<519D118B.6010306@zytor.com>
	<519D11BF.5000604@redhat.com>
	<519DCE2A.4010801@meduna.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Rik van Riel <riel@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	"the arch/x86 maintainers" <x86@kernel.org>,
	Hai Huang <hhuang@redhat.com>
To: Stanislav Meduna <stano@meduna.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <519DCE2A.4010801@meduna.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Thu, May 23, 2013 at 1:07 AM, Stanislav Meduna <stano@meduna.org> wrote:
>
> It did not crash overnight, but it also does not show any
> minor fault counted for the threads

Page faults that don't cause us to map a page (ie a spurious one, or
one that just updates dirty/accessed bits) don't show up as even minor
faults. Thing of the major/minor as "mapping activity" not a page
fault count.

So if this is due to some stuck TLB entry, that wouldn't show up anyway.

                    Linus
