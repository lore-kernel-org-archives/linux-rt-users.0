Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from mga02.intel.com ([134.134.136.20]:26632 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751490AbeCETad (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 5 Mar 2018 14:30:33 -0500
From: "Hindman, Gavin" <gavin.hindman@intel.com>
Subject: RE: Merge conflict on RT 4.14 to latest stable
Date: Mon, 5 Mar 2018 19:30:31 +0000
Message-ID: <D5D6254030DBC644B6EE58B333BFBB1E9DABA270@ORSMSX101.amr.corp.intel.com>
References: <abeee969-3171-da04-ab56-bb0482640e87@ti.com>
 <20180301134123.GA955@jcartwri.amer.corp.natinst.com>
 <0e822795-fa27-abb5-aec0-db27f81d703e@ti.com>
 <20180301211335.GB955@jcartwri.amer.corp.natinst.com>
 <8806abae-ac00-08ec-894b-904ebfcdb7f0@ti.com>
 <20180301215909.GD955@jcartwri.amer.corp.natinst.com>
In-Reply-To: <20180301215909.GD955@jcartwri.amer.corp.natinst.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: Julia Cartwright <julia@ni.com>, Dan Murphy <dmurphy@ti.com>
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>

> -----Original Message-----
> From: linux-rt-users-owner@vger.kernel.org [mailto:linux-rt-users-
> owner@vger.kernel.org] On Behalf Of Julia Cartwright
> Sent: Thursday, March 01, 2018 1:59 PM
> To: Dan Murphy <dmurphy@ti.com>
> Cc: linux-rt-users@vger.kernel.org; Sebastian Andrzej Siewior
> <bigeasy@linutronix.de>
> Subject: Re: Merge conflict on RT 4.14 to latest stable
> 
> On Thu, Mar 01, 2018 at 03:21:48PM -0600, Dan Murphy wrote:
> [..]
> > >>>> We have a merge conflict in kernel/softirq.c when upgrading to
> > >>>> the latest stable release
> > >>>
> > >>> Can you elaborate on what you are merging and into where?  There
> > >>> isn't enough context here to make sense of what you are trying to do.
> > >>>
> > >>
> > >> Sorry for that.  I was attempting to merge in the current Linux
> > >> 4.14 stable tree 4.14.23 tag into the rt-devel 4.14-rt tree which
> > >> is at 4.14.20
> > >
> > > You're off into Sebastian territory for 4.14-rt conflicts, although
> > > I'm sure he is either already aware, or will shortly be made aware
> > > when he does the merge himself.
> > >
> > > I'm not sure these notifications provide anything but additional
> > > unnecessary noise.
> >
> > How else are we supposed to have this resolved by the RT maintainers?
> 
> First off: sending out an email notification like this doesn't guarantee
> anything, at all.
> 
> > There is no consistent merge cadence like we have for the stable RT
> > tree.  As GKH points out we all need to be using the latest stable.
> 
> I'm actually okay with rt-devel being behind the latest 4.14.y release; stated a
> different way: I would consider the merging of a later 4.14.y to be lower
> priority than doing more meaningful development work, like driving the rt
> patch upstream.  Considering right now Sebastian is doing both, I'm okay with
> being behind.
> 
> Now, if there are actually real users asking for a 4.14.y merge on a more
> frequent cadence, then it might be a sign we should transfer ownership of
> this branch to the rt stable team; I'm sure there is already an impeding
> conversation in this direction (maybe at ELC).
> 

>From an Intel perspective we would have high interest in a 4.14-stable, and could probably round up a maintainer for it.    I would also very much like to see the rt-devel tree more closely track mainline - right now we have the catch-22 of new platform support going into, or at least being developed against, mainline so we don't really have a path for testing new platforms with an rt-enabled kernel without either a painful backport or forward-port.   As you note, we should probably queue this up into the partner meeting in a few weeks.

>    Julia
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in the
> body of a message to majordomo@vger.kernel.org More majordomo info at
> http://vger.kernel.org/majordomo-info.html

-Gavin
