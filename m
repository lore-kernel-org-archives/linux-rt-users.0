From: Lukasz Majewski <majess1982@gmail.com>
Subject: Re: [linux-2.6.26.8-rt14] RT Page Fault.
Date: Tue, 24 Feb 2009 01:00:24 +0100
Message-ID: <49A33898.5010000@gmail.com>
References: <49A1BA49.7060308@gmail.com> <3efb10970902221329h89b18cbl60c8d3365009e2d9@mail.gmail.com> <49A1D930.4010600@gmail.com> <20090223124016.GH5367@pengutronix.de> <49A2CD10.4080605@gmail.com> <20090223204656.GO5367@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Cc: Marc Kleine-Budde <m.kleine-budde@pengutronix.de>,
	linux-rt-users@vger.kernel.org
To: Robert Schwebel <r.schwebel@pengutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-bw0-f161.google.com ([209.85.218.161]:46945 "EHLO
	mail-bw0-f161.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755620AbZBXAA3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 23 Feb 2009 19:00:29 -0500
Received: by bwz5 with SMTP id 5so5331196bwz.13
        for <linux-rt-users@vger.kernel.org>; Mon, 23 Feb 2009 16:00:25 -0800 (PST)
In-Reply-To: <20090223204656.GO5367@pengutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello Robert,

I've tried to build toolchain using the following ptxconfig file:

./ptxconfigs/arm-v5te-linux-gnueabi-gcc-4.3.2-glibc-2.8-binutils-2.18-kernel-2.6.27-sanitized


I've also (as You advice) downloaded and used

OSELAS.Toolchain-1.99.3.1.tar.bz2

Then I've started building of my toolchain with

lukma@xxx:~/sbox_lukma/build-tools/OSELAS.Toolchain-1.99.3.1$ ../bin/ptxdist go

I've encountered following error (I hope that it's long enough to track 
it down.):

gawk -f ../scripts/gen-as-const.awk ../ports/sysdeps/arm/nptl/tcb-offsets.sym \

    | /usr/bin/gcc -S -o /home/lukma/sbox_lukma/build-tools/OSELAS.Toolchain-1.99.3.1/platform-arm-v5te-linux-gnueabi-gcc-4.3.2-glibc-2.8-binutils-2.18-kernel-2.6.27-sanitized/build-target/glibc-2.8-crt-build/tcb-offsets.hT3 -std=gnu99 -fgnu89-inline -O2 -Wall -Winline -Wwrite-strings -fmerge-all-constants -g -Wstrict-prototypes      -I../include -I/home/lukma/sbox_lukma/build-tools/OSELAS.Toolchain-1.99.3.1/platform-arm-v5te-linux-gnueabi-gcc-4.3.2-glibc-2.8-binutils-2.18-kernel-2.6.27-sanitized/build-target/glibc-2.8-crt-build/csu -I/home/lukma/sbox_lukma/build-tools/OSELAS.Toolchain-1.99.3.1/platform-arm-v5te-linux-gnueabi-gcc-4.3.2-glibc-2.8-binutils-2.18-kernel-2.6.27-sanitized/build-target/glibc-2.8-crt-build -I../ports/sysdeps/arm/elf -I../ports/sysdeps/unix/sysv/linux/arm/eabi/nptl
  -I../ports/sysdeps/unix/sysv/linux/arm/eabi -I../ports/sysdeps/unix/sysv/linux/arm/nptl -I../ports/sysdeps/unix/sysv/linux/arm -I../ports/sysdeps/unix/sysv/linux -I../nptl/sysdeps/unix/sysv/linux -I../nptl/sysdeps/pthread -I../sysdeps/pthread -I../sysdeps/unix/sysv/linux -I../sysdeps/gnu -I../sysdeps/unix/common -I../sysdeps/unix/mman -I../sysdeps/unix/inet -I../ports/sysdeps/unix/sysv -I../nptl/sysdeps/unix/sysv -I../sysdeps/unix/sysv -I../ports/sysdeps/unix/arm -I../ports/sysdeps/unix -I../nptl/sysdeps/unix -I../sysdeps/unix -I../sysdeps/posix -I../ports/sysdeps/arm/eabi -I../ports/sysdeps/arm/nptl -I../ports/sysdeps/arm -I../sysdeps/wordsize-32 -I../sysdeps/ieee754/flt-32 -I../sysdeps/ieee754/dbl-64 -I../sysdeps/ieee754 -I../sysdeps/generic/elf -I../sysdeps/generic -I../ports -I../np
 tl  -I.. -I../libio -I. -nostdinc -isystem /usr/lib/gcc/i486-linux-gnu/4.2.4/include -isystem /home/lukma/sbox_lukma/tools/arm-d940/arm-v5te-linux-gnueabi/gcc-4.3.2-glibc-2.8-binutils-2.18-kernel-2.6.27-sanitized/sysroot-arm-v5te-linux-gnueabi/usr/include -D_LIBC_REENTRANT -include ../include/libc-symbols.h        -DHAVE_INITFINI -x c - \

        -MD -MP -MF /home/lukma/sbox_lukma/build-tools/OSELAS.Toolchain-1.99.3.1/platform-arm-v5te-linux-gnueabi-gcc-4.3.2-glibc-2.8-binutils-2.18-kernel-2.6.27-sanitized/build-target/glibc-2.8-crt-build/tcb-offsets.h.dT -MT '/home/lukma/sbox_lukma/build-tools/OSELAS.Toolchain-1.99.3.1/platform-arm-v5te-linux-gnueabi-gcc-4.3.2-glibc-2.8-binutils-2.18-kernel-2.6.27-sanitized/build-target/glibc-2.8-crt-build/tcb-offsets.h.d /home/lukma/sbox_lukma/build-tools/OSELAS.Toolchain-1.99.3.1/platform-arm-v5te-linux-gnueabi-gcc-4.3.2-glibc-2.8-binutils-2.18-kernel-2.6.27-sanitized/build-target/glibc-2.8-crt-build/tcb-offsets.h'

