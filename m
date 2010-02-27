From: GeunSik Lim <leemgs1@gmail.com>
Subject: Re: [ANNOUNCE] 2.6.33-rt3
Date: Sat, 27 Feb 2010 18:50:36 +0900
Message-ID: <49b7c2351002270150l1ed375et71821ffdbbe26d13@mail.gmail.com>
References: <alpine.LFD.2.00.1002241740410.4245@localhost.localdomain>
	 <alpine.LFD.2.00.1002262041020.4245@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: LKML <linux-kernel@vger.kernel.org>,
	rt-users <linux-rt-users@vger.kernel.org>,
	Ingo Molnar <mingo@elte.hu>,
	Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Clark Williams <williams@redhat.com>, nando@ccrma.stanford.edu,
	Carsten Emde <ce@ceag.ch>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-qy0-f179.google.com ([209.85.221.179]:35207 "EHLO
	mail-qy0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S968079Ab0B0Juh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 27 Feb 2010 04:50:37 -0500
In-Reply-To: <alpine.LFD.2.00.1002262041020.4245@localhost.localdomain>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Dear Thomas,

Thank you for notice about 2.6.33 based -rt3.

I tested system booting with linux-2.6.33-rt3 on my Q6600 based Desktop=
=2E
=46or reference, I am using Centos 5.4 rootFS.
As a result, I booted this version on my desktop successfully.

* Booting result of linux-2.6.33-rt3 on Q6600 PC. --> Passed.
http://picasaweb.google.com/leemgs/LinuxRelatedScreenshot#5442856195052=
253634

Regards,
Geunsik Lim.

On Sat, Feb 27, 2010 at 4:54 AM, Thomas Gleixner <tglx@linutronix.de> w=
rote:
> We are pleased to announce the next update to our new preempt-rt
> series.
>
> =C2=A0 =C2=A0- Update to 2.6.33
>
> =C2=A0 =C2=A0- rt fixes:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 Peter Zijlstra (1):
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 highmem, -rt: Implem=
ent pfn and prot kmaps
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0Thomas Gleixner (2):
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 x86: pci: Prevent mm=
config memory corruption
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mmc: omap_hsmmc: Fix=
 the locking mess
>
> A note on the development process:
>
> =C2=A0The rt/2.6.33 branch is now stabilization only. The rt/head bra=
nch
> =C2=A0will follow linus tree from now on, so it will inherit all
> =C2=A0(mis)features which come in the merge window.
>
> Download locations:
>
> =C2=A0 http://www.kernel.org/pub/linux/kernel/projects/rt/
>
> Git development branch:
> =C2=A0 git://git.kernel.org/pub/scm/linux/kernel/git/tip/linux-2.6-ti=
p.git rt/head
>
> Git release branch:
> =C2=A0 git://git.kernel.org/pub/scm/linux/kernel/git/tip/linux-2.6-ti=
p.git rt/2.6.33
>
> Gitweb:
> =C2=A0 http://git.kernel.org/?p=3Dlinux/kernel/git/tip/linux-2.6-tip.=
git;a=3Dshortlog;h=3Drt/2.6.33
>
> Information on the RT patch can be found at:
>
> =C2=A0 http://rt.wiki.kernel.org/index.php/Main_Page
>
> To build the 2.6.33-rt3 tree, the following patches should be
> applied:
>
> =C2=A0 http://www.kernel.org/pub/linux/kernel/v2.6/linux-2.6.33.tar.b=
z2
> =C2=A0 http://www.kernel.org/pub/linux/kernel/projects/rt/patch-2.6.3=
3-rt3.bz2
>
> Enjoy !
>
> =C2=A0 =C2=A0 =C2=A0tglx
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-us=
ers" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
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
