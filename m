From: Julia Cartwright <julia@ni.com>
Subject: Re: Changing checksums of RT patches
Date: Fri, 10 Mar 2017 20:27:51 -0600
Message-ID: <20170311022751.GE32162@jcartwri.amer.corp.natinst.com>
References: <12e5d51b-8589-d9ba-90cd-d00688e8602d@gmx.de>
 <20170210185433.h35nynmmeu5toml6@linutronix.de>
 <812bef1a-a86e-15b6-b77c-6455832c8790@gmx.de>
 <548e1359-5539-4a7c-e9ca-44817ffa69b6@gmx.de>
 <20170214091829.12273157@gandalf.local.home>
 <ea5ff7b5-77d2-754d-b7c2-6c9f9c3d7b90@gmx.de>
 <20170214135738.366f21e5@gandalf.local.home>
 <alpine.DEB.2.20.1702281856310.4732@nanos>
 <067fe46c-dd9f-6bb4-36d5-4ceccfee2f88@gmx.de>
 <20170310181947.3f9cde20@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Cc: Dominic Sacr? <dominic.sacre@gmx.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        <linux-rt-users@vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx0a-00010702.pphosted.com ([148.163.156.75]:42778 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1755463AbdCKC2L (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 10 Mar 2017 21:28:11 -0500
Content-Disposition: inline
In-Reply-To: <20170310181947.3f9cde20@gandalf.local.home>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, Mar 10, 2017 at 06:19:47PM -0500, Steven Rostedt wrote:
> On Sat, 11 Mar 2017 00:13:25 +0100
> Dominic Sacré <dominic.sacre@gmx.de> wrote:
> 
> > Hi all,
> > 
> > I'm sorry to bring this up again, but it looks like
> > 4.1/older/patch-4.1.38-rt45.patch.gz changed when -rt46 was released, so
> > the Bitbake recipes that use this patch are now broken again.
> 
> Note, Julia just took over for 4.1-rt maintainership, so there is going
> to be some expected hiccups along the way until she is fully up to
> speed. Please have patience during this time.

*sigh*.  I was setup to fail here, wasn't I? :).  I even recalled this
thread, but thought "surely if I do the most obvious thing, I won't run
into problems!".

[..]
> > IMHO it's bad practice for files to change once they've been released
> > (with a version number and everything), even if the contents remain the
> > same. The sha256-based approach seems to be working for thousands of
> > projects in OpenEmbedded; I don't see any particular reason for patches
> > on kernel.org to be any different.
> > 
> > By the way, the 4.1.38-rt46 release is currently still missing from the
> > "older" directory.
> 
> Julia,
> 
> Just an FYI, especially if you are using my older scripts (I haven't
> updated the ones I posted). I was asked when I do my upload of a new
> version to copy to both the main and older directory. But my scripts
> still moved the main to the older one when a new release went out. This
> caused the checksums of the created .gz to change in the older
> directory.
>
> What I do now is to still upload to both main and older, but when I
> have a new release, I simply delete the main one, as the older one
> already exists.

Okay, sounds simple enough.  I've uploaded both the patch and series
tarball to older/, which should now remain unchanged.

I'd still like to understand why kernel.org decides to re-compress when
the simply moving patches around...

Thanks,

   Julia