In file included from ../include/tls.h:6,

                 from ../ports/sysdeps/unix/sysv/linux/arm/eabi/sysdep.h:28,

                 from <stdin>:1:

../ports/sysdeps/arm/nptl/tls.h:48:3: error: #error "TLS support is required."

In file included from ../include/tls.h:6,

                 from ../include/link.h:45,

                 from ../include/dlfcn.h:3,

                 from ../sysdeps/generic/ldsodefs.h:32,

                 from ../ports/sysdeps/arm/ldsodefs.h:39,

                 from ../sysdeps/unix/sysv/linux/ldsodefs.h:25,

                 from <stdin>:2:

../ports/sysdeps/arm/nptl/tls.h:48:3: error: #error "TLS support is required."

In file included from ../ports/sysdeps/arm/nptl/tls.h:57,

                 from ../include/tls.h:6,

                 from ../include/link.h:45,

                 from ../include/dlfcn.h:3,

                 from ../sysdeps/generic/ldsodefs.h:32,

                 from ../ports/sysdeps/arm/ldsodefs.h:39,

                 from ../sysdeps/unix/sysv/linux/ldsodefs.h:25,

                 from <stdin>:2:

../ports/sysdeps/unix/sysv/linux/arm/eabi/sysdep.h:31:3: error: #error Kernel headers are too old

In file included from <stdin>:1:

../ports/sysdeps/unix/sysv/linux/arm/eabi/sysdep.h:31:3: error: #error Kernel headers are too old

make[3]: *** [/home/lukma/sbox_lukma/build-tools/OSELAS.Toolchain-1.99.3.1/platform-arm-v5te-linux-gnueabi-gcc-4.3.2-glibc-2.8-binutils-2.18-kernel-2.6.27-sanitized/build-target/glibc-2.8-crt-build/rtld-global-offsets.h] Error 1

make[3]: *** Waiting for unfinished jobs....

make[3]: *** [/home/lukma/sbox_lukma/build-tools/OSELAS.Toolchain-1.99.3.1/platform-arm-v5te-linux-gnueabi-gcc-4.3.2-glibc-2.8-binutils-2.18-kernel-2.6.27-sanitized/build-target/glibc-2.8-crt-build/tcb-offsets.h] Error 1

