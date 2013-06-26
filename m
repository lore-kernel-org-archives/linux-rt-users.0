From: Steven Rostedt <rostedt@goodmis.org>
Subject: [RFC][PATCH RT 0/6] rt: Updates to handle some 3.10 changes
Date: Wed, 26 Jun 2013 15:28:06 -0400
Message-ID: <20130626192806.107564905@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clark.williams@gmail.com>,
	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:15705 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752479Ab3FZTav (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 26 Jun 2013 15:30:51 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

I've been playing around with a 3.10 -rt queue that Clark Williams has
been trying to put together. I got it to boot and ran a stress test that
does a hackbench and compile over and over again.

I have lockdep compiled in too, and haven't seen any bugs or lockdep splats.

Here's the changes I did to that.

Comments?

-- Steve

