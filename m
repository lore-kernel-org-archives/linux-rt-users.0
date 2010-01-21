From: GeunSik Lim <leemgs1@gmail.com>
Subject: Re: [PATCH]cyclictest: CFLAGS to support static compiliation with ARM
	Crosscompiler
Date: Thu, 21 Jan 2010 22:10:46 +0900
Message-ID: <49b7c2351001210510r545a086er2fe6badcd3657fa6@mail.gmail.com>
References: <1246593855.2153.55.camel@centos51>
	 <1264032570.2121.4.camel@centos51>
	 <520f0cf11001201640r4f1cf00ew3b4a4e9424c28602@mail.gmail.com>
	 <49b7c2351001201737l403a20cduf3c32072e8e4f8d1@mail.gmail.com>
	 <alpine.LFD.2.00.1001211201340.3873@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: williams <williams@redhat.com>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	tglx <tglx@linutronix.de>
To: John Kacur <jkacur@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-pw0-f42.google.com ([209.85.160.42]:59223 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751514Ab0AUNRV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 21 Jan 2010 08:17:21 -0500
Received: by pwj9 with SMTP id 9so3910271pwj.21
        for <linux-rt-users@vger.kernel.org>; Thu, 21 Jan 2010 05:17:20 -0800 (PST)
In-Reply-To: <alpine.LFD.2.00.1001211201340.3873@localhost.localdomain>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, Jan 21, 2010 at 8:40 PM, John Kacur <jkacur@redhat.com> wrote:
>
>
> On Thu, 21 Jan 2010, GeunSik Lim wrote:
>
>> On Thu, Jan 21, 2010 at 9:40 AM, John Kacur <jkacur@redhat.com> wrot=
e:
>> >
>> > Did you leave something out?
>> Not at all.
>> I summary, We have to =C2=A0change =C2=A0CFLAGS from "-lpthread -lrt=
" to "-lrt
>> -lpthread" to compile
>> rt-tests source successfully =C2=A0for static linking with GCC based=
 arm
>> cross compiler.
>>
>> This is testcase.
>> Fedora11#> git clone
>> git://git.kernel.org/pub/scm/linux/kernel/git/clrkwllms/rt-tests.git
>> Fedora11#> cd rt-tests
>> Fedora11#> vi Makefile ( for static linking)
>> =C2=A0 CFLAGS =C2=A0+=3D -O2 -static <--- Edit this line.
>> Fedora11#> make CC=3Darm-linux-eabi-gcc
>> =C2=A0 =C2=A0We will meet some errors like =C2=A0"undefined referenc=
e to . . . . . .
>> " messages.
>
> Okay, I tested that change on normal x86_64 with the static flag, and=
 it
> does seem to work, so I have no problem with your change.
Thank you for verification on X86 64bit.
=46or reference, I tested that change on X86 32bit with the "-static"op=
tion.
>
> Are you sure you need a -static link flag for embedded? I was talking=
 to
> another arm developer who also cross compiles but doesn't need it.
Of course. In general, Most embedded developers use shared linking for
Embedded environment. But, Consider some case like Speedup and
independent binary for debugging. In this case, We need useful
"-static"option.
>
> Also, the reason I asked whether something was missing, is that the t=
ext
> to your patch contains "Subject: [PATCH 2/2] bugfix: Support static
> linking(-static) with"
>
> so I was wondering where Patch 1/2 was.
>
Sorry. I mistook.:)
Patch is just one.
> Thanks.
>



--=20
Regards,
GeunSik Lim ( Samsung Electronics )
Blog : http://blog.naver.com/invain/
e-Mail: geunsik.lim@samsung.com
           leemgs@gmail.com , leemgs1@gmail.com
--
To unsubscribe from this list: send the line "unsubscribe linux-kernel"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
