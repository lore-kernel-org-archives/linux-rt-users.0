From: GeunSik Lim <leemgs1@gmail.com>
Subject: Re: About "error mounting as ext3" when using 2.6.29-rt2 on Fedora.
Date: Wed, 8 Apr 2009 22:11:04 +0900
Message-ID: <49b7c2350904080611s35947c65q87baa8183c69ec7c@mail.gmail.com>
References: <49b7c2350904021920o1fbffeffn22b9fa7ea1365db1@mail.gmail.com>
	 <49b7c2350904031904w7fd63cc9o2c0f700a879e217@mail.gmail.com>
	 <alpine.LFD.2.00.0904040637480.12916@localhost.localdomain>
	 <49b7c2350904041951i2d984221qca33229dff6f0df4@mail.gmail.com>
	 <alpine.LFD.2.00.0904051606170.747@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.172]:4752 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932824AbZDHNLF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 8 Apr 2009 09:11:05 -0400
Received: by wf-out-1314.google.com with SMTP id 29so95821wff.4
        for <linux-rt-users@vger.kernel.org>; Wed, 08 Apr 2009 06:11:05 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.00.0904051606170.747@localhost.localdomain>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

I tested with howto that you explained.
Sorry for my late response about your advice.
Specially, Thank you for presentation about CFS scheduler
at the 3rd korea technical jamboree last year.

2009/4/5 Thomas Gleixner <tglx@linutronix.de>:
> On Sun, 5 Apr 2009, GeunSik Lim wrote:
>> > Hmm. You said the same kernel works fine on other distros, right ?=
 Do
>> > you use the same .config for the different distros. If not you cou=
ld
>> > try to build the kernel on fedora with the other-distro config.
>> Yes.
>> I used the same kernel on various distros as I said previously.
>> ( config file :
>> http://leemgs1.googlecode.com/files/i386.2.6.29-rt2.ftrace.config-in=
vain-invain.20090402)
>> for example,
>> At first,I built linux-2.6.29.rt2 kernel source.
>> And then, =C2=A0I tested
>> kernel booting with this same kernel
>> binary(ex:vmlinuz,Systemmap,initrd , /lib/modules/2.6.29.rt2) on oth=
er
>> distros.
>
> Ok, can you try the following ? Boot into fedora, copy the fedora
> config file into your -rt build directory and enable preempt-rt on
> it. Now build the kernel and install it with "make modules_install
> install". Does this work ?
=2E
I compiled -rt kernel source with gcc 4 on fedora 9 distribution
directly as you said.
I  boot -rt kernel binary on fedora 9 distribution successfully about
Q9300 target.

But, I still can't boot -rt kernel binary on fedora 9 about Q8200 targe=
t.
I will report tomorrow that I capture kernel error display with my
digital camera.

This is a summary report until now.
-----------------------------------------------------------------------=
--------------------------------------------------------------
CPU Info of Desktop/Netbook                               Kernel
      rootFS        Booting
-----------------------------------------------------------------------=
--------------------------------------------------------------
Intel Atom(TM)  CPU N270  @ 1.60GHz /         Linux-2.6.29-rt2
=46edora 9      Success
Intel Core(TM)2 Quad CPU Q6600 @2.40GHz   same as above    CentOS5.2   =
Success
Intel Core(TM)2 Quad CPU Q6600 @2.40GHz   same as above    Ubuntu8.04  =
Success
Intel Core(TM)2 Quad CPU Q9300 @2.50GHz   same as above    Fedora9     =
  Success
Intel Core(TM)2 Quad CPU Q8200 @2.33GHz   same as above    Fedora9
  Fail(still)
-----------------------------------------------------------------------=
--------------------------------------------------------------
* ref) I compiled -rt kernel source with gcc on each target board direc=
tly.

Thanks you for your help.
>
> Thanks,
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0tglx
>



--=20
Regards,
GeunSik Lim
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
