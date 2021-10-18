Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70393C433EF
	for <linux-rt-users@archiver.kernel.org>; Mon, 18 Oct 2021 15:51:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58BA860F93
	for <linux-rt-users@archiver.kernel.org>; Mon, 18 Oct 2021 15:51:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233094AbhJRPx6 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 18 Oct 2021 11:53:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:42401 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232019AbhJRPx6 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 18 Oct 2021 11:53:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634572306;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sFe9r2eqDA3lIzkSOv0gOlfGXMolMrOUcQJUXN5jUVc=;
        b=Xe+3JsiuiVbX/3g8H4PYgSpjpExqYY/TFQA3RUGUtxbpttsSGS0PGKTDmz0K0qQ9sjUf3d
        VyWAwj2d2ljRjeC1cQXv6mUXechJkq9dgDlRBu62ZLx/fjW90PAvbwxqFbwQehN33YE3i4
        A8ScNdx9ckU3YB6XtEvLONohq93eKWo=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-46-nXKNnvrjPqSzCvAvnNlR_w-1; Mon, 18 Oct 2021 11:51:45 -0400
X-MC-Unique: nXKNnvrjPqSzCvAvnNlR_w-1
Received: by mail-lf1-f72.google.com with SMTP id d12-20020a0565123d0c00b003fdb52f1cdcso110862lfv.4
        for <linux-rt-users@vger.kernel.org>; Mon, 18 Oct 2021 08:51:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sFe9r2eqDA3lIzkSOv0gOlfGXMolMrOUcQJUXN5jUVc=;
        b=VPhQ3xxWcRyz/47vZaVYiIXabj8VUALCaKTQxLmexdWuwSGbEG0PPXGIlfHNiKrYTg
         T5tnadyETjdpp3sfD3hSbgeYlWX302NOmWvD3APRxkjfkKCQLMN1TbjmLZf7oQGBbDGk
         0MnvGbyL7d4vDBQcaowU7J0CEQsv7IVg+NKQ+OlkUDSBvfRu4eZvn/NIRgQ2R241k2Po
         svxRccCP5wCk7zvRZ13n50NDQLIh0q+0ta3q6TmektVTGtSrhU9t+hJEKVxeg32XBTTg
         hkHae5SwIYTNyBTrAXK85L3UVAJUU1qsvZ85x2dTYpJ7yhrp/nhNI78pnTJn3AuTFTRx
         B7xg==
X-Gm-Message-State: AOAM533Yh38pIxITKEcORFwRVVYLowyNjIJLtLHpwiRohr3KVz7L0CB9
        RlcF38RdnHKI5DgIupmBwmXZJOc9fquS+qJ+uSGyIEKsRtX4G1TKKmSngHZfhzUbSCDwgEqi1/q
        eExbc8YECQN/Z8+AmRNO952V/C+Dvh5L+Nfdc8gq8dUw=
X-Received: by 2002:a2e:b603:: with SMTP id r3mr613615ljn.14.1634572303606;
        Mon, 18 Oct 2021 08:51:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyoSeiDoriwtJKDJfVe90M6IIPI5nL7ubR93/U8ZQvyer02tV0t+8SO5L3ECxqQRxmIrfjqvEoJOiSsf2apbqA=
X-Received: by 2002:a2e:b603:: with SMTP id r3mr613603ljn.14.1634572303443;
 Mon, 18 Oct 2021 08:51:43 -0700 (PDT)
MIME-Version: 1.0
References: <YVuwBEWw4F7NGUd2@uudg.org> <20211011163333.2o64amr4qks4gpdm@linutronix.de>
In-Reply-To: <20211011163333.2o64amr4qks4gpdm@linutronix.de>
From:   Luis Goncalves <lgoncalv@redhat.com>
Date:   Mon, 18 Oct 2021 12:51:32 -0300
Message-ID: <CAD8J---eDMZb7Z39vYLY+vZZYhvTokv3NgsCCa=oJhH_hTYH6w@mail.gmail.com>
Subject: Re: [RFC RT v5.10] [rt] repair usage of raw_v6_hashinfo.lock in raw_seq_start()
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        stable-rt@vger.kernel.org, Chunyu Hu <chuhu@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Mon, Oct 11, 2021 at 1:33 PM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2021-10-04 22:53:08 [-0300], Luis Claudio R. Goncalves wrote:
> > Avoid a possible circular locking dependency by taking the softirq_ctrl.lock
> > before taking raw_v6_hashinfo.lock in raw_seq_start(), keeping locking order
> > consistent.
>
> How do you reproduce this one? It does not trigger here. Maybe I'm doing
> something wrong. The command
>         hping3 -C 3 -K 1 -c 1 $ip

In order to reproduce that lockdep splat I am running the following
tests from LTP lite:

   # Read every file in /proc. Not likely to crash, but does enough
   # to disturb the kernel. A good kernel latency killer too.
   # Was not sure why it should reside in runtest/crashme and won't
get tested ever

   read_all_dev read_all -d /dev -p -q -r 3
   read_all_proc read_all -d /proc -q -r 3
   read_all_sys read_all -d /sys -q -r 3

One thing I noticed though is that I can't reproduce the problem when
the tuned profile
in use is *realtime*. I can reproduce the problem with the
*throughput-performance* profile.

Again, the use of tuned in the tests is mostly to reproduce the
configuration in use at
the moment. I can isolate the specific configuration that makes it
possible to trigger the
lockdep splat.

>
> triggers raw_icmp_error() from within the softirq processing. And
>         cat /proc/net/raw
>
> does raw_seq_start(). No BH here. Additionally during boot raw_hash_sk()
> is invoked from non-BH context here but it is a write-lock so it has to
> disable BH since there is at least one reader in BH.
>
> The ipv4 code looks close to the ipv6. The problem is that hping does
> not support v6 :/ Maybe the ipv6 acquires a bh lock somewhere which
> leads to this.
>
> Sebastian
>

