Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F9D0C433EF
	for <linux-rt-users@archiver.kernel.org>; Thu, 30 Sep 2021 13:26:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 557B160E09
	for <linux-rt-users@archiver.kernel.org>; Thu, 30 Sep 2021 13:26:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349512AbhI3N2e (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 30 Sep 2021 09:28:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351439AbhI3N22 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 30 Sep 2021 09:28:28 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67413C06176A
        for <linux-rt-users@vger.kernel.org>; Thu, 30 Sep 2021 06:26:45 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id z24so25210676lfu.13
        for <linux-rt-users@vger.kernel.org>; Thu, 30 Sep 2021 06:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile-fr.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=NybuCZCYQfYttq5k8XjD/7/SDWB26dEHIB3DjvHT4CI=;
        b=mxk8lIB1CJzORGauh3pqoga9WAI1/n48WF3aH1OGpq8GX9MKNiFdzRey3UZYcAAoz1
         pJquJHti+jwTDB8gS4QGjEo3EY1dPzTBawYGCFzjSHjHhSTPhBH6VbSFSUPiwr5bZyxB
         0AhQsBOt2fXt44FO4kQs5EPlEvChXZJ0ptvYQV9Oj1AfJbPsxFUDYjv2O0x8N2WO9/qY
         YAskbX/7mcSWMEULv1/wQKuT7j3UkmgDJ8QCxrH3JoDoADZdKtrLGlladIRgw5c7IxbX
         mNZyFKzjvCWK5xR2xrJj5cl98kmUDBW5FhFrU7SwoVXTP67EPMCC3QDV6E+1Z8BVQAsJ
         aehg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NybuCZCYQfYttq5k8XjD/7/SDWB26dEHIB3DjvHT4CI=;
        b=LIOCIxhD7HPRQvZhOE+0DxU2XUoUJVNAclIVniNi8ACKr1hsuYGbiq5PgFAQUp5I4z
         ch4JuPmAmfiq91n91RjiorfFepps6PQKyPc/fpj92eLTUPEM36fxR5KnDmhSIht+4k/k
         fSSsyWgsNVAM33yeKhiwBAnNNzrdrOBb8QLBIKkZPAU9FuLZboQ2QAg122Qu+75f737Z
         lWZmg8+P0++Co7dFHyCmr2SaE0IjD80fRcIt9CGgpOscV/4zdYpaBdYPBee3ZPB2e38b
         8iFRQBqFRAEUysoqzt19GgHI7V4sP3MJrGrblXr5ldNIa30TOiVzoNnseFm0u4ic1z1k
         K+8w==
X-Gm-Message-State: AOAM5324xf7auRGiiX34cIhKOdmQcMHud3ThW9fgtua/decXMuRisEz/
        psYqd6dU+PgHBaMxruxWScRyYO/khKhyMQcDm+5lMw==
X-Google-Smtp-Source: ABdhPJyeDAPWAHK9weZMOxFkKK4Lfg8TMukDDJw2t1IdnPVnCrvJ0NyBP0JCDMboQ3SgZXJiTFYz7PiGEe2LlJPLJec=
X-Received: by 2002:a05:6512:553:: with SMTP id h19mr5916368lfl.33.1633008403312;
 Thu, 30 Sep 2021 06:26:43 -0700 (PDT)
MIME-Version: 1.0
References: <CAFc1U0sgMtKvcpTWkyjwXsq3Md_Huew7mSye_AratkM63D6K-Q@mail.gmail.com>
 <87y27e53a2.fsf@stealth> <20210930132319.eixnv6rb66ui6x6j@linutronix.de>
In-Reply-To: <20210930132319.eixnv6rb66ui6x6j@linutronix.de>
From:   Pierre FICHEUX <pierre.ficheux@smile.fr>
Date:   Thu, 30 Sep 2021 15:26:32 +0200
Message-ID: <CAFc1U0uMuj1PPmxPQTTVqscYsnKfOE+sjtasK9KqadkgaUgLSg@mail.gmail.com>
Subject: Re: Strange problem with PREEMPT_RT
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Punit Agrawal <punitagrawal@gmail.com>,
        Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>, linux-rt-users@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

I've just copied the set_latency_target() of cyclcitest.c to my code
but I got the same behaviour.

Le jeu. 30 sept. 2021 =C3=A0 15:23, Sebastian Andrzej Siewior
<bigeasy@linutronix.de> a =C3=A9crit :
>
> On 2021-09-30 09:13:25 [+0900], Punit Agrawal wrote:
> > With hackbench, the system is sufficiently busy to avoid the going into
> > idle.
>
> Not just that. cyclictest's usage of /dev/cpu_dma_latency has the side
> effect that it may disable some of the PM stuff in the system.
> So your system appears good but then when cyclictest is gone, the
> numbers go up.
>
> Maybe we should drop that so we observe a system without altering its
> behaviour?
>
> Sebastian



--=20

Pierre FICHEUX -/- CTO Smile ECS, France -\- pierre.ficheux@smile.fr
                             http://www.smile.fr
                             https://smile.eu/fr/offres/embarque-iot
I would love to change the world, but they won't give me the source code
