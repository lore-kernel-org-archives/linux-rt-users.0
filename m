From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RT 0/2 v5] preempt-rt/x86: Handle sending signals from
 do_trap() by gdb
Date: Wed, 08 Feb 2012 08:46:29 -0500
Message-ID: <1328708789.2200.117.camel@gandalf.stny.rr.com>
References: <20120208005612.852040607@goodmis.org>
	 <20120208115754.GA30029@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	John Kacur <jkacur@redhat.com>,
	Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>,
	Ingo Molnar <mingo@elte.hu>,
	Andrew Morton <akpm@linux-foundation.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Alexander van Heukelum <heukelum@fastmail.fm>,
	Andi Kleen <ak@linux.intel.com>,
	Clark Williams <williams@redhat.com>,
	Luis Goncalves <lgoncalv@redhat.com>
To: Oleg Nesterov <oleg@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.123]:52382 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750764Ab2BHNqc (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 8 Feb 2012 08:46:32 -0500
In-Reply-To: <20120208115754.GA30029@redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, 2012-02-08 at 12:57 +0100, Oleg Nesterov wrote:
> On 02/07, Steven Rostedt wrote:
> >
> > Oleg, please take a look at the modifications I made to your patch,
> > and if you are fine with it, please ack it.
> 
> Yes, I believe the modifications are fine.

Thanks Oleg,

Thomas, can you add these to the 3.2-rt series.

-- Steve


