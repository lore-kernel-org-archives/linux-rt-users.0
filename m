From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: Changing checksums of RT patches
Date: Fri, 10 Mar 2017 18:19:47 -0500
Message-ID: <20170310181947.3f9cde20@gandalf.local.home>
References: <12e5d51b-8589-d9ba-90cd-d00688e8602d@gmx.de>
        <20170210185433.h35nynmmeu5toml6@linutronix.de>
        <812bef1a-a86e-15b6-b77c-6455832c8790@gmx.de>
        <548e1359-5539-4a7c-e9ca-44817ffa69b6@gmx.de>
        <20170214091829.12273157@gandalf.local.home>
        <ea5ff7b5-77d2-754d-b7c2-6c9f9c3d7b90@gmx.de>
        <20170214135738.366f21e5@gandalf.local.home>
        <alpine.DEB.2.20.1702281856310.4732@nanos>
        <067fe46c-dd9f-6bb4-36d5-4ceccfee2f88@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-rt-users@vger.kernel.org, Julia Cartwright <julia@ni.com>
To: Dominic =?UTF-8?B?U2FjcsOp?= <dominic.sacre@gmx.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:50930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932705AbdCJXTx (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 10 Mar 2017 18:19:53 -0500
In-Reply-To: <067fe46c-dd9f-6bb4-36d5-4ceccfee2f88@gmx.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Sat, 11 Mar 2017 00:13:25 +0100
Dominic Sacré <dominic.sacre@gmx.de> wrote:

> Hi all,
> 
> I'm sorry to bring this up again, but it looks like
> 4.1/older/patch-4.1.38-rt45.patch.gz changed when -rt46 was released, so
> the Bitbake recipes that use this patch are now broken again.

Note, Julia just took over for 4.1-rt maintainership, so there is going
to be some expected hiccups along the way until she is fully up to
speed. Please have patience during this time.

> 
> On 2017-02-28 19:03, Thomas Gleixner wrote:
> > What matters is the content and not the compressed thingy. Again:
> > 
> >  - The sha256 only tells you that the download was not corrupted.
> > 
> >  - The PGP signature is what protects the content and that does not change
> >    whether you move it or upload the same thing again.  
> 
> I don't disagree, but there's currently no support for verifying
> downloads by PGP signature in Bitbake; sha256 is the best we've got.
> 
> Besides, we're talking about a system for automated builds here.
> I would argue that verifying the authenticity of files (e.g. using PGP
> signatures) is the responsibility of the person writing the Bitbake recipe.
> For those who then use that recipe to build the software, all that
> matters is that the download is not corrupted, and that the file being
> downloaded is actually the same one that was used by the author of the
> recipe.
> 
> Of course, it really is the content that matters. But working with
> sha256 checksums of the compressed files simplifies both the build
> system, and, perhaps more importantly, the process of writing recipes.
> 
> IMHO it's bad practice for files to change once they've been released
> (with a version number and everything), even if the contents remain the
> same. The sha256-based approach seems to be working for thousands of
> projects in OpenEmbedded; I don't see any particular reason for patches
> on kernel.org to be any different.
> 
> By the way, the 4.1.38-rt46 release is currently still missing from the
> "older" directory.

Julia,

Just an FYI, especially if you are using my older scripts (I haven't
updated the ones I posted). I was asked when I do my upload of a new
version to copy to both the main and older directory. But my scripts
still moved the main to the older one when a new release went out. This
caused the checksums of the created .gz to change in the older
directory.

What I do now is to still upload to both main and older, but when I
have a new release, I simply delete the main one, as the older one
already exists.

Thanks!

-- Steve
