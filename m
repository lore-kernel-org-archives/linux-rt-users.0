From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: RCU splat on boot from an idle CPU
Date: Fri, 11 Dec 2015 08:53:26 -0800
Message-ID: <20151211165326.GO28602@linux.vnet.ibm.com>
References: <CA+0CQ216LKjL4-PVeqW3vwZhvFLhRJ2GuTOfVsEvxtoZ=xoVgQ@mail.gmail.com>
 <alpine.DEB.2.11.1509011721510.15006@nanos>
 <20150902153823.749a9f73@gandalf.local.home>
 <CA+0CQ20mdGqWn6+rsA+Q6LWiDotXW=GUj-xmWBKcCrvHC=Z_vA@mail.gmail.com>
 <20150902230729.GZ4029@linux.vnet.ibm.com>
 <20150903165411.GA25462@philipp-debian.peloton-tech.com>
 <20151211163252.GE6720@linutronix.de>
 <CA+0CQ22gEUOzLqwLiLLBD=S-d_bVhEbz4UnbS=7udUttFhExxQ@mail.gmail.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-rt-users@vger.kernel.org
To: Philipp Schrader <philipp@peloton-tech.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e33.co.us.ibm.com ([32.97.110.151]:48328 "EHLO
	e33.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752276AbbLKQxZ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 11 Dec 2015 11:53:25 -0500
Received: from localhost
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-rt-users@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
	Fri, 11 Dec 2015 09:53:25 -0700
Received: from b03cxnp08028.gho.boulder.ibm.com (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
	by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 972D71FF0042
	for <linux-rt-users@vger.kernel.org>; Fri, 11 Dec 2015 09:41:34 -0700 (MST)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
	by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id tBBGrNaZ29294658
	for <linux-rt-users@vger.kernel.org>; Fri, 11 Dec 2015 09:53:23 -0700
Received: from d03av05.boulder.ibm.com (localhost [127.0.0.1])
	by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id tBBGrMYG006185
	for <linux-rt-users@vger.kernel.org>; Fri, 11 Dec 2015 09:53:23 -0700
Content-Disposition: inline
In-Reply-To: <CA+0CQ22gEUOzLqwLiLLBD=S-d_bVhEbz4UnbS=7udUttFhExxQ@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, Dec 11, 2015 at 08:46:13AM -0800, Philipp Schrader wrote:
> On Fri, Dec 11, 2015 at 8:32 AM, Sebastian Andrzej Siewior
> <bigeasy@linutronix.de> wrote:
> > Did someone in the meantime sent a patch? It does not look so.
> > If this patch gets re-sent witch a changelog and gets acked by Paul/Steven I
> > don't see a problem why I should not include it.
> >
> > Sebastian
> 
> I sent out a patch here:
> http://lkml.iu.edu/hypermail/linux/kernel/1509.0/02788.html
> Though I never received a response.

I replied with "Looks good to me!"

> Shall I re-send it?

If Steven is OK with the patch, you can use:

Acked-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>

							Thanx, Paul

