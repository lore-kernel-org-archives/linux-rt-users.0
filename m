From: "Paul Gortmaker" <paul.gortmaker@gmail.com>
Subject: Re: RT patches against v2.6.27-rc7 available
Date: Wed, 1 Oct 2008 01:12:59 -0400
Message-ID: <7d1d9c250809302212n7845dd61w58847b98f74cfad@mail.gmail.com>
References: <20080930033248.GA24480@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org, rostedt@goodmis.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-gx0-f16.google.com ([209.85.217.16]:50920 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750719AbYJAFNB (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 1 Oct 2008 01:13:01 -0400
Received: by gxk9 with SMTP id 9so12677639gxk.13
        for <linux-rt-users@vger.kernel.org>; Tue, 30 Sep 2008 22:13:00 -0700 (PDT)
In-Reply-To: <20080930033248.GA24480@windriver.com>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, Sep 29, 2008 at 11:32 PM, Paul Gortmaker
<paul.gortmaker@windriver.com> wrote:

> I've completed a carry forward of the 26rt9 broken out patchset onto
> the 2.6.27-rc7 kernel.  There were a lot of changes in 2.6.27, so this
> wasn't just a simple case of having all the patches magically work as-is.
>

The git tree and patches are updated to rc8, and if you are using the
patches, I've ensured they should be fuzz/offset free.  The patch
headers should also be a bit more consistent;  there were some patch
headers that guilt was truncating when it found the first match for "^---"
which was incorrectly matching on ascii art and PGP sigs etc.

Aside from the basic context changes of rc8, there are no real functional
changes in this update.  Location remains the same as below.  There
are branches for the previous versions and these versions,so you can
easily do comparisons as you wish.

Thanks,
Paul.


> Location:
> ---------
>
> The broken out patches and series file can be obtained from here:
>
>        git://opensource1.windriver.com/people/paulg/rt/patches
>
> A fully patched 2.6.27-rc7 git tree can be had from here:
>
>        git://opensource1.windriver.com/people/paulg/rt/linux-2.6
>
> The latter is just the result of applying the broken out patches with guilt,
> and then committing the series file on the end as a useful reference.
> I intend to clean up some of the patch headers so that patch attribution
> in git comes out giving the proper credit - that is also on my todo list...
> (Note: pre-patched tree is on branch "v2.6.27-rc7-26rt9" and not "master".)
>
> As I mentioned earlier, I'm happy to take feedback on how this can be
> tailored to be a more useful resource to those who are doing the real work
> on the code -- there are folks out there who clearly have a much better
> understanding of RT than I do, and as such I'd like this be something
> of real value to them -- just to be clear, I don't have any interest
> (or the skill) for this to be a separate project, or fork or similar.
>
> Thanks,
> Paul.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
