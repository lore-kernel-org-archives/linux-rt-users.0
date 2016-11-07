From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH] rcu: update: make RCU_EXPEDITE_BOOT default
Date: Mon, 7 Nov 2016 11:04:12 -0800
Message-ID: <20161107190412.GT24166@linux.vnet.ibm.com>
References: <20161031181543.GN3716@linux.vnet.ibm.com>
 <20161102163002.igni3zdnid535nou@linutronix.de>
 <20161103162228.GG3716@linux.vnet.ibm.com>
 <20161103163326.jkjbncoz7a5oriy5@linutronix.de>
 <20161103165931.GJ3716@linux.vnet.ibm.com>
 <20161107121939.7346923f@gandalf.local.home>
 <20161107173029.caktxw4piluk5atu@linutronix.de>
 <20161107173546.t7aokzncidauio43@x>
 <20161107180513.GQ24166@linux.vnet.ibm.com>
 <20161107180831.nrwg2k7h5cghntwu@x>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Julia Cartwright <julia@ni.com>,
        Luiz Capitulino <lcapitulino@redhat.com>,
        linux-rt-users@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org
To: Josh Triplett <josh@joshtriplett.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42156 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932916AbcKGTEX (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 7 Nov 2016 14:04:23 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id uA7J4KXP008155
        for <linux-rt-users@vger.kernel.org>; Mon, 7 Nov 2016 14:04:23 -0500
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
        by mx0a-001b2d01.pphosted.com with ESMTP id 26jw5pbh4x-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-rt-users@vger.kernel.org>; Mon, 07 Nov 2016 14:04:23 -0500
Received: from localhost
        by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-rt-users@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 7 Nov 2016 12:04:16 -0700
Content-Disposition: inline
In-Reply-To: <20161107180831.nrwg2k7h5cghntwu@x>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, Nov 07, 2016 at 10:08:32AM -0800, Josh Triplett wrote:
> On Mon, Nov 07, 2016 at 10:05:13AM -0800, Paul E. McKenney wrote:
> > On Mon, Nov 07, 2016 at 09:35:46AM -0800, Josh Triplett wrote:
> > > On Mon, Nov 07, 2016 at 06:30:30PM +0100, Sebastian Andrzej Siewior wrote:
> > > > On 2016-11-07 12:19:39 [-0500], Steven Rostedt wrote:
> > > > > I agree, but if this creates a boot time regression in large machines,
> > > > > it may not be warranted.
> > > > > 
> > > > > I know Linus usually doesn't like options with default y, but this may
> > > > > be one of those exceptions. Perhaps we should make it on by default and
> > > > > say in the config "if you have a machine with 100s or 1000s of CPUs,
> > > > > you may want to disable this".
> > > > 
> > > > The default could change if we know where the limit is. I have access to
> > > > a box with approx 140 CPUs so I could check there if it is already bad.
> > > > But everything above that / in the 1000 range is a different story.
> > > 
> > > Right; if we can characterize what machines it benefits and what
> > > machines it hurts, we can automatically detect and run the appropriate
> > > case with no configuration option needed.
> > 
> > I very much like this approach!  Anyone have access to large systems on
> > which this experiment could be carried out?  In the absence of new data,
> > I would just set the cutoff at 256 CPUs, as I have done in the past.
> 
> One potential issue here: the point where RCU_EXPEDITE_BOOT pessimizes
> likely depends on interconnect as much as CPUs.  I'd guess that you may
> want to set the cutoff based on number of NUMA nodes, rather than number
> of CPUs.

Longer term, the solution would be a function that defined the cutoff
point.  If an architecture didn't define the function, they get the
default cutoff of 256.  If they do define the function, they get whatever
they coded.

							Thanx, Paul

