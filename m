Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6C3DC4361B
	for <linux-rt-users@archiver.kernel.org>; Fri, 18 Dec 2020 13:53:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DFBB23AAA
	for <linux-rt-users@archiver.kernel.org>; Fri, 18 Dec 2020 13:53:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726502AbgLRNxN (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 18 Dec 2020 08:53:13 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:52650 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726120AbgLRNxN (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 18 Dec 2020 08:53:13 -0500
Date:   Fri, 18 Dec 2020 14:52:30 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1608299551;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hpk/x+7qccxJ+1SXcqCXr++Arc5uRL0N27oKgrEkAUM=;
        b=hvW2pFQ8VVUNbb/eXFjLN0SC7IL12WzZ5NOe6D8Gsy+4+vI+9JkdEExa01+qllL1E8oPwm
        SIYjgNZSsKv+DxEF334bUgF5qP2ykJikwAaYdjGmIaemWL2ggEZk8n+dxgJ8v3TYFtEBDX
        l6L+rjsGZ7NELnnd5Sf6WXFy5G7/POlWflmnEaXt9czBrupLlSvoh8JjOktbn4fBmQ5dX+
        gmvDh9eVxGIF6oz7lgq53o46RJpH1t4chYhplCGmSLNjZ/PTvSgsaBYjuwKlN8SWUo0gbm
        FaUiZlwfZpQSMQ0QfSMBotUXiLJhvWynOeEdhOW25tYDEGDAwYDp4fY9pO/BKw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1608299551;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hpk/x+7qccxJ+1SXcqCXr++Arc5uRL0N27oKgrEkAUM=;
        b=1yokuxgBctE0p9mErm8GaNFb+v2FxkCV3OypZQUe55ZzPzc3cmKGog6J+5bmb578XXlwFf
        6xbeEL8q4/sTtNDA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Paul Thomas <pthomas8589@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-rt-users <linux-rt-users@vger.kernel.org>
Subject: Re: net latency, long wait for softirq_entry
Message-ID: <20201218135230.hb25ii2a3sbqrucw@linutronix.de>
References: <CAD56B7dKyiUBQctrrpLYU6XM5cjfXD10E1fFMU5GpAe00g_TZQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAD56B7dKyiUBQctrrpLYU6XM5cjfXD10E1fFMU5GpAe00g_TZQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2020-12-05 13:30:21 [-0500], Paul Thomas wrote:
> (this time with a proper subject)
> Hello,
Hi,=20

> I've been testing out the 5.10 rt kernel[1], and now I'm trying to
=E2=80=A6
> But then in the long latency case, instead of going straight to
> softirq_entry this is delayed and it does the softirq_entry from the
> ksoftirqd task instead of the irq/30-eth%d task. The problem is that
> before ksoftirqd runs, another lower priority task runs (in this case
> it's the macb tx interrupt thread at priority 80, but I've seen this
> be user threads in slightly different tests). It seems the paths
> diverge with a call to __kthread_should_park.
>=20
> This is on an arm64 zynqmp platform.
>=20
> Any thoughts on how this could be improved would be appreciated.

The usual flow is:
- wake IRQ thread
- IRQ thread raises NAPI (softirq NET_RX)
- NAPI is processed on the exit of the IRQ thread.

This flow was disturbed by the timer:
- stress-ng is running
- the HZ tick timer fired, raised TIMER softirq. This leads to waking
  the ksoftirqd thread to process it (this is normal).
- stress-ng continues.
- the networking IRQ fires. The thread is woken up, raises NET_RX
  softirq. Usually, the softirq would be invoked on return from the
  interrupt thread but since ksoftirqd is already woken nothing happens.
  It is delayed to ksoftirqd. The IRQ-thread goes idle.

Having a thread to run the tick-timer would avoid that scenario.

Side note: If the networking thread runs for a longer period of then it
will handover to ksoftirqd.

 -Paul

Sebastian
