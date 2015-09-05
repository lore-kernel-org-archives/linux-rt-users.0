From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC][PATCH RT 0/3] RT: Fix trylock deadlock without msleep()
 hack
Date: Sat, 5 Sep 2015 08:27:23 -0400
Message-ID: <20150905082723.5bc11a25@gandalf.local.home>
References: <20150904011900.730816481@goodmis.org>
	<alpine.DEB.2.11.1509051217330.15006@nanos>
	<20150905081836.2967d80d@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Kacur <jkacur@redhat.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Clark Williams <clark.williams@gmail.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Ingo Molnar <mingo@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtprelay0237.hostedemail.com ([216.40.44.237]:34597 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750846AbbIEM11 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 5 Sep 2015 08:27:27 -0400
In-Reply-To: <20150905081836.2967d80d@gandalf.local.home>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Sat, 5 Sep 2015 08:18:36 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:


> I even had that solution in my slides at LinuxCon/LinuxPlumbers ;-)

Here's my slides:

http://rostedt.homelinux.com/private/linux-con-rt-into-mainline-2015.pdf

Slide 19 is where I start talking about it.

Slide 21 shows Ingo's solution.

Slide 22 shows the complex issue of dcache.c.

Would your solution work with that code?

-- Steve

> 
> 
> But then I talk about dcache.c. Take a look at that file, and the
> complexity of that. Is it safe to take the inode and dcache parent
> locks after you unlock the other locks?

