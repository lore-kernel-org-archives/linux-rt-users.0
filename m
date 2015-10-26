From: Javier Sanz <jsanza@gmail.com>
Subject: numa.h for rt-test
Date: Mon, 26 Oct 2015 11:56:45 +0100
Message-ID: <CAOLSsAxE8ppH2_wVjMOxskOGKtporbwaztG8GzfvN88gJyO20Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: RT <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-yk0-f174.google.com ([209.85.160.174]:35180 "EHLO
	mail-yk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753315AbbJZK5P (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 26 Oct 2015 06:57:15 -0400
Received: by ykaz22 with SMTP id z22so180167501yka.2
        for <linux-rt-users@vger.kernel.org>; Mon, 26 Oct 2015 03:57:14 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello,

I am trying to compile rt-tests-0.96 and i got :

root@darkstar rt-tests-0.96]# make
gcc -D VERSION=0.96 -c src/cyclictest/cyclictest.c -Wall -Wno-nonnull
-O2 -DNUMA -D_GNU_SOURCE -Isrc/include -o bld/cyclictest.o
In file included from src/cyclictest/cyclictest.c:39:0:
src/cyclictest/rt_numa.h:29:18: fatal error: numa.h: No such file or directory
compilation terminated.
Makefile:87: recipe for target 'bld/cyclictest.o' failed
make: *** [bld/cyclictest.o] Error 1
[root@darkstar rt-tests-0.96]#


why do i need to get numa.h ??

Tx
