Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE913C43217
	for <linux-rt-users@archiver.kernel.org>; Thu,  3 Mar 2022 14:10:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233934AbiCCOL2 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 3 Mar 2022 09:11:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233899AbiCCOL1 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 3 Mar 2022 09:11:27 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A4C8818CC0F
        for <linux-rt-users@vger.kernel.org>; Thu,  3 Mar 2022 06:10:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646316640;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aWk3jBMeJTdwrNX3wqrCnZbk5d/gQSX5OEwgsEHsMQY=;
        b=CIkdahvzdSPSmxYnghK0xrMVl/vN2JCALBA+r2xaID7ESstmaF/VenzfQEMGe21wN+JvC5
        la/3kBqeNf5dBPlMKtekslfJlDEMJA57p3ZxI5gYt27Ov+Y7tlmyjZD3SpOAYKhVqKmRrg
        D/wpgl85qT+BVv3VfHu7uD7A1aP9aoI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-557-vXnD5SLKOmaDXTjVO9O7xw-1; Thu, 03 Mar 2022 09:10:39 -0500
X-MC-Unique: vXnD5SLKOmaDXTjVO9O7xw-1
Received: by mail-wm1-f69.google.com with SMTP id n31-20020a05600c3b9f00b003812242973aso1699284wms.4
        for <linux-rt-users@vger.kernel.org>; Thu, 03 Mar 2022 06:10:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=aWk3jBMeJTdwrNX3wqrCnZbk5d/gQSX5OEwgsEHsMQY=;
        b=u00Vz/iMp4Rh5odLFm1MFgfbd3V9GOvOkQZfOD9BFZq6ThT9/EEosN/Tgl5bwOqv6E
         u2SmTTnv+c9lBwQni1yIkbzw6p7RPrudcWsR6gDxaOKglVT9gWHMAeOa5FZ9irsQniVl
         CbHSAYig0vueWJvmFaod+y1/Y+NtwuJTTPDOVJBK/VMiaxEtb4yaUw8GinBSD+9O2pLa
         wXJDmAUozf2pn4s08G41aoCQvSp4cB6/ILqgx1GmZUJRqIUKJ9kCVlCC9yzEJ5W4faM3
         vb9twxOmhnvvNLVgdn7yNqON/Rn+Dc9woJvKXhOCGx7vmEbYaqepwrCpHadMkgs76beT
         feBw==
X-Gm-Message-State: AOAM531NimgszxhdRDvVaKn+PjjoOH5Ihz5kHcU4yog1xIYJwWsXMIJk
        2yoE7nfjVHxmUtH0JoGhF8djVVN8mnkr5a4C082LkfWJSj6sLqypMHFnTBT6z2y6NdgPDIYIPQI
        gO1To2KckKQVV7fqgfwS7KUxvxzk=
X-Received: by 2002:a1c:a583:0:b0:383:67c7:3d58 with SMTP id o125-20020a1ca583000000b0038367c73d58mr3923433wme.150.1646316638327;
        Thu, 03 Mar 2022 06:10:38 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy5tuwb8TCREOTiw1/McPbtRm6otYmLs60Pbfo9wZFOZgL7sBSpDo17lbyuysN9uH3XoeRXYA==
X-Received: by 2002:a1c:a583:0:b0:383:67c7:3d58 with SMTP id o125-20020a1ca583000000b0038367c73d58mr3923418wme.150.1646316638039;
        Thu, 03 Mar 2022 06:10:38 -0800 (PST)
Received: from ?IPv6:2a0c:5a80:1b14:b500:abb:f9d1:7bc2:3db8? ([2a0c:5a80:1b14:b500:abb:f9d1:7bc2:3db8])
        by smtp.gmail.com with ESMTPSA id bd5-20020a05600c1f0500b00387d812a267sm2255337wmb.37.2022.03.03.06.10.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 06:10:37 -0800 (PST)
