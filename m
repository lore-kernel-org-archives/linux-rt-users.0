From: Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [RT] [PATCH] Make scheduler root_domain modular
	(sched_classspecific)
Date: Sun, 23 Mar 2008 12:53:04 +0100
Message-ID: <1206273184.6437.106.camel@lappy>
References: <20080322142915.GA9478@in.ibm.com>
	 <47E511D4.BA47.005A.0@novell.com> <20080323090215.GA8082@in.ibm.com>
	 <1206271627.6437.100.camel@lappy>  <20080323113738.GB8082@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Gregory Haskins <ghaskins@novell.com>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Ingo Molnar <mingo@elte.hu>,
	Steven Rostedt <rostedt@goodmis.org>,
	LKML <linux-kernel@vger.kernel.org>
To: Ankita Garg <ankita@in.ibm.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from pentafluge.infradead.org ([213.146.154.40]:41869 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754483AbYCWLxg (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 23 Mar 2008 07:53:36 -0400
In-Reply-To: <20080323113738.GB8082@in.ibm.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Sun, 2008-03-23 at 17:07 +0530, Ankita Garg wrote:
> Hi Peter,
> 
> On Sun, Mar 23, 2008 at 12:27:07PM +0100, Peter Zijlstra wrote:
> > On Sun, 2008-03-23 at 14:32 +0530, Ankita Garg wrote:
> > > Hi Gregory,
> > > 
> > > On Sat, Mar 22, 2008 at 12:04:04PM -0600, Gregory Haskins wrote:
> > > > >>> On Sat, Mar 22, 2008 at 10:29 AM, in message
> > > > <20080322142915.GA9478@in.ibm.com>, Ankita Garg <ankita@in.ibm.com> wrote: 
> > > > > Hello,
> > > > > 
> > > > > Thanks Gregory for clarifying my question on root_domains infrastructure. 
> > > > > What
> > > > > I was effectively mentioning on irc the other day was to make the 
> > > > > root_domain
> > > > > infrastructure modular, ie sched_class specific. Currently, only rt is 
> > > > > making
> > > > > use of this infrasture. Making it modular would enable ease of extension to
> > > > > other sched_classes if required. Trivial patch to that effect.
> > > > > 
> > > > > Patch compile and boot tested.
> > > > 
> > > > Hi Ankita,
> > > >   Very nice, thanks!  Couple of minor nits and further cleanup opportunities inline, but otherwise:
> > > >
> > > > Acked-by: Gregory Haskins <ghaskins@novell.com>
> > > > 
> > > > > 
> > > The changes you have suggested are consistent with what we do for rt_rq
> > > and cfs_rq. Here is the patch with these modifications.
> > 
> > As this patch doesn't touch -rt specific code you should have provided a
> > patch against the upstream code in sched-devel/latest.
> >
> 
> The cpupri bits have not been added to the sched-devel tree yet. This
> patch involves linking to the cpupri from the rt_root_domain. Thus  the
> patch against the latest RT tree. Pl let me know if I understand it
> incorrectly.

The root_domain code is upstream and not -rt specific, that -rt carries
a patch that touches this code is perhaps unfortunate.

We strive to keep the -rt patch as small as possible, that means push
stuff upstream whenever possible. As your patch doesn't change anything
specific to -rt, upstream is the right place to restructure the
root_domain code. Next time the -rt tree gets fwd ported the cpupri bits
will be made to match.



