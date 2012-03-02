From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RT 7/9][RFC] [PATCH 7/9] cpu/rt: Rework cpu down for
 PREEMPT_RT
Date: Fri, 02 Mar 2012 10:15:23 -0500
Message-ID: <1330701323.25686.260.camel@gandalf.stny.rr.com>
References: <20120301185527.064629423@goodmis.org>
	 <20120301190346.172835662@goodmis.org>
	 <alpine.LFD.2.02.1203021518501.2742@ionos>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Carsten Emde <C.Emde@osadl.org>,
	John Kacur <jkacur@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Clark Williams <clark.williams@gmail.com>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:16521 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758411Ab2CBPPZ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 2 Mar 2012 10:15:25 -0500
In-Reply-To: <alpine.LFD.2.02.1203021518501.2742@ionos>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, 2012-03-02 at 15:52 +0100, Thomas Gleixner wrote:

> So no, I rather keep the current problem than applying that insanity.

Note, patches 1,2,3,5 and 6, were bugs I found while debugging hotplug.
Please add them, they are not insanity fixes but real bug fixes.

And can you mark them as stable-rt fixes too.

Thanks,

-- Steve


