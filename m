From: Ingo Molnar <mingo@elte.hu>
Subject: Re: Poor UDP performance using 2.6.21-rc5-rt5
Date: Tue, 3 Apr 2007 10:51:32 +0200
Message-ID: <20070403085132.GA15344@elte.hu>
References: <20070402190445.GB2081@elte.hu> <001d01c77584$6a92ffe0$7901a8c0@dad>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "'dave_sperry@ieee.org'" <dasperry@comcast.net>,
	linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
To: David Sperry <dave_sperry@ieee.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx2.mail.elte.hu ([157.181.151.9]:42925 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933372AbXDCIvj (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 3 Apr 2007 04:51:39 -0400
Content-Disposition: inline
In-Reply-To: <001d01c77584$6a92ffe0$7901a8c0@dad>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


* David Sperry <dave_sperry@ieee.org> wrote:

> > there are a few other things i'm working on to improve this. I've 
> > uploaded -rt9 which is the current state of affairs. Note that using 
> > -rt9 you'll likely only see IRQ-8406 overhead in the system, because 
> > i've added an optimization to do process the softirq-net-tx workload 
> > in the hardirq thread if the priority of the two is the same (which 
> > is the default behavior). But -rt9 is still work in progress that is 
> > not fully finished yet: in some cases i'm seeing 'fluctuating 
> > performance' problems on forcedeth that werent there before.
> 
> I tried -rt9 and saw some odd 'fluctuating performance'. I'll try it 
> again tomorrow when I am much closer to the box's power button.

could you try -rt10? I've improved hardirq/softirq threading performance 
some more, and have tuned the forcedeth driver too.

	Ingo
