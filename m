From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: 3.8.10-rt6: suspend/resume irqs enabled splat
Date: Fri, 21 Jun 2013 12:49:40 +0200
Message-ID: <20130621104940.GB21228@linutronix.de>
References: <1367473433.5808.8.camel@marge.simpson.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: RT <linux-rt-users@vger.kernel.org>
To: Mike Galbraith <bitbucket@online.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:38429 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751350Ab3FUKtl (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 21 Jun 2013 06:49:41 -0400
Content-Disposition: inline
In-Reply-To: <1367473433.5808.8.camel@marge.simpson.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Mike Galbraith | 2013-05-02 07:43:53 [+0200]:

>Suspend/resume works fine on laptop, but, suspend, let it sit there a
>bit, then resume produces the gripe below.  Seems to be -rt specific,
>3.8.10 with only voluntary preempt/autogroup config delta doesn't gripe.

Could you please check if you see those on latest RT?

Sebastian
