From: Mike Galbraith <bitbucket@online.de>
Subject: Re: 3.8.10-rt6: suspend/resume irqs enabled splat
Date: Fri, 21 Jun 2013 14:59:40 +0200
Message-ID: <1371819580.5992.2.camel@marge.simpson.net>
References: <1367473433.5808.8.camel@marge.simpson.net>
	 <20130621104940.GB21228@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: RT <linux-rt-users@vger.kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:53995 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422675Ab3FUM7p (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 21 Jun 2013 08:59:45 -0400
In-Reply-To: <20130621104940.GB21228@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, 2013-06-21 at 12:49 +0200, Sebastian Andrzej Siewior wrote: 
> * Mike Galbraith | 2013-05-02 07:43:53 [+0200]:
> 
> >Suspend/resume works fine on laptop, but, suspend, let it sit there a
> >bit, then resume produces the gripe below.  Seems to be -rt specific,
> >3.8.10 with only voluntary preempt/autogroup config delta doesn't gripe.
> 
> Could you please check if you see those on latest RT?

Yup, during boot.

-Mike

