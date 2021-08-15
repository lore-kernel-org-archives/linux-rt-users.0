Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88DE1C4338F
	for <linux-rt-users@archiver.kernel.org>; Sun, 15 Aug 2021 04:17:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4AB42600CC
	for <linux-rt-users@archiver.kernel.org>; Sun, 15 Aug 2021 04:17:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbhHOERr (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sun, 15 Aug 2021 00:17:47 -0400
Received: from mout.gmx.net ([212.227.15.18]:59565 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229452AbhHOERq (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Sun, 15 Aug 2021 00:17:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1629001022;
        bh=28Cm88gB91O+DOo2cXrYee+kaKO5JMPkKnACkSuChu4=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=CXer1sPzt2AIwzMLMHXGIwNF6/oDtbpZdLGBCW3YFUyLc4rCaJTsQJ0oFwxh3njky
         JmhSkDcHNfijoiGF84VqSks9qKnoHvS+5J6OOnlZiBgrEcCEDFqPKW7fFTE3SgxbKg
         TYYHXE8953fmDGvbHUA17XKGv1iOSz2pmYR85OVk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.146.48.238]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MNswE-1mQBHC2AkS-00OJOZ; Sun, 15
 Aug 2021 06:17:02 +0200
Message-ID: <5dbf6cf9e82ef15ce0febf070608da2d5b128763.camel@gmx.de>
Subject: Re: [ANNOUNCE] v5.14-rc5-rt8
From:   Mike Galbraith <efault@gmx.de>
To:     Vlastimil Babka <vbabka@suse.cz>,
        Clark Williams <williams@redhat.com>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        RT <linux-rt-users@vger.kernel.org>
Date:   Sun, 15 Aug 2021 06:17:01 +0200
In-Reply-To: <96ceab8e-4bf9-147a-e931-848676003c3f@suse.cz>
References: <20210810163731.2qvfuhenolq2gdlv@linutronix.de>
         <20210812151803.52f84aaf@theseus.lan>
         <5f0c793d-5084-4607-8475-209fa7310ba2@suse.cz>
         <20210812162448.26274298@theseus.lan>
         <bb98b54c-6d88-2a56-4998-51a304c19e8c@suse.cz>
         <20210812164440.0426d8b7@theseus.lan>
         <96ceab8e-4bf9-147a-e931-848676003c3f@suse.cz>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.3 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:zOks0Z9lu4N4TQjHJJD53Xx17gxenPlj6wnwUl+gsW3D30qhNSO
 ErovfmyBVvAI2ONYC+X1kt3hSdMs5/y6WAnQN/q7OXYTNKq79pwIi0QfcjzFzk5NQRHJpQX
 PM3A/fGgmWPuIXEekpw4K3+TPpLkv7UMLQLojc//MbY5yTfG/o/kKaMlFju0KkT5A+IU5ua
 VAH2LoQ9XwrKhSK3weTnw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:nP1cVzObGqs=:7Ui9MoAU51KEcfRbs8YPRA
 AoFQzhZ99vY8S8jfP759kmx+/hBdtbTqtqaPkVuNlKpv185YmLSYXVRSSqwkWt7p6gR79MZHH
 5/lezqhtdryPdvZs9UVa4xUKiCk4e0EE+4yoooihHcxCV0Sz25ZVuifjmBU5ZnL5yLeTvwsQ4
 0EKadMWOrZic0xylEB61gwmPrE8n8scDqmZa4MzqZRfzCEKN12gILpof32V5+YHT2wQFOAgaP
 NRnkG4yRhCVr4qNOHwthC8+FtmYzs0Z9ZLX3g28SRzjo3rSo0Rxugww88zGXcaK86Np1nSvYG
 PV7+0E9Ng1+VHpYhWn0m2YqqYO6CyHYiGZteDsS9JdaIxAxQiV0/KQCRWQ1cdpi7gops9ovPp
 MVTG/6eJj4VUYYi+1wk9ZWpNTL86cl5n3JoLwMCXrVZHeOHlJ/AjkBIvOyMclBWLHCsEjhL30
 qm9ClweJm0aSV458H7XYLqKM638wlmPJotTgtvUKBMxaCqa6eT9W9XH9F0XNvlTJMNSD7Wsat
 D3qvq60w5NeiXllQ9NyFIdDV26BGm6X/CGHiVuBl6rZ2uwSQAjvlAIztAhtXJ7fVxpQUF+9Uz
 ik0mo3oh0jNSE02duoe9pZfNEJyC29pzFr3DTFxWihbuemMhR5IHbYq9uAMNl7OzUlvRLis9A
 SHeJuNHdxUAm/jhfLxRxmTzzaw71fa8MehwyGIDIO8B1O4KPOfetbkks3iHiGYo8j+XbPGtBa
 JRNzusZzBK5ri5a/9O4UsyohNEvuHvJbW81RvIGOHJmHzeePCKRu9z8OttJqNopaH1lm5anWl
 VOGxcvejjParhhsbCmnjfMERPmCLg3H4YTjJMZrGL1w7TQACo8rcTaeGo6wMlukdtYqwQYaI4
 hxKTBWtyo752getxWEu5ParTjyA6BNIdyWFKYFt9sC0BIb9HOfT1xyVqXuA0ZHg8lLwpANzC/
 qTsiirJ7Ygilc1oxQUs5upKhbuwo1s4DHk4kqceL19isR+AQcTF1zpsX+TsMxxc6z8dx/L49t
 WRq2ZKDaLZtfszYd/ruySGoppUyLHHQi2NuKzVmIibI8x5Y48Cv86VQjZ65DAbN5I5PVRsaN0
 QQyHMzzo/nqC+VHChc4Ilcyg2Caaen4xPZP
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Sat, 2021-08-14 at 21:08 +0200, Vlastimil Babka wrote:
>
> Aha! That's helpful. Hopefully it's just a small issue where we
> opportunistically test flags on a page that's protected by the local
> lock we didn't take yet, and I didn't realize there's the VM_BUG_ON
> which can trigger if our page went away (which we would have realized
> after taking the lock).

Speaking of optimistic peeking perhaps going badly, why is the below
not true?  There's protection against ->partial going disappearing
during a preemption... but can't it just as easily appear, so where is
that protection?

If the other side of that window is safe, it could use a comment so
dummies reading this code don't end up asking mm folks why the heck
they don't just take the darn lock and be done with it instead of tap
dancing all around thething :)

=2D--
 mm/slub.c |   14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

=2D-- a/mm/slub.c
+++ b/mm/slub.c
@@ -2937,17 +2937,16 @@ static void *___slab_alloc(struct kmem_c

 new_slab:

+	/*
+	 * To avoid false negative race with put_cpu_partial() during a
+	 * preemption, we must call slub_percpu_partial() under lock.
+	 */
+	local_lock_irqsave(&s->cpu_slab->lock, flags);
 	if (slub_percpu_partial(c)) {
-		local_lock_irqsave(&s->cpu_slab->lock, flags);
 		if (unlikely(c->page)) {
 			local_unlock_irqrestore(&s->cpu_slab->lock, flags);
 			goto reread_page;
 		}
-		if (unlikely(!slub_percpu_partial(c))) {
-			local_unlock_irqrestore(&s->cpu_slab->lock, flags);
-			/* we were preempted and partial list got empty */
-			goto new_objects;
-		}

 		page =3D c->page =3D slub_percpu_partial(c);
 		slub_set_percpu_partial(c, page);
@@ -2955,8 +2954,7 @@ static void *___slab_alloc(struct kmem_c
 		stat(s, CPU_PARTIAL_ALLOC);
 		goto redo;
 	}
-
-new_objects:
+	local_unlock_irqrestore(&s->cpu_slab->lock, flags);

 	freelist =3D get_partial(s, gfpflags, node, &page);
 	if (freelist)


