Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAA1EC4332F
	for <linux-rt-users@archiver.kernel.org>; Fri, 23 Dec 2022 14:23:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235627AbiLWOXE (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 23 Dec 2022 09:23:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230374AbiLWOXB (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 23 Dec 2022 09:23:01 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4439731379
        for <linux-rt-users@vger.kernel.org>; Fri, 23 Dec 2022 06:23:01 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id n10-20020a17090a73ca00b00225cbc4dfaeso655259pjk.3
        for <linux-rt-users@vger.kernel.org>; Fri, 23 Dec 2022 06:23:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vje6yt/sqIiWl/oxBi3EgOo+WxcYhyjLAaabUiAoG9Y=;
        b=bv8OfQkXO77sCikHsu0zjgLzrXbPO63CvDO7qWFsRyd/VYZKC3wSR0BlKh2MdQtlMy
         ffGEobkXHS8RewvP/yX7AZI6dAXjDrXNZ3Uug7auOz7yGQjvQKvs4t+5Hh36+qKJm9aA
         5Wyz540SNtO7xpi7L6Jvy1tqEi+Nx9Ryyk++EfVQXUrUBH7DLF+cZXza0D+BKNQJop/5
         AHcnikcxSFaEvkKt0SwMPjqgf2//otI/7uubDRx9M4t3CjX+OZrrfCmokKaCqKXTZE96
         2qYrV0Gej8JY8xC114FNjPalSWmcGx1MNxR3vagbduELh04s8GkVC9MR0tt8Cqtqr2WI
         FIDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vje6yt/sqIiWl/oxBi3EgOo+WxcYhyjLAaabUiAoG9Y=;
        b=B6S5A9T8tAODUDiQe0yGD5GidMuIDQfcfyxgvi7cCvTJ+XmAR9c5QGVJZY1oIvRLVG
         wyLGZVsIUGKr896Xj33xMb1JG6v8he2EB5tE9eqrFzs4pyshLBm+4OVhwjY829DGQNM7
         1HasZ2Rf0c8llbwWim+8VnEDEFAw4iaDf34+QXWPBzoCalv16h3WoOUXc+M6hE+skTtN
         pOTquyCPjIV9X1UXkDA3DHgz4Pok6+GGlL5mJfV1sNgDyUXQd6Vb2cPmJSuovlUNjl6Z
         fI3I7h0m/3gONCUvrV9b+XZHG/ZbJAxMzCtj1LWV7ek4jJWk5Iyh0GCYpQPLhkBr5/sp
         KTrQ==
X-Gm-Message-State: AFqh2koOROvq8IfJ4fn0pgfSJtmzPoo+edCL4PcmgovUJlCeu9bdiSOW
        BscwWdWMhvKkhGtnL7ZRNIa35QFCE6GA+uERUUERl43b2Ik=
X-Google-Smtp-Source: AMrXdXst3FFsR7Q2ucBqFa12vECfQAthKNPiaN64dTyjqktCn9menQaEabji5m2e4VcI2vE0zJKTqKd5ZHP+qrGKcqM=
X-Received: by 2002:a17:90a:8d0d:b0:219:da8f:c6f0 with SMTP id
 c13-20020a17090a8d0d00b00219da8fc6f0mr1028696pjo.1.1671805380372; Fri, 23 Dec
 2022 06:23:00 -0800 (PST)
MIME-Version: 1.0
References: <CAA6Pxnhb2XwztmT8QpJkokC3A6k1mmMdUoYpr-WQw6rzhjAqJQ@mail.gmail.com>
In-Reply-To: <CAA6Pxnhb2XwztmT8QpJkokC3A6k1mmMdUoYpr-WQw6rzhjAqJQ@mail.gmail.com>
From:   =?UTF-8?B?VsOtY3RvciBMw7NwZXo=?= <lopez1987@gmail.com>
Date:   Fri, 23 Dec 2022 15:22:34 +0100
Message-ID: <CAA6PxngEQppmQZ0t3OMz00hnd37V6NBax+81R5xVccRkaRf01g@mail.gmail.com>
Subject: Re: Non-rt sleep is extremely inaccurate
To:     linux-rt-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

I have pinpointed the source of the delays to this patch:
softirq: Use a dedicated thread for timer wakeups.
(https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git/comm=
it/?h=3Dlinux-6.1.y-rt-rebase&id=3D65f32c25b9c87966cbf2ecbbe478273f13e97ceb=
).

At least on the 6.1-rc7 kernel.

Additionally, I've found that although the wrong sleep behavior is
present with both acpi-cpufreq and intel_paste CPU governors, with
acpi-cpufreq the sleep errors are always under 50ms. But with
intel_pstate the delays go over 1200ms.

I am testing a kernel without that patch, and the patches built on top
of that, but I would like to know why.
This patch is not on the linux-rt-stable repo.


On Thu, 1 Dec 2022 at 15:34, V=C3=ADctor L=C3=B3pez <lopez1987@gmail.com> w=
rote:
>
> I reported this on https://bugzilla.kernel.org/show_bug.cgi?id=3D216702
> two weeks ago, but I believe that the bug tracker has less activity
> than this mailing list.
>
> Here's the bug report I pasted:
> std::this_thread::sleep_for and other types of sleep in non-realtime
> tasks are extremely inaccurate on some RT kernels.
> A sleep of 10ms may sometimes take over 700ms to complete.
> The PC is idle, and there are no RT tasks running.
>
> This has been tested on modern Intel CPUs (1165G7 and 1260p) as well
> as Ryzen 4800HS.
>
> I have tested many combinations of CPU governors and performance
> settings but the problem is not fixed by those.
>
> I initially tried  5.10, 5.16, 5.19, and 6.0, and all except 5.10
> exhibited the same behavior.
>
> With a 5.10 kernel, I may run the sample code for 20 minutes and get
> 3-4 messages about the sleep taking at most 25ms.
>
> With the other kernels, multiple times per minute I get sleeps of up to 7=
00ms.
>
> Later I tried v6.1-rc5-rt3 which exhibits the same problem too 7-8
> messages per minute.
>
> 5.16.2 with 5.16.2-rt18 works better, with 1-2 messages per minute.
>
> 5.15.49 with 5.15.49-rt47  works almost flawlessly.
>
> I have tried the same kernels without the RT patch on the same
> computers, and the problem does not occur.
>
> I have built the kernels myself, and have also tried with the ones from:
> https://packages.debian.org/search?arch=3Damd64&keywords=3Dlinux-image-rt
>
> I have tried using the config from 5.10 on the 6.0 kernel, but the
> problem still appears on the 6.0 rt kernel.
>
> I would really like to use the RT patch on 6.1 or  6.2 when available
> since the system we are using has an Intel Hybrid 12th gen CPU, the
> support of which is being greatly improved lately.
>
> I am attaching an example to reproduce the issue:
