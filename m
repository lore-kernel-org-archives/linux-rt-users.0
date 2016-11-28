From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: failed to compile rt-sched
Date: Mon, 28 Nov 2016 15:12:47 +0100
Message-ID: <20161128141246.hlbqdxiavslkn4ds@linutronix.de>
References: <CANKSX+FhtJFu=wifY-ppnSGkhWrwxJGS5sZw04ujPHH5-r+P=g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Cc: linux-rt-users@vger.kernel.org
To: "$rik@nth " <srikanth007m@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:46022 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932283AbcK1OMt (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 28 Nov 2016 09:12:49 -0500
Content-Disposition: inline
In-Reply-To: <CANKSX+FhtJFu=wifY-ppnSGkhWrwxJGS5sZw04ujPHH5-r+P=g@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 2016-11-28 15:13:02 [+0530], $rik@nth  wrote:
> Hi All,
Hi,

I suggest to set a proper From: in your mail client.

> I am trying to cross compile rt-tests on Ubuntu with 64bit cross gcc
> tool chain and ended up with below error (Able to compile successfully
> with 32bit tool chain). Can someone help clarifying the below error?
> Is this the issue with syscalls or with linux kernel version. How to
> get it compile successfully for 64bit ARCH.
> 
> aarch64-linux-gnu-gcc-4.8 -D VERSION=1.0 -c src/lib/rt-sched.c -Wall
> -Wno-nonnull -O2 -D_GNU_SOURCE -Isrc/include -o bld/rt-sched.o
> src/lib/rt-sched.c: In function âsched_setattrâ:
> src/lib/rt-sched.c:34:17: error: â__NR_sched_setattrâ undeclared
> (first use in this function)
>   return syscall(__NR_sched_setattr, pid, attr, flags);

It works here:
aarch64-linux-gnu-gcc -D VERSION=1.0 -c src/lib/rt-sched.c -Wall
-Wno-nonnull -O2 -D_GNU_SOURCE -Isrc/include -o bld/rt-sched.o

with gcc version 6.2.1 20161124 (Debian 6.2.1-5).
I assume your toolchain is too old. __NR_sched_setattr was added in
v3.14 so I assume your kernel headers are pre v3.14.

Sebastian
