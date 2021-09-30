Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98423C433EF
	for <linux-rt-users@archiver.kernel.org>; Thu, 30 Sep 2021 14:32:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8057060FC2
	for <linux-rt-users@archiver.kernel.org>; Thu, 30 Sep 2021 14:32:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351992AbhI3Odn (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 30 Sep 2021 10:33:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351998AbhI3Ode (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 30 Sep 2021 10:33:34 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 629E0C06176A
        for <linux-rt-users@vger.kernel.org>; Thu, 30 Sep 2021 07:31:51 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id i19so23046720lfu.0
        for <linux-rt-users@vger.kernel.org>; Thu, 30 Sep 2021 07:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile-fr.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=WG7zknnC11iN89WOxbbMKWAW/QNmn70Rp6JvnJGb6wM=;
        b=MFqSnVxbHKHTgLQzhv11lsdYknsmJdXWnI3tg22HkIossqvZ26voCKQNwKzKKJ+aBQ
         lM1lt74S91DhW5Lr7QOELgiTaWBpPrGYxA7ekv9V9Gn48HU7zrdXs/j09bSXDDzA8zsk
         v7KgCqMlWMSyhldoKMJbAHxsf/bpegWQbIETruA+gt9Ly/a7bpoDalusJJlKv8NS7ub1
         D0uNoqcqt06TUPnqHmupIXjy9h9+7w45UAIovtnGkFIRy03tepB8ypdVPMoGrR1aDTyN
         4Hz7EvzX1+NWvgPd1HWEsNwlaKcjPRDiegbee8y6EAia5xQLzV2kk05H9hFDcogvsWfB
         vh4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WG7zknnC11iN89WOxbbMKWAW/QNmn70Rp6JvnJGb6wM=;
        b=pnQ+fBRiAelackljeSKUCRqe3sD7MtOa09UaADI4i/CvdkYajwfsJEpQaBeI415DmR
         jPtx69nONod3k1/g7J2DdD2feZmAnEtMFlbxSQfBOjgdFwSf+ljsMBjIajb3IKDEXeYA
         WMHlGAPafYTPHgN+nmqgvGBjoRtN/wHGFmOLa1/R2+I9PJioabdMw4AFdTf534BKm/B+
         fT4I6vLYuzv9614aEbWRqhmBho6Nmzcis260s/z4NjOOUGc77Lz8xi3IL/yOaXKE2Pw3
         VbQPck9BA7ppa/YVr0QUsmxtUiebgyfGjprUXjD4IFCwyvl4FzjWAQTGYR0WjV4do/zw
         i0OA==
X-Gm-Message-State: AOAM532eGx758siHOABXyZg9sYyjz5Zg6ov5T+DoupCawe8TdEjE7JHb
        Pqjn8whdD4hblonfQe5t0io/V31Cr5wGiVnVz1YbWg==
X-Google-Smtp-Source: ABdhPJz+noKJJ3UllW4r3eIVn1iliVbntVzs9rJ2N3CravvposGHqBmW1Or8Sn/t2bG3vsTfIjMw/XN8Nk5+khyPFfo=
X-Received: by 2002:a2e:2406:: with SMTP id k6mr6498200ljk.453.1633012296144;
 Thu, 30 Sep 2021 07:31:36 -0700 (PDT)
MIME-Version: 1.0
References: <CAFc1U0sgMtKvcpTWkyjwXsq3Md_Huew7mSye_AratkM63D6K-Q@mail.gmail.com>
 <87y27e53a2.fsf@stealth> <20210930132319.eixnv6rb66ui6x6j@linutronix.de>
 <CAFc1U0uMuj1PPmxPQTTVqscYsnKfOE+sjtasK9KqadkgaUgLSg@mail.gmail.com> <20210930135145.mdlzzwp64yykixhx@linutronix.de>
In-Reply-To: <20210930135145.mdlzzwp64yykixhx@linutronix.de>
From:   Pierre FICHEUX <pierre.ficheux@smile.fr>
Date:   Thu, 30 Sep 2021 16:31:25 +0200
Message-ID: <CAFc1U0sYdJQWkeLgPjiR1Y1CnafV22zgS4AW0Yf6+h7CO03u+g@mail.gmail.com>
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

# cpupower -c all idle-info
CPUidle driver: none
CPUidle governor: menu
analyzing CPU 0:

CPU 0: No idle states
...
same for all cpus.

Le jeu. 30 sept. 2021 =C3=A0 15:51, Sebastian Andrzej Siewior
<bigeasy@linutronix.de> a =C3=A9crit :
>
> On 2021-09-30 15:26:32 [+0200], Pierre FICHEUX wrote:
> > I've just copied the set_latency_target() of cyclcitest.c to my code
> > but I got the same behaviour.
>
> What happens if you disable idle states > C1 with cpupower?
>
> Sebastian



--=20

Pierre FICHEUX -/- CTO Smile ECS, France -\- pierre.ficheux@smile.fr
                             http://www.smile.fr
                             https://smile.eu/fr/offres/embarque-iot
I would love to change the world, but they won't give me the source code
