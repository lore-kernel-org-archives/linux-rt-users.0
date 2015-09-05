From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC][PATCH RT 0/3] RT: Fix trylock deadlock without msleep()
 hack
Date: Sat, 5 Sep 2015 08:26:26 -0400
Message-ID: <20150905082626.00a20902@gandalf.local.home>
References: <20150904011900.730816481@goodmis.org>
	<alpine.DEB.2.11.1509051217330.15006@nanos>
	<20150905120457.GA21338@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Kacur <jkacur@redhat.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Clark Williams <clark.williams@gmail.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
To: Ingo Molnar <mingo@kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtprelay0115.hostedemail.com ([216.40.44.115]:41608 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751442AbbIEM03 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 5 Sep 2015 08:26:29 -0400
In-Reply-To: <20150905120457.GA21338@gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Sat, 5 Sep 2015 14:04:57 +0200
Ingo Molnar <mingo@kernel.org> wrote:

 
> So why not do:
> 
> 	lock(B);
> 	if (!trylock(A)) {
> 		unlock(B);
> 		lock(A);
> 		lock(B);
> 	}
> 
> ?
> 
> Or, if this can be done, why didn't we do:
> 
> 	lock(A);
> 	lock(B);
> 
> to begin with?
> 
> i.e. I'm not sure the problem is properly specified.

Yeah, this is actually the solution I came up with before. I misread
what Thomas wrote. His is slightly different.

-- Steve
