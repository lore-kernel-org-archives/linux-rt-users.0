Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F4AEC4338F
	for <linux-rt-users@archiver.kernel.org>; Sun, 25 Jul 2021 15:02:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47EFB60F35
	for <linux-rt-users@archiver.kernel.org>; Sun, 25 Jul 2021 15:02:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231272AbhGYOWF (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sun, 25 Jul 2021 10:22:05 -0400
Received: from mout.gmx.net ([212.227.15.18]:34423 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231208AbhGYOWE (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Sun, 25 Jul 2021 10:22:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1627225344;
        bh=/ytJ1exakUcFtI+Zuz9UGunDJo0+/Jeh2/x6mYHvx2Y=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=H9+7F/T/F4c9xppuKqPAIXYOFRI80hh56pnZtFGBb5/8oIP71FUU0XZsfAd8hPMBW
         n2He0NVbpfRPjrIZAyPvLqyJ79dg9Q2rXn2a7frG/RzWWFOJktiCxN6eDUFqT8aPMf
         Tsn8tGl2UH16ehA8TiXIbYDZ4B8oJBvDEjmVccPU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.191.216.136]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MxlzI-1l9lSL3PVG-00zHKC; Sun, 25
 Jul 2021 17:02:23 +0200
Message-ID: <72a045663bf8f091ae11dd328d5e085541d54fcd.camel@gmx.de>
Subject: Re: [rfc/patch] mm/slub: restore/expand unfreeze_partials() local
 exclusion scope
From:   Mike Galbraith <efault@gmx.de>
To:     Vlastimil Babka <vbabka@suse.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     linux-rt-users@vger.kernel.org,
        Mel Gorman <mgorman@techsingularity.net>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Date:   Sun, 25 Jul 2021 17:02:22 +0200
In-Reply-To: <76dedfc3-0497-1776-d006-486b9bfd88da@suse.cz>
References: <87tul5p2fa.ffs@nanos.tec.linutronix.de>
         <8c0e0c486056b5185b58998f2cce62619ed3f05c.camel@gmx.de>
         <878s2fnv79.ffs@nanos.tec.linutronix.de>
         <6c0e20dd84084036d5068e445746c3ed7e82ec4b.camel@gmx.de>
         <7431ceb9761c566cf2d1f6f263247acd8d38c4b5.camel@gmx.de>
         <f9935c4c-078c-4b52-5297-64ee22272664@suse.cz>
         <f16b78bd3bb8fecf734017d40274e4c3294554ab.camel@gmx.de>
         <240f104fc6757d8c38fa01342511eda931632d5a.camel@gmx.de>
         <69da2ecd-a797-e264-fbfa-13108dc7a573@suse.cz>
         <84a7bd02cf109c6a5a8c7cc2bfc2898cb98270aa.camel@gmx.de>
         <5be1a703-9a0a-4115-1d69-634e5e8ecefd@suse.cz>
         <bd121f5db01404774dbecc70bd7155f8431d8046.camel@gmx.de>
         <76dedfc3-0497-1776-d006-486b9bfd88da@suse.cz>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.2 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:3phcavwfqppgh3AowbO+lAimT5+vqqqpnEVkj1EdYHynb41+wBk
 ACauVILDgziVPQDOTpbEE99n0zV1Ac6W2cX3HaxSvphN5W2IksJWPHzJmf+Zffo3vz3yK0y
 DKn1Vq9ut60xj0XIBviUJ+tSk0f5u0lVcssXq1SkquBXNuBC8BNXf4p9paU+Z26zkD9VPEL
 oL17/+xdOzjK7nxiYwZAw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:E39Zbhz0Nck=:9eh50UmaImvovEBdAhw8Bb
 NgYql2lapW9y678VdBBHZQBVYu3/sEkvI8WYBfMwIBIAcdcoNsfWsjYVwKCx4rTQLw81dmiWG
 FRzl5zYwG/2mFpbqq1OtG5LqQAOyz2x06VD/LYh3wcEzznoNmmilCqlGaZKPHr02KDsPb23fO
 +HVAtENTFusyj2+FQCBpK2qIuS80YU7tE2tY16usqy6fmJ/kj4M3+Pe804M+cODwEqNVgdVoc
 crm03Q/gE3p9uYa9Y10tzR+CkDn3xAsPzNU6vmvSUJHdL5HM3y1VWTbJLqWsxN+I54DAeNvM9
 qGxxTFqtGgY3M80tthaYLyqZCMlkQURsx8eCvyC7s9LzPJPToZK8sSXzX+8p+ymIB7LUr3qez
 7ZCmtQITK/W/M9DKbK6U2lTMasxnkAPTEUFQIzaSzm7YwG5cewmNgICMgVPV7XL2TTAipixe1
 jLn2o1N8J00f7/Kpi1Bt/SMQlCh1i/MP1nd6iZPxYvl4+v7Anae9HEKCXUOjJjVbCAvRhyQnd
 74DNR3Z3TqeqowQzt77ABIDsf2ZuaB0p3K59+1Uj5vE+ge2hx4aZsMwM+tq5V4FuQ4yBTjgfJ
 wOT0qFR/EI3V071e+uOmbk/Rh7HLyx8vjOdZfvbNLAmYSsNQWJsUq2PKmS9z06rRa3u+2lvnK
 hobyRjM4FPQn4TOY0chbG2a+B+PfFMyU5kmE++cqeOkcZK2JTA3Pn6mfN3MiS5QOHv7WrhYbW
 3Yrkty3ZYOKwkO+AOnVAD/5YJ+Wx5qSp6iT4eKkaKUjy7WCTtBOgXfVyGjgkTNOO06UNSHl6P
 ysuDVlnQbMQMGZUazqBf8n2S75UiAOM2dgJgcWVheJxgtYZ2ZPsI5u7SNGfw0LqERsns4dQ+1
 p/rdZEVrO0cUWaTfJMTEmQf0XnhO8Zug+CkzDwKUOzUK1Nnq2VZeyMnLAfe1JBqP7Bofo69gz
 MbDUkt5JfYqA2y9cqiUY0JsmGxY2Nji9FA5lfiu0WV5EmEzmcm7WJMvyzhQ+zi72aHWnbeY4F
 dbcMPLeyrEB79hMvzbvAuzvufMpDwS71tg/+LJyJSGJhXb/3UhvYvj733M10zDTAOw+zMklXS
 gUBdIHFwrkmfZBGWTzionTKV86jWMO//Awa
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Sun, 2021-07-25 at 16:16 +0200, Vlastimil Babka wrote:
> On 7/25/21 4:09 PM, Mike Galbraith wrote:
> > On Sat, 2021-07-24 at 00:39 +0200, Vlastimil Babka wrote:
> > >
> > > If not, then I would expect this to work (I don't think they ever ne=
st
> > > in the opposite order, also lockdep should tell us instead of
> > > -ENOBOOT?), but might be missing something...
> >
> > Yeah, like #ifndef CONFIG_PREMPT_RT at the bottom of the loop that our
> > useless damn eyeballs auto-correct instead of reporting :)
>
> Well doh, good catch.

I never did see it.  I got sick of saying "but but but", and did make
mm/slub.i, which made it glow.

> Hope fixing that helps then?

Yeah, though RT should perhaps be pinned across release/re-acquire?

Actually, local locks should rediscover the recursion handling skills
they long had so such RT specific hole poking isn't necessary.  There
previously would have been no ifdef+typo there for eyeballs to miss and
miss and miss.

	-Mike

