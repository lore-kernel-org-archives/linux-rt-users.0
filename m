Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3A7EECAAD3
	for <linux-rt-users@archiver.kernel.org>; Thu,  1 Sep 2022 12:57:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232449AbiIAM5H (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 1 Sep 2022 08:57:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232631AbiIAM5G (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 1 Sep 2022 08:57:06 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90E4E89CEB
        for <linux-rt-users@vger.kernel.org>; Thu,  1 Sep 2022 05:56:59 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id j14so13935316lfu.4
        for <linux-rt-users@vger.kernel.org>; Thu, 01 Sep 2022 05:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile-fr.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=uq4TioZRjmxZyraXuN53eYanizVG9Ee08Arm04Mm13w=;
        b=fjsRrNNMw92JUFFcrIXSknDkHLRkimmJWJteVKTxslYK7s8Xdt4b9153G8oRoK+9A1
         01Ewea+E0PURUOApZ1b0xHiYxYpFtwwF86SYmRuQwzPvA6imzvdrgXJiGlTFhwvRz+2t
         sWke0k6nNHv1yoLcsDQT/yfid+9PkxKWvBucHCsRAfsbwliAPviriMwEA0FWaOC5WpUn
         xPO/o15hAZXSTGbjj5tev1aBJQaFINSBi5iNrlREaNcAhn9lrh5NnfBVD0xixnIXIB1t
         pLRlY05UoPakdCWHoCiFVGnlVXhVL+ihxPjjRQTrg4AzQlAKD6WEOumequxKMEYn0hk5
         eEyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=uq4TioZRjmxZyraXuN53eYanizVG9Ee08Arm04Mm13w=;
        b=QtnCPi8EpbgLmjmBsdh8gFKpMcAxCU0OoBstwgIA1DwijX6SyDldytozwmTjdTy8qD
         aAtbYXcHaJBWBoZiElVZTqXsp05E+521xzuWttcIbLigjXQs40QRwg4ZftJw6tF2Rylt
         P08Uh+W67s64Ydb7sPqTree0unN8zwMe7PI2u40NHB67FMmjOvQKKulkiQyQFfwggA4q
         Kh6QTKB5pXZ5L2cudIdgz9dcOTxHqYnVzqmVOmUNgPd9gjlAlF2W+z8d6RHB+DyC2yXL
         JLL4Ot7PO9ymBoXdFQEG8dpQB0FpTE01yQ4yamU7MlbHHI3CUEfod6Oupe2QyIdWvR8s
         TOPg==
X-Gm-Message-State: ACgBeo1BX70AAojXhPWqR10ETojBiAUl520G+EY7IYLHSfb/QtQzC2A+
        JxkmaJuSKN7D8IyE15tQZHFenmClBw8pxzgoBUofjuKs18I=
X-Google-Smtp-Source: AA6agR5T/m6K7VYTbPnljK10Px/aKKzZrSVJYu6cP6YR70VCHFJKUaEEVVR8wF7/Pdzvbus9fzyl/0BTbFwtzS68AH4=
X-Received: by 2002:a05:6512:ac5:b0:48c:ecd1:4f14 with SMTP id
 n5-20020a0565120ac500b0048cecd14f14mr9994028lfu.287.1662037017390; Thu, 01
 Sep 2022 05:56:57 -0700 (PDT)
MIME-Version: 1.0
References: <CAJuRqcA02DGBGMh4frvkN8ceQbucMaomiUkOXPUGwhQvnesrfQ@mail.gmail.com>
In-Reply-To: <CAJuRqcA02DGBGMh4frvkN8ceQbucMaomiUkOXPUGwhQvnesrfQ@mail.gmail.com>
From:   Yoann CONGAL <yoann.congal@smile.fr>
Date:   Thu, 1 Sep 2022 14:56:31 +0200
Message-ID: <CAMSfU+73Wdb8HHu_5JyeyALHOefwAYqw6ccMCdakZv+iALhR1Q@mail.gmail.com>
Subject: Re: CONFIG_HZ impact on system load
To:     Florent Carli <fcarli@gmail.com>
Cc:     linux-rt-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hello,

After some experimentation, tracing and debug, I=E2=80=99ve arrived at the
conclusion that it is only a problem of how the load is measured and not
a =E2=80=9Creal=E2=80=9D system load. Explanation follows and conclusion at=
 the bottom
(if you want to skip ahead).

First, some context about how the load is computed (most of which I
discovered during this):

The =E2=80=9Ctick=E2=80=9D is basically a periodical function called CONFIG=
_HZ times a
second on every CPU. Tasks have two states that are counted in the load:
running and uninterruptible (for when the task is waiting for
something). On ticks spaced by ~5s, the number of tasks in these two
states is summed to compute the current load and this value is injected
into a filter to get values evolving in 1, 5 and 15 minutes (as seen in
/proc/loadavg). See the excellent blog post from  Brendan Gregg for more
information [1].

The above paragraph ignores the NoHZ feature that allows ticks to not
happen if not needed (if the CPU is idle or running only one task for
exemple). Enabling/disabling the NoHZ feature did not change the problem
so it was disabled (nohz=3Doff on cmdline) to make the analysis easier.

First, I used =E2=80=9Ctrace-cmd analyze=E2=80=9D (a not-yet merged patch f=
rom Steven
Rostedt [2], rebased on master here [3]). This uses ftrace to compute
statistics about tasks. In particular, it does compute the time each
task spends in the running and uninterruptible states (measured on
scheduler switches). The global time tasks spent in these states does
not change with HZ. So there is no additional load when HZ decreases.
Moreover, the theoretical load computed over a long time is what you
would expect : slightly above 1 for a stress process + the rest of the
system when the load average shows values above 2.

Using ftrace, we can dump the load sample every 5s (before filtering).
This shows a base value of 1-2 but many spikes around 10. These spikes
are the reason loadavg shows a load significantly higher than 1.

To look for the sources of these spikes, we can get the instantaneous
load using the scheduler debugfs directory : $debugfs/sched/debug allows
us to compute the number of tasks in the running and uninterruptible
state (note: the counter of tasks in uninterruptible state is
distributed across all CPUs. See kernel source kernel/sched/loadavg.c).
By sampling this value at 10Hz we get no spikes and an average load of ~1.

At this point, the hypothesis is that the spikes are short enough to not
be visible from userland. So, the next step is to precisely trace the
evolution of the instantaneous load. By =E2=80=9Cftracing=E2=80=9D the valu=
e composing
the load (nr_running & nr_running for each CPU), we can retroactively
compute the load at each point in time. This shows the instantaneous
load increases suddenly (spikes are 15-20 high and ~20=C2=B5s wide) and, at
the same time the load is sampled (AFAIK, the sampling does not cause
the load increase, this is just simultaneous). And by taking stacktraces
on load increase in the spikes, we see that some tasks are activated
during the tick (for example, RCU related periodic tasks are activated
on ticks).

At last, the conclusion: The load is sampled at the end of the tick
function. During the tick function, some tasks may activate and increase
the instantaneous load. This creates a spike in load which is then
sampled and averaged. This creates a bias in the load measure and
displays higher load than in reality.

The influence of CONFIG_HZ on this bias is this : lower HZ increases the
probability of activating tasks exactly at the tick that samples the load.

All of this was observed on a CONFIG_PREEMPT_RT=3Dy kernel. This leaves a
question : as per the original post, the anomalous load does not happen
on a !PREEMPT_RT kernel. Why? My (un-tested) guess is that the RT
preemption model allows the awakened threads to increase the load during
the tick whereas the non-RT preemption model increases the load after
the tick.

Finally, more general questions : Is the load increase when changing
!RT/RT or HZ generally seen? Is this a bug in loadavg?

Links:
[1]: https://www.brendangregg.com/blog/2017-08-08/linux-load-averages.html
[2]: https://lwn.net/ml/linux-rt-users/20220324025726.1727204-1-rostedt@goo=
dmis.org/
[3]: https://github.com/ycongal-smile/trace-cmd/tree/trace-cmd-analyze

--
Yoann Congal
Smile ECS - Expert technique
