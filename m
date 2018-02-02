From: Julia Cartwright <julia@ni.com>
Subject: Re: Linux stable vs RT stable and RT dev
Date: Fri, 2 Feb 2018 15:46:11 -0600
Message-ID: <20180202214611.GD868@jcartwri.amer.corp.natinst.com>
References: <8155aea247374c058bd7c797124c3d28@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
        "Murphy, Dan" <dmurphy@ti.com>, "Nori, Sekhar" <nsekhar@ti.com>,
        <rostedt@goodmis.org>
To: "Mills, William" <wmills@ti.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx0a-00010702.pphosted.com ([148.163.156.75]:36990 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751880AbeBBVqS (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 2 Feb 2018 16:46:18 -0500
Content-Disposition: inline
In-Reply-To: <8155aea247374c058bd7c797124c3d28@ti.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, Feb 02, 2018 at 07:00:12PM +0000, Mills, William wrote:
> Hello,

Hey Bill-

> I am trying to understand the policy WRT the RT stable branches and
> the Linux stable releases.  It appears not every Linux stable gets its
> own RT stable. [1]

I'm assuming you mean not every Linux stable release gets it's own
stable-rt release, correct?  If so, then you're correct.  Some times
I'll jump a few upstream stable versions if it's been awhile since I did
an upstream merge.

The only guarantee is that the merged upstream stable release is
monotonically increasing.

You can consider a stable-rt release to be a synchronization point
between the upstream stable release process and the rt-devel process.

> What is the goal?
> 	Not getting behind by more than X weeks?
> 	Only change when RT series needs to be updated?

In an ideal world, we could turn around a stable-rt release ontop of an
upstream stable release in the time it takes to test it.  However, we're
not in an ideal world, and merging in an upstream stable release can
and does cause rt-specific regressions.

That being said, we do have a goal to be releasing a new stable-rt
release within a month of an upstream stable release -OR- an rt-devel
tree release with stable-targeted fixes.

> What is the expected consumer model?:
> 	Use only the version published by the maintainer
> 	Merge in upstream point release themselves between rt-stable releases

It's expected that a consumer use the version released by the
maintainer.

Obviously, you're in control of your own destiny here, though.  One
option for you would be to merge in an upstream point release for
testing, then once a maintainer has released a new version, compare the
two.

> How is the policy different for rt-dev vs rt-stable?

I'm not sure it is.

> Long version / background
> -----------------------------------------------------------------------------------
> TI publishes 3 variants of our kernel for customers:
> 	Base + TI + [Linaro LSK]
> 	Base + TI + RT
> 	Base + TI + Android Common
>
> All this is based on the latest GKH LTS and there is maintenance of last years LTS
>
> (Yes we understand this is all very simple if the TI set is nil.  We
> have never achieved that to date.  In the very least it is backports
> from tip to latest LTS.  In reality it is more.)
>
> Right now Base above is always the very latest stable from GKH LTS.
> It is auto merged as soon as it is published and picked up by our
> nightly builds.   Any merge conflict in any of the variants stops auto
> merge progress.
>
> In this structure we tend to be the first to merge RT with a new
> stable.  Most of the time this is OK but sometimes it is not.

Yes, obviously there are many way things can fail that wouldn't trigger
a textual merge conflict.  It's the responsibility of the maintainer to
try to catch these things, or resolve them once they've been found.

What I would like to understand is how you are testing these automerged
branches.

   Julia
