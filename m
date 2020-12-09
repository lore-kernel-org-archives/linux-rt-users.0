Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4240C4361B
	for <linux-rt-users@archiver.kernel.org>; Wed,  9 Dec 2020 06:34:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C10D123B86
	for <linux-rt-users@archiver.kernel.org>; Wed,  9 Dec 2020 06:34:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728117AbgLIGeE (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 9 Dec 2020 01:34:04 -0500
Received: from mout.gmx.net ([212.227.17.21]:51135 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725892AbgLIGeE (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 9 Dec 2020 01:34:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1607495507;
        bh=oF+jgZSk0/ApQ0CUxxispVHjMEEdWgmI5TN+uGVhzCw=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=TWoTAIaOVQb7f+m3ckjebDQ+UTNrKXeGtY6tL481lIXard5qfA4kVPfX6lyrPfAD5
         6y+noePn7cLUVvjGanR12ho3oZbw/5a52porZ/iX9w/uBMcI3DH3COcQ3tjMBYzQ/j
         MpM1MKN48GCjL84zuSbh/7Vwg8neRfbZxKr/ad3I=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.146.49.92]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mt79F-1jyckE0ANF-00tSrP; Wed, 09
 Dec 2020 07:31:47 +0100
Message-ID: <e1bd1eb367b57c0ac7f7bd48b1c190befde99126.camel@gmx.de>
Subject: Re: scheduling while atomic in z3fold
From:   Mike Galbraith <efault@gmx.de>
To:     Vitaly Wool <vitaly.wool@konsulko.com>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-rt-users@vger.kernel.org
Date:   Wed, 09 Dec 2020 07:31:43 +0100
In-Reply-To: <35863f8cbdb99b2a7eeac3bca13ae6962d6a98c0.camel@gmx.de>
References: <90c4857c53b657147bfb71a281ece9839b0373c2.camel@gmx.de>
         <856b5cc2a3d4eb673743b52956bf1e60dcdf87a1.camel@gmx.de>
         <20201130145229.mhbkrfuvyctniaxi@linutronix.de>
         <05121515e73891ceb9e5caf64b6111fc8ff43fab.camel@gmx.de>
         <20201130160327.ov32m4rapk4h432a@linutronix.de>
         <fca7ecadf1bddafb7e88cbeb4a57d1464c87b044.camel@gmx.de>
         <20201202220826.5chy56mbgvrwmg3d@linutronix.de>
         <abe48cb9ab522659a05d7e41ce07317da2a85163.camel@gmx.de>
         <64ab382309c41ca5c7a601fc3efbb6d2a6e68602.camel@gmx.de>
         <20201203133934.37aotbdjnd36lrxv@linutronix.de>
         <10d5088861ba219f3f7cd657fc95b0bedc19010a.camel@gmx.de>
         <cad7848c-7fd3-b4a4-c079-5896bb47ee49@konsulko.com>
         <3ffed6172820f2e8e821e1b8817dbd0bdd693c26.camel@gmx.de>
         <CAM4kBBL5+xNWq6DWHY6nQjwDTj8PZKem-rGuFvimi7jekjA+Xw@mail.gmail.com>
         <3ec93680c6a27626b23e99d552aa778be7b2ecec.camel@gmx.de>
         <CAM4kBBJ2jqBKdTPWPZEfuc17yiARMr_NwOSoHL_r0eC9n7UpUQ@mail.gmail.com>
         <9bd908b65ef15149458aa060c0daf065f9d45615.camel@gmx.de>
         <159ce32b-a7c4-08be-9283-9e38a7c27848@konsulko.com>
         <35863f8cbdb99b2a7eeac3bca13ae6962d6a98c0.camel@gmx.de>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6VUkP/TS9+Uo/OQVOwbD8JnTS/6WTvChuI4SSfS1LdjXlap4d3V
 GE0uxVeL6TImC5YooDgOiMKz3vkkwyl+7M6U4b2rPySepdEXXVw0kKn8TQvybxgNeg8Sqv8
 G1Ey1xhoeCpET5Yacc0nek094+cXD6xPr/+V6E3Zbty2RIyb0+ph6LsNMGHFyCW10gk1g3b
 sB5Va0ITLCG5PkPk/JtwQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:CUhKsH1FlZM=:sG4PUUCZQcbH7M0hY+nbV2
 47T/8lULS0w/ylgnr+LQdtW88AJGnaskn2sEIb02hUxMIqXtOqwyE37pIrhefDxcopVoD1voD
 NwahgajA3orPKhuS5ksRWmnru5FZAUtw7RhPNUNTZfUOZ5zzq7X5/lYyw9W98uq/RGoBCXKtB
 ePYA94ZMQbB5T+ru/Hifp5/2T/Zakzh3VNzNrjiojRXXl9oNxoh63OtMFrULFznlDqFjA6kkn
 CnerMbYfTmnChTxfbEn5sIkB2vanRRbb3gvjIKg3hD71ekop+DzQtCb/GRHNz5dXf8MwUEt6i
 jeT/KRSULIzK+O6BV9UfOLNguzIeaoH9njX51ZA4fkAzt3pELJeU9XHTzCsEHd5aVna791KSf
 JDs0a4MGMrXCfx4UV5pas9txny0hCjZjt/mQxwoyDhbxnHuwmEi7fO27teIW3Zslgh8t04jXd
 uzGCRY1AllHt8LWVaQA2U/1cYpGBRKqkcfQaN+bNxAKCQFOuAirDwnQ5p3pgKRJTGaGofg1h5
 R0c6/wm4gchnEDJ43D/PVdnBUApBD6ffbJl3eg44E+py5KVPbUrCeM2qqh884i2PpSY6BxVcE
 gL3wjvGjzkOuqVeH/VDC34QFbqo8OPMOqzkW5FZfzzVZrV4Y1P1zkHV/MT6y+hUVJJ5HqwqaH
 NEGdyXK/BL+vhjozIBhfi943ujdCX4nKpmbWvNfveOQsQEinQGsLEuuIeBYmlg6qs0gG5iyQX
 3oR0WEp214r/f6UFdYpN9TwbnpRMszDClOjwec0nhCzhbs9WmA2KD6+aQhSPl8cIoL3Bi3MWy
 nHxjn/Fv5MYUmqGq9UxW7yevdJ9L0dmK56YuBbuo2TMGCdJG4ENAXjRwhg7Utp0JM94458bhl
 br9jGOHQq/loL1bdVBV1Kf/gQK5oupGmLa581dBYWHvrGuHiIudnQVTxvG6Kty
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Wed, 2020-12-09 at 07:13 +0100, Mike Galbraith wrote:
> On Wed, 2020-12-09 at 00:26 +0100, Vitaly Wool wrote:
> > Hi Mike,
> >
> > On 2020-12-07 16:41, Mike Galbraith wrote:
> > > On Mon, 2020-12-07 at 16:21 +0100, Vitaly Wool wrote:
> > >> On Mon, Dec 7, 2020 at 1:34 PM Mike Galbraith <efault@gmx.de> wrote=
:
> > >>>
> > >>
> > >>> Unfortunately, that made zero difference.
> > >>
> > >> Okay, I suggest that you submit the patch that changes read_lock() =
to
> > >> write_lock() in __release_z3fold_page() and I'll ack it then.
> > >> I would like to rewrite the code so that write_lock is not necessar=
y
> > >> there but I don't want to hold you back and it isn't likely that I'=
ll
> > >> complete this today.
> > >
> > > Nah, I'm in no rush... especially not to sign off on "Because the
> > > little voices in my head said this bit should look like that bit ove=
r
> > > yonder, and testing _seems_ to indicate they're right about that" :)
> > >
> > > 	-Mike
> > >
> >
> > okay, thanks. Would this make things better:
>
> Yup, z3fold became RT tolerant with this (un-munged and) applied.

Below is the other change that any RT users of z3fold will need.

mm, z3fold: Remove preempt disabled sections for RT

Replace get_cpu_ptr() with migrate_disable()+this_cpu_ptr() so RT can take
spinlocks that become sleeping locks.

Signed-off-by Mike Galbraith <efault@gmx.de>
=2D--
 mm/z3fold.c |   17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

=2D-- a/mm/z3fold.c
+++ b/mm/z3fold.c
@@ -617,14 +617,16 @@ static inline void add_to_unbuddied(stru
 {
 	if (zhdr->first_chunks =3D=3D 0 || zhdr->last_chunks =3D=3D 0 ||
 			zhdr->middle_chunks =3D=3D 0) {
-		struct list_head *unbuddied =3D get_cpu_ptr(pool->unbuddied);
-
+		struct list_head *unbuddied;
 		int freechunks =3D num_free_chunks(zhdr);
+
+		migrate_disable();
+		unbuddied =3D this_cpu_ptr(pool->unbuddied);
 		spin_lock(&pool->lock);
 		list_add(&zhdr->buddy, &unbuddied[freechunks]);
 		spin_unlock(&pool->lock);
 		zhdr->cpu =3D smp_processor_id();
-		put_cpu_ptr(pool->unbuddied);
+		migrate_enable();
 	}
 }

@@ -861,8 +863,9 @@ static inline struct z3fold_header *__z3
 	int chunks =3D size_to_chunks(size), i;

 lookup:
+	migrate_disable();
 	/* First, try to find an unbuddied z3fold page. */
-	unbuddied =3D get_cpu_ptr(pool->unbuddied);
+	unbuddied =3D this_cpu_ptr(pool->unbuddied);
 	for_each_unbuddied_list(i, chunks) {
 		struct list_head *l =3D &unbuddied[i];

@@ -880,7 +883,7 @@ static inline struct z3fold_header *__z3
 		    !z3fold_page_trylock(zhdr)) {
 			spin_unlock(&pool->lock);
 			zhdr =3D NULL;
-			put_cpu_ptr(pool->unbuddied);
+			migrate_enable();
 			if (can_sleep)
 				cond_resched();
 			goto lookup;
@@ -894,7 +897,7 @@ static inline struct z3fold_header *__z3
 		    test_bit(PAGE_CLAIMED, &page->private)) {
 			z3fold_page_unlock(zhdr);
 			zhdr =3D NULL;
-			put_cpu_ptr(pool->unbuddied);
+			migrate_enable();
 			if (can_sleep)
 				cond_resched();
 			goto lookup;
@@ -909,7 +912,7 @@ static inline struct z3fold_header *__z3
 		kref_get(&zhdr->refcount);
 		break;
 	}
-	put_cpu_ptr(pool->unbuddied);
+	migrate_enable();

 	if (!zhdr) {
 		int cpu;

