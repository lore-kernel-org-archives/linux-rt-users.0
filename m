Return-Path: <SRS0=v1XI=UX=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED411C4646C
	for <linux-rt-users@archiver.kernel.org>; Mon, 24 Jun 2019 23:17:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1D33204FD
	for <linux-rt-users@archiver.kernel.org>; Mon, 24 Jun 2019 23:17:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eQhWOJ5p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728362AbfFXXRZ (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 24 Jun 2019 19:17:25 -0400
Received: from mail-ua1-f51.google.com ([209.85.222.51]:36525 "EHLO
        mail-ua1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726486AbfFXXRZ (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 24 Jun 2019 19:17:25 -0400
Received: by mail-ua1-f51.google.com with SMTP id v20so6354568uao.3
        for <linux-rt-users@vger.kernel.org>; Mon, 24 Jun 2019 16:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TVg/tfkk+DOkpQEJG7Vvc6MEOT+BuHcV40Cxe7pPlW8=;
        b=eQhWOJ5pD9nruPsz8eFuLS0WKw0fEniKXIG32ROcsaGoWyb8kL/tmyzWhiXDunWP3X
         EZpuIYkFFEW+seirKaPZagdJe19LTpNjrk+sjsRQmvbPDoN9+aTn38LDF8Kjbq1wJ41r
         evxIj22qHmhmMF64hVXX6cGfmevHyJyPMvYVfc2p3SLOMlWUbKrMp6gDeF1JnPEe2GLG
         jtK1vEOwuQ8AI3rBEOXXURpcuv5R2X/9yI0soZUuKnprHwMSoksbx5j4evMim/OtWPpQ
         um3sTbUnzWLHv5DX0C9SDlAfBHo7YZ9XJ2U9K4wIlDdj1MSYPbblsrKNox2YB4c8IEgk
         W8Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TVg/tfkk+DOkpQEJG7Vvc6MEOT+BuHcV40Cxe7pPlW8=;
        b=KX8VmmuqR/3mV/+3SNELcsjImm29M+1LFyS1UlpvaHI9Ccg6qwTpDu3FJtn36aWpq2
         47vsG1oU9NPHe74QHLwP4E80p/acsnXyBay7sYKBzk0RDiyWl4omUlDrSoRjgB1mQD/a
         VOl8caCoD6hER5xm8pH/bETJPtTJfXEK9Cd0zjkgZ+PMfnLwwX8HxzHqgAblZNiPXRu7
         CRV9TyvzaB1SMW4KyZIPR9gleApEb2szZF/PGZwL76CfrCyEtd0wp2o1JE+6gib3k4q0
         8l6I+Bn1Q79TEiohQPQzLfuDQmtPkiadVo9cdIWCFxOxVeQtFFV2X7JJPw/vGmFo9LAf
         qj7A==
X-Gm-Message-State: APjAAAVKJkX9x00RYVu4F6p1bDWtNw0ictHa9aEJ0q6WZ5+idJFCC1Ju
        4VDUD6ds7/EbjyxoNftsEmYCQr54VVhK9ArhW5HRr6Cl9K4=
X-Google-Smtp-Source: APXvYqygDCGc78WJ6VV9WCY5RjdTiLTdzERU99+393R4Ru3XKmsZDxzyw0oBUrFipPmLZG8xO/od/jWgfltD95waA/c=
X-Received: by 2002:ab0:66:: with SMTP id 93mr26825093uai.135.1561418244305;
 Mon, 24 Jun 2019 16:17:24 -0700 (PDT)
MIME-Version: 1.0
References: <CAEVNDXsR03jGXKO5diQbjMQecS=wXxdEW5eGQAAL1PPOQ_RO6Q@mail.gmail.com>
 <CAJfkoWqsPJoxeQwxCYAU1kG6ny5BBuiTCpiqM+KgAsZH58trbw@mail.gmail.com>
 <CAEVNDXv88RvDgWDhxD=3XW=0kO3TSBYy57q0s1u985z1TaaFVg@mail.gmail.com> <CAJfkoWp=eDa86x7EmAdqa1chSsLRMPBg=XnqaeBPP+H2La1XNg@mail.gmail.com>
In-Reply-To: <CAJfkoWp=eDa86x7EmAdqa1chSsLRMPBg=XnqaeBPP+H2La1XNg@mail.gmail.com>
From:   Ming Yang <minos.future@gmail.com>
Date:   Mon, 24 Jun 2019 16:17:13 -0700
Message-ID: <CAEVNDXt3UhqoCsnN+mcEh9X4hXRvTv6qQbdgkcRprPfBRr9qSg@mail.gmail.com>
Subject: Re: sched_deadline sched_setattr fails after setting cpuset
To:     Luca Abeni <lucabe72@gmail.com>
Cc:     linux-rt-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi,

On Fri, Jun 21, 2019 at 3:34 AM Luca Abeni <lucabe72@gmail.com> wrote:
>
> Hi,
>
> On Fri, 21 Jun 2019 at 02:54, Ming Yang <minos.future@gmail.com> wrote:
> [...]
> > I have a question about the admission test with cpuset.  Is the
> > sched_deadline admission test examined with respect to the CPUs
> > allowed in the cpuset?
>
> Yes, in theory you should be able to use up to 95% (or whatever you
> configured in /proc/sys/kernel/sched_rt*) of the CPUs contained in the
> cpuset.
>
> I am pretty sure it worked correctly when I tested this, but it was a
> lot of time ago...
>

Thanks!
I suppose acceptance test on cpusets that share CPUs doesn't work? For
example, the following three scenarios:

Scenario 1, sub-cpusets:
cpuset/A/cpuset.cpu_exclusive: 1
cpuset/A/cpuset.sched_load_balance: 0
cpuset/A/cpuset.cpus: 0,1,2,3
cpuset/A/B/cpuset.cpu_exclusive: 1
cpuset/A/B/cpuset.cpus: 0,1
cpuset/A/C/cpuset.cpu_exclusive: 1
cpuset/A/C/cpuset.cpus: 2,3
Is any acceptance test examined when a task is added to A or B (or C)?
My experiment results:
For A, yes, but it fails to utilize more than *two* cores when tasks
are added to cpuset/A/tasks. Even if all cores are added to
A/cpuset.cpus, it's still examined against two cores.
For B (or C), yes, the acceptance test is examined for total
utilization of two cores when tasks are added to cpuset/A/B(or
C)/tasks.

Scenario 2, identical cpusets:
cpuset/A/cpuset.cpu_exclusive: 0
cpuset/A/cpuset.cpus: 0,1
cpuset/B/cpuset.cpu_exclusive: 0
cpuset/B/cpuset.cpus: 0,1
Is any acceptance test examined when a task is added to A (or B)?
My experiment result:
Yes, the acceptance test is examined with respect to cpuset {0,1},
regardless of A or B.

Scenario 3, overlapping cpusets:
cpuset/A/cpuset.cpu_exclusive: 0
cpuset/A/cpuset.cpus: 0,1
cpuset/B/cpuset.cpu_exclusive: 0
cpuset/B/cpuset.cpus: 1,2
Is any acceptance test examined when a task is added to A (or B)?
My experiment result:
Operation not permitted for adding deadline tasks to cpusets that
overlaps with others.

> > I get deterministic admission test result without cpuset.  m-1 cores
> > can be utilized (not m?).
>
> The maximum SCHED_DEADLINE utilization should be 95% of m (unless you
> changed the values in /proc/sys/kernel/sched_rt_{runtime,period}_us).
>
>
> > But with cpuset, the total utilization of accepted sched_deadline
> > tasks seems not respecting the cpuset and changes every run.  For
> > example, if cpuset contains 4 cores, I can have task sets (bound to
> > this cpuset) utilizing 400%, 600%, or 300% before failing to add
> > another task. It could be my program's issue. I'm still looking into
> > it.
>
> If you get this result, I suspect you found a bug... Can you provide a
> simple testcase for reproducing int?
>

I'll try to send you a test case soon.
In the meantime, I figured out why I got the EPERM I mentioned in my
first email. It's because I didn't disable cpuset.sched_load_balance
at the root domain. It makes sense as allowing tasks to move in and
out the cpuset violates the acceptance test assumption. But it might
worth emphasizing this flag in the documentation though.

Thanks,
Ming

>
> Luca
