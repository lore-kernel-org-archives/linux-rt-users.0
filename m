From: Daniel Walker <dwalker@mvista.com>
Subject: Re: fully bisectable real time series
Date: Mon, 07 Apr 2008 17:57:24 -0700
Message-ID: <1207616244.21308.174.camel@localhost.localdomain>
References: <1207611243.21308.167.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0804072027080.7121@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	mingo@elte.hu
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.158]:60851 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753699AbYDHA50 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 7 Apr 2008 20:57:26 -0400
In-Reply-To: <Pine.LNX.4.58.0804072027080.7121@gandalf.stny.rr.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


On Mon, 2008-04-07 at 20:33 -0400, Steven Rostedt wrote:
> On Mon, 7 Apr 2008, Daniel Walker wrote:
> 
> >
> > I've re-worked the -rt series, and some of the core patches to make it
> > all bisectable. I've done bisect updates in the past which really only
> > scratched the surface.
> >
> 
> Daniel,
> 
> Thanks, for doing this. I'll try to look at it when I get a chance. If you
> can make a bisectable series that still gives a byte for byte identical
> kernel with a make allyesconfig, I'll incorporate it.

I haven't actually tested if it's byte for byte identical, I can or you
can review it an decide what you think of it.. The executable code parts
should be identical. I just moved patches around, patch split-ups, did
name changes, and added macros ..

Daniel

