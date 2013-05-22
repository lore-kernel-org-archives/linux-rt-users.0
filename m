From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] mm: fix up a spurious page fault whenever it happens
Date: Wed, 22 May 2013 14:11:56 -0400
Message-ID: <1369246316.6828.176.camel@gandalf.local.home>
References: <5195ED8B.7060002@meduna.org>
	 <1369183168.6828.168.camel@gandalf.local.home>
	 <519CBB30.3060200@redhat.com>
	 <CA+55aFxMqvDvcVtLW-yD2PuU_CcjPOC30Zk07Kuk6S25WCzbHQ@mail.gmail.com>
	 <20130522134111.33a695c5@cuia.bos.redhat.com> <519D08B0.8050707@meduna.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
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
To: Stanislav Meduna <stano@meduna.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <519D08B0.8050707@meduna.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Wed, 2013-05-22 at 20:04 +0200, Stanislav Meduna wrote:
> On 22.05.2013 19:41, Rik van Riel wrote:
> 
> >> I think you should also remove the
> >>
> >>         if (flags & FAULT_FLAG_WRITE)
> 
> Done
> 
> >>> Can you test the attached patch?
> 
> Nope. Fails with the same symptoms, min_flt skyrockets,
> the throttler activates and after 2 seconds all is well
> again.
> 
> This is on Geode LX, I don't have the Celeron M at the hand now.
> 

Did you apply both patches? Without the first one, this one is
meaningless.

-- Steve
