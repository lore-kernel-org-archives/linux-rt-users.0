From: John Kacur <jkacur@redhat.com>
Subject: Re: beagleboard RT problem
Date: Mon, 14 Jun 2010 13:05:12 +0200 (CEST)
Message-ID: <alpine.LFD.2.00.1006141301100.26248@localhost.localdomain>
References: <AANLkTik4gFjREMEwYqCyg24o6veBaEEa1oiEIkZl50kr@mail.gmail.com> <AANLkTikWXBR-ZmsdMrPI3KyAgLV2G1yvuQrAYp07KFCN@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Maksym Parkachov <lazy.gopher@gmail.com>,
	linux-rt-users@vger.kernel.org
To: Sujit K M <sjt.kar@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:11772 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756036Ab0FNLFS (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 14 Jun 2010 07:05:18 -0400
In-Reply-To: <AANLkTikWXBR-ZmsdMrPI3KyAgLV2G1yvuQrAYp07KFCN@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



On Mon, 14 Jun 2010, Sujit K M wrote:

> > CONFIG_PREEMPT_RCU=y
> > # CONFIG_PREEMPT_RCU_TRACE is not set
> 
> Why is RCU being set to y?

It should be fine to set it to y

> 
> > # CONFIG_PREEMPT_NONE is not set
> > # CONFIG_PREEMPT_VOLUNTARY is not set
> > # CONFIG_PREEMPT_DESKTOP is not set
> 
> Fine.
> 
> > CONFIG_PREEMPT_RT=y
> 
> This is correct.
> 
> > CONFIG_PREEMPT=y
> > CONFIG_PREEMPT_SOFTIRQS=y
> > CONFIG_PREEMPT_HARDIRQS=y
> 
> I think this part is susceptible.

Suceptible to what?
Those setting are all correct.
In fact, most are automatically set for you  after
choosing CONFIG_PREEMPT_RT=y

His problem is not with the config.
