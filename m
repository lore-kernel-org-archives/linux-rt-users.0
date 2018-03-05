Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from Galois.linutronix.de ([146.0.238.70]:60218 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751723AbeCER4T (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 5 Mar 2018 12:56:19 -0500
Date: Mon, 5 Mar 2018 18:56:14 +0100
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: Merge conflict on RT 4.14 to latest stable
Message-ID: <20180305175614.nobnduk7td2rixz4@linutronix.de>
References: <abeee969-3171-da04-ab56-bb0482640e87@ti.com>
 <20180301134123.GA955@jcartwri.amer.corp.natinst.com>
 <0e822795-fa27-abb5-aec0-db27f81d703e@ti.com>
 <20180301211335.GB955@jcartwri.amer.corp.natinst.com>
 <8806abae-ac00-08ec-894b-904ebfcdb7f0@ti.com>
 <20180301215909.GD955@jcartwri.amer.corp.natinst.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180301215909.GD955@jcartwri.amer.corp.natinst.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: Julia Cartwright <julia@ni.com>
Cc: Dan Murphy <dmurphy@ti.com>, "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>

On 2018-03-01 15:59:09 [-0600], Julia Cartwright wrote:
> On Thu, Mar 01, 2018 at 03:21:48PM -0600, Dan Murphy wrote:
> > > You're off into Sebastian territory for 4.14-rt conflicts, although I'm
> > > sure he is either already aware, or will shortly be made aware when he
> > > does the merge himself.

the merge has been done v4.14.24-rt19 is out.

> > There is no consistent merge cadence like we have for the stable RT
> > tree.  As GKH points out we all need to be using the latest stable.

be ware that v4.14-RT is not exactly stable maintenance work here. I do
throw new things into it and I am glad about any testing it gets. So I
have a pile of dcache related patches which I did not want to add to the
queue yet. And we had the one or other timer related problem before the
queue hit Linus' tree.

> Now, if there are actually real users asking for a 4.14.y merge on a
> more frequent cadence, then it might be a sign we should transfer
> ownership of this branch to the rt stable team; I'm sure there is
> already an impeding conversation in this direction (maybe at ELC).

It might be good not having multiple people hacking on one branch.
However, given that v4.16 will be out "soon" I will move on.

>    Julia

Sebastian
