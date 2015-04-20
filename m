From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [GIT RFC PULL rcu/urgent] Prevent Kconfig from asking pointless
 questions
Date: Mon, 20 Apr 2015 14:21:49 -0400
Message-ID: <20150420142149.3ac58a2c@gandalf.local.home>
References: <20150416183812.GA5571@linux.vnet.ibm.com>
	<20150418130340.GA26931@gmail.com>
	<20150418133444.GD23685@linux.vnet.ibm.com>
	<20150418143238.GA2337@gmail.com>
	<20150419020541.GA5561@linux.vnet.ibm.com>
	<20150420113554.598e503f@sluggy>
	<20150420170902.GU5561@linux.vnet.ibm.com>
	<20150420180107.GE24936@home.goodmis.org>
	<20150420180904.GA19229@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	a.p.zijlstra@chello.nl, akpm@linux-foundation.org,
	linux-rt-users@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtprelay0154.hostedemail.com ([216.40.44.154]:51969 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752603AbbDTSVx (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 20 Apr 2015 14:21:53 -0400
In-Reply-To: <20150420180904.GA19229@gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, 20 Apr 2015 20:09:04 +0200
Ingo Molnar <mingo@kernel.org> wrote:


> So the disadvantage is that if a boot default is wrong, we'll hear 
> about it eventually and can fix/improve it.
> 
> If a sysctl knob is wrong, people will just 'tune' it and forget to 
> propagate it to the kernel proper (why should they).

My fear is that there is no one true value. One person complains about
it, we change it, then someone else complains about the new value. That
would be even worse.

> 
> Which is fine for something like ftrace and other ad-hoc 
> instrumentation that is generally very fine tuned to a given bug or 
> given piece of hardware, but for something like the RCU implementation 
> of the kernel - even if it's just a RT side thought of it - I'm not so 
> sure about it.

I would argue than every case is different, and only the sysadmin would
know the right value. Thus, just set it to one, and if that's not good
enough, then the sysadmins can change it to their needs.

-- Steve
