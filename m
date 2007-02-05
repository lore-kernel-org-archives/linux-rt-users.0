From: "Sunil Naidu" <akula2.shark@gmail.com>
Subject: Re: v2.6.20-rt1, yum/rpm
Date: Mon, 5 Feb 2007 16:45:36 +0530
Message-ID: <8355959a0702050315y35eb0df9h4229d73226f064ea@mail.gmail.com>
References: <20070205065636.GA1652@elte.hu>
	 <8355959a0702050236k14aa8c98g29fdbac2c1370def@mail.gmail.com>
	 <1170672153.4672.1.camel@twins>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Ingo Molnar" <mingo@elte.hu>, linux-kernel@vger.kernel.org,
	linux-rt-users@vger.kernel.org
To: "Peter Zijlstra" <a.p.zijlstra@chello.nl>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.168]:63933 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752500AbXBELPv (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 5 Feb 2007 06:15:51 -0500
Received: by ug-out-1314.google.com with SMTP id 44so1263383uga
        for <linux-rt-users@vger.kernel.org>; Mon, 05 Feb 2007 03:15:50 -0800 (PST)
In-Reply-To: <1170672153.4672.1.camel@twins>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 2/5/07, Peter Zijlstra <a.p.zijlstra@chello.nl> wrote:
> On Mon, 2007-02-05 at 16:06 +0530, Sunil Naidu wrote:
> > On 2/5/07, Ingo Molnar <mingo@elte.hu> wrote:
> > > i have released the v2.6.20-rt1 kernel, which can be downloaded from the
> > > usual place:
> >
> > Clean boot for me with 2.6.20 & 2.6.20-rt1. There isn't any error
> > (like in 2.6.20-rc7-rt3).
> >
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
>
> Look here:
>   http://lkml.org/lkml/2007/1/24/294

Thanks for the input. I did check the URL to refer the update of the
patch by Paul:-

http://lkml.org/lkml/2007/01/15/219

I am getting error, The requested URL /lkml/2007/01/15/219. was not
found on this server.

~Akula2
