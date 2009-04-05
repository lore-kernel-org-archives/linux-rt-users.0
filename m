From: GeunSik Lim <leemgs1@gmail.com>
Subject: Re: About "error mounting as ext3" when using 2.6.29-rt2 on Fedora.
Date: Sun, 5 Apr 2009 11:51:51 +0900
Message-ID: <49b7c2350904041951i2d984221qca33229dff6f0df4@mail.gmail.com>
References: <49b7c2350904021920o1fbffeffn22b9fa7ea1365db1@mail.gmail.com>
	 <49b7c2350904031904w7fd63cc9o2c0f700a879e217@mail.gmail.com>
	 <alpine.LFD.2.00.0904040637480.12916@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.173]:32960 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756697AbZDECvx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 4 Apr 2009 22:51:53 -0400
Received: by wf-out-1314.google.com with SMTP id 29so1763887wff.4
        for <linux-rt-users@vger.kernel.org>; Sat, 04 Apr 2009 19:51:52 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.00.0904040637480.12916@localhost.localdomain>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Dear Thomas,

Thank you for your fast response.

2009/4/4 Thomas Gleixner <tglx@linutronix.de>:
> On Sat, 4 Apr 2009, GeunSik Lim wrote:
>
>> I solved =C2=A0mounting error =C2=A0with "acpi=3Doff =C2=A0noapic no=
dma" options about
>> below problem .
>> =C2=A0( reference : ./linux-2.6.29-rt2/Documentation/x86/x86_64/boot=
-options.txt )
>
> Ouch. That's not a real solution.
I think so.
But, I need trick for  kernel booting on Q9300 &Q8200Target successfull=
y.
>
>> Hope this helps for fedora users.
>> This is kernel issues? In fact, I am not sure.
>
> Hmm. You said the same kernel works fine on other distros, right ? Do
> you use the same .config for the different distros. If not you could
> try to build the kernel on fedora with the other-distro config.
Yes.
I used the same kernel on various distros as I said previously.
( config file :
http://leemgs1.googlecode.com/files/i386.2.6.29-rt2.ftrace.config-invai=
n-invain.20090402)
for example,
At first,I built linux-2.6.29.rt2 kernel source.
And then,  I tested
kernel booting with this same kernel
binary(ex:vmlinuz,Systemmap,initrd , /lib/modules/2.6.29.rt2) on other
distros.

I will test with the same kernel binary on Q8200 /Q9300(Core2Quad)
using ubuntu 8.04 without fedora 9 later on.

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
