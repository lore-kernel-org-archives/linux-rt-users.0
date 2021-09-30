Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD133C433EF
	for <linux-rt-users@archiver.kernel.org>; Thu, 30 Sep 2021 13:51:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2DB56141B
	for <linux-rt-users@archiver.kernel.org>; Thu, 30 Sep 2021 13:51:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351485AbhI3Nxa (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 30 Sep 2021 09:53:30 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:50290 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350042AbhI3Nxa (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 30 Sep 2021 09:53:30 -0400
Date:   Thu, 30 Sep 2021 15:51:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1633009906;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=39LePJNdQ8aftlNFU3qZ7TQ7ylaHwIKJE9tRSXLG7Zk=;
        b=Pm/Ov1stoS73vaG8+SQgJlILFBVHqpGjI7jLU2iFBexOQ/14RjIW/QFY5HS8owQ0jnZR3y
        J7RMwUkVjVJlTvVYV0Cg0fdXi9qAkTRxzQPURKKutoAdRN9PSAV+S/FLNgy64pJtzgpXFy
        qQTG8NjV6u4lf9Pt09NhBq+CPUHEvMMttq4nEoVbKasgDICv9wR10+4hXwvYHm3+RKIOqv
        tWD6RFHMnZtKbL7FQfcGGM3FzyIvNgpCKoMuUS5c4pzxOKMAIzvi7fXIXGiDgEQH4OI3u4
        cM87t/sEk5jxEqSEVX1TgMlLWjp0GsT8mKx+xLuBS6jK5e2jB0WExauSdFIMoA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1633009906;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=39LePJNdQ8aftlNFU3qZ7TQ7ylaHwIKJE9tRSXLG7Zk=;
        b=d22fh72ovpIt83Bab7nhPDGG10X0VSdklQgVCImerUvAtCtpUd2u+1VwZXQjXvs6GldNcR
        rqEVYoXKz5bCZxDg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Pierre FICHEUX <pierre.ficheux@smile.fr>
Cc:     Punit Agrawal <punitagrawal@gmail.com>,
        Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>, linux-rt-users@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Strange problem with PREEMPT_RT
Message-ID: <20210930135145.mdlzzwp64yykixhx@linutronix.de>
References: <CAFc1U0sgMtKvcpTWkyjwXsq3Md_Huew7mSye_AratkM63D6K-Q@mail.gmail.com>
 <87y27e53a2.fsf@stealth>
 <20210930132319.eixnv6rb66ui6x6j@linutronix.de>
 <CAFc1U0uMuj1PPmxPQTTVqscYsnKfOE+sjtasK9KqadkgaUgLSg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFc1U0uMuj1PPmxPQTTVqscYsnKfOE+sjtasK9KqadkgaUgLSg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2021-09-30 15:26:32 [+0200], Pierre FICHEUX wrote:
> I've just copied the set_latency_target() of cyclcitest.c to my code
> but I got the same behaviour.

What happens if you disable idle states > C1 with cpupower?

Sebastian
