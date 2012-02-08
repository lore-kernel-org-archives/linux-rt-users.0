From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 0/2 v5] preempt-rt/x86: Handle sending signals from do_trap() by gdb
Date: Tue, 07 Feb 2012 19:56:12 -0500
Message-ID: <20120208005612.852040607@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	John Kacur <jkacur@redhat.com>,
	Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>,
	Ingo Molnar <mingo@elte.hu>,
	Andrew Morton <akpm@linux-foundation.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Alexander van Heukelum <heukelum@fastmail.fm>,
	Andi Kleen <ak@linux.intel.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Clark Williams <williams@redhat.com>,
	Luis Goncalves <lgoncalv@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:48094 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756602Ab2BHA6w (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 7 Feb 2012 19:58:52 -0500
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

OK, this patch set should be good to go.

Oleg, please take a look at the modifications I made to your patch,
and if you are fine with it, please ack it.

Thomas, this should be the final set (after I get an ack from Oleg)
and hopefully this one can go into -rt.

Thanks!

-- Steve

