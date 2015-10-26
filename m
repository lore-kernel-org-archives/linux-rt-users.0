From: Jeff Epler <jepler@unpythonic.net>
Subject: Re: numa.h for rt-test
Date: Mon, 26 Oct 2015 07:45:37 -0500
Message-ID: <20151026124537.GB23645@unpythonic.net>
References: <CAOLSsAxE8ppH2_wVjMOxskOGKtporbwaztG8GzfvN88gJyO20Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: RT <linux-rt-users@vger.kernel.org>
To: Javier Sanz <jsanza@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from zaphod.unpythonic.net ([76.79.27.186]:23666 "EHLO
	zaphod.unpythonic.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753819AbbJZN0K (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 26 Oct 2015 09:26:10 -0400
Content-Disposition: inline
In-Reply-To: <CAOLSsAxE8ppH2_wVjMOxskOGKtporbwaztG8GzfvN88gJyO20Q@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, Oct 26, 2015 at 11:56:45AM +0100, Javier Sanz wrote:
> Hello,
> 
> I am trying to compile rt-tests-0.96 and i got :
> 
> root@darkstar rt-tests-0.96]# make
> gcc -D VERSION=0.96 -c src/cyclictest/cyclictest.c -Wall -Wno-nonnull
> -O2 -DNUMA -D_GNU_SOURCE -Isrc/include -o bld/cyclictest.o
> In file included from src/cyclictest/cyclictest.c:39:0:
> src/cyclictest/rt_numa.h:29:18: fatal error: numa.h: No such file or directory
> compilation terminated.
> Makefile:87: recipe for target 'bld/cyclictest.o' failed
> make: *** [bld/cyclictest.o] Error 1
> [root@darkstar rt-tests-0.96]#
> 
> 
> why do i need to get numa.h ??

Some documentation on the rt wiki:
    https://rt.wiki.kernel.org/index.php/Cyclictest#Compile_failure_because_numa.h_can.27t_be_found
[which says that the package on Fedora-derived systems is numactl-devel]

On Debian-derived systems, the header is from libnuma-dev.

Jeff
