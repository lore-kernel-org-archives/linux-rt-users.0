From: Mark Knecht <markknecht@gmail.com>
Subject: Re: [ANNOUNCE] 2.6.31.12-rt20
Date: Thu, 21 Jan 2010 14:03:01 -0800
Message-ID: <5bdc1c8b1001211403s32a4c571s11550b2af0f8af2b@mail.gmail.com>
References: <alpine.LFD.2.00.0902112332370.415@localhost.localdomain>
	 <alpine.LFD.2.00.0908261910460.2888@localhost.localdomain>
	 <alpine.LFD.2.00.0908282326460.19335@localhost.localdomain>
	 <alpine.LFD.2.00.0909152257590.8957@localhost.localdomain>
	 <alpine.LFD.2.00.0909190027400.2889@localhost.localdomain>
	 <alpine.LFD.2.00.0910061210400.2646@localhost.localdomain>
	 <alpine.LFD.2.00.0910141115020.9428@localhost.localdomain>
	 <alpine.LFD.2.00.0911061743210.12138@localhost.localdomain>
	 <alpine.LFD.2.00.0911101326280.2725@localhost.localdomain>
	 <alpine.LFD.2.00.1001212102220.2906@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: rt-users <linux-rt-users@vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-pz0-f201.google.com ([209.85.222.201]:55511 "EHLO
	mail-pz0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755418Ab0AUWJ5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 21 Jan 2010 17:09:57 -0500
Received: by pzk39 with SMTP id 39so345801pzk.15
        for <linux-rt-users@vger.kernel.org>; Thu, 21 Jan 2010 14:09:55 -0800 (PST)
In-Reply-To: <alpine.LFD.2.00.1001212102220.2906@localhost.localdomain>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Congrats and thanks for all the hard work. You guys make it possible.

- Mark

On Thu, Jan 21, 2010 at 1:23 PM, Thomas Gleixner <tglx@linutronix.de> w=
rote:
> We are pleased to announce the next update to our new preempt-rt
> series.
>
> =C2=A0 - forward to 2.6.31.12
>
> =C2=A0 - large number of RCU assumption fixes vs. cred and tasklist_l=
ock
>
> =C2=A0 - Priority Inheritance POSIX compliance fix
>
> =C2=A0 - workaround for Priority Protection POSIX compliance problem
>
> =C2=A0 - misc. fixlets here and there
>
> It took quite a while to get this update out for various reasons:
>
> =C2=A0 - mainline merge of the locking infrastructure changes which a=
re a
> =C2=A0 =C2=A0 further milestone on the way to full rt integration. Th=
at merge
> =C2=A0 =C2=A0 will shave off a large portion of the rt patch (don't w=
orry, we
> =C2=A0 =C2=A0 have enough new and exiting stuff in the pipeline to ke=
ep the
> =C2=A0 =C2=A0 patch size large enough)
>
> =C2=A0- fixing RCU assumptions in mainline and backport to 31-rt
>
> =C2=A0- lots of brain twisting around the POSIX scheduling policy
> =C2=A0 =C2=A0compliance problems which got reported vs. Priority
> =C2=A0 =C2=A0Inheritance/Protection
>
> =C2=A0- an extended christmas break and the resulting email backlog
>
> =C2=A0- our new housemate: http://tglx.de/~tglx/housemate.png
>
> Further plans:
>
> =C2=A0- a last big feature for 31-rt is pending, which is worth a sep=
arate
> =C2=A0 =C2=A0release: Nick Piggins VFS scalability patches. I'm still=
 running
> =C2=A0 =C2=A0tests on that, so no promise.
>
> =C2=A0- I'm going to switch 31-rt into maintaince mode (with or witho=
ut
> =C2=A0 =C2=A0the VFS patches) and concentrate on getting .33-rcX-rt o=
ut. Yes,
> =C2=A0 =C2=A0there will be no .32-rt. The reason is simply that the l=
ocking
> =C2=A0 =C2=A0changes which got merged into .33 are making my life eas=
ier and
> =C2=A0 =C2=A0are the base to sort out more ready for the mainline stu=
ff.
>
> Download locations:
>
> =C2=A0 http://rt.et.redhat.com/download/ (temporary out of sync)
> =C2=A0 http://www.kernel.org/pub/linux/kernel/projects/rt/
>
> Git release branch:
> =C2=A0 git://git.kernel.org/pub/scm/linux/kernel/git/tip/linux-2.6-ti=
p.git rt/2.6.31
>
> Git development branch:
> =C2=A0 git://git.kernel.org/pub/scm/linux/kernel/git/tip/linux-2.6-ti=
p.git rt/head
>
> Gitweb:
> =C2=A0 http://git.kernel.org/?p=3Dlinux/kernel/git/tip/linux-2.6-tip.=
git;a=3Dshortlog;h=3Drt/2.6.31
>
> Information on the RT patch can be found at:
>
> =C2=A0 http://rt.wiki.kernel.org/index.php/Main_Page
>
> to build the 2.6.31.12-rt20 tree, the following patches should be
> applied:
>
> =C2=A0 http://www.kernel.org/pub/linux/kernel/v2.6/linux-2.6.31.12.ta=
r.bz2
> =C2=A0 http://www.kernel.org/pub/linux/kernel/projects/rt/patch-2.6.3=
1.12-rt20.bz2
>
> Enjoy !
>
> =C2=A0 =C2=A0 =C2=A0tglx
>
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
