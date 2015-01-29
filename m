From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: kernel-rt rcuc lock contention problem
Date: Thu, 29 Jan 2015 12:06:44 -0500
Message-ID: <20150129120644.1d052e16@gandalf.local.home>
References: <20150126141403.469dc92f@redhat.com>
	<20150127203752.GD19109@linux.vnet.ibm.com>
	<20150128015508.GA12233@amt.cnet>
	<20150128180335.GR19109@linux.vnet.ibm.com>
	<20150128182512.GB1259@amt.cnet>
	<20150128185552.GT19109@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Marcelo Tosatti <mtosatti@redhat.com>,
	Luiz Capitulino <lcapitulino@redhat.com>,
	linux-rt-users@vger.kernel.org
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtprelay0009.hostedemail.com ([216.40.44.9]:48382 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755347AbbA2RGs (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 29 Jan 2015 12:06:48 -0500
In-Reply-To: <20150128185552.GT19109@linux.vnet.ibm.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, 28 Jan 2015 10:55:53 -0800
"Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:

> Then your only hope is to prevent the host (and other guests) from
> preempting the real-time guest.

Right!

I think there's a miscommunication here.

Basically what is needed is to run the RT guest on a CPU by itself. We
can all agree on that. That guest runs at a high priority where nothing
should preempt it. We should enable NO_HZ_FULL, and move as much off of
that CPU as possible (including rcu callbacks).

I'm not sure if the code does this or not, but I believe it does. When
we enter the guest, the host should be in an RCU quiescent state, where
RCU will ignore the CPU that is running the guest. Remember, we are only
talking about interactions of the host, not the workings of the guest.

Once this isolation happens, then the guest should be running in a
state that it could handle RT reaction times for its own processes (if
the guest OS supports it). The guest shouldn't be preempted by anything
unless it does something that requires a service (interacting with the
network or other baremetal device), then it will need to do the same
things that any RT task must do.

I think all this is feasible.

-- Steve
