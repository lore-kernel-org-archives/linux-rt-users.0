From: "$rik@nth " <srikanth007m@gmail.com>
Subject: Re: failed to compile rt-sched
Date: Mon, 28 Nov 2016 20:40:34 +0530
Message-ID: <CANKSX+GXnEreqjLWuzQfA1CWx8E05xwsCgqmin+KoT+MeV+AvQ@mail.gmail.com>
References: <CANKSX+FhtJFu=wifY-ppnSGkhWrwxJGS5sZw04ujPHH5-r+P=g@mail.gmail.com>
 <20161128141246.hlbqdxiavslkn4ds@linutronix.de>
Reply-To: srikanth007m@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Cc: linux-rt-users@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-qk0-f195.google.com ([209.85.220.195]:36075 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932517AbcK1PKf (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 28 Nov 2016 10:10:35 -0500
Received: by mail-qk0-f195.google.com with SMTP id h201so13585455qke.3
        for <linux-rt-users@vger.kernel.org>; Mon, 28 Nov 2016 07:10:35 -0800 (PST)
In-Reply-To: <20161128141246.hlbqdxiavslkn4ds@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, Nov 28, 2016 at 7:42 PM, Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
> On 2016-11-28 15:13:02 [+0530], $rik@nth  wrote:
>> Hi All,
> Hi,
>
> I suggest to set a proper From: in your mail client.
>
>> I am trying to cross compile rt-tests on Ubuntu with 64bit cross gcc
>> tool chain and ended up with below error (Able to compile successfully
>> with 32bit tool chain). Can someone help clarifying the below error?
>> Is this the issue with syscalls or with linux kernel version. How to
>> get it compile successfully for 64bit ARCH.
>>
>> aarch64-linux-gnu-gcc-4.8 -D VERSION=3D1.0 -c src/lib/rt-sched.c -Wall
>> -Wno-nonnull -O2 -D_GNU_SOURCE -Isrc/include -o bld/rt-sched.o
>> src/lib/rt-sched.c: In function =C3=A2sched_setattr=C3=A2:
>> src/lib/rt-sched.c:34:17: error: =C3=A2__NR_sched_setattr=C3=A2 undeclar=
ed
>> (first use in this function)
>>   return syscall(__NR_sched_setattr, pid, attr, flags);
>
> It works here:
> aarch64-linux-gnu-gcc -D VERSION=3D1.0 -c src/lib/rt-sched.c -Wall
> -Wno-nonnull -O2 -D_GNU_SOURCE -Isrc/include -o bld/rt-sched.o
>
> with gcc version 6.2.1 20161124 (Debian 6.2.1-5).
> I assume your toolchain is too old. __NR_sched_setattr was added in
> v3.14 so I assume your kernel headers are pre v3.14.
That makes sense.. mine is having little old gcc. But strange thing,
Why 32bit compiler is not returning such error.
arm-linux-gnueabihf-gcc (Ubuntu/Linaro 4.8.4-2ubuntu1~14.04.1) 4.8.4
aarch64-linux-gnu-gcc (Ubuntu/Linaro 4.8.4-2ubuntu1~14.04.1) 4.8.4
>
> Sebastian



--=20
Thanks & Regards,
M.Srikanth Kumar.
