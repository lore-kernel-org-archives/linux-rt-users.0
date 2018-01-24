From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: Patching kernel versions for which there is no version specific
 patch released?
Date: Wed, 24 Jan 2018 15:07:15 +0100
Message-ID: <20180124140714.aqrhwpslt2z7wqii@linutronix.de>
References: <413db8dc-b0d6-8f49-dd5f-2b842c06e05a@lsa2.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Cc: linux-rt-users@vger.kernel.org
To: Joshua Kordani <jkordani@lsa2.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:60697 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933576AbeAXOHQ (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 24 Jan 2018 09:07:16 -0500
Content-Disposition: inline
In-Reply-To: <413db8dc-b0d6-8f49-dd5f-2b842c06e05a@lsa2.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 2018-01-16 10:34:25 [-0500], Joshua Kordani wrote:
> Greetings,
Hi,

> I am trying to patch a kernel for which there doesn't seem to be a specific
> patch set released.
> For example, patch-4.9.61-rt52.patch.xz and patch-4.9.65-rt56.patch.xz
> exist, but nothing in between.  Is it safe to assume that
> patch-4.9.61-rt52.patch.xz is appropriate for all kernel versions from
> 4.9.61 to 4.9.64?  Or, since the rt version jumps from 52 to 56, there are
> intermediate versions of the patchset for intermediate versions of the
> kernel that are available only in the git repo?
> 
> Looking to make the right call about how to patch what I need instead of
> just compiling and hoping.

Those intermediate aren't uploaded but only tagged in git [0]. If you
really require an intermediate then I guess the best way would be to
create the diff from git.
In general you are encourage to use the latest stable release.

[0] https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git/

> Thanks for your help!
> 
> Joshua Kordani
> 

Sebastian
