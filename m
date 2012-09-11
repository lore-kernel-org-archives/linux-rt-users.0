From: Mike Galbraith <efault@gmx.de>
Subject: Re: Question regarding 'sched: RT throttling activated'
Date: Tue, 11 Sep 2012 15:20:17 +0200
Message-ID: <1347369617.20252.41.camel@marge.simpson.net>
References: <OFB52301AB.00D27859-ONC1257A76.003FE866-C1257A76.003FE86C@br-automation.com>
	 <alpine.LFD.2.02.1209111401450.5585@tycho>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Wolfgang Wallner <Wolfgang.Wallner@br-automation.com>,
	linux-rt-users@vger.kernel.org,
	Josef Baumgartner <Josef.Baumgartner@br-automation.com>
To: John Kacur <jkacur@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mailout-de.gmx.net ([213.165.64.22]:45860 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754149Ab2IKNUW (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 11 Sep 2012 09:20:22 -0400
In-Reply-To: <alpine.LFD.2.02.1209111401450.5585@tycho>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, 2012-09-11 at 14:10 +0200, John Kacur wrote:
> 
> On Tue, 11 Sep 2012, Wolfgang Wallner wrote:
> 
> > Hello all,
> > 
> > I have a few questions about the logging entry "sched: RT throttling
> activated" which I observe, and hope this is the correct place to
> ask :)
> > I will start by describing how i come to see this logging entry:
> > 
> > I use an industrial PC with an 2.6.33 RT PREEMP kernel...

BTW, there have been a few throttle fixes since then that you'll likely
want to backport.  I don't have a list handy, but they're easy to find
with git.

-Mike

