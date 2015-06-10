From: Joe Korty <joe.korty@ccur.com>
Subject: Re: rt patch
Date: Wed, 10 Jun 2015 10:40:47 -0400
Message-ID: <20150610144047.GB31886@zipoli.ccur.com>
References: <5576FC70.8050908@numalliance.com>
 <CABgxDo+cC7n8AbWvuwRrUWj-08DvtApL78OsqX66gN7U519iXA@mail.gmail.com>
 <5577DCE0.3000805@numalliance.com>
 <CABgxDoJdNJMc3tE1=pzhP-=VsSB6irPT7q3_CPJpJJuGwSwRmA@mail.gmail.com>
 <5577E019.6030106@numalliance.com>
Reply-To: Joe Korty <joe.korty@ccur.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Romain Perier <romain.perier@gmail.com>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: St??phane ancelot <sancelot@numalliance.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from vpnflf.ccur.com ([12.220.59.2]:39715 "EHLO zipoli.ccur.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S933280AbbFJP1J (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 10 Jun 2015 11:27:09 -0400
Content-Disposition: inline
In-Reply-To: <5577E019.6030106@numalliance.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, Jun 10, 2015 at 02:58:33AM -0400, St??phane ancelot wrote:
> here is an example with linux-3.18.13 and patch 3.18.13-rt10:
> 3.18.13-rt10
> 
> zcat ../patches-3.18.13-rt10.tar.gz |patch -p1 --dry-run
> patching file arch/arm64/kernel/perf_event.c
> Hunk #1 succeeded at 461 (offset -6 lines).
> patching file arch/sparc/Kconfig
> patching file arch/arm64/Kconfig
> Hunk #1 succeeded at 61 (offset -7 lines).
> patching file include/linux/notifier.h
> patching file include/linux/srcu.h
> patching file arch/x86/mm/iomap_32.c
> Hunk #1 FAILED at 65.
> 1 out of 1 hunk FAILED -- saving rejects to file arch/x86/mm/iomap_32.c.rej


It appears you are applying the patch to an Android or other third-party
derivative of Linux, instead of Linux proper, or that either the kernel
or the patch you have fetched is corrupt.  Try re-fetching everything and
try again.  This sequence works for me:

   cd
   mkdir junk
   cd junk
   wget -q ftp://ftp.kernel.org/pub/linux/kernel/v3.0/linux-3.18.11.tar.xz
   wget -q ftp://ftp.kernel.org/pub/linux/kernel/projects/rt/3.18/patch-3.18.13-rt10.patch.xz
   tar xf l*xz
   cd linux*11
   unxz <../pat*xz | patch -p1

There are some (annoying) offset errors, but no fuzzies or rejects like you have
been seeing.

Joe
