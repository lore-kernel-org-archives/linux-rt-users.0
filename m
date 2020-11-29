Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0108FC3E8C5
	for <linux-rt-users@archiver.kernel.org>; Sun, 29 Nov 2020 06:43:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84F5E207BC
	for <linux-rt-users@archiver.kernel.org>; Sun, 29 Nov 2020 06:43:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="FPEJN+1j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725912AbgK2Gnn (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sun, 29 Nov 2020 01:43:43 -0500
Received: from mout.gmx.net ([212.227.17.21]:33173 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725828AbgK2Gnm (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Sun, 29 Nov 2020 01:43:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1606632088;
        bh=fCWPWMom4CBnkfFlttg3JFbO+85K6yihPMP/Yycb3Mc=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=FPEJN+1jSmXd6xpA9SmN6wsIXPYCa/6dPwz/g97heECAairmWv1SoiCwnEwYSnC4l
         nZqhCqoUjHtwzaovXHEam7hCL7uSjlccUe3UbxfgG07QlXC+NXMgjg+YTTHjR78gvI
         XcvAL5lEAHb3B4Rn2vKnM6THBT8B5lL9MVjAxKyM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.191.218.83]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MjjCF-1kKQ2l0S0x-00lAJD; Sun, 29
 Nov 2020 07:41:28 +0100
Message-ID: <15171df044b167351e7f6a688aabd71bade9ae2a.camel@gmx.de>
Subject: Re: scheduling while atomic in z3fold
From:   Mike Galbraith <efault@gmx.de>
To:     Oleksandr Natalenko <oleksandr@natalenko.name>,
        linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-rt-users@vger.kernel.org
Date:   Sun, 29 Nov 2020 07:41:26 +0100
In-Reply-To: <20201128142723.zik6d5skvt3uwu5f@spock.localdomain>
References: <20201128140523.ovmqon5fjetvpby4@spock.localdomain>
         <20201128140924.iyqr2h52z2olt6zb@spock.localdomain>
         <20201128142723.zik6d5skvt3uwu5f@spock.localdomain>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vQVwnfLQ7SUFijawEudOBEUX2bvdX0ddMTBTNZH9SYYoeDo3IsB
 lxcV+LFrl4+hDqi3ethkrXpsFraWP6fYogvnMRdqTUvD1SwOeIaKfLGZcAknGitv0S6qTAM
 tjXQpeyfLiCqgrlyohEAruKGwWRF1kmTqFXd5bpEmUJSU4hU6oFZTm1o5lA4C5aERkvEYhk
 +z9pL4oOaRvGye3ncvwXg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:803a9b8iOAI=:fMQ3UE+K1ja4qAdVdstH2e
 fs+VCZbD2lyDg3IEOrdGviXq3sGR5lOQp2lPpV+J5i9xMrtYAbC5F9UuESVG+b9FJHyMT16IB
 X3FmK2NPIVcPUJG4ox0PYdGLZ+oXkRz7dTGwzECAigUhWNw2qZycK/HewK6UK6PhRdKApzTxG
 ZbOU+lWv3FVv5aIHpVqJ7+0cqidBbacwmi8ZnUZzn0gyXc7eQX2CVH1Te8r8bRxut2mDBYFvF
 HA/vttloh/KEkXeJoKBmHfyD+svxFBIisp6jBptah0qi0lsrwmSMupfo4Q9AJTeR2yMUp5ViP
 ebGcvB6EpPd9C6yGNvDnXz6Pb/jOvNidxxFzMyXhlt7R5B2mAvHzTuWNYLmf0a1SWgXT0X54y
 mBW6H3jaZRF0uq+ugy1GG6cytAAiI+QXYwRS4udWjlTvRnbYKN+pu8yOc7fxVPApfZeOCkOWV
 zdsLJFmQXH51GtiAxkCAWKDhoJ7G9Sv/BiFqNzP7Bilcd/F48i4pBaE9ZrTDadGN/jzmg3T1J
 hgeS/BM4aUYY3/cDdsZ2QxyVUfbeqShMGlikuFtgon59YcZNO+vFidKKbBKofg6lk0W3EnpXt
 ksCd9Wwy+/Vv8HSKFFkyVaBZs5N/A/+SmCzKXAlBzV4zlONpMg3Nu+zhPCFuuu2UTSIPZbTXh
 AVazuER1mvdvWP+j7qY+SAK7PJYv2eeK4mLzksWZQ57sTp6ckblkFH3L52JYwFMcYMvYrWo4N
 74JRxOtjDbUzNPUXADhmjhmY7XOpUq4lt8FwLcQv+w7eoGzIJtZx8JKeLurjvdSbuYd724oXC
 w92C/xgcnbPBjnNw+hdBfDmkMzy3RF0TfUBVjpW49T/q94ZhuDOgoVL+skv7crkTiMDm1jGhQ
 PbeJJuNTlh8rYyhVMcGQ==
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Sat, 2020-11-28 at 15:27 +0100, Oleksandr Natalenko wrote:
>
> > > Shouldn't the list manipulation be protected with
> > > local_lock+this_cpu_ptr instead of get_cpu_ptr+spin_lock?
>
> Totally untested:

Hrm, the thing doesn't seem to care deeply about preemption being
disabled, so adding another lock may be overkill.  It looks like you
could get the job done via migrate_disable()+this_cpu_ptr().

In the case of the list in __z3fold_alloc(), after the unlocked peek,
it double checks under the existing lock.  There's not a whole lot of
difference between another cpu a few lines down in the same function
diddling the list and a preemption doing the same, so why bother?

Ditto add_to_unbuddied().  Flow decisions are being made based on zhdr-
>first/middle/last_chunks state prior to preemption being disabled as
the thing sits, so presumably their stability is not dependent thereon,
while the list is protected by the already existing lock, making the
preempt_disable() look more incidental than intentional.

Equally untested :)

=2D--
 mm/z3fold.c |   17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

=2D-- a/mm/z3fold.c
+++ b/mm/z3fold.c
@@ -642,14 +642,16 @@ static inline void add_to_unbuddied(stru
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

@@ -886,8 +888,9 @@ static inline struct z3fold_header *__z3
 	int chunks =3D size_to_chunks(size), i;

 lookup:
+	migrate_disable();
 	/* First, try to find an unbuddied z3fold page. */
-	unbuddied =3D get_cpu_ptr(pool->unbuddied);
+	unbuddied =3D this_cpu_ptr(pool->unbuddied);
 	for_each_unbuddied_list(i, chunks) {
 		struct list_head *l =3D &unbuddied[i];

@@ -905,7 +908,7 @@ static inline struct z3fold_header *__z3
 		    !z3fold_page_trylock(zhdr)) {
 			spin_unlock(&pool->lock);
 			zhdr =3D NULL;
-			put_cpu_ptr(pool->unbuddied);
+			migrate_enable();
 			if (can_sleep)
 				cond_resched();
 			goto lookup;
@@ -919,7 +922,7 @@ static inline struct z3fold_header *__z3
 		    test_bit(PAGE_CLAIMED, &page->private)) {
 			z3fold_page_unlock(zhdr);
 			zhdr =3D NULL;
-			put_cpu_ptr(pool->unbuddied);
+			migrate_enable();
 			if (can_sleep)
 				cond_resched();
 			goto lookup;
@@ -934,7 +937,7 @@ static inline struct z3fold_header *__z3
 		kref_get(&zhdr->refcount);
 		break;
 	}
-	put_cpu_ptr(pool->unbuddied);
+	migrate_enable();

 	if (!zhdr) {
 		int cpu;

