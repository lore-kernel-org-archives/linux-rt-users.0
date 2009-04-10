From: Mark Knecht <markknecht@gmail.com>
Subject: Re: Fedora 10 as basis for RT?
Date: Fri, 10 Apr 2009 11:21:01 -0700
Message-ID: <5bdc1c8b0904101121h3d909fcdhdae4642741eea951@mail.gmail.com>
References: <loom.20090409T134400-381@post.gmane.org>
	 <loom.20090410T171457-788@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: Al Dorrington <albert.dorrington@lmco.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.233]:46442 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751684AbZDJSVC (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 10 Apr 2009 14:21:02 -0400
Received: by rv-out-0506.google.com with SMTP id f9so1153246rvb.1
        for <linux-rt-users@vger.kernel.org>; Fri, 10 Apr 2009 11:21:01 -0700 (PDT)
In-Reply-To: <loom.20090410T171457-788@post.gmane.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, Apr 10, 2009 at 10:28 AM, Al Dorrington
<albert.dorrington@lmco.com> wrote:
> Ok - one more question about Fedora 10...
>
> Fedora 10 uses the 2.6.27 kernel, looking at the patches available at the RT
> kernel project site at kernel.org, I see patches for 2.6.26 and 2.6.29.
>
> I am not sure what the correct way to integrate the RT patches at this point.
> Are there alternate patch sites, or should I downgrade to 2.6.26 or upgrade to
> 2.6.29?
>
> Thanks - Al
>

If it's your first time with the rt-kernel then you should download
the 3 file set that Thomas announces for each kernel. One thing you do
NOT want to do is mix and match in ways that the rt-developers don't
suggest. Note that the rt-kernel should always (AFAIK) be built only
against the kernel.org kernel with the same base revision number.

Here's a recent announcement:

<QUOTE>

We are pleased to announce the next update to our new preempt-rt
series.

       - include the futex rework + requeue_pi support (Darren Hart)

The futex changes need profound testing. As we know from prior futex
work the best stress tests for the futex interface are RT-Java-VMs
especially with enterprise work loads on larger machines. Can the
folks who have access to such monstrosities please unleash the beasts
and give the futex code a good work out ? Please tell your sysadmin
upfront that he should be stand by to fix up the resulting wreckage
which might vary from harmless to system replacement.

Unfortunately I was not able to track down the weird 32bit PAE
shutdown crash, so the affected users need to stick to the
nosmp-alternatives work around for now.

Download locations:

    http://rt.et.redhat.com/download/
    http://www.kernel.org/pub/linux/kernel/projects/rt/

Information on the RT patch can be found at:

    http://rt.wiki.kernel.org/index.php/Main_Page

to build the 2.6.29.1-rt5 tree, the following patches should be
applied:

    http://www.kernel.org/pub/linux/kernel/v2.6/linux-2.6.29.1.tar.bz2
    http://www.kernel.org/pub/linux/kernel/projects/rt/patch-2.6.29.1-rt5.bz2

The broken out patches are also available at the same download
locations.

Enjoy !

      tglx

</QUOTE>
