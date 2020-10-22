Return-Path: <SRS0=0dn7=D5=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B75BEC388F9
	for <linux-rt-users@archiver.kernel.org>; Thu, 22 Oct 2020 14:36:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F32424171
	for <linux-rt-users@archiver.kernel.org>; Thu, 22 Oct 2020 14:36:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="VzQ+BCMn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2900954AbgJVOg3 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 22 Oct 2020 10:36:29 -0400
Received: from mout.gmx.net ([212.227.17.21]:38405 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2507890AbgJVOg3 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 22 Oct 2020 10:36:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1603377376;
        bh=jYaDHtDxM+TgpdFUUjTa/Gj3Bd4VuCrF8iK4uBD1hpg=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=VzQ+BCMn99jpNDHJMY1QP5PqPjuDFTR0MCcy+ItzQ5JVlHbiAIiROWDNRcUvTOQWA
         8lWYn2pUsanAz1a4p8sjLFRpfZJUlIJog/qfzoVZOlkBynxpAHATprMoBKISruQBws
         10+3Udcs48reU8EnUm8NCI6RgZ4X1xlnfCiZ3v5U=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.simpson.net ([185.221.150.153]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M4JmT-1kVKiU3TyT-000Neu; Thu, 22
 Oct 2020 16:36:15 +0200
Message-ID: <43c56d9bd7c5d0b7c455a5ba3c00080b1600b718.camel@gmx.de>
Subject: Re: printk: add pr_flush()
From:   Mike Galbraith <efault@gmx.de>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     John Ogness <john.ogness@linutronix.de>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Date:   Thu, 22 Oct 2020 16:36:15 +0200
In-Reply-To: <20201022141529.zvwafoqglnhyklj5@linutronix.de>
References: <15cd3dc322eb1485fe1e67df465febdc6ad389d8.camel@gmx.de>
         <20201022141529.zvwafoqglnhyklj5@linutronix.de>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5DX1ZQ+MqlCF73rS/ETmFaeqh8/cykpwmJ2olJ9hnbtZRIy2eWs
 oJRfX7Q4feB8ASN2QdIu6ssUAfk1QO8mom08It1DZNMu6wOGacFwbwams/guhhmM3IYFOrv
 5sLEpxSYEvy/qOfvOkm7Sj2xQozGhXi8eG/0aFnAPaMkVKpnJ5Kfr/cE1BEt3EWcxnyFAAo
 ngrz6SXskKIq+GFcGDxcQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:UEwog922GzQ=:DxxMh7Z0uCShdjy4w0pf14
 yXEq6mbXY0/NssvEFLouXVx3vdi5wKtityOs5KSnO7XUiigymJ91kJrAprSa7KeV0AcxwzJdp
 tR+2ahccMlA4LCYotHKJbmj8PgW24Bf//cxBNtrHYwNWRsqVlPwPXTebTNfbigLIr+NOWRkqA
 IqTnUlFfq4LwR87I1SYx0DpzRlTTqjU5Y47B78CNozLYPyupzDcNUG1X06SUGB9MiofkRtq20
 wwFvu5ZvXiZfSlZlrd4AoXzIacT6hFyj+ctDt84iVA9QK+5mBBCWAkrBR6lrck4tZP5aPR943
 y/OpnBgn3ZizoK71l0PCimrFLJ3D2KhgAiE2s8pgL6JXgyepzhXKuHDgiqJqzD1lz03qYgwFx
 HXcD2vzVZOG2vQb7hKTOGiuJq/Y42ClnGf25kOp3uYdEAzSU+EiRIIUAl04nOiZoMrWaLi9Lb
 /YcnoyZy8Pr9LRFPMidQm8c6JRC6fC6FGaZD6T7J+vd2QeAJyALoPk0g9Cg5dLxpACKXl5miC
 fiCPZVNP1j7zykvW0W4IA1dUbPuQWYeRoCX1rosDH3esgnQ+kQmrVWTDW3lPTNPtOCNz2dkKp
 +wAhARPlDbHwozfQOVzKGbbxMu3nP3WTVnd9O5IeqVnxL9NS13vU/36juQZ1CFLef0cmGyP3O
 D+sT4SUHJUdtLK0okBYWqHH/5Q8LsdJ2UaRXG6XOKSoiEwhlgUARwvXHukNruWRMz7K4W1znk
 Mj7WQdZovIqOpWrRr05UQYrVJWqNDYFro0PC0bwwJpdgY+Wh0pTsegV5qSLnP//rWgpDa5Mov
 lzoYlBl4yvtjPu1lGFCYKfgXvV6wMgN2aSnn0HvPTyiKvRCXmrmWaVvYwuwcRdVQHyIcdjT6U
 Ut+4Wfq96vnaU4zm7JCg==
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Thu, 2020-10-22 at 16:15 +0200, Sebastian Andrzej Siewior wrote:
> On 2020-10-22 16:12:41 [+0200], Mike Galbraith wrote:
> > Greetings,
> >
> > Seems this patch can cause hangs.  I can reliably reproduce one such
> > hang by poking sysrq-b, and it goes away if I revert that.
>
> does it still happen if the wait argument is `false'?

Yup.

	-Mike

