From: "Luis Claudio R. Goncalves" <lclaudio@uudg.org>
Subject: Re: [PATCH] rcutorture: fix missing function at build time
Date: Mon, 2 Mar 2015 18:20:53 -0300
Message-ID: <20150302212053.GB4189@uudg.org>
References: <20150302201530.GA4189@uudg.org>
 <20150302211815.GY15405@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-rt-users@vger.kernel.org
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-qg0-f44.google.com ([209.85.192.44]:40853 "EHLO
	mail-qg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932113AbbCBVU5 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 2 Mar 2015 16:20:57 -0500
Received: by mail-qg0-f44.google.com with SMTP id z107so7372623qgd.3
        for <linux-rt-users@vger.kernel.org>; Mon, 02 Mar 2015 13:20:56 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20150302211815.GY15405@linux.vnet.ibm.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, Mar 02, 2015 at 01:18:15PM -0800, Paul E. McKenney wrote:
...
| > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
| > index a4e9e25..28a54f6 100644
| > --- a/kernel/rcu/tree.c
| > +++ b/kernel/rcu/tree.c
| > @@ -378,6 +378,11 @@ void rcu_bh_force_quiescent_state(void)
| >  	force_quiescent_state(&rcu_bh_state);
| >  }
| >  EXPORT_SYMBOL_GPL(rcu_bh_force_quiescent_state);
| > +#else
| > +void rcu_force_quiescent_state(void)
| > +{
| > +}
| > +EXPORT_SYMBOL_GPL(rcu_force_quiescent_state);
| 
| This is -rt only, correct?

Yes, -rt only. And the only complaint I saw was from rcutorture.

Luis
