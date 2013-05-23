From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] mm: fix up a spurious page fault whenever it happens
Date: Thu, 23 May 2013 11:27:16 -0400
Message-ID: <1369322836.6828.199.camel@gandalf.local.home>
References: <5195ED8B.7060002@meduna.org>
	   <1369183168.6828.168.camel@gandalf.local.home>
	   <519CBB30.3060200@redhat.com>
	   <CA+55aFxMqvDvcVtLW-yD2PuU_CcjPOC30Zk07Kuk6S25WCzbHQ@mail.gmail.com>
	   <20130522134111.33a695c5@cuia.bos.redhat.com>
	  <519D08B0.8050707@meduna.org>
	  <1369246316.6828.176.camel@gandalf.local.home>
	  <519D0CAB.7020800@meduna.org> <519D0FF8.5080200@redhat.com>
	  <519D118B.6010306@zytor.com> <519D11BF.5000604@redhat.com>
	  <519DCE2A.4010801@meduna.org> <519E095A.4000105@redhat.com>
	 <1369315769.6828.198.camel@gandalf.local.home> <519E3089.8040701@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Rik van Riel <riel@redhat.com>,
	Stanislav Meduna <stano@meduna.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	the arch/x86 maintainers <x86@kernel.org>,
	Hai Huang <hhuang@redhat.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <519E3089.8040701@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Thu, 2013-05-23 at 08:06 -0700, H. Peter Anvin wrote:

> We don't even need the jump_label infrastructure -- we have
> static_cpu_has*() which actually predates jump_label although it uses
> the same underlying ideas.

Ah right. I wonder if it would be worth consolidating a lot of these
"modifying of code" infrastructures. Which reminds me, I need to update
text_poke() to do things similar to what ftrace does, and get rid of the
stop machine code.

-- Steve