make[3]: Leaving directory `/home/lukma/sbox_lukma/build-tools/OSELAS.Toolchain-1.99.3.1/platform-arm-v5te-linux-gnueabi-gcc-4.3.2-glibc-2.8-binutils-2.18-kernel-2.6.27-sanitized/build-target/glibc-2.8/csu'

make[2]: *** [csu/subdir_lib] Error 2

make[2]: Leaving directory `/home/lukma/sbox_lukma/build-tools/OSELAS.Toolchain-1.99.3.1/platform-arm-v5te-linux-gnueabi-gcc-4.3.2-glibc-2.8-binutils-2.18-kernel-2.6.27-sanitized/build-target/glibc-2.8'

make[1]: Leaving directory `/home/lukma/sbox_lukma/build-tools/OSELAS.Toolchain-1.99.3.1/platform-arm-v5te-linux-gnueabi-gcc-4.3.2-glibc-2.8-binutils-2.18-kernel-2.6.27-sanitized/build-target/glibc-2.8-crt-build'

make[1]: *** [csu/subdir_lib] Error 2

make: *** [/home/lukma/sbox_lukma/build-tools/OSELAS.Toolchain-1.99.3.1/platform-arm-v5te-linux-gnueabi-gcc-4.3.2-glibc-2.8-binutils-2.18-kernel-2.6.27-sanitized/state/glibc-crt.compile] Error 2

I don't know what kind of error it is.

My host PC is running at Ubuntu 2.6.24-22-generic with gcc 4.2.4. I've 
only changed target directory from '/opt' to 
'/home/lukma/sbox_lukma/tools' with "ptxdist menuconfig". Above error is 
the same for

OSELAS.Toolchain-1.99.3 and OSELAS.Toolchain-1.99.3.1


Regards,
Lukasz.


Robert Schwebel wrote:
> Hi Lukasz,
>
> On Mon, Feb 23, 2009 at 05:21:36PM +0100, Lukasz Majewski wrote:
>   
>> I'm building toolchain for AT572D940HF Atmel chip. It's ARM9 combined
>> with DSP. I'd like to build toolchain for ARM9 (ARMv5tej) with
>> -msoft-float support, EABI and full glibc ,to support all stuff
>> connected with PREEMPT_RT patch - especially librt.
>>     
>
> Ok.
>
>   
>> Now I've downloaded:
>> ptxdist-1.99.11 and ptxdist-1.99.11-patches.
>>     
>
> yup
>
>   
>> and
>> OSELAS.Toolchain-1.99.3
>>     
>
> exactly
>
>   
>> I've selected
>> ./ptxconfigs/arm-v5te-linux-gnueabi-gcc-4.3.2-glibc-2.8-binutils-2.18-kernel-2.6.27-sanitized
>>
>> I need toolchain with -msoft-float support and EABI.
>>     
>
> The toolchain you've selected above actually is softfloat and EABI. You
> don't have to change anything, just do the steps you've mentioned above
> and 'ptxdist go'.
>
>   
>> Unfortunately there is an error about mismatch in the linux-kernel
>> headers.
>>     
>
> Please send the exact error message (if too long, please off-list, to me
> and "Marc Kleine-Budde <m.kleine-budde@pengutronix.de>").
>
>   
>> My Host PC has linux-kernel of 2.6.24 and not 2.6.27.
>>     
>
> That's no problem; the toolchain you are trying to build is based on the
> 2.6.27 sanitized kernel headers. It's usually no problem at all using
> such a toolchain on a variety of other kernel versions.
>
>   
>> My target is working under 2.6.26.8-rt14 kernel.
>>     
>
> Should work.
>
>   
>> The error is in building of NTPL library, after successfully compilation
>> of gcc compiler.
>>
>> How can I provide proper kernel headers?
>>     
>
> See above, error messages, please.
>
>   
>> Now I'm trying with
>> arm-v5te-linux-gnueabi-gcc-4.1.2-glibc-2.5-binutils-2.17-kernel-2.6.18
>> ptxconfig. I hope that this will be sufficiently new to provide priority
>> inheritance, futexes , librt with all features.
>>     
>
> Yes, it is.
>
>   
>> I'm building it now and hope that I won't encounter any problems.
>>     
>
> You may want to check that we have an update for 1.99.3 here:
> http://www.pengutronix.de/oselas/toolchain/download/OSELAS.Toolchain-1.99.3.1.tar.bz2
>
> There has been a build error on some distros and it might happen that
> you are seeing exactly this issue.
>
> rsc
>   


