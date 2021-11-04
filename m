Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A537EC433F5
	for <linux-rt-users@archiver.kernel.org>; Thu,  4 Nov 2021 18:49:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F1CB61157
	for <linux-rt-users@archiver.kernel.org>; Thu,  4 Nov 2021 18:49:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231709AbhKDSvl (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 4 Nov 2021 14:51:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:22296 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231932AbhKDSvk (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 4 Nov 2021 14:51:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636051741;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3zcGBuB5mX/lhDlKWtUXhrOQHIju49HA9Iz7BgK9HfE=;
        b=JMFhBWDfGZg/Lwmnr/bWOYJZO0wsDdUYf8vbQpElAdDGIYqAwIzBWFHLURokTUyjUcajbA
        hByJEBwreeX8EtVs3Lh7B7hxevIxRrTUUmsoh5LswN5o23PscKbpbwEyvpBrB7C3szveDy
        KjNxY5CRixkrWUNA4chrVvlLwNwhRCU=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-310-6H5AaIBxPneqsfMq3DY6QQ-1; Thu, 04 Nov 2021 14:48:59 -0400
X-MC-Unique: 6H5AaIBxPneqsfMq3DY6QQ-1
Received: by mail-lf1-f70.google.com with SMTP id r10-20020ac25c0a000000b004017ded5edeso2036023lfp.17
        for <linux-rt-users@vger.kernel.org>; Thu, 04 Nov 2021 11:48:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3zcGBuB5mX/lhDlKWtUXhrOQHIju49HA9Iz7BgK9HfE=;
        b=AI0U4M4tepuHfZwEmYz/wa1dbnkpcVyIG6oNvSWW14l2V06+JOpCeMkNIImmlvM/rf
         5qaxnjq6pgPfgRziX6TnhEpganKotULG4J09nVaFwOD7xClLUGhx5NixJPWDw6/6ykiV
         sSKpRxjwdaTB8BEWX5je0QzDpNczK2l774u6YpGmKICn3TE19yqmXMxM/SpHuypdhsXS
         kj+tNWhfCGM4BFNp8LLAmuJqHQPVw2XYjeHiFw1hvBk4fdKX0KmYvPERHLcgUmYXGPLw
         M2zJCzUKQOU9jf/iYsMsAvr132jLXohqwqI/dNb2dnq0+4C+RDVBVbT0yxBO/sfmTJYz
         RIhg==
X-Gm-Message-State: AOAM530NDZizDkgb9TBnn/+BhgJr9mMbgJWuPKWuiTUp97yIMaqar3VE
        2sFOVwBExSB9zwkqUHD/yOOmS+dynuo+qPzdl/W0TEQwic2/yH7KFin94v0ozbkVYctAd2c/t0e
        vrJm6XcTUuu4hhtjuPvVPwWBP+szl94CgMlZjksBJt4Y=
X-Received: by 2002:a05:6512:3e12:: with SMTP id i18mr22338920lfv.456.1636051738383;
        Thu, 04 Nov 2021 11:48:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxUd9TJGgH/mD5EopUZ9eLteurxG8B+hrTDuCd3AAHc8fWT4qPJ+3HvxYnbtCEtjp/EgqTqewg5bqX+s3sNHHw=
X-Received: by 2002:a05:6512:3e12:: with SMTP id i18mr22338913lfv.456.1636051738220;
 Thu, 04 Nov 2021 11:48:58 -0700 (PDT)
MIME-Version: 1.0
References: <YVuwBEWw4F7NGUd2@uudg.org> <20211011163333.2o64amr4qks4gpdm@linutronix.de>
 <CAD8J---eDMZb7Z39vYLY+vZZYhvTokv3NgsCCa=oJhH_hTYH6w@mail.gmail.com> <20211027090650.fqpqtze6wfetihej@linutronix.de>
In-Reply-To: <20211027090650.fqpqtze6wfetihej@linutronix.de>
From:   Luis Goncalves <lgoncalv@redhat.com>
Date:   Thu, 4 Nov 2021 15:48:46 -0300
Message-ID: <CAD8J---Dxofu+k3yxyMxvUBd5sQfBZEHM8N3Q-S8f8-1dfa4Fw@mail.gmail.com>
Subject: Re: [RFC RT v5.10] [rt] repair usage of raw_v6_hashinfo.lock in raw_seq_start()
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        stable-rt@vger.kernel.org, Chunyu Hu <chuhu@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Wed, Oct 27, 2021 at 6:06 AM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2021-10-18 12:51:32 [-0300], Luis Goncalves wrote:
> > Again, the use of tuned in the tests is mostly to reproduce the
> > configuration in use at
> > the moment. I can isolate the specific configuration that makes it
> > possible to trigger the
> > lockdep splat.
>
> I can't reproduce any of those two issues. I tried both and iterated the
> tuned profiles
>         tuned-adm profile realtime
>         tuned-adm profile throughput-performance
>
> while running the test you mentioned.
> Could you please try if this reproduces with latest v5.15-RT and post
> complete lockdep backtrace?

Yes, sure!

Just as a reminder, I was able to reproduce that backtrace in v5.14-rt
up to v5.14-rc6-rt11. But starting from v5.14-rc7-rt12 I no longer
reproduced the problem.

> Sebastian
>

