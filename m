Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 162E7C00140
	for <linux-rt-users@archiver.kernel.org>; Fri, 12 Aug 2022 14:34:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238540AbiHLOen (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 12 Aug 2022 10:34:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238539AbiHLOem (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 12 Aug 2022 10:34:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6A14BAB183
        for <linux-rt-users@vger.kernel.org>; Fri, 12 Aug 2022 07:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660314879;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zHQHSVYWMaCEAF1QdkwSod85X5iJpPMR8bSKsq+HERE=;
        b=VIoolzNudAgoSyq+08Nsc9GgDYbi7To3xgcBMZpW0KDD52GgcJr1surhfGHNSdplwLisn9
        nfvr8GeCtuj9/trb51xRssP5YXrBHUJPAhuThb38LsUaCwrayC/JIA7mg2VIryPxoo4sep
        ntDzWItR0jVtr+b9dXGZRzq9pUHN6DU=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-491-VWg1vtmTPo6IEhN_jWkEsQ-1; Fri, 12 Aug 2022 10:34:38 -0400
X-MC-Unique: VWg1vtmTPo6IEhN_jWkEsQ-1
Received: by mail-qt1-f199.google.com with SMTP id s2-20020ac85cc2000000b00342f8ad1f40so901372qta.12
        for <linux-rt-users@vger.kernel.org>; Fri, 12 Aug 2022 07:34:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc;
        bh=zHQHSVYWMaCEAF1QdkwSod85X5iJpPMR8bSKsq+HERE=;
        b=Rpzo6iluHYw0vRn4tIHVgHD2SkthYfD7w6XfEqywLJktX4wWajG2GIHT+q0rUHnZpb
         4ft7zaCol1Xp+QgDlZQ3lyGSe1Q1uKRSb1asdi+3fbM7VvibCx0tiES96pEhV/ZLDIuK
         Izm/+LLtxmpp5KH1p+HI4W+nS8CWMNyKqGrVVRW072JhPvasXufaOFvbh34VFLDFxSdR
         irLeFOKCqGT3VUjZ4+6MjEJFlXYp6p44I6OkV1Vpz8x4IuP0hlnWjXRVbZoNTFBB7SBy
         rGE8/N3v57HvCpCyMvKsa0KhEezZkq3WzJv26HTUvfYw4XJCQdZwR6X/Kny4YbK/aNQv
         N5LA==
X-Gm-Message-State: ACgBeo3x7n49i2T7Hkym2L7PPiMevPNTftBD9FXK5597AjTUl2ZUyAk5
        IeIb1TGfdC4hsmFPenfRyUEMhTgnj0Jrn4PL3SVeucgGuakxzHDGrFKlxfw4DrLsQrBriKWTin8
        oVcHXRbBXEeLl5/1Q9afLIZ7b9HM=
X-Received: by 2002:ac8:5f0d:0:b0:343:6e79:f1a2 with SMTP id x13-20020ac85f0d000000b003436e79f1a2mr3806956qta.657.1660314877747;
        Fri, 12 Aug 2022 07:34:37 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4ba6gDw8JXDUqPvwQdUUirAup2S1IT494UqID4bMKeKU/KTlG4pasPcaGilz6pDtH//8l7CA==
X-Received: by 2002:ac8:5f0d:0:b0:343:6e79:f1a2 with SMTP id x13-20020ac85f0d000000b003436e79f1a2mr3806935qta.657.1660314877480;
        Fri, 12 Aug 2022 07:34:37 -0700 (PDT)
Received: from fionn ([142.189.102.90])
        by smtp.gmail.com with ESMTPSA id j12-20020a05620a288c00b006b61b2cb1d2sm1856056qkp.46.2022.08.12.07.34.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Aug 2022 07:34:36 -0700 (PDT)
Date:   Fri, 12 Aug 2022 10:34:25 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     John Stultz <jstultz@google.com>
cc:     linux-rt-users@vger.kernel.org,
        Connor O'Brien <connoro@google.com>,
        Qais Yousef <qais.yousef@arm.com>
Subject: Re: [PATCH v2] cyclictest: Fix threads being affined even when -a
 isn't set
In-Reply-To: <CANDhNCrn=ngRwzkraHB7LAsMFrQjyOu87SsXF6xedkGR2Vk=HQ@mail.gmail.com>
Message-ID: <2041d210-cfbe-cad-ff0-1b7bd735ba2b@redhat.com>
References: <20220728202236.3998964-1-jstultz@google.com> <dc8e8275-d242-6766-b799-fb23a952398e@redhat.com> <CANDhNCoA1p2C5knQ_1p9-rn9JERgg4=7HzcXZJKqfgVAp55t8w@mail.gmail.com> <CANDhNCrn=ngRwzkraHB7LAsMFrQjyOu87SsXF6xedkGR2Vk=HQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Thu, 11 Aug 2022, John Stultz wrote:

> On Thu, Aug 11, 2022 at 11:57 AM John Stultz <jstultz@google.com> wrote:
> >
> > On Thu, Aug 11, 2022 at 10:57 AM John Kacur <jkacur@redhat.com> wrote:
> > > On Thu, 28 Jul 2022, John Stultz wrote:
> > >
> > > > Using cyclictest without specifying affinity via -a, I was
> > > > noticing a strange issue where the rt threads where not
> > > > migrating when being blocked.
> > > >
> > > > After lots of debugging in the kernel, I found its actually an
> > > > issue with cyclictest.
> > > >
> > > > When using -t there is no behavioral difference between specifying
> > > > -a or not specifying -a.
> > > >
> > > > This can be confirmed by adding printf messages around the
> > > > pthread_setaffinity_np() call in the threadtest function.
> > > >
> > > > Currently:
> > > >
> > > > root@localhost:~/rt-tests# ./cyclictest -t -a -q -D1
> > > > Affining thread 0 to cpu: 0
> > > > Affining thread 1 to cpu: 1
> > > > Affining thread 2 to cpu: 2
> > > > Affining thread 3 to cpu: 3
> > > > Affining thread 4 to cpu: 4
> > > > Affining thread 5 to cpu: 5
> > > > Affining thread 7 to cpu: 7
> > > > Affining thread 6 to cpu: 6
> > > > T: 0 (15034) P: 0 I:1000 C:   1000 Min:     82 Act:  184 Avg:  180 Max: 705
> > > > ...
> > > >
> > > > root@localhost:~/rt-tests# ./cyclictest -t -q -D1
> > > > Affining thread 0 to cpu: 0
> > > > Affining thread 1 to cpu: 1
> > > > Affining thread 2 to cpu: 2
> > > > Affining thread 3 to cpu: 3
> > > > Affining thread 4 to cpu: 4
> > > > Affining thread 5 to cpu: 5
> > > > Affining thread 6 to cpu: 6
> > > > Affining thread 7 to cpu: 7
> > > > T: 0 (15044) P: 0 I:1000 C:   1000 Min:     74 Act:  144 Avg:  162 Max: 860
> > > > ..
> > > >
> > > > This issue seems to come from the logic in process_options():
> > > >       /* if smp wasn't requested, test for numa automatically */
> > > >       if (!smp) {
> > > >               numa = numa_initialize();
> > > >               if (setaffinity == AFFINITY_UNSPECIFIED)
> > > >                       setaffinity = AFFINITY_USEALL;
> > > >         }
> > > >
> > > > Here, by setting setaffinity = AFFINITY_USEALL, we effectively
> > > > pin each thread to its respective cpu, same as the "-a" option.
> > > >
> > > > This was most recently introduced in commit bdb8350f1b0b
> > > > ("Revert "cyclictest: Use affinity_mask for steering
> > > > thread placement"").
> > > >
> > > > This seems erronious to me, so I wanted to share this patch
> > > > which removes the overriding AFFINITY_UNSPECIFIED with
> > > > AFFINITY_USEALL by default. Also, some additional tweaks to
> > > > preserve the existing numa allocation affinity.
> > > >
> > > > With this patch, we no longer call pthread_setaffinity_np() in the
> > > > "./cyclictest -t -q -D1"  case.
> > > >
> > > > Cc: John Kacur <jkacur@redhat.com>
> > > > Cc: Connor O'Brien <connoro@google.com>
> > > > Cc: Qais Yousef <qais.yousef@arm.com>
> > > > Signed-off-by: John Stultz <jstultz@google.com>
> > > > ---
> > > > v2: Fixes error passing cpu = -1 to rt_numa_numa_node_of_cpu()
> > > > ---
> > > >  src/cyclictest/cyclictest.c | 10 ++++++----
> > > >  1 file changed, 6 insertions(+), 4 deletions(-)
> > > >
> > > > diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
> > > > index decea78..82759d1 100644
> > > > --- a/src/cyclictest/cyclictest.c
> > > > +++ b/src/cyclictest/cyclictest.c
> > > > @@ -1270,8 +1270,6 @@ static void process_options(int argc, char *argv[], int max_cpus)
> > > >       /* if smp wasn't requested, test for numa automatically */
> > > >       if (!smp) {
> > > >               numa = numa_initialize();
> > > > -             if (setaffinity == AFFINITY_UNSPECIFIED)
> > > > -                     setaffinity = AFFINITY_USEALL;
> > > >       }
> > > >
> > > >       if (option_affinity) {
> > > > @@ -2043,9 +2041,13 @@ int main(int argc, char **argv)
> > > >                       void *stack;
> > > >                       void *currstk;
> > > >                       size_t stksize;
> > > > +                     int node_cpu = cpu;
> > > > +
> > > > +                     if (node_cpu == -1)
> > > > +                             node_cpu = cpu_for_thread_ua(i, max_cpus);
> > > >
> > > >                       /* find the memory node associated with the cpu i */
> > > > -                     node = rt_numa_numa_node_of_cpu(cpu);
> > > > +                     node = rt_numa_numa_node_of_cpu(node_cpu);
> > > >
> > > >                       /* get the stack size set for this thread */
> > > >                       if (pthread_attr_getstack(&attr, &currstk, &stksize))
> > > > @@ -2056,7 +2058,7 @@ int main(int argc, char **argv)
> > > >                               stksize = PTHREAD_STACK_MIN * 2;
> > > >
> > > >                       /*  allocate memory for a stack on appropriate node */
> > > > -                     stack = rt_numa_numa_alloc_onnode(stksize, node, cpu);
> > > > +                     stack = rt_numa_numa_alloc_onnode(stksize, node, node_cpu);
> > > >
> > > >                       /* touch the stack pages to pre-fault them in */
> > > >                       memset(stack, 0, stksize);
> > > > --
> > > > 2.37.1.455.g008518b4e5-goog
> > > >
> > > >
> > >
> > > Still thinking about this, I guess if we go with the above change it will
> > > mean that to get meaningful numa behaviour you'll need to specify -a
> >
> > So, I guess what exactly do you mean when you say "meaningful numa behavior"?
> >
> > My instinct is you want the memory for the thread running allocated on
> > the numa node its running on.
> > Ideally the kernel should take care of this automatically (doing local
> > node allocations and preferring the tasks' local node in the
> > scheduler), but I guess if you are trying to setup the initial thread
> > distribution across all the nodes, that's a bit hard to do w/o setting
> > the affinity.  So I sort of expect that if you're wanting to align
> > allocations to numa nodes, you probably want to either explicitly set
> > the affinity, or not give any guidance and let the kernel make its
> > best choice.
> >
> > I guess there's a fairly recent SCHED_SOFT_AFFINITY, which might
> > provide a soft affinity for numa?
> >
> > > This is what happened, inorder to reduce the alphabet soup of cyclictest
> > > options, we decided that if you don't specify --smp, we would test if
> > > numa was available and go with that and both implied -a, so we are missing
> > > a third option.
> > >
> > > Another possibility I guess would be to put back --numa, since it's
> > > starting to appear that the cure was worse than the disease. At least
> > > that's more explicit than using -a to get numa behaviour.
> >
> > This seems more intuitive to me.   Maybe --numa w/o -a would only
> > affine the cpumask to nodes, rather than cpus?
> 
> Thinking about this for just a second more.  This shouldn't be too
> hard. Just have to get a node->cpumask mapping, rather than affining
> thread x -> cpu x, you would just affine to
> node_mask(node(thread_id)).
> 
> thanks
> -john
> 

I had time to have a closer look at this, and it works fine, and isn't
causing any problems for rteval for example, which is explicitly
setting -a anyway when it calls cyclictest

Thanks for your patch!

Signed-off-by: John Kacur <jkacur@redhat.com>

