From: Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH RT 0/2 v5] preempt-rt/x86: Handle sending signals from
	do_trap() by gdb
Date: Wed, 8 Feb 2012 12:57:54 +0100
Message-ID: <20120208115754.GA30029@redhat.com>
References: <20120208005612.852040607@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:50588 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756372Ab2BHMEp (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 8 Feb 2012 07:04:45 -0500
Content-Disposition: inline
In-Reply-To: <20120208005612.852040607@goodmis.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 02/07, Steven Rostedt wrote:
>
> Oleg, please take a look at the modifications I made to your patch,
> and if you are fine with it, please ack it.

Yes, I believe the modifications are fine.

Thanks Steven!

Oleg.

