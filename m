From: Azraiyl <azraiyl@gmail.com>
Subject: RT Latency on Atmel Processors
Date: Thu, 24 Sep 2009 14:02:56 +0200
Message-ID: <a9067d050909240502n3377f3c5gb70fcf16c58b3942@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-bw0-f210.google.com ([209.85.218.210]:35157 "EHLO
	mail-bw0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752161AbZIXMCy (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 24 Sep 2009 08:02:54 -0400
Received: by bwz6 with SMTP id 6so1226404bwz.37
        for <linux-rt-users@vger.kernel.org>; Thu, 24 Sep 2009 05:02:57 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi all,

I try to get PREEMP_RT running on an Olimex SAM9-L9260 board. On this board
there is an AT91SAM9260 processor (ARM926EJ-S).

Unfortunately more or less nothing works out of the box, whenever I try to use
RT. I even have problems providing some useful data here (I'll try to explain
why).

I started with vanilla linux-2.6.31, no Atmel patch. Kernel .config was reduced
to a minium. Kernel boots without a problem. When I enable debugging options and
some tests like "Locking API Testsuite" I have no problems as well.

When I apply patch-2.6.31-rt11 but do not enable full RT the kernel boots. When
I try to get cyclictest (cyclictest -p99 -D5 -q -n) running I often get some
unexpected results which are somewhat hard to describe. When I run cyclictest
without any other process running (only /bin/ash from busybox) Max is often
smaller than 1000 us. Sometimes I get 50000 us (no RT yet, so that is ok). When
I start to ping -f the board, Max, Avg and Min start to increase, even if I stop
the ping command, all three values are constantly increasing. In the given
example above it is not uncommon that all three values are above 4'500'000. The
same happens if I start a telnetd daemon in addition and login on the board. The
fancy thing here that I can open new sessions and type some commands, therefore
the system is still responsive. Without using the "-n" options results are
often random numbers.

Whenever I switch to RT (still linux-2.6.31) the kernel boots until init should
be called. It is the same problem as here:
http://article.gmane.org/gmane.linux.rt.user/5108.

I switched back to linux-2.6.29.6 then. Main reason was that
linuxlink.timesys.com offers a RT linux for AT91SAM9260 (an indication that
should boot at least).

Vanilla 2.6.29.6 boots fine.

When I apply patch-2.6.29.6-rt23 without enabling RT, I get the same odd
behavior with cyclictest as described above.

When I enable RT, everything works more or less (tons of kernel Oops, often with
at least one call to JFFS2 in the backtrace). Without any load, Max from
cyclictest is below 500 us. If I ping -f the board Max goes up to ca. 8000 us.

When I compare this results with:

http://rt.wiki.kernel.org/index.php/CONFIG_PREEMPT_RT_Patch

it should be possible to get worst case latency below 150 us (for this kind of
processor). The problem with this page is that there are no details, about the
test environment. Was it measured with cyclictest? Was there anything running in
the background? Any testsuite that produces any load? Even details like, how
much influence the gcc version has, would be interesting. It would be nice if
anyone can post some details about their environment (especially ARM and PPC
environment, PPC is missing in the list, whatever the reason).

I thought then, ok let's track the source of the problem. I was reading
http://www.osadl.org/Realtime-Preempt-Kernel.kernel-rt.0.html then.

After enabling Function Tracing in the kernel, i was not able to compile the
kernel anymore. I'm using the latest Code Sourcery GCC for ARM. I found a fix
and if anyone is interested I'll post it here.

Second problem is that it seems that cyclictest does not exactly works together
with the current layout of debugfs (looks like some virtual files were moved
around).

Third problem ist when I try to interpret the output from debugfs I get
thousands of lines prefixed with the exact same time. It seems impossible for me
to get any idea, where the problem is.

I've to admit that currently have so many problems that I don't now where I
should start (write docs, fix tools, try to get more info about the Oops I get,
get into the problem that somehow the results from cyclictest are sometimes
totally wrong, ...).

Thanks for any clarification, hint, or detailed description of a working ARM
setup.

Azraiyl
