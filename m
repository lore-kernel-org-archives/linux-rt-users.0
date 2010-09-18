From: jordan <triplesquarednine@gmail.com>
Subject: Re: "yum install ...." based instruction on building a RT kernel.
Date: Sat, 18 Sep 2010 15:15:54 -0400
Message-ID: <AANLkTikv7cmA_F==TKa1m0o_N1OHxp3RgXXMErhcgGM0@mail.gmail.com>
References: <4C92A00C.6050401@atl.lmco.com>
	<AANLkTi=eaPvCZmecBKT_d0C8YunJr7L6M8A7Y9pEiQK_@mail.gmail.com>
	<AANLkTi=GbDU7fKh9LvCEpjhSSMFF0syCqJVuqUERVBEJ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Gautam Thaker <gautam.h.thaker@lmco.com>,
	linux-rt-users@vger.kernel.org
To: John Kacur <jkacur@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:59684 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757068Ab0IRTPz (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 18 Sep 2010 15:15:55 -0400
Received: by eyb6 with SMTP id 6so1296128eyb.19
        for <linux-rt-users@vger.kernel.org>; Sat, 18 Sep 2010 12:15:54 -0700 (PDT)
In-Reply-To: <AANLkTi=GbDU7fKh9LvCEpjhSSMFF0syCqJVuqUERVBEJ@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hey John,

> You think that optimizing it is easy?

Yes, i do. :)

1. Patching the kernel is simple (as long as you are using the right
patch with the right version). Most of the time it is as simple as
putting the patch in the kernel's directory and running:

patch -p1 <  "whatever the patch is called"

Then it will show you if it patched correctly, if it didn't hit a
linux forum and ask for help.  It isn't rocket science...

2. To strip away all modules that you don't require, you only need to
run a simple command from a terminal before you compile:

"make localmodconfig".

Then you can use "make menuconfig or mkae xconfig", and look through
the configuration, then disable features that you don't need or want.
Alot of the time it is common sense, as some things will be obvious to
most people, that they are features your hardware/setup doesn't
require. other times, google will be your bestfriend.

3. After that, you can hit the gentoo documentation and/or the GCC
documentation, and read about CFLAGS...once, you figure out what you
may like to use, and what isn't dangerous (too harsh of optimizations
can break things).
Then, you can run the necessary commands when you go to compile.

my example (these are for my machine, and i use strict optimizations,
so don't assume you should use them!)

'make CFLAGS="-O3 -march=native -pipe -fomit-frame-pointer -DPIC -fPIC
-s" LDFLAGS="-z combreloc" rpm'

(in my case this will make my optimized kernel into RPMs to use with Fedora)

4. Let it compile, if that goes okay, install it. then, depending on
your distro/method used by the distro, you may have to use "dracut" or
some other tool that make your initrd and you might manually have to
edit grub.
After this is all completed reboot!

if there are any problems booting into your new kernel, google the
error message and fix the problem.
if you need help hit a forum.

I don't think that is difficult. I taught myself how to do this, and
im not a genius! (it's like 5 terminal commands, some reading and
following instructions, easily found on the interweb)

jordan
