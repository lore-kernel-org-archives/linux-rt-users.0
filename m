From: Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: v2.6.20-rt1, yum/rpm
Date: Mon, 05 Feb 2007 11:42:33 +0100
Message-ID: <1170672153.4672.1.camel@twins>
References: <20070205065636.GA1652@elte.hu>
	 <8355959a0702050236k14aa8c98g29fdbac2c1370def@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
	linux-rt-users@vger.kernel.org
To: Sunil Naidu <akula2.shark@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from amsfep17-int.chello.nl ([213.46.243.15]:28037 "EHLO
	amsfep13-int.chello.nl" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751460AbXBEKqy (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 5 Feb 2007 05:46:54 -0500
In-Reply-To: <8355959a0702050236k14aa8c98g29fdbac2c1370def@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Mon, 2007-02-05 at 16:06 +0530, Sunil Naidu wrote:
> On 2/5/07, Ingo Molnar <mingo@elte.hu> wrote:
> > i have released the v2.6.20-rt1 kernel, which can be downloaded from the
> > usual place:
> 
> Clean boot for me with 2.6.20 & 2.6.20-rt1. There isn't any error
> (like in 2.6.20-rc7-rt3).
> 
> But here is an interesting dmesg:
> 
> rcu_boost_dat: idx=1 b=0 ul=0 ub=0 boost: a=0 b=0
> rcu_boost_dat block:    0  0  0  0?
> rcu_boost_dat boost:    0! 0  0  0?
> rcu_boost_dat unlock:   0? 0  0  0?
> 
> I didn'tunderstand this with ? Am I missing anything here or please
> give some inputs.

That is Paul McKenney's RCU priority boosting stuff.

Look here:
  http://lkml.org/lkml/2007/1/24/294
