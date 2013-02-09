From: Sven-Thorsten Dietrich <sven@thebigcorporation.com>
Subject: Re: rt-tests: make rpm fails if numactl-devel is missing
Date: Fri, 8 Feb 2013 16:49:02 -0800
Message-ID: <FDED51B5-DFB9-4C2D-BC7E-0F4594194697@thebigcorporation.com>
References: <51158456.8000009@am.sony.com>
Mime-Version: 1.0 (Mac OS X Mail 6.2 \(1499\))
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Clark Williams <williams@redhat.com>, <jkacur@redhat.com>,
	<linux-rt-users@vger.kernel.org>
To: <frank.rowand@am.sony.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:61837 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932076Ab3BIAtF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 8 Feb 2013 19:49:05 -0500
Received: by mail-pa0-f53.google.com with SMTP id bg4so2323586pad.12
        for <linux-rt-users@vger.kernel.org>; Fri, 08 Feb 2013 16:49:05 -0800 (PST)
In-Reply-To: <51158456.8000009@am.sony.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


On Feb 8, 2013, at 3:03 PM, Frank Rowand <frank.rowand@am.sony.com> wrote:

> Hi all,
> 
> I'm not sure what the best solution for this is.  Or if it is even
> worth fixing.  So just reporting for the archives...
> 
> rt-tests can be built without NUMA:
> 
>   make NUMA=0
> 
> But "make rpm" does not have a way to be successful without NUMA:

I ran into this in the past with OBS on Suse.

There was a tertiary issue, because some distros use i386
and others use i586 or i686.

E.g.

[sven@www rt-tests]$ gcc -dumpmachine
i586-suse-linux

diff --git a/Makefile b/Makefile
index 3a82407..7bb022c 100644
--- a/Makefile
+++ b/Makefile
@@ -16,7 +16,7 @@ srcdir        ?= $(prefix)/src
 
 machinetype = $(shell $(CC) -dumpmachine | \
     sed -e 's/-.*//' -e 's/i.86/i386/' -e 's/mips.*/mips/' -e 's/ppc.*/powerpc/')
-ifneq ($(filter x86_64 i386 ia64 mips powerpc,$(machinetype)),)
+ifneq ($(filter x86_64 i586 ia64 mips powerpc,$(machinetype)),)
 NUMA   := 1
 endif

So all in all, this feature probably only works on some, and maybe needs to be worked around more often than not.

Sven