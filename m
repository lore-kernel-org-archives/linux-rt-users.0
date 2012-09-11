From: Mike Galbraith <efault@gmx.de>
Subject: Re: Question regarding 'sched: RT throttling activated'
Date: Tue, 11 Sep 2012 20:10:29 +0200
Message-ID: <1347387029.7018.53.camel@marge.simpson.net>
References: <OF6683632B.9200AAEB-ONC1257A76.0053E7B9-C1257A76.00558786@br-automation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org, John Kacur <jkacur@redhat.com>,
	Josef Baumgartner <Josef.Baumgartner@br-automation.com>
To: Wolfgang Wallner <Wolfgang.Wallner@br-automation.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mailout-de.gmx.net ([213.165.64.23]:42408 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1757729Ab2IKSKf (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 11 Sep 2012 14:10:35 -0400
In-Reply-To: <OF6683632B.9200AAEB-ONC1257A76.0053E7B9-C1257A76.00558786@br-automation.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, 2012-09-11 at 17:34 +0200, Wolfgang Wallner wrote:

> >> My questions are now:
> >> 
> >> * What does this logging entry mean?
> >> Could you please point me to some information about RT throttling
> >> so that I can understand what's it about?
> 
> > With stock settings, it means realtime task[s] consumed > 95% of the
> > throttle interval (1s), so the throttle activated, allowing
> SCHED_NORMAL
> > tasks to have a sip of CPU, to let you try to save the box from
> nutty RT
> > CPU hogs. See kernel/sched_rt.c.
> 
> I think if the application turns into a cpu hog...

Where from comes 'if'?  You presented evidence, so methinks there's not
a _lot_ of room for an 'if', there's just a missing 'why'.

-Mike

