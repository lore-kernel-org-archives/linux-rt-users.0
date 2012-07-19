From: Mike Galbraith <efault@gmx.de>
Subject: Re: [PATCH RT 00/12] [ANNOUNCE] 3.0.36-rt58-rc1 stable review
Date: Thu, 19 Jul 2012 15:51:39 +0200
Message-ID: <1342705899.7342.42.camel@marge.simpson.net>
References: <20120718223910.898476857@goodmis.org>
	 <1342670426.7342.8.camel@marge.simpson.net>
	 <1342703141.12353.24.camel@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>, John Kacur <jkacur@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mailout-de.gmx.net ([213.165.64.22]:54911 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750942Ab2GSNvo (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 19 Jul 2012 09:51:44 -0400
In-Reply-To: <1342703141.12353.24.camel@gandalf.stny.rr.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, 2012-07-19 at 09:05 -0400, Steven Rostedt wrote: 
> On Thu, 2012-07-19 at 06:00 +0200, Mike Galbraith wrote:
> > On Wed, 2012-07-18 at 18:39 -0400, Steven Rostedt wrote:
> > 
> > > Please test the patches too.
> > 
> > Your hotplug stress test script made x3550 M3 box fall over.  It took a
> > bit, but down she went.  64 core test box fell over quickly, but that's
> > very far from virgin source.. seems to be the same though.
> 
> Thanks for the report. I know a few areas in the hotplug code that can
> still deadlock (but are hard to hit). But there's no easy fix for them.
> Basically, the only thing we can do is redesign cpu hotplug (I think
> someone is already trying to do that ;-).

Every kernel I've fed you script to has died sooner or later, so I wish
him fair sailing.  Here there be sea monsters ;-)

-Mike

