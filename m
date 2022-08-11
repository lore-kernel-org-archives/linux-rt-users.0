Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDE7CC19F2A
	for <linux-rt-users@archiver.kernel.org>; Thu, 11 Aug 2022 19:00:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236270AbiHKTA1 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 11 Aug 2022 15:00:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236248AbiHKTAZ (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 11 Aug 2022 15:00:25 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E669275DD
        for <linux-rt-users@vger.kernel.org>; Thu, 11 Aug 2022 12:00:22 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-3246910dac3so181691787b3.12
        for <linux-rt-users@vger.kernel.org>; Thu, 11 Aug 2022 12:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=NAJnhIFCTJzlrf4RwvX9S/AMcQIkoq83bYKRyjk7vhw=;
        b=j5j7vxvVmkj+srffR01bL6LTUvhLPUWfE1VYreAhw0gnB/bfQGsLQAbsdEFo9PLhOF
         Q0pODk4dt1KOlJ13NJl860Fped70OqN4aMFyvvs+4efhUHYHVjsf5ZBsF0GX6tP7nz7l
         HU65S0fsDv9XRzGfCvmGgNsGYRDO0Lf6A0C6hPWVC0sZKGk2W7DeFyole/H7l1EQCJWy
         XsN0BmUmp58Oki9MNRBvVZo6FAI729/oGiSGgMOFOB62jGcqz7MbW+/bwqQXZqZS/9Wm
         ngMn5EVcIK+S15jUTvxkPJpTyueA1GtP8rYN/IwPUGyXbzgoQV8nQVInS/n2JZjFVZtl
         2wAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=NAJnhIFCTJzlrf4RwvX9S/AMcQIkoq83bYKRyjk7vhw=;
        b=TSQbjoMbIHbNlm7xN+Y108fnSG5fMYxTKuHBL7oFs0mYDmTaIoutcabelo0qeOHE2V
         e/7U3ZedV81VQgwejG8bNVPTJuYvHr+V8BFZZ4/6kfwRdDKEAbPo/t5WzTM0Ggr0+hrL
         CIHJV5dK4DO3I/8EYzVB4SwKB0v+zf6Z+hk5AvrHgMUyIdYBzd3mHJ4X0l1Keq3UFXhF
         JGW9wVhVp87kSg0BdJdoXRwqdfhPgBZqAAAwbSdxkIq0/ai1l+HoY+lsL3ekBcXCMOuW
         GNCNbFzjQaO7DxVMxrvqxjadTIv7NggFU2GUZTHJqYHhBSKMGZBlZj2rXIQfwXpqIFH2
         SLSw==
X-Gm-Message-State: ACgBeo05UHzQvmv7mhY6RZjjopp+b6q2w8k8xCYukVbURzl9GPb9mRdW
        6dxpnsB2EkEie2C6A8L5MgK5/6YuMvEvwZ5X3Hu5
X-Google-Smtp-Source: AA6agR5nlk40VNF2V1ldrKAh3eu3nZ+lGnU/kNA66U4q5NDF/yNyoxLtmeWgODYNtDf4drdPCgnQ6DbFEcQsogfAoyM=
X-Received: by 2002:a0d:cb57:0:b0:32b:2ff9:8d1e with SMTP id
 n84-20020a0dcb57000000b0032b2ff98d1emr582930ywd.395.1660244421403; Thu, 11
 Aug 2022 12:00:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220728202236.3998964-1-jstultz@google.com> <dc8e8275-d242-6766-b799-fb23a952398e@redhat.com>
 <CANDhNCoA1p2C5knQ_1p9-rn9JERgg4=7HzcXZJKqfgVAp55t8w@mail.gmail.com>
In-Reply-To: <CANDhNCoA1p2C5knQ_1p9-rn9JERgg4=7HzcXZJKqfgVAp55t8w@mail.gmail.com>
From:   John Stultz <jstultz@google.com>
Date:   Thu, 11 Aug 2022 12:00:10 -0700
Message-ID: <CANDhNCrn=ngRwzkraHB7LAsMFrQjyOu87SsXF6xedkGR2Vk=HQ@mail.gmail.com>
Subject: Re: [PATCH v2] cyclictest: Fix threads being affined even when -a
 isn't set
To:     John Kacur <jkacur@redhat.com>
Cc:     linux-rt-users@vger.kernel.org,
        "Connor O'Brien" <connoro@google.com>,
        Qais Yousef <qais.yousef@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Thu, Aug 11, 2022 at 11:57 AM John Stultz <jstultz@google.com> wrote:
>
> On Thu, Aug 11, 2022 at 10:57 AM John Kacur <jkacur@redhat.com> wrote:
> > On Thu, 28 Jul 2022, John Stultz wrote:
> >
> > > Using cyclictest without specifying affinity via -a, I was
> > > noticing a strange issue where the rt threads where not
> > > migrating when being blocked.
> > >
> > > After lots of debugging in the kernel, I found its actually an
> > > issue with cyclictest.
> > >
> > > When using -t there is no behavioral difference between specifying
> > > -a or not specifying -a.
> > >
> > > This can be confirmed by adding printf messages around the
> > > pthread_setaffinity_np() call in the threadtest function.
> > >
> > > Currently:
> > >
> > > root@localhost:~/rt-tests# ./cyclictest -t -a -q -D1
> > > Affining thread 0 to cpu: 0
> > > Affining thread 1 to cpu: 1
> > > Affining thread 2 to cpu: 2
> > > Affining thread 3 to cpu: 3
> > > Affining thread 4 to cpu: 4
> > > Affining thread 5 to cpu: 5
> > > Affining thread 7 to cpu: 7
> > > Affining thread 6 to cpu: 6
> > > T: 0 (15034) P: 0 I:1000 C:   1000 Min:     82 Act:  184 Avg:  180 Max: 705
> > > ...
> > >
> > > root@localhost:~/rt-tests# ./cyclictest -t -q -D1
> > > Affining thread 0 to cpu: 0
> > > Affining thread 1 to cpu: 1
> > > Affining thread 2 to cpu: 2
> > > Affining thread 3 to cpu: 3
> > > Affining thread 4 to cpu: 4
> > > Affining thread 5 to cpu: 5
> > > Affining thread 6 to cpu: 6
> > > Affining thread 7 to cpu: 7
> > > T: 0 (15044) P: 0 I:1000 C:   1000 Min:     74 Act:  144 Avg:  162 Max: 860
> > > ..
> > >
> > > This issue seems to come from the logic in process_options():
> > >       /* if smp wasn't requested, test for numa automatically */
> > >       if (!smp) {
> > >               numa = numa_initialize();
> > >               if (setaffinity == AFFINITY_UNSPECIFIED)
> > >                       setaffinity = AFFINITY_USEALL;
> > >         }
> > >
> > > Here, by setting setaffinity = AFFINITY_USEALL, we effectively
> > > pin each thread to its respective cpu, same as the "-a" option.
> > >
> > > This was most recently introduced in commit bdb8350f1b0b
> > > ("Revert "cyclictest: Use affinity_mask for steering
> > > thread placement"").
> > >
> > > This seems erronious to me, so I wanted to share this patch
> > > which removes the overriding AFFINITY_UNSPECIFIED with
> > > AFFINITY_USEALL by default. Also, some additional tweaks to
> > > preserve the existing numa allocation affinity.
> > >
> > > With this patch, we no longer call pthread_setaffinity_np() in the
> > > "./cyclictest -t -q -D1"  case.
> > >
> > > Cc: John Kacur <jkacur@redhat.com>
> > > Cc: Connor O'Brien <connoro@google.com>
> > > Cc: Qais Yousef <qais.yousef@arm.com>
> > > Signed-off-by: John Stultz <jstultz@google.com>
> > > ---
> > > v2: Fixes error passing cpu = -1 to rt_numa_numa_node_of_cpu()
> > > ---
> > >  src/cyclictest/cyclictest.c | 10 ++++++----
> > >  1 file changed, 6 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
> > > index decea78..82759d1 100644
> > > --- a/src/cyclictest/cyclictest.c
> > > +++ b/src/cyclictest/cyclictest.c
> > > @@ -1270,8 +1270,6 @@ static void process_options(int argc, char *argv[], int max_cpus)
> > >       /* if smp wasn't requested, test for numa automatically */
> > >       if (!smp) {
> > >               numa = numa_initialize();
> > > -             if (setaffinity == AFFINITY_UNSPECIFIED)
> > > -                     setaffinity = AFFINITY_USEALL;
> > >       }
> > >
> > >       if (option_affinity) {
> > > @@ -2043,9 +2041,13 @@ int main(int argc, char **argv)
> > >                       void *stack;
> > >                       void *currstk;
> > >                       size_t stksize;
> > > +                     int node_cpu = cpu;
> > > +
> > > +                     if (node_cpu == -1)
> > > +                             node_cpu = cpu_for_thread_ua(i, max_cpus);
> > >
> > >                       /* find the memory node associated with the cpu i */
> > > -                     node = rt_numa_numa_node_of_cpu(cpu);
> > > +                     node = rt_numa_numa_node_of_cpu(node_cpu);
> > >
> > >                       /* get the stack size set for this thread */
> > >                       if (pthread_attr_getstack(&attr, &currstk, &stksize))
> > > @@ -2056,7 +2058,7 @@ int main(int argc, char **argv)
> > >                               stksize = PTHREAD_STACK_MIN * 2;
> > >
> > >                       /*  allocate memory for a stack on appropriate node */
> > > -                     stack = rt_numa_numa_alloc_onnode(stksize, node, cpu);
> > > +                     stack = rt_numa_numa_alloc_onnode(stksize, node, node_cpu);
> > >
> > >                       /* touch the stack pages to pre-fault them in */
> > >                       memset(stack, 0, stksize);
> > > --
> > > 2.37.1.455.g008518b4e5-goog
> > >
> > >
> >
> > Still thinking about this, I guess if we go with the above change it will
> > mean that to get meaningful numa behaviour you'll need to specify -a
>
> So, I guess what exactly do you mean when you say "meaningful numa behavior"?
>
> My instinct is you want the memory for the thread running allocated on
> the numa node its running on.
> Ideally the kernel should take care of this automatically (doing local
> node allocations and preferring the tasks' local node in the
> scheduler), but I guess if you are trying to setup the initial thread
> distribution across all the nodes, that's a bit hard to do w/o setting
> the affinity.  So I sort of expect that if you're wanting to align
> allocations to numa nodes, you probably want to either explicitly set
> the affinity, or not give any guidance and let the kernel make its
> best choice.
>
> I guess there's a fairly recent SCHED_SOFT_AFFINITY, which might
> provide a soft affinity for numa?
>
> > This is what happened, inorder to reduce the alphabet soup of cyclictest
> > options, we decided that if you don't specify --smp, we would test if
> > numa was available and go with that and both implied -a, so we are missing
> > a third option.
> >
> > Another possibility I guess would be to put back --numa, since it's
> > starting to appear that the cure was worse than the disease. At least
> > that's more explicit than using -a to get numa behaviour.
>
> This seems more intuitive to me.   Maybe --numa w/o -a would only
> affine the cpumask to nodes, rather than cpus?

Thinking about this for just a second more.  This shouldn't be too
hard. Just have to get a node->cpumask mapping, rather than affining
thread x -> cpu x, you would just affine to
node_mask(node(thread_id)).

thanks
-john
