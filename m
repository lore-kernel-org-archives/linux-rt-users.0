From: "Remy Bohmer" <linux@bohmer.net>
Subject: Re: [PATCH RT] Revert Softdisable for simple irqs.
Date: Wed, 12 Dec 2007 21:05:06 +0100
Message-ID: <3efb10970712121205s7fcda39dt7cfa154c53f3eecb@mail.gmail.com>
References: <3efb10970711260531x5e9f05acgfabdfa885a220192@mail.gmail.com>
	 <3efb10970711260545i419a8352o4ca5248b10d81db5@mail.gmail.com>
	 <1196176294.13982.58.camel@localhost.localdomain>
	 <1196177122.23808.7.camel@imap.mvista.com>
	 <1196178834.23808.11.camel@imap.mvista.com>
	 <Pine.LNX.4.58.0712121436260.21795@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
	"Thomas Gleixner" <tglx@linutronix.de>,
	"Ingo Molnar" <mingo@elte.hu>, RT <linux-rt-users@vger.kernel.org>,
	"Daniel Walker" <dwalker@mvista.com>,
	"Russell King" <rmk+lkml@arm.linux.org.uk>
To: "Steven Rostedt" <rostedt@goodmis.org>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1758972AbXLLUF0@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0712121436260.21795@gandalf.stny.rr.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hello Steven,

>
> In commit 76d2160147f43f982dfe881404cfde9fd0a9da21 lazy irq disabling
> was implemented, and the simple irq handler had a masking set to it.
>
> Remy Bohmer discovered that some devices in the ARM architecture
> would trigger the mask, but never unmask it. His patch to do the
> unmasking was questioned by Russell King about masking simple irqs
> to begin with. Looking further, it was discovered that the problems
> Remy was seeing was due to improper use of the simple handler by
> devices, and he later submitted patches to fix those. But the issue
> that was uncovered was that the simple handler should never mask.
>
> This patch reverts the masking in the simple handler.

Also:
Acked-by: Remy Bohmer <linux@bohmer.net>

Thanks for the effort also, I still had it on my todo list, but that
is needed anymore...

Remy
