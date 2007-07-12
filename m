From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH -rt WIP] NMI-safe lightweight parallel-update -rt RCU
Date: Wed, 11 Jul 2007 17:30:12 -0700
Message-ID: <20070712003011.GF14550@linux.vnet.ibm.com>
References: <20070712000157.GA4168@linux.vnet.ibm.com> <20070712000937.GA1946@elte.hu>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de,
	rostedt@goodmis.org, dipankar@in.ibm.com, josht@linux.vnet.ibm.com,
	linux-rt-users@vger.kernel.org, akpm@linux-foundation.org
To: Ingo Molnar <mingo@elte.hu>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e4.ny.us.ibm.com ([32.97.182.144]:60216 "EHLO e4.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964952AbXGLAaQ (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 11 Jul 2007 20:30:16 -0400
Content-Disposition: inline
In-Reply-To: <20070712000937.GA1946@elte.hu>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Thu, Jul 12, 2007 at 02:09:37AM +0200, Ingo Molnar wrote:
> 
> * Paul E. McKenney <paulmck@linux.vnet.ibm.com> wrote:
> 
> > Hello!
> > 
> > Just work in progress, not recommended for inclusion.  Seems stable 
> > under rigorous rcutorture testing, so should be OK for 
> > experimentation.
> 
> nice stuff!
> 
> i'm wondering, could you try to do this as a splitup against -mm? I 
> think we should get people exposed to the idea of RCU_PREEMPT in the 
> upstream kernel a bit more. The netfilter folks promised some 
> preparatory enhancements to make it easier, a few months ago :)

Good point!

Besides, I might as well test out my assertion that I have made
integration with CPU hotplug easier, being as that was one of the reasons
that it got kicked out earlier this year, IIRC.  ;-)

						Thanx, Paul
