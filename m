From: "Peter W. Morreale" <pmorreale@novell.com>
Subject: Re: preempt-rt, need old style rwlocks for systemtap
Date: Sat, 03 May 2008 16:05:07 -0600
Message-ID: <1209852307.5433.5.camel@hermosa.morrealenet>
References: <20080503132327.GA28881@redhat.com>
	 <481C77E8.8050002@redhat.com>  <20080503171627.GC23961@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
	linux-rt-users@vger.kernel.org
To: "Frank Ch. Eigler" <fche@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from victor.provo.novell.com ([137.65.250.26]:51309 "EHLO
	victor.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754315AbYECWFX (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 3 May 2008 18:05:23 -0400
In-Reply-To: <20080503171627.GC23961@redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Sat, 2008-05-03 at 13:16 -0400, Frank Ch. Eigler wrote:
> Hi -
> 
> On Sat, May 03, 2008 at 09:34:16AM -0500, Clark Williams wrote:
> > [...]
> > > It has come to my attention that the preempt-rt patch suite
> > > deliberately defeats the potential concurrency intended by systemtap's
> > > use of rwlocks to permit concurrent readers [...]
> 
> > The reason it "defeats" the concurrent behavior is that it's really
> > complicated to have concurrent readers with Priority Inheritance, so
> > the initial cut of rtmutexes serialized all lock accesses. [...]
> 
> Do you believe priority inheritance to be an essential property of
> every use of these primitives, regardless of the nature of the
> specifical critical sections being protected?  Is there no way & need
> to opt out of the extra machinery?
> 
> - FChE

Yes, for (at least) two reasons. And No.

Without PI the best case is indeterminate latencies.  The worst case is
deadlock.  Please read Steven's excellent description of the issues in
the Documentation directory of a kernel tree.   


Best,
-PWM


> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

