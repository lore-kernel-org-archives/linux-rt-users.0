Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA5D0C7EE22
	for <linux-rt-users@archiver.kernel.org>; Wed, 10 May 2023 11:38:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236791AbjEJLid (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 10 May 2023 07:38:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236808AbjEJLib (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 10 May 2023 07:38:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5061269A
        for <linux-rt-users@vger.kernel.org>; Wed, 10 May 2023 04:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683718666;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=q6W2Dw41SOm3qVvAWDDmCFfV0SEGNy54raIoegI7jQ0=;
        b=SRj/IcOj77KAZZy6OCBrqbTe3QtAFLk9PTeIcSxXd4wHr05lrwBommZ6BRW2XSGUHz/pCH
        r3Xt/Hx9YQXnPwoZlrj6UQamludmB1GuHKr+7CIQ2jn5TgUYu4GcTbWdcjkF8bSAPnJdcJ
        qrJ0nYm5NMarks8O3AZCGsWKgn1wqnU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-Yc_AiyIvPru4aL7vlQJuQA-1; Wed, 10 May 2023 07:37:44 -0400
X-MC-Unique: Yc_AiyIvPru4aL7vlQJuQA-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3f426514683so12256505e9.1
        for <linux-rt-users@vger.kernel.org>; Wed, 10 May 2023 04:37:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683718664; x=1686310664;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q6W2Dw41SOm3qVvAWDDmCFfV0SEGNy54raIoegI7jQ0=;
        b=GUukzmUkWgFHzF2lwgWPrTn74dMqf2jMWuqdOgRnMtzwuSXIpBGgOzAQ1IC2Lufkge
         TwDsHVL1i41xvaaPkZxF+mmHjO9OCAeSIbgxQYJuW9fV4I9pjUdHgfuXMJ49sxLShPU+
         M7b8LjAPD7Ox/02bqOtWiv7DuHCJNduQQA5iDyusL08cnuNurQAmk5ebaE/2F63I5N6O
         XFWcSacW971fq5UYYBCzJgyA3rHKHGCpRnTJe8+4COBx2eyYej1PgSfYP+vBVuMXOHpo
         etSccLz9EdXV6TLQWtwHsYyPS9hQCHtJEZghz6wFeKzttJNUUNBP/DiqGGpPA8edQb1+
         R3Og==
X-Gm-Message-State: AC+VfDzwz9rPesnzMT93KQrPcW0v7NttimqGtMzAvlB3FuWnE+tOJdi9
        DvVNKObZyKikY28js5PC+19Qa0jg2FYZPAbQCZjo5e92sAqUits4mM6hgljRPFJWshuGAduXms2
        1mdLyHy8NA1D9lZaH4A+OlDXa438=
X-Received: by 2002:adf:ee46:0:b0:306:26d7:3805 with SMTP id w6-20020adfee46000000b0030626d73805mr12746644wro.63.1683718663784;
        Wed, 10 May 2023 04:37:43 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ55hv52rdA9ePi18bMW8pKcGBFLT/tiSzgCXsRLDdbk5GEk3fHYjtKTRQQdDL62Wkv1T/cUPg==
X-Received: by 2002:adf:ee46:0:b0:306:26d7:3805 with SMTP id w6-20020adfee46000000b0030626d73805mr12746627wro.63.1683718663512;
        Wed, 10 May 2023 04:37:43 -0700 (PDT)
Received: from vschneid.remote.csb ([154.57.232.159])
        by smtp.gmail.com with ESMTPSA id q18-20020a056000137200b003063176ef09sm17328517wrz.6.2023.05.10.04.37.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 04:37:43 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Juri Lelli <juri.lelli@redhat.com>
Subject: Re: [ANNOUNCE] v6.3.1-rt13
In-Reply-To: <20230509164640.-aaZNrjH@linutronix.de>
References: <20230509164640.-aaZNrjH@linutronix.de>
Date:   Wed, 10 May 2023 12:37:42 +0100
Message-ID: <xhsmhy1lwifi1.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 09/05/23 18:46, Sebastian Andrzej Siewior wrote:
> Dear RT folks!
>
> I'm pleased to announce the v6.3.1-rt13 patch set.
>
> Changes since v6.3.1-rt12:
>
>   - Two posix-timers picked-up from the list. They are scheduled for
>     upstream inclusion. One of prevents a livelock on PREEMPT_RT in
>     itimer_delete(). Patches by Thomas Gleixner.
>
>   - A softirq handling patch from the list 'revert: "softirq: Let
>     ksoftirqd do its job' from Paolo Abeni. This revert should reduce a
>     lot of trouble which start once ksoftirqd is woken up.
>     The 6.1-RT series has the ktimersd thread which mitigates some of
>     the pain. This patch should render the patch obsolete.
>     Should everything work out as expected I intend to backport this
>     patch the earlier RT series and revert the ktimersd patch in the
>     v6.1 series.

The ktimersd threads solved some priority inversion problem we were seeing,
IIRC it looked something like so:
- GP kthread is waiting on swait_event_idle_timeout_exclusive(...)
- p0 (CFS NICE0) did spin_lock(L) then got throttled by CFS bandwidth
- p1 (CFS NICE0) did local_bh_disable() + did spin_lock(L)

So p0 owns L, but cannot get bandwidth replenished since local softirqs are
disabled, and the GP kthread can't be woken up by timeout to initiate
boosting either.

Even if ksoftirqd has its priority tuned to ensure timers can be expired,
the above never wakes ksoftirqd due to:

static inline bool should_wake_ksoftirqd(void)
{
        return !this_cpu_read(softirq_ctrl.cnt);
}

on the other hand, ktimersd are woken up unconditionally, so in this
scenario it gets to run and donate its priority via

  ksoftirqd_run_begin()
  `\
    local_lock(&softirq_ctrl.lock)

(note that this only solves the CFS bandwidth issue if ktimersd are FIFO or
above, but they are spawned as FIFO1)


TL;DR: for RT, I think we should also kill should_wake_ksoftirqd()

