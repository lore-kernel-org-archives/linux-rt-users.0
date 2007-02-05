From: Ingo Molnar <mingo@elte.hu>
Subject: Re: v2.6.20-rt1, yum/rpm
Date: Mon, 5 Feb 2007 11:22:49 +0100
Message-ID: <20070205102249.GA16652@elte.hu>
References: <20070205065636.GA1652@elte.hu> <8355959a0702050236k14aa8c98g29fdbac2c1370def@mail.gmail.com> <1170672153.4672.1.camel@twins>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sunil Naidu <akula2.shark@gmail.com>, linux-kernel@vger.kernel.org,
	linux-rt-users@vger.kernel.org
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx2.mail.elte.hu ([157.181.151.9]:40674 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932077AbXBELQf (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 5 Feb 2007 06:16:35 -0500
Content-Disposition: inline
In-Reply-To: <1170672153.4672.1.camel@twins>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


* Peter Zijlstra <a.p.zijlstra@chello.nl> wrote:

> > But here is an interesting dmesg:
> > 
> > rcu_boost_dat: idx=1 b=0 ul=0 ub=0 boost: a=0 b=0
> > rcu_boost_dat block:    0  0  0  0?
> > rcu_boost_dat boost:    0! 0  0  0?
> > rcu_boost_dat unlock:   0? 0  0  0?
> > 
> > I didn'tunderstand this with ? Am I missing anything here or please
> > give some inputs.
> 
> That is Paul McKenney's RCU priority boosting stuff.

yeah, those messages are diagnostic. You can turn them off by disabling 
CONFIG_PREEMPT_RCU_BOOST_STATS.

	Ingo
