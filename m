Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E327C25B0C
	for <linux-rt-users@archiver.kernel.org>; Thu, 11 Aug 2022 18:57:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236235AbiHKS5Q (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 11 Aug 2022 14:57:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234747AbiHKS5P (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 11 Aug 2022 14:57:15 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3CD99F757
        for <linux-rt-users@vger.kernel.org>; Thu, 11 Aug 2022 11:57:14 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id k12so29676176ybk.6
        for <linux-rt-users@vger.kernel.org>; Thu, 11 Aug 2022 11:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=blyFuuhGEKM0gwIWrxHrNasJix3knrnD1fSG+ut4Diw=;
        b=juL3xEjR8T457FQJWY0siCUAQFMYKrpuzgd7QszpeBOoVZpcsr0T92ac6Bghb/hmg3
         jnJq3LsYnut2bVF2qFnxI/YWPHlDXAgdLRtu2bjuXg+3lb889C+Gsyu8IUuyFNsESKGy
         PkVmcT6g5HOOX2FWHtuwyBjtzoNwziij9xC4H3cY5/Dr6516hLMhADB3LDwgxoDRKZ5p
         hpUQrtj6Mh2tcLzB1XOIiFnLmPAm+Nsz9Thuwd3doabgfPRUqjw2P9/9THwcFeqoEiM8
         dBgd/38drVAqfKKeeM5YPJaG78xT4FgYh2uRqAATBQXlQj1gnW4MqlNhYBwhFyDAHYO7
         ID1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=blyFuuhGEKM0gwIWrxHrNasJix3knrnD1fSG+ut4Diw=;
        b=g0SALyl7TCuaig/GxWfnqQ4S7CFqM2rUjE8GFlUqrxh9yeeDhWmWVPJW9zeSVjNx2s
         9r7DGFBBGqIHOg4q9NqnQpGqYpumCiaTtKSGor0MdraS+V+VdVBVohnOhI+nsuYFgLD8
         27WFdbscFGUQAJBhesL2Vrg+iJC8qJs8n25+wmKCrQ6hrNlcuzZ7kz0OgouRVqphW7J3
         mt+elBbFT13PmS+Vlzovp5fEHi72xN1mcLu5uWVQiNioBWOpKbVbSUeA0c1/tp1DZjjx
         B9ps98FiNfd9FtQTxaIUid2dWfTekffjBh5i3MHvQPqcWkJelPIMvXGlNS4XSFuDRrN7
         RQPw==
X-Gm-Message-State: ACgBeo0YzEyh18GjOkzgqgo3tW10l6yrkYo2WfCIsOJ6l5vnZBsqCjd3
        A0oL3DqQtbxaVS9xIk91jNRf0IJkTUdl8BORuQX+
X-Google-Smtp-Source: AA6agR5Cx3386g92WfPGMwjIO36ZPvySTQccS3CJ9B0WZoww5ubyTVgiT4MKzRU7yVgFnmXYIvZrOLkZCUQ7HQv6ngY=
X-Received: by 2002:a25:2344:0:b0:67d:dafe:3bf6 with SMTP id
 j65-20020a252344000000b0067ddafe3bf6mr655876ybj.95.1660244233765; Thu, 11 Aug
 2022 11:57:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220728202236.3998964-1-jstultz@google.com> <dc8e8275-d242-6766-b799-fb23a952398e@redhat.com>
In-Reply-To: <dc8e8275-d242-6766-b799-fb23a952398e@redhat.com>
From:   John Stultz <jstultz@google.com>
Date:   Thu, 11 Aug 2022 11:57:02 -0700
Message-ID: <CANDhNCoA1p2C5knQ_1p9-rn9JERgg4=7HzcXZJKqfgVAp55t8w@mail.gmail.com>
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

On Thu, Aug 11, 2022 at 10:57 AM John Kacur <jkacur@redhat.com> wrote:
> On Thu, 28 Jul 2022, John Stultz wrote:
>
> > Using cyclictest without specifying affinity via -a, I was
> > noticing a strange issue where the rt threads where not
> > migrating when being blocked.
> >
> > After lots of debugging in the kernel, I found its actually an
> > issue with cyclictest.
> >
> > When using -t there is no behavioral difference between specifying
> > -a or not specifying -a.
> >
> > This can be confirmed by adding printf messages around the
> > pthread_setaffinity_np() call in the threadtest function.
> >
> > Currently:
> >
> > root@localhost:~/rt-tests# ./cyclictest -t -a -q -D1
> > Affining thread 0 to cpu: 0
> > Affining thread 1 to cpu: 1
> > Affining thread 2 to cpu: 2
> > Affining thread 3 to cpu: 3
> > Affining thread 4 to cpu: 4
> > Affining thread 5 to cpu: 5
> > Affining thread 7 to cpu: 7
> > Affining thread 6 to cpu: 6
> > T: 0 (15034) P: 0 I:1000 C:   1000 Min:     82 Act:  184 Avg:  180 Max: 705
> > ...
> >
> > root@localhost:~/rt-tests# ./cyclictest -t -q -D1
> > Affining thread 0 to cpu: 0
> > Affining thread 1 to cpu: 1
> > Affining thread 2 to cpu: 2
> > Affining thread 3 to cpu: 3
> > Affining thread 4 to cpu: 4
> > Affining thread 5 to cpu: 5
> > Affining thread 6 to cpu: 6
> > Affining thread 7 to cpu: 7
> > T: 0 (15044) P: 0 I:1000 C:   1000 Min:     74 Act:  144 Avg:  162 Max: 860
> > ..
> >
> > This issue seems to come from the logic in process_options():
> >       /* if smp wasn't requested, test for numa automatically */
> >       if (!smp) {
> >               numa = numa_initialize();
> >               if (setaffinity == AFFINITY_UNSPECIFIED)
> >                       setaffinity = AFFINITY_USEALL;
> >         }
> >
> > Here, by setting setaffinity = AFFINITY_USEALL, we effectively
> > pin each thread to its respective cpu, same as the "-a" option.
> >
> > This was most recently introduced in commit bdb8350f1b0b
> > ("Revert "cyclictest: Use affinity_mask for steering
> > thread placement"").
> >
> > This seems erronious to me, so I wanted to share this patch
> > which removes the overriding AFFINITY_UNSPECIFIED with
> > AFFINITY_USEALL by default. Also, some additional tweaks to
> > preserve the existing numa allocation affinity.
> >
> > With this patch, we no longer call pthread_setaffinity_np() in the
> > "./cyclictest -t -q -D1"  case.
> >
> > Cc: John Kacur <jkacur@redhat.com>
> > Cc: Connor O'Brien <connoro@google.com>
> > Cc: Qais Yousef <qais.yousef@arm.com>
> > Signed-off-by: John Stultz <jstultz@google.com>
> > ---
> > v2: Fixes error passing cpu = -1 to rt_numa_numa_node_of_cpu()
> > ---
> >  src/cyclictest/cyclictest.c | 10 ++++++----
> >  1 file changed, 6 insertions(+), 4 deletions(-)
> >
> > diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
> > index decea78..82759d1 100644
> > --- a/src/cyclictest/cyclictest.c
> > +++ b/src/cyclictest/cyclictest.c
> > @@ -1270,8 +1270,6 @@ static void process_options(int argc, char *argv[], int max_cpus)
> >       /* if smp wasn't requested, test for numa automatically */
> >       if (!smp) {
> >               numa = numa_initialize();
> > -             if (setaffinity == AFFINITY_UNSPECIFIED)
> > -                     setaffinity = AFFINITY_USEALL;
> >       }
> >
> >       if (option_affinity) {
> > @@ -2043,9 +2041,13 @@ int main(int argc, char **argv)
> >                       void *stack;
> >                       void *currstk;
> >                       size_t stksize;
> > +                     int node_cpu = cpu;
> > +
> > +                     if (node_cpu == -1)
> > +                             node_cpu = cpu_for_thread_ua(i, max_cpus);
> >
> >                       /* find the memory node associated with the cpu i */
> > -                     node = rt_numa_numa_node_of_cpu(cpu);
> > +                     node = rt_numa_numa_node_of_cpu(node_cpu);
> >
> >                       /* get the stack size set for this thread */
> >                       if (pthread_attr_getstack(&attr, &currstk, &stksize))
> > @@ -2056,7 +2058,7 @@ int main(int argc, char **argv)
> >                               stksize = PTHREAD_STACK_MIN * 2;
> >
> >                       /*  allocate memory for a stack on appropriate node */
> > -                     stack = rt_numa_numa_alloc_onnode(stksize, node, cpu);
> > +                     stack = rt_numa_numa_alloc_onnode(stksize, node, node_cpu);
> >
> >                       /* touch the stack pages to pre-fault them in */
> >                       memset(stack, 0, stksize);
> > --
> > 2.37.1.455.g008518b4e5-goog
> >
> >
>
> Still thinking about this, I guess if we go with the above change it will
> mean that to get meaningful numa behaviour you'll need to specify -a

So, I guess what exactly do you mean when you say "meaningful numa behavior"?

My instinct is you want the memory for the thread running allocated on
the numa node its running on.
Ideally the kernel should take care of this automatically (doing local
node allocations and preferring the tasks' local node in the
scheduler), but I guess if you are trying to setup the initial thread
distribution across all the nodes, that's a bit hard to do w/o setting
the affinity.  So I sort of expect that if you're wanting to align
allocations to numa nodes, you probably want to either explicitly set
the affinity, or not give any guidance and let the kernel make its
best choice.

I guess there's a fairly recent SCHED_SOFT_AFFINITY, which might
provide a soft affinity for numa?

> This is what happened, inorder to reduce the alphabet soup of cyclictest
> options, we decided that if you don't specify --smp, we would test if
> numa was available and go with that and both implied -a, so we are missing
> a third option.
>
> Another possibility I guess would be to put back --numa, since it's
> starting to appear that the cure was worse than the disease. At least
> that's more explicit than using -a to get numa behaviour.

This seems more intuitive to me.   Maybe --numa w/o -a would only
affine the cpumask to nodes, rather than cpus?


> Or if -a is unused we could have a --no--affinity

Though, having -a which doesn't do anything and --no-affinity might
just add to the confusion.

thanks
-john
