Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A29CC0015E
	for <linux-rt-users@archiver.kernel.org>; Fri, 28 Jul 2023 15:07:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236764AbjG1PHZ (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 28 Jul 2023 11:07:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjG1PHX (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 28 Jul 2023 11:07:23 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA77C35A3;
        Fri, 28 Jul 2023 08:07:22 -0700 (PDT)
Date:   Fri, 28 Jul 2023 17:07:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690556841;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=O2+wYfg2qc/dbl2pgvjkp5a1AYZnnmGamTG/T/UMqAg=;
        b=biJli4etcT7aONa6IYmphL4wUoVahSXfpSltitzbI83XpZnWBIoZgisHH1J/b7dKj1hCvy
        +1uuXs72Uy3hhsTfR0XqDi3yQ6v/75NnStY1mM9GUzkWuAV2BQigDd/c7HnimkuZmX2Ndi
        XY0w8CQc7sYvIHkK+xmCGS/h2t2WOeG823poStHJaICIc6ko8ID5//1wxEvoNZTQy05kEz
        RvEU/oII2yKw19EBsuaOIjGY/yhtLmQNn5cqQEQzhEPNHJ15cJvnKQXpDT/GDAoHAdAYIG
        g4VpbX8/iT5NyG3Y/qerFM6FZpBP+T4bB8vy8Y27krx8g6tufCPyK1Gtnboh8w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690556841;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=O2+wYfg2qc/dbl2pgvjkp5a1AYZnnmGamTG/T/UMqAg=;
        b=JzHT8tRW/hrS6muMmXIMQRfpN62WVAsKIar1aWM8+cr3TFCsZwljmod41RuUn9blT+eqeP
        qc/K66O0SB/lhGAg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Mike Galbraith <efault@gmx.de>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Marco Elver <elver@google.com>, linux-rt-users@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>,
        ThomasGleixner <tglx@linutronix.de>
Subject: Re: 'perf test sigtrap' failing on PREEMPT_RT_FULL
Message-ID: <20230728150718.8odZX-jD@linutronix.de>
References: <ZMAtZ2t43GXoF6tM@kernel.org>
 <e368f2c848d77fbc8d259f44e2055fe469c219cf.camel@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <e368f2c848d77fbc8d259f44e2055fe469c219cf.camel@gmx.de>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2023-07-26 08:10:45 [+0200], Mike Galbraith wrote:
> > [=C2=A0=C2=A0 52.848925] BUG: scheduling while atomic: perf/6549/0x0000=
0002
>=20
> Had bf9ad37dc8a not been reverted due to insufficient beauty, you could
> trivially make the sigtrap test a happy camper (wart tested in tip-rt).

Thank you for the pointer Mike.

I guess we need this preempt_disable_notrace() in perf_pending_task()
due to context accounting in get_recursion_context(). Would a
migrate_disable() be sufficient or could we send the signal outside of
the preempt-disabled block?

This is also used in perf_pending_irq() and on PREEMPT_RT this is
invoked from softirq context which is preemptible.

Sebastian
