From: GeunSik Lim <leemgs1@gmail.com>
Subject: Re: About "error mounting as ext3" when using 2.6.29-rt2 on Fedora.
Date: Sat, 4 Apr 2009 11:04:29 +0900
Message-ID: <49b7c2350904031904w7fd63cc9o2c0f700a879e217@mail.gmail.com>
References: <49b7c2350904021920o1fbffeffn22b9fa7ea1365db1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.168]:34705 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752969AbZDDCEb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 3 Apr 2009 22:04:31 -0400
Received: by wf-out-1314.google.com with SMTP id 29so1458641wff.4
        for <linux-rt-users@vger.kernel.org>; Fri, 03 Apr 2009 19:04:30 -0700 (PDT)
In-Reply-To: <49b7c2350904021920o1fbffeffn22b9fa7ea1365db1@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

I solved  mounting error  with "acpi=3Doff  noapic nodma" options about
below problem .
 ( reference : ./linux-2.6.29-rt2/Documentation/x86/x86_64/boot-options=
=2Etxt )
Hope this helps for fedora users.
This is kernel issues? In fact, I am not sure.
Thanks reading.



2009/4/3 GeunSik Lim <leemgs1@gmail.com>:
> Hi, all.
>
> This is Result about Booting using linux-2.6.29-rt2 Kernel on X86 Tar=
gets.
> I used below desktop and netbook in this test.
> ---------------------------------------------------------------------=
----------------------------------------------------------------
> CPU Info of Desktop/Netbook =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Kernel
> =C2=A0 =C2=A0 =C2=A0 =C2=A0rootFS =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 Booting
> ---------------------------------------------------------------------=
----------------------------------------------------------------
> Intel Atom(TM) =C2=A0CPU N270 =C2=A0 @ 1.60GHz / =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 Linux-2.6.29-rt2
> Fedora 9 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Success
> Intel Core(TM)2 Quad CPU Q6600 @2.40GHz =C2=A0 =C2=A0same as above =C2=
=A0 =C2=A0 =C2=A0 CentOS
> 5.2 =C2=A0 =C2=A0 =C2=A0Success
> Intel Core(TM)2 Quad CPU Q6600 @2.40GHz =C2=A0 =C2=A0same as above =C2=
=A0 =C2=A0 =C2=A0 Ubuntu
> 8.04 =C2=A0 =C2=A0 =C2=A0Success
> Intel Core(TM)2 Quad CPU Q9300 @2.50GHz =C2=A0 =C2=A0same as above =C2=
=A0 =C2=A0 =C2=A0 Fedora
> 9 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Fail(Always)
> Intel Core(TM)2 Quad CPU Q8200 @2.33GHz =C2=A0 =C2=A0same as above =C2=
=A0 =C2=A0 =C2=A0 Fedora
> 9 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Fail(Always)
> ---------------------------------------------------------------------=
----------------------------------------------------------------
> -http://www.kernel.org/pub/linux/kernel/v2.6/testing/linux-2.6.29.tar=
=2Ebz2
> -http://www.kernel.org/pub/linux/kernel/projects/rt/older/patch-2.6.2=
9-rt2.bz2
> -config file: http://mfiles.naver.net/6eb85b8594cfa2143352/data42/200=
9/4/3/195/i386.2.6.29-rt2.ftrace.config-invain-invain.20090402?type=3Da=
ttachment
>
> I captured when display error messages on console.
> <error messages>
> mount: error mounting /dev/root on /sysroot as ext3: No such file or
> directory ......
>
> 2.6.29-rt1 kernel -->
> http://blogfiles7.naver.net/data41/2009/3/31/22/panic.2.6.29-rt1_inva=
in.png
> 2.6.29-rt2 kernel -->
> http://blogfiles5.naver.net/data42/2009/4/2/164/2.6.29-rt2.error.q820=
0_invain.png
>
>
> I read RedHat Bugzilla's pages about the problems.
> for example,
> https://bugzilla.redhat.com/show_bug.cgi?id=3D479188
>
> Anyone have this problems on Fedora Linux Distribution with linux-2.6=
=2E29-rt2 ?
>
> --
> Regards,
> GeunSik Lim
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kerne=
l" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
> Please read the FAQ at =C2=A0http://www.tux.org/lkml/
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
