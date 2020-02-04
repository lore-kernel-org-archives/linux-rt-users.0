Return-Path: <SRS0=wDRI=3Y=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09019C2D0B1
	for <linux-rt-users@archiver.kernel.org>; Tue,  4 Feb 2020 11:10:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D47DA20674
	for <linux-rt-users@archiver.kernel.org>; Tue,  4 Feb 2020 11:10:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="BAQbYNF/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727177AbgBDLKj (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 4 Feb 2020 06:10:39 -0500
Received: from mout.gmx.net ([212.227.17.21]:36971 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727165AbgBDLKj (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 4 Feb 2020 06:10:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1580814629;
        bh=w+SKvp56UKIMNMDCt6NqCccXI38PRnIdXVD4TjA0chE=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=BAQbYNF/lO4xuQOi+ii/UXoh8CHY+aS+yuhsPgoqmxZT5BtUlSPYKxRKvNeixvRNU
         p+u5wTIgRwDnQall5/NWBiDhECr4wkw1gTKEC56AA20NCz5vd01x0SNptwUaXWcWfY
         MZurp4KnmotZ/AnAMrV15MQ+SWNpzP9vKu9Xfo5E=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.simpson.net ([185.191.216.162]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N3KPq-1jhaad0CVm-010LEc; Tue, 04
 Feb 2020 12:10:29 +0100
Message-ID: <1580814626.22602.26.camel@gmx.de>
Subject: Re: [PATCH RT] mm/memcontrol: Move misplaced
 local_unlock_irqrestore()
From:   Mike Galbraith <efault@gmx.de>
To:     Matt Fleming <matt@codeblueprint.co.uk>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        Daniel Wagner <wagi@monom.org>
Date:   Tue, 04 Feb 2020 12:10:26 +0100
In-Reply-To: <20200204093519.GC4303@codeblueprint.co.uk>
References: <20200126211945.28116-1-matt@codeblueprint.co.uk>
         <20200203181746.htlca2aynoqidm3o@linutronix.de>
         <20200204093519.GC4303@codeblueprint.co.uk>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ysEKcjmRuZGpGf3+qTb6S9467Hf2cCE8lzqPowAFHDHKg/QVcAH
 FRrbdaPp0sLBPxQ11Cf9xrylGHLWRQPBL3RhEB9fUVTGHw0PfNKE5r38iyxJgVUq7QOSuRe
 GCtGUVWUG9Pc1GfnLvDFh0EZQgnDgeJ9tXu1Xk/uZ1gGjavlnLkQLUnN171Kp8S6iZGODwv
 SDCR2Hv1yfdbNeJrsvOaA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:1pksGFDYPTw=:WE4KbA4xnHh4KjvkjTpNwL
 DWWbWkYgACzuHUEoQSWukuASdfY02ob1H+Vcie2oVfXlJL4ACiqB7H08sMBrkXwyT/YEzi+k0
 11wriJYNtX87dpywUqrQiqlcMHbunlmMcg1mYTsjA+c2yh+S2DInHQOP08SmzJ67Nibc/wMrY
 rXVOv3uGkxrzOyQF2qpGCFHzp5taapT2J1qBF2SA7qPA8umBiPUemKIaoKtggZcX71oYc9mmt
 s82vWesIfjvLbWo2clL+pj3U1zghJ0n0CTKPDIRmgVpik2a7qf2Jtkcq+8ZnyQBf6GPIhp0XV
 Z9rJMtDND9R+oos6Zy69Qbz2VTDZs+9dS1sIYHjX9R10nt1sum9DDKYpM9zJ6l1JEYqTAjnTX
 CDWuzljp0DttSTxvvVsL59Vy7UGb0aZu1ztvE+Ug9wM5xV/jgzZvxO8pV+ADcRA+xh0ZPz6fK
 hms5Lj+ytSGa/5IvOTCwMdpcvE0UQIUnQgdCY0rg6noYjfuyI1cN1FSxVy/fjEwstKd8/1nh5
 BIODofxU0mL9GwCNiTyf2ByASq+sLvwgeFiFEV7H6weT/u8SzJgy4sHTSfnTAV8qTvBvFiPjA
 ocF2CbtN04Ru9A3uuWN6kkVgFYyfIOOA1/YDXkvGQ+p9V7aKBHBQNIDqQtzZKSNcqrPceArAZ
 D8RjvjE9orWuwXfvD2+hcn2Qc/Cq0mrpN8Us1+IBeZwbVYmCMkC0z/YYC0+WR9SCeEloklnTT
 7B+0XSVV6ddG23eTUuTarYywJal+Qm6BibVfzHH6TeYz/PkYKaY04NhloUEuBkG5FwTwuYtn2
 UZjfFX7Chm0HdGj13DVQs6vkJUajoe/NHlyA8PGZng7qwwx4vcIzAxtM2wqTNfe3+2/Wd/rOe
 GvrAEOn5dCLRjX24hVA5FAJ92QzYoA+XR6qwQ77CfjgYTR43J4XEcxuV1qjot7930lHwyGTBT
 Tlvh9Zgt910lrj8Qur57lrhP4R/EAI8TJEjeSFIdQCJrdzv+G7krM5hjM3OKhl8mo+QnwxSPA
 0Cdv4or0LezIUkRE/q79EJ3HH3i8zQpfM+QXyzyQcufQX4yoUAjhm3Awc3Af1TMRSfXGi48nK
 obIuLLkseTmdAjujqPhncov8A9klb4mAYoyJhkkRlIhpuFwTWS9VjJocaOl3erkmXkTNPi2l5
 Bc+PDne8M+0iunyxY6IGsyzWz5sImKd9XgChZehdN1Eo7Ky52ReHfN1rCf7flf25Ho/j4mwZJ
 2tKY0FTpwWFH+Ovpc
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Tue, 2020-02-04 at 09:35 +0000, Matt Fleming wrote:
> On Mon, 03 Feb, at 07:17:46PM, Sebastian Andrzej Siewior wrote:
> > On 2020-01-26 21:19:45 [+0000], Matt Fleming wrote:
> > > There's no need to leave interrupts disabled when calling css_put_ma=
ny().
> >
> > For RT the interrupts are never actually disabled and for !RT they are
> > disabled with or without the change.
> > The comment about the disable function mentions just the counters and
> > css_put_many()'s callback just invokes a worker so it is probably save
> > to move the function as suggested.
> >
> > May I ask how on earth you managed to open that file on a Sunday
> > evening?
>
> We're carrying it in some of our older SUSE RT kernels and I'd really
> like to get it upstream or sent to /dev/null ;)

My recollection of the reason for that patchlet existing was simply
because while rummaging around one day, unlock placement offended my
eye a bit, so I did a dinky on the spot correction.

	-Mike