Message-ID: <d2b9c1ebe7d25060ad4334a0d37d909860e1bd37.camel@redhat.com>
Subject: Re: [PATCH 0/2] mm/page_alloc: Remote per-cpu lists drain support
From:   Nicolas Saenz Julienne <nsaenzju@redhat.com>
To:     Vlastimil Babka <vbabka@suse.cz>, akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        frederic@kernel.org, tglx@linutronix.de, mtosatti@redhat.com,
        mgorman@suse.de, linux-rt-users@vger.kernel.org, cl@linux.com,
        paulmck@kernel.org, willy@infradead.org
Date:   Thu, 03 Mar 2022 15:10:35 +0100
In-Reply-To: <ad999259-0ea9-06f4-eec0-bba5372bbb0a@suse.cz>
References: <20220208100750.1189808-1-nsaenzju@redhat.com>
         <ad999259-0ea9-06f4-eec0-bba5372bbb0a@suse.cz>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Thu, 2022-03-03 at 14:27 +0100, Vlastimil Babka wrote:
> On 2/8/22 11:07, Nicolas Saenz Julienne wrote:
> > This series replaces mm/page_alloc's per-cpu page lists drain mechanism with
> > one that allows accessing the lists remotely. Currently, only a local CPU is
> > permitted to change its per-cpu lists, and it's expected to do so, on-demand,
> > whenever a process demands it by means of queueing a drain task on the local
> > CPU. This causes problems for NOHZ_FULL CPUs and real-time systems that can't
> > take any sort of interruption and to some lesser extent inconveniences idle and
> > virtualised systems.
> > 
> > The new algorithm will atomically switch the pointer to the per-cpu page lists
> > and use RCU to make sure it's not being concurrently used before draining the
> > lists. And its main benefit of is that it fixes the issue for good, avoiding
> > the need for configuration based heuristics or having to modify applications
> > (i.e. using the isolation prctrl being worked by Marcello Tosatti ATM).
> > 
> > All this with minimal performance implications: a page allocation
> > microbenchmark was run on multiple systems and architectures generally showing
> > no performance differences, only the more extreme cases showed a 1-3%
> > degradation. See data below. Needless to say that I'd appreciate if someone
> > could validate my values independently.
> > 
> > The approach has been stress-tested: I forced 100 drains/s while running
> > mmtests' pft in a loop for a full day on multiple machines and archs (arm64,
> > x86_64, ppc64le).
> > 
> > Note that this is not the first attempt at fixing this per-cpu page lists:
> >  - The first attempt[1] tried to conditionally change the pagesets locking
> >    scheme based the NOHZ_FULL config. It was deemed hard to maintain as the
> >    NOHZ_FULL code path would be rarely tested. Also, this only solves the issue
> >    for NOHZ_FULL setups, which isn't ideal.
> >  - The second[2] unanimously switched the local_locks to per-cpu spinlocks. The
> >    performance degradation was too big.
> 
> For completeness, what was the fate of the approach to have pcp->high = 0
> for NOHZ cpus? [1] It would be nice to have documented why it wasn't
> feasible. Too much overhead for when these CPUs eventually do allocate, or
> some other unforeseen issue? Thanks.

Yes sorry, should've been more explicit on why I haven't gone that way yet.

Some points:
 - As I mention above, not only CPU isolation users care for this. RT and HPC
   do too. This is my main motivation for focusing on this solution, or
   potentially Mel's.

 - Fully disabling pcplists on nohz_full CPUs is too drastic, as isolated CPUs
   might want to retain the performance edge while not running their sensitive
   workloads. (I remember Christoph Lamenter's commenting about this on the
   previous RFC).

 - So the idea would be to selectively disable pcplists upon entering in the
   really 'isolated' area. This could be achieved with Marcelo Tosatti's new
   WIP prctrl[1]. And if we decide the current solutions are unacceptable I'll
   have a go at it.

Thanks!

[1] https://lore.kernel.org/lkml/20220204173554.534186379@fedora.localdomain/T/

-- 
Nicolás Sáenz

