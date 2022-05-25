Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB971C433EF
	for <linux-rt-users@archiver.kernel.org>; Wed, 25 May 2022 11:50:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243148AbiEYLum (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 25 May 2022 07:50:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230294AbiEYLul (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 25 May 2022 07:50:41 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9D33A204F
        for <linux-rt-users@vger.kernel.org>; Wed, 25 May 2022 04:50:39 -0700 (PDT)
Date:   Wed, 25 May 2022 13:50:36 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1653479437;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UgWIOi4l+vZLNNI4Lta2Z4tlHBdcYQBP3oDu2A6CGoo=;
        b=26UxcUSa3g5wZe7ttET6/NUMNizW14ZdEo7EGKMFrjzFrgTXHcJde5gt2hzn2whnUdIuL5
        d+orV8KkQFc4FhvMDtoeaR77+8ZpQpd73SnxT8DWLcOLhNypcI5KAPW74Z7mOsoMN6EA7c
        rWDRxiVnjxtW8Cz9ugY/t+tcVLjMWaNJVHGxCOmOR5f8347pZEjPI21AccAhu5m3Uex/cx
        vKXnaiS1E90frJnd4EldE7O9GkGdBScsboRQcRUYr9m2MG/wOaVstV8ikUZo5Q+brHpCCd
        xvjUq7bc/LKtPAFOUrSCLYgmpmkr7oaW2wwWWApA8glwCgsvOa3NxqUZaFiQLQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1653479437;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UgWIOi4l+vZLNNI4Lta2Z4tlHBdcYQBP3oDu2A6CGoo=;
        b=FxbyM6aPyocrDVCsyyrrnVxMTF5br9j0ItZeWLS8w3rY2W78tPiKfxpCFVsz9IIjlnJLIp
        cJ1FR+0K1DBbWyAg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     yosi yarchi <yosi.yarchi@gmail.com>
Cc:     linux-rt-users@vger.kernel.org
Subject: Re: high latency introduced by hrtimer_interrupt
Message-ID: <Yo4YDC1G5Ax/M4Wg@linutronix.de>
References: <70b2548e-4f45-cb4f-d893-0a4d59ee4faf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <70b2548e-4f45-cb4f-d893-0a4d59ee4faf@gmail.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2022-05-12 08:13:58 [+0300], yosi yarchi wrote:
> hi
Hi,

> I'm using linux-rt, 5.4.41, at91 sam9x35 (single core).
>=20
> AFAIK, the hrtimer_interrupt must run at HW context, and could not be
> threaded.
> On my system, hrtimer_interrupt processing takes ~100us in average, ~40us=
 in
> best case and ~200us in worst case. when adding the overhead of the
> re-scheduling that follow each interrupt, we get to worst case overhead of
> ~250us for the hrtimer_interrupt.
> This worst case and the huge variance are too high for some of my threaded
> interrupts, which have to record timestamps of HW events with precision <
> 100us.
>=20
> Digging in documentation and mailing lists, I didn't find any solution...
>=20
> Any idea on how to overcome this problem?

So the hrtimer runs in hardirq context for the important timer like the
system tick or a wake up of RT tasks. It can run at lower priority
(threaded) if it is a timer for non-RT tasks. Nevertheless even the
"threaded" hrtimer needs a wake up from the hard irq context.=20
You could enable additional events to figure out what exactly is the
hrtimer doing (processing a specific callback, waking a task, =E2=80=A6).

Either there is a timer doing something nasty, leading to these long
runs of the callback _or_ your CPU is simply slow and this is the best
you can get.

> With best regards
> Yosi Yarchi

Sebastian
