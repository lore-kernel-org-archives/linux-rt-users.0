From: Denys Dmytriyenko <denis@denix.org>
Subject: Re: [PATCH 1/3] rt-tests: Support user supplied CFLAGS and LDFLAGS
Date: Wed, 21 Mar 2012 15:10:22 -0400
Message-ID: <20120321191022.GA6857@denix.org>
References: <3343440fb02872debc8b49be5261aec530a205f3.1332270303.git.dvhart@linux.intel.com>
 <CAONaPpH2Cr-k=NviUhnkf6j-dk5J6aY_9mmZT17ixGLsb5h2mw@mail.gmail.com>
 <4F691C88.2020907@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: John Kacur <jkacur@redhat.com>, linux-rt-users@vger.kernel.org,
	Clark Williams <williams@redhat.com>
To: Darren Hart <dvhart@linux.intel.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from vms173015pub.verizon.net ([206.46.173.15]:57404 "EHLO
	vms173015pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760118Ab2CUUKh (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 21 Mar 2012 16:10:37 -0400
Received: from gandalf.denix.org ([unknown] [71.178.225.66])
 by vms173015.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0M1900I8W19A7UO0@vms173015.mailsrvcs.net> for
 linux-rt-users@vger.kernel.org; Wed, 21 Mar 2012 14:10:29 -0500 (CDT)
Content-disposition: inline
In-reply-to: <4F691C88.2020907@linux.intel.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, Mar 20, 2012 at 05:10:48PM -0700, Darren Hart wrote:
> 
> 
> On 03/20/2012 04:58 PM, John Kacur wrote:
> > On Tue, Mar 20, 2012 at 8:05 PM, Darren Hart <dvhart@linux.intel.com> wrote:
> >> Accept user supplied CFLAGS and LDFLAGS, overwriting the
> >> Makefile supplied versions. This can cause the build to
> >> fail if the user does not provide at least what the Makefile
> >> defines, but so be it.
> >>
> >> Signed-off-by: Darren Hart <dvhart@linux.intel.com>
> >> CC: Clark Williams <williams@redhat.com>
> >> CC: John Kacur <jkacur@redhat.com>
> >> CC: Denys Dmytriyenko <denis@denix.org>
> >> ---
> > 
> > I was just wondering what you need LDFLAGS for? Chatting with Darren
> > on IRC, it seems like you're using -Wl to pass options via gcc to the
> > linker, and we don't have loadable libs either. Maybe you could resend
> > the patch with just the CFLAGS change until we have a real world
> > reason for LDFLAGS
> 
> Denys,
> 
> Am I missing a reason why we need LDFLAGS? With the current Makefile. we
> could just add anything we want to CFLAGS in a pinch anyway...

Darren,

>From OE-Core config files:

LINKER_HASH_STYLE ??= "gnu"
TARGET_LINK_HASH_STYLE ?= "${@['-Wl,--hash-style=gnu',''][d.getVar('LINKER_HASH_STYLE', True) != 'gnu']}"
export TARGET_LDFLAGS = "-Wl,-O1 ${TARGET_LINK_HASH_STYLE}"
ASNEEDED = "-Wl,--as-needed"
TARGET_LDFLAGS += "${ASNEEDED}"
export LDFLAGS = "${TARGET_LDFLAGS}"


So, those are still linker flags (altough passed through -Wl to gcc), hence 
they belong to LDFLAGS, not CFLAGS. Arguably, you only need to pass CFLAGS 
during compile stage and LDFLAGS during link stage. On the other hand, as a 
workaround, I was passing them to TARGET_CC_ARCH, which gets embedded into CC 
and won't distinguish between compile/link stages...

So rt-tests just gets away not using LDFLAGS and re-using CFLAGS for the link 
stage. :) But the current Makefile as it is now won't honor CFLAGS being set 
from outside, unless you pass them explicitly on the command line to make, or 
call make with -e flag.

-- 
Denys
