Return-Path: <SRS0=be3R=ZF=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF155C432C3
	for <linux-rt-users@archiver.kernel.org>; Wed, 13 Nov 2019 21:29:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2764206E3
	for <linux-rt-users@archiver.kernel.org>; Wed, 13 Nov 2019 21:29:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EWuMCylg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbfKMV3r (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 13 Nov 2019 16:29:47 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:45811 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbfKMV3q (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 13 Nov 2019 16:29:46 -0500
Received: by mail-lf1-f67.google.com with SMTP id v8so3147331lfa.12
        for <linux-rt-users@vger.kernel.org>; Wed, 13 Nov 2019 13:29:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7upnmHMd29Y4sOOm17RV4hbSfhIxUnNxrGNXUhifBAk=;
        b=EWuMCylgYJsbTjyfZh4dUKUYHRaAovgbIBhaA7nOv3wX8PSo9y1QpwRn04MP6hRpbm
         5zFrge81HwtOrlxES0Z/AReyIs0jo+5KNzp+CVBT9JZfauU6p0xpmbQsSpFaiKEAMUBx
         mHT/HdLAR8ynqQcmAI+m+ILqVWrK/ZAs6Xvt3489AALQIVs8BGzCQ9NoiQJR/D4v/04C
         8ujRW96EDqyDzd1ng8jEuRKDWgo7TBcG0RoKqDGuCfiacQJUxnweLUalKXquXIuyLJYc
         8tTx+V+xBR2r5aE8HTkCH9wumdVlP0zSHxGOTH/xyL5C9/iP8M8nShBttfwaQ4B4Xtj7
         XU3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7upnmHMd29Y4sOOm17RV4hbSfhIxUnNxrGNXUhifBAk=;
        b=tYfZn/sVya6Ir9HWWdKEE1oXBs8aZ5ij8+9MBDUnDguTDypRu5noqjWm1L5T2rXHlC
         OzTWy09at2Wo6O5w1pcnneVz4jYp2mtsQg5FItHYcYSKkQLad+JxUrbyAiqQVIrjGdgh
         TN1unF57fbJYQ+W0DU6n2/3VqGHZ5JJ6hIP3kaaQsZq66BImeVAkgUIMJP+ayQ7RIKff
         Y+eSWTBfozc1aY10SciAp0W4uOE2tK2F6b7z6/8hB8iQOMpczZz01IFj+vh4Ttqaqv4+
         2eVvYBLz8MZAnHKiqnncrv9RdxeV/dGryasstRDG3B4u3nb9di+ZOdgtv0Zn9EtNtBEK
         68uA==
X-Gm-Message-State: APjAAAWsIAkRm56fLdFy9KlKoqMHqaJjV6x3L5kqbg9R6u5XElziqPZe
        TKlGOgUKVqc6cGuUIYSvaHLcAB6MPITPG9kLcC+vWqia
X-Google-Smtp-Source: APXvYqw2VW0DfCnvt1/Xi8Kpt60uawwaAfTyJh451NpF0FQ54lBFHW0Qo7PqsQrwqhH7OTzZJoIHCjOTN557qKOitk4=
X-Received: by 2002:ac2:5a11:: with SMTP id q17mr4237598lfn.41.1573680584514;
 Wed, 13 Nov 2019 13:29:44 -0800 (PST)
MIME-Version: 1.0
References: <a0a64a18-5805-de3b-c4f7-537de8fa0508@softplc.com>
 <CAD56B7cgt704nWrowch8KrcT7e6ASr5Hi9FQ8-xmgztYcdceyA@mail.gmail.com> <adcdeaa2-69e0-9f61-35c9-888e2a281f37@softplc.com>
In-Reply-To: <adcdeaa2-69e0-9f61-35c9-888e2a281f37@softplc.com>
From:   Paul Thomas <pthomas8589@gmail.com>
Date:   Wed, 13 Nov 2019 16:29:33 -0500
Message-ID: <CAD56B7ej=hR0ye-ser9P3ROraBr2PJABD64K=w2XG7fwfozToQ@mail.gmail.com>
Subject: Re: Need help building for aarch64 kernel 5.2
To:     Dick Hollenbeck <dick@softplc.com>
Cc:     linux-rt-users <linux-rt-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Wed, Nov 13, 2019 at 1:02 PM Dick Hollenbeck <dick@softplc.com> wrote:
>
> On 11/12/19 2:33 PM, Paul Thomas wrote:
> > I hope this helps. Good luck!
> >
> > -Paul
>
>
> [PATCH] needed
>
> Hi Paul,
>
> A+ for your help.  Thanks very much for your valuable time and excellent post.
>
> The problem is two fold:
>
> 1) the configuration variable CONFIG_HOTPLUG_CPU controls the existence of the
> *definition* of 'takedown_cpu_task' at kernel/cpu.c line 880.  (The *declaration* is in a
> header file.) But there's a usage at kernel/sched/core.c line 7399 and following line
> which is not conditioned on that same CONFIG_HOTPLUG_CPU config variable.
>
> 3) The linker message is misleading.  All they had to say was that the symbol was
> undefined.  The continued detail about this being an offset out of range issue created
> ambiguity as to whether this was out of range first and foremost, leading to the undefined
> status.  Clearly now it is simply an undefined usage.
>
> I am looking for a low latency transfer of control from a GPIO interrupt handler that I
> wrote in one of my drivers, all the way to a high RT priority wait_queue blocked user
> thread.  And stock (non-RT) 5.1 kernel was atrocious, simply unbelievably bad.  Somewhere
> along the way during the great hunt for improvement I turned off CONFIG_HOTPLUG_CPU just
> to try a simpler config.
>
>
> BTW cyclictest on that same stock 5.1 kernel was showing an intermittent 4 msecs of delay.
>  Yes msecs, not usecs.
>
>
> I would have submitted a patch for this but since its so trivial, it seems somebody with
> commit rights could make this change faster than applying a patch.

Yup, with CONFIG_HOTPLUG_CPU not set I get the same compile failure.
It looks like those two references to takedown_cpu_task should be
conditional on CONFIG_HOTPLUG_CPU like you said, but I'll leave that
to others to look at.

-Paul
