From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH] rcutorture: fix missing function at build time
Date: Mon, 2 Mar 2015 13:30:19 -0800
Message-ID: <20150302213019.GZ15405@linux.vnet.ibm.com>
References: <20150302201530.GA4189@uudg.org>
 <20150302211815.GY15405@linux.vnet.ibm.com>
 <20150302212053.GB4189@uudg.org>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-rt-users@vger.kernel.org
To: "Luis Claudio R. Goncalves" <lclaudio@uudg.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e39.co.us.ibm.com ([32.97.110.160]:37308 "EHLO
	e39.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755904AbbCBVaY (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 2 Mar 2015 16:30:24 -0500
Received: from /spool/local
	by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-rt-users@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
	Mon, 2 Mar 2015 14:30:24 -0700
Received: from b03cxnp08026.gho.boulder.ibm.com (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
	by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 788E819D803E
	for <linux-rt-users@vger.kernel.org>; Mon,  2 Mar 2015 14:21:29 -0700 (MST)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
	by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t22LUZVk41025748
	for <linux-rt-users@vger.kernel.org>; Mon, 2 Mar 2015 14:30:35 -0700
Received: from d03av05.boulder.ibm.com (localhost [127.0.0.1])
	by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t22LUKSE008020
	for <linux-rt-users@vger.kernel.org>; Mon, 2 Mar 2015 14:30:21 -0700
Content-Disposition: inline
In-Reply-To: <20150302212053.GB4189@uudg.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, Mar 02, 2015 at 06:20:53PM -0300, Luis Claudio R. Goncalves wrote:
> On Mon, Mar 02, 2015 at 01:18:15PM -0800, Paul E. McKenney wrote:
> ...
> | > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> | > index a4e9e25..28a54f6 100644
> | > --- a/kernel/rcu/tree.c
> | > +++ b/kernel/rcu/tree.c
> | > @@ -378,6 +378,11 @@ void rcu_bh_force_quiescent_state(void)
> | >  	force_quiescent_state(&rcu_bh_state);
> | >  }
> | >  EXPORT_SYMBOL_GPL(rcu_bh_force_quiescent_state);
> | > +#else
> | > +void rcu_force_quiescent_state(void)
> | > +{
> | > +}
> | > +EXPORT_SYMBOL_GPL(rcu_force_quiescent_state);
> | 
> | This is -rt only, correct?
> 
> Yes, -rt only. And the only complaint I saw was from rcutorture.

Agreed, nothing other than rcutorture should use these.  Just thinking
out loud about what (if anything) should happen in mainline.

							Thanx, Paul

