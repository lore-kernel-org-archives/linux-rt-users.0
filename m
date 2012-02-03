From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 0/2 v4] preempt-rt/x86: Handle sending signals from do_trap() by gdb
Date: Fri, 03 Feb 2012 13:28:53 -0500
Message-ID: <20120203182853.547078531@goodmis.org>
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
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.123]:63422 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752612Ab2BCSan (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 3 Feb 2012 13:30:43 -0500
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Thomas,

Can you apply these to v3.2-rt.

Version 4:
 In testing, Clark Williams triggered a bug in the paranoid_exit return
 path. The %rcx register was being clobbered by a function call and
 needed to be restored with: GET_THREAD_INFO(%rcx)

This version has been tested and so far has triggered no bugs.

-- Steve

