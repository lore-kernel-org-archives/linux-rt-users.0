Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DFB2C433B4
	for <linux-rt-users@archiver.kernel.org>; Tue, 20 Apr 2021 07:39:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C93FC61354
	for <linux-rt-users@archiver.kernel.org>; Tue, 20 Apr 2021 07:39:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbhDTHj6 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 20 Apr 2021 03:39:58 -0400
Received: from smtp2-g21.free.fr ([212.27.42.2]:30744 "EHLO smtp2-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229471AbhDTHj4 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 20 Apr 2021 03:39:56 -0400
Received: from zimbra35-e6.priv.proxad.net (unknown [172.20.243.185])
        by smtp2-g21.free.fr (Postfix) with ESMTP id DB14C200385;
        Tue, 20 Apr 2021 09:39:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
        s=smtp-20201208; t=1618904364;
        bh=c10ftkGMu3uK4hTT54u0XEuU5QePkKFvGzp6+sjndrA=;
        h=Date:From:To:Cc:In-Reply-To:Subject:From;
        b=OtmoZj3o2K8ZrIpWV6GOOfRthWEcr0SqSWot8XZ5ryQZNdD5TjkpGmaBtkdyQIVwO
         fnqITozJePcmvEsmy2GMe5hpW2i9Ubp4nYWNWmbepcTQ8rdHEg9gaXHGopNR6rNpvr
         KUZDsKwZkh3uU2BfkoUZcEeZly40O5h+IYfPHakWEWpWQqxv+3nUuHPok2Tqr6HXAN
         G34rWkrbnbDK54VT3XleF+qNJtYX4GlG57Pk385VWHyfwoA2hzggPOvvBlzG/TXWXi
         sqP2jOCG/f+qZPUgPZuAxjQrO3htaVyyUc1Y8dS5S/3aG00as6b5/150UXYpsprYJy
         zx6FxLwJQAx2Q==
Date:   Tue, 20 Apr 2021 09:39:23 +0200 (CEST)
From:   ycollette.nospam@free.fr
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <wagi@monom.org>,
        Tom Zanussi <zanussi@kernel.org>,
        "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Message-ID: <941471789.41891679.1618904363608.JavaMail.root@zimbra35-e6.priv.proxad.net>
In-Reply-To: <20210419184731.246fa474@gandalf.local.home>
Subject: Re: [ANNOUNCE] 5.10.30-rt37
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [79.83.134.110]
X-Mailer: Zimbra 7.2.0-GA2598 (ZimbraWebClient - FF3.0 (Linux)/7.2.0-GA2598)
X-Authenticated-User: ycollette.nospam@free.fr
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hello,

I tried to compile 5.0.30-rt37 on Fedora 33 and I met  the following error =
during compilation:

  CC      net/ipv4/datagram.o
In file included from ./include/linux/mmzone.h:16,
                 from ./include/linux/gfp.h:6,
                 from ./include/linux/mm.h:10,
                 from ./include/linux/bvec.h:14,
                 from ./include/linux/skbuff.h:17,
                 from ./include/net/xfrm.h:9,
                 from net/xfrm/xfrm_state.c:18:
net/xfrm/xfrm_state.c: In function 'xfrm_state_init':
./include/linux/seqlock.h:178:36: error: initialization of 'seqcount_spinlo=
ck_t *' {aka 'struct seqcount_spinlock *'} from incompatible pointer type '=
seqcount_t *' {aka 'struct seqcount *'} [-Werror=3Dincompatible-pointer-typ=
es]
  178 |   seqcount_##lockname##_t *____s =3D (s);   \
      |                                    ^
./include/linux/seqlock.h:184:42: note: in expansion of macro 'seqcount_LOC=
KNAME_init'
  184 | #define seqcount_spinlock_init(s, lock)  seqcount_LOCKNAME_init(s, =
lock, spinlock)
      |                                          ^~~~~~~~~~~~~~~~~~~~~~
net/xfrm/xfrm_state.c:2666:2: note: in expansion of macro 'seqcount_spinloc=
k_init'
 2666 |  seqcount_spinlock_init(&net->xfrm.xfrm_state_hash_generation,
      |  ^~~~~~~~~~~~~~~~~~~~~~
cc1: some warnings being treated as errors
make[2]: *** [scripts/Makefile.build:279: net/xfrm/xfrm_state.o] Error 1
make[1]: *** [scripts/Makefile.build:496: net/xfrm] Error 2
make[1]: *** Waiting for unfinished jobs....


Best regards,

Yann

----- Mail original -----
De: "Steven Rostedt" <rostedt@goodmis.org>
=C3=80: "LKML" <linux-kernel@vger.kernel.org>, "linux-rt-users" <linux-rt-u=
sers@vger.kernel.org>
Cc: "Thomas Gleixner" <tglx@linutronix.de>, "Carsten Emde" <C.Emde@osadl.or=
g>, "John Kacur" <jkacur@redhat.com>, "Sebastian Andrzej Siewior" <bigeasy@=
linutronix.de>, "Daniel Wagner" <wagi@monom.org>, "Tom Zanussi" <zanussi@ke=
rnel.org>, "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>
Envoy=C3=A9: Mardi 20 Avril 2021 00:47:31
Objet: [ANNOUNCE] 5.10.30-rt37


Dear RT Folks,

I'm pleased to announce the 5.10.30-rt37 stable release.


This release is just an update to the new stable 5.10.30 version
and no RT specific changes have been made.


You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v5.10-rt
  Head SHA1: 1df1cfc1a111790bb79975f27a1bda9bc632a940


Or to build 5.10.30-rt37 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v5.x/linux-5.10.tar.xz

  http://www.kernel.org/pub/linux/kernel/v5.x/patch-5.10.30.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/5.10/patch-5.10.30-rt3=
7.patch.xz




Enjoy,

-- Steve

