Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D100C4338F
	for <linux-rt-users@archiver.kernel.org>; Sat, 31 Jul 2021 01:03:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14A9560D07
	for <linux-rt-users@archiver.kernel.org>; Sat, 31 Jul 2021 01:03:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234449AbhGaBEA (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 30 Jul 2021 21:04:00 -0400
Received: from mout.gmx.net ([212.227.17.22]:48125 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231337AbhGaBEA (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 30 Jul 2021 21:04:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1627693386;
        bh=NvOfU3vudpzB1gN5IEwQ5eLbIIUMOlAEGpRRt0GcmFc=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=dchH6Y5DFoQETsLyZZrR+3Xikxk65wH5ZhLy2KReA28gV5HAXWTkHjtXRITI7lcxg
         XrR6uqAPaaJ2FiId87sScpobl74gn6DGlkW3VRYLyXnzCZf2hNO7SYMuCYB5OIjXA7
         rDuPiBwWGoluy26Z+Dqd4iXWcpPh2AqD4oPzejl4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.191.218.109]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mkpap-1mtOp330aF-00mKKf; Sat, 31
 Jul 2021 03:03:06 +0200
Message-ID: <a2cd339c0e440cb5beed788d66a19a636b2e39a1.camel@gmx.de>
Subject: Re: v5.14-rc3-rt1 losing wakeups?
From:   Mike Galbraith <efault@gmx.de>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>
Date:   Sat, 31 Jul 2021 03:03:05 +0200
In-Reply-To: <87pmuzsf1p.ffs@tglx>
References: <20210730110753.jvli6alm63h5lefy@linutronix.de>
         <2ae27233ab091d09a7d1e971a47144b40dd51fa0.camel@gmx.de>
         <87pmuzsf1p.ffs@tglx>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.3 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:bCXKUODlOQ6QM5iOrYOPoKcIvbkBA8A5IGmVMGbcy3cq4/hVBAI
 RV6h3F6QP0iFymw2b9VqB54kUKNPo4FNgqMJHXi8bVN4dUAEnLAokYqWqKjXrN2Yeg6hFbS
 KVJPkpGrlR3LmhWHb8NJPnzi/6vGExtYHntNCq9stT/PeCqVdbbShqqXuXGhHnqjxKlfc93
 2KnRuBU9XlaXjctQlwNVg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:xGJ0rSlsorU=:fV7AumzYQ9S3xUV8SA+gnG
 EibBGX0yKXcMfdQpXAdPLI5/d2SzX7nfc2bWmAw2igUgWcet9zDpM2vCd+jDXemdwm4ZxA7Gb
 IVNr7ZpA5ozYv1oDB0gk0Fg1DiIfw8eZXv4O5m5ZgoHaWnoWgeFS8sYdm5xFZoj5iYWeRPzDO
 dMYU+u/76nSK8L7odc21vydUPGlhw9aTyrOYb/KS/ojgFelZ2R0801UaWsfUZCVc6+bzAKxsz
 a5/F5JS11bnDQKZ21vhBFWM7bwX+dsVn4geSk8Ar3P1tXVfsTKb935OfCQIcEuItE972Gia9h
 bhI0etmAjZ9mCtgCBORNvB5qVZkekzt+nEPeCMGuQLpdRj+zI6azvPsoEyLnFYWx35PJNF1Yd
 1EmZ3BlTMTIcQbmQ7cZpXmsyVUN70W8gRc+IyRfWUoIuruvkgX5+cjpf+pR8UlstqEODrAWkc
 HxEQ13SmqfnKJ+FjR2XWH5QUDL5CoCtDgcT8iKeqJNmUUDd/JnWwcPsIbe+Z30wC6IpGqj29z
 tlPmDfV2YIRqXluzXqB+ds4QPrCkmAUfPpyaRQXUX23zr18IDJ39x/bSu07m4M5g0A1G9gRuM
 lORPkH2/q3Dz9Ml8RIB1eOEPVydgBq/2CYqFmnqGg69B+x32e+9wlWc1T6vjY7+V9TEl7J7ug
 /NWgW2j54Q6HVFbtAQLJRfJUXIbRK26qz8WExSXiRruL61Hir+kQL5JWgLPEFe7SZZoPLf7af
 Fw9as4GFx+Vwr8Tc2lCjcLp+3dFJlN0BiSciC6LINlBp3oEapucbgD0a2AR4dS6HbIdFmqgJA
 jJxtPnSxE5hvZCdqi2LlAu7IVilLb1TVVe+SBkr1efvJg4FYFlH2PTN1tSM45CUs04F/7/GrO
 yH2pxksRBwD6NXUsEvVn92QZ7yxDJsvgTsGUyTwDLM5BdFdzClSZkuv582D17QqIXdu2zcwFI
 5VyIqXI76Qmm61a2poVX/CuuPkOzdQWro+6PQOMZPNYhE9XLtoHKcnOHL96ECdiqaRCAIdQxO
 etrKuWb32oCozrZ+LwlvnTNYieQ6p+AAO0htCFGy6oEDS3okbF0eNy5b0zMYnqN/uSfn2eEyF
 6Nz9D1ehc4FtRE9p5ehSA47UjnSw6YH4K2u
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Fri, 2021-07-30 at 22:49 +0200, Thomas Gleixner wrote:
> >
> > First symptom is KDE/Plasma's task manager going comatose.=C2=A0 Notic=
e soon
>
> KDE/Plasma points at the new fangled rtmutex based ww_mutex from
> Peter.

Yeah, that seems to be most of the delta from 50->62 [now 63] commit
delta, and the 50 turning out to be what I was already running.  I'm
staring, but as yet, nothing has poked me in the eye.

>  I tried to test the heck out of it...

And futextests, rt-tests etc work fine, just stay away from GUI.

> Which graphics driver is in use on that machine?

The all too often problem child nouveau, but I don't _think_ it's
playing a roll in this, as nomodeset hangs as well.  I'll stuff it into
lappy (i915) to double check that.

	-Mike

