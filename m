From: "Gilles.Carry" <Gilles.Carry@ext.bull.net>
Subject: Re: rt-sources 2.6.26.6-rt11 fails to make
Date: Thu, 18 Dec 2008 08:19:02 +0100
Message-ID: <4949F966.8040903@ext.bull.net>
References: <20081217150402.cafa8173a4e6358765f4d9836504dcb0.e8d81f4a79.wbe@email.secureserver.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org
To: Audiodef <damien@audiodef.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:44478 "EHLO
	ecfrec.frec.bull.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751434AbYLRHVr (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 18 Dec 2008 02:21:47 -0500
In-Reply-To: <20081217150402.cafa8173a4e6358765f4d9836504dcb0.e8d81f4a79.wbe@email.secureserver.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Audiodef a =C3=A9crit :
> Hi everyone,
>=20
> I'm trying to set up a Gentoo Linux box with the goal of eventually
> getting rid of Windoze completely (I currently have 1 remaining Windo=
ze
> workstation because of my Mackie Onyx (w/ Firewire) mixers). So I tri=
ed
> to compile rt-sources 2.6.26.6-r11 and this is what happened:
>=20
>  CHK include/linux/version.h
>  CHK include/linux/utsrelease.h
>  CC arch/x86/kernel/asm-offsets.s
> In file included from include/linux/notifier.h:14,
>  from include/linux/memory_hotplug.h:6,
>  from include/linux/mmzone.h:560,
>  from include/linux/gfp.h:4,
>  from include/linux/slab.h:12,
>  from include/linux/percpu.h:5,
>  from include/linux/rcupdate.h:39,
>  from include/linux/tracepoint.h:18,
>  from include/linux/module.h:19,
>  from include/linux/crypto.h:21,
>  from arch/x86/kernel/asm-offsets_32.c:7,
>  from arch/x86/kernel/asm-offsets.c:2:
> include/linux/rwsem.h:150: error: redefinition of 'rwsem_is_locked'
> include/asm/rwsem.h:261: error: previous definition of 'rwsem_is_lock=
ed'
> was here
> include/linux/rwsem.h: In function 'rwsem_is_locked':
> include/linux/rwsem.h:151: error: implicit declaration of function
> 'compat_rwsem_is_locked'
> make[1]: *** [arch/x86/kernel/asm-offsets.s] Error 1
> make: *** [prepare0] Error 2=20
>=20

Hello,

Read this:
http://lkml.org/lkml/2008/9/29/116
and this:
http://lkml.indiana.edu/hypermail/linux/kernel/0809.3/1878/rwsem_is_loc=
ked-fix.patch


Regards,
Gilles.

--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
