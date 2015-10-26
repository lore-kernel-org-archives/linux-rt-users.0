From: Javier Sanz <jsanza@gmail.com>
Subject: Re: numa.h for rt-test
Date: Mon, 26 Oct 2015 12:05:28 +0100
Message-ID: <CAOLSsAwhY1OnTHKfHW2_es4mbGrum5+s5iioNyLmem4SGMPcyw@mail.gmail.com>
References: <CAOLSsAxE8ppH2_wVjMOxskOGKtporbwaztG8GzfvN88gJyO20Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: RT <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-yk0-f171.google.com ([209.85.160.171]:36276 "EHLO
	mail-yk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752934AbbJZLF6 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 26 Oct 2015 07:05:58 -0400
Received: by ykba4 with SMTP id a4so173285835ykb.3
        for <linux-rt-users@vger.kernel.org>; Mon, 26 Oct 2015 04:05:57 -0700 (PDT)
In-Reply-To: <CAOLSsAxE8ppH2_wVjMOxskOGKtporbwaztG8GzfvN88gJyO20Q@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Sorry,

make NUMA=0

Tx

2015-10-26 11:56 GMT+01:00 Javier Sanz <jsanza@gmail.com>:
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
>
> Tx
