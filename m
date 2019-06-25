Return-Path: <SRS0=Os7+=UY=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF2DFC4646B
	for <linux-rt-users@archiver.kernel.org>; Tue, 25 Jun 2019 01:00:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD92720644
	for <linux-rt-users@archiver.kernel.org>; Tue, 25 Jun 2019 01:00:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LyYOKWlT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729894AbfFYBAw (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 24 Jun 2019 21:00:52 -0400
Received: from mail-vs1-f46.google.com ([209.85.217.46]:33364 "EHLO
        mail-vs1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728340AbfFYBAv (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 24 Jun 2019 21:00:51 -0400
Received: by mail-vs1-f46.google.com with SMTP id m8so9803561vsj.0
        for <linux-rt-users@vger.kernel.org>; Mon, 24 Jun 2019 18:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Nur1iJ3nvuzqd9Olmexogs08mrlF+fy/gjHx6/K4FGg=;
        b=LyYOKWlTkwNcuV+HdcqAezQKxp5tMwhOsdjpwCPHF1T/UQzfXaqrK+G5RnZtEZrFtP
         OrVVOmtTMagfQQ3PvoWBuGzzsZSiFPOnW+Gkri+oLsFQftXMNo2CfZKAs6Gnz5WclbM7
         mpyTZUq+EEy4EL3G7cD+HdwP5MnJj7ih5zZXmFfPmAneoPs/5Hey8EvoQb2yl95jeeQE
         wfEwkf5xBo44rMGgU5AlErDBFh+h6MJh0tmJp0OUGJRnTRAr1WTwNfUfFh892d27uCJr
         vN6wj1FqsJLFP96k2IeG9ySuMshFUdGi+PXYdvngGLoOOlHtUWADLRcA1bEkRFKAafCK
         4ZBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Nur1iJ3nvuzqd9Olmexogs08mrlF+fy/gjHx6/K4FGg=;
        b=O/bKeFp00PUHRCNnPym7FnDZgyaxC7XasV3AizNS8DCCuTFkLgCz0zjz83TGjyWFxB
         PDI2PAKM5cC8SO+5LnQ5Weo22mSLWBXOYo0zP/yvMdqd+s+nNEx94m4pqxQW5cmvlNh4
         x2IUkWThiSA7BeC89x1Mok1MrAlcZ36NJ+5RSdTAUtupir1DEdviZ5wnWd2NL0vxU9WQ
         AjaBf9hnOVO8X8o03DLpALTn6qHvwzb3kieMVWz/RJJcrAD8zgyBTt+77jt06qhQ63Lc
         Bj0E+W4ldSOaegsYcJEW0DjfT4SiNIRezP8lTkMQJBKz5n+gup2cS5Sk1WjnK6EXlRIx
         mLcw==
X-Gm-Message-State: APjAAAVc8rnRsNbO7DfgxJ1G7ucQThBR6oKDqwsJ6FZUYOb27vTyr+61
        cfaEP3i2uGr5j8pUJMC13+DJcQ13i9pR1Taa2UndWfyNVxw=
X-Google-Smtp-Source: APXvYqwOgU9cabBrehi9RRwTozTBkSxVemHVlH57L74hx9h0Yq57xiy/ggb5LdeYSq/PlCMNJvIdPyfgMrbiIHOklV0=
X-Received: by 2002:a67:c496:: with SMTP id d22mr14682499vsk.205.1561424450070;
 Mon, 24 Jun 2019 18:00:50 -0700 (PDT)
MIME-Version: 1.0
References: <CAEVNDXsR03jGXKO5diQbjMQecS=wXxdEW5eGQAAL1PPOQ_RO6Q@mail.gmail.com>
 <CAJfkoWqsPJoxeQwxCYAU1kG6ny5BBuiTCpiqM+KgAsZH58trbw@mail.gmail.com>
 <CAEVNDXv88RvDgWDhxD=3XW=0kO3TSBYy57q0s1u985z1TaaFVg@mail.gmail.com>
 <CAJfkoWp=eDa86x7EmAdqa1chSsLRMPBg=XnqaeBPP+H2La1XNg@mail.gmail.com> <CAEVNDXt3UhqoCsnN+mcEh9X4hXRvTv6qQbdgkcRprPfBRr9qSg@mail.gmail.com>
In-Reply-To: <CAEVNDXt3UhqoCsnN+mcEh9X4hXRvTv6qQbdgkcRprPfBRr9qSg@mail.gmail.com>
From:   Ming Yang <minos.future@gmail.com>
Date:   Mon, 24 Jun 2019 18:00:39 -0700
Message-ID: <CAEVNDXs4en99qbWsyMc551cxyN4iGGg69b3UYGzhFPzD2pR1qA@mail.gmail.com>
Subject: Re: sched_deadline sched_setattr fails after setting cpuset
To:     Luca Abeni <lucabe72@gmail.com>
Cc:     linux-rt-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

I looked into Linux source code and here make an attempt to answer my question:

Linux uses `root_domain` to manage bandwidth and uses `cpuset` to
manage cpu mask.  Overlapping cpusets are unioned into one root
domain.  So each CPU belongs to only one `root_domain` but may belong
to multiple `cpuset`.  When the cpuset is a subset of the
`root_domain`, it rejects new tasks because of the
not-containing-all-cpu rule. It makes sense because the acceptance
test is performed against the bandwidth, which is defined per root
domain.  This is shown by scenario 3, where the root domain contains
cpus 0,1,2 but either cpuset contains only two of the three cpus, so
adding tasks fails.

For scenario 1, when a task is added to A, it's added to the root
domain of {0,1} or {2,3}, depending on where the task executes on.  So
allowed total utilization or bandwidth is two.

Please correct me if any of this is wrong.

Thanks,
Ming

On Mon, Jun 24, 2019 at 4:17 PM Ming Yang <minos.future@gmail.com> wrote:
>
> Hi,
>
> On Fri, Jun 21, 2019 at 3:34 AM Luca Abeni <lucabe72@gmail.com> wrote:
> >
> > Hi,
> >
> > On Fri, 21 Jun 2019 at 02:54, Ming Yang <minos.future@gmail.com> wrote:
> > [...]
> > > I have a question about the admission test with cpuset.  Is the
> > > sched_deadline admission test examined with respect to the CPUs
> > > allowed in the cpuset?
> >
> > Yes, in theory you should be able to use up to 95% (or whatever you
> > configured in /proc/sys/kernel/sched_rt*) of the CPUs contained in the
> > cpuset.
> >
> > I am pretty sure it worked correctly when I tested this, but it was a
> > lot of time ago...
> >
>
> Thanks!
> I suppose acceptance test on cpusets that share CPUs doesn't work? For
> example, the following three scenarios:
>
> Scenario 1, sub-cpusets:
> cpuset/A/cpuset.cpu_exclusive: 1
> cpuset/A/cpuset.sched_load_balance: 0
> cpuset/A/cpuset.cpus: 0,1,2,3
> cpuset/A/B/cpuset.cpu_exclusive: 1
> cpuset/A/B/cpuset.cpus: 0,1
> cpuset/A/C/cpuset.cpu_exclusive: 1
> cpuset/A/C/cpuset.cpus: 2,3
> Is any acceptance test examined when a task is added to A or B (or C)?
> My experiment results:
> For A, yes, but it fails to utilize more than *two* cores when tasks
> are added to cpuset/A/tasks. Even if all cores are added to
> A/cpuset.cpus, it's still examined against two cores.
> For B (or C), yes, the acceptance test is examined for total
> utilization of two cores when tasks are added to cpuset/A/B(or
> C)/tasks.
>
> Scenario 2, identical cpusets:
> cpuset/A/cpuset.cpu_exclusive: 0
> cpuset/A/cpuset.cpus: 0,1
> cpuset/B/cpuset.cpu_exclusive: 0
> cpuset/B/cpuset.cpus: 0,1
> Is any acceptance test examined when a task is added to A (or B)?
> My experiment result:
> Yes, the acceptance test is examined with respect to cpuset {0,1},
> regardless of A or B.
>
> Scenario 3, overlapping cpusets:
> cpuset/A/cpuset.cpu_exclusive: 0
> cpuset/A/cpuset.cpus: 0,1
> cpuset/B/cpuset.cpu_exclusive: 0
> cpuset/B/cpuset.cpus: 1,2
> Is any acceptance test examined when a task is added to A (or B)?
> My experiment result:
> Operation not permitted for adding deadline tasks to cpusets that
> overlaps with others.
>
> > > I get deterministic admission test result without cpuset.  m-1 cores
> > > can be utilized (not m?).
> >
> > The maximum SCHED_DEADLINE utilization should be 95% of m (unless you
> > changed the values in /proc/sys/kernel/sched_rt_{runtime,period}_us).
> >
> >
> > > But with cpuset, the total utilization of accepted sched_deadline
> > > tasks seems not respecting the cpuset and changes every run.  For
> > > example, if cpuset contains 4 cores, I can have task sets (bound to
> > > this cpuset) utilizing 400%, 600%, or 300% before failing to add
> > > another task. It could be my program's issue. I'm still looking into
> > > it.
> >
> > If you get this result, I suspect you found a bug... Can you provide a
> > simple testcase for reproducing int?
> >
>
> I'll try to send you a test case soon.
> In the meantime, I figured out why I got the EPERM I mentioned in my
> first email. It's because I didn't disable cpuset.sched_load_balance
> at the root domain. It makes sense as allowing tasks to move in and
> out the cpuset violates the acceptance test assumption. But it might
> worth emphasizing this flag in the documentation though.
>
> Thanks,
> Ming
>
> >
> > Luca
