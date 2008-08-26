From: Jon Masters <jonathan@jonmasters.org>
Subject: Re: 2.6.26.3-rt3 bug report
Date: Tue, 26 Aug 2008 00:14:40 -0400
Message-ID: <1219724080.25366.13.camel@perihelion>
References: <520f0cf10808241551x2fe64e9esadf66634b3790c54@mail.gmail.com>
	 <520f0cf10808251615r5953794x9816bd58ea771ab3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Steven Rostedt <rostedt@goodmis.org>,
	LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@elte.hu>
To: John Kacur <jkacur@gmail.com>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753512AbYHZEPa@vger.kernel.org>
In-Reply-To: <520f0cf10808251615r5953794x9816bd58ea771ab3@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tue, 2008-08-26 at 01:15 +0200, John Kacur wrote:

> Slightly different form today.
> 
> Bad page state in process 'firefox-bin'
> page:ffffe20000daa360 flags:0x0100000000000000
> mapping:ffffe20000daa378 mapcount:0 count:0
> Trying to fix it up, but a reboot is needed
> Backtrace:
> Pid: 16955, comm: firefox-bin Not tainted 2.6.26.3-rt3 #3

Er, does firefox run reliably on a non-RT 2.6.26.3 kernel? This many
random calls to bad_page suggests more of a RAM problem.

Jon.
