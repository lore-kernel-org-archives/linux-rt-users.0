Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6BD3C433EF
	for <linux-rt-users@archiver.kernel.org>; Mon,  7 Mar 2022 13:57:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242562AbiCGN6t (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 7 Mar 2022 08:58:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241637AbiCGN6s (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 7 Mar 2022 08:58:48 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 03F883A1B9
        for <linux-rt-users@vger.kernel.org>; Mon,  7 Mar 2022 05:57:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646661472;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wM6VOulZtYrylaSH6OVQrZB6SV0lfkKkm0v+oBQEvPk=;
        b=ifrn7hDyGk+ErHM2XhBsvxckv7+SMyxFPW9WBNvOEpBO2GV0PB3/F8XWBkKwCA9w6E5SSY
        EGOULgpLgi7NIUL4gC4sslCptpVPpd7GngF+Q/pBQbeJA1Bmn9zjLaZyKAmh+lsRjKI4LE
        K/K5UkbmEg9cd4Py3kVphuDxRhloSwc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-168-Y-1SIRE3MqmBw2ki5wlrUQ-1; Mon, 07 Mar 2022 08:57:50 -0500
X-MC-Unique: Y-1SIRE3MqmBw2ki5wlrUQ-1
Received: by mail-wr1-f70.google.com with SMTP id t8-20020adfa2c8000000b001e8f6889404so4581739wra.0
        for <linux-rt-users@vger.kernel.org>; Mon, 07 Mar 2022 05:57:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=wM6VOulZtYrylaSH6OVQrZB6SV0lfkKkm0v+oBQEvPk=;
        b=q+WQgAjIpZEi3zAK89zh+lC3MPNTX4U9CuvrJBnjPsRDyatpHjkOCSqKKJsxQZi9/7
         qd0ejFHazjFkEvd6ByyLZnIJjIhFQ/Ei8BgdACZQJPSax0BtHzPm736y0mQ3p3xhAmJl
         6QdihF5KeYUqTEaLPKEk8t4iuyGTHw/TOkvwDuqOVnZV522btDOqCbCE4f75YKTWUzk4
         VYR7uga8/hCIcj8TLnq2J+DXX92R91cFM6EbzV7h7p8RuRe+tVQ+MxEIqPbhZ3Ss7Rlm
         3CMsoXsTSW9VzAYJZ8MzbJ1KISTxpenlB46etenfFx5ciU7nENjNa116iMg300oOc4eh
         rLDg==
X-Gm-Message-State: AOAM531lUNFgiaXHv6QmkXW4t2kc/l5pAQHlbQvlPn+FGjP983DMNg6V
        hQ+7078BrcUJblVKKxPWCHVQE4cb5sRmAY0hxcdHZUFDrZ5TAG0RTNS1aURsmzzzJivlzPbodnF
        v2kz7E1X+E4kT9q4+384GkitHZ+I=
X-Received: by 2002:adf:d1e4:0:b0:1fd:bcc4:66c8 with SMTP id g4-20020adfd1e4000000b001fdbcc466c8mr822266wrd.488.1646661469374;
        Mon, 07 Mar 2022 05:57:49 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzoPAJ77EFUcVlCEoryGdZ4Di7c8IlBBuTKzrsfodTyiISnPTIgOVliwHERXJfFacwYmqHQlQ==
X-Received: by 2002:adf:d1e4:0:b0:1fd:bcc4:66c8 with SMTP id g4-20020adfd1e4000000b001fdbcc466c8mr822240wrd.488.1646661469127;
        Mon, 07 Mar 2022 05:57:49 -0800 (PST)
Received: from ?IPv6:2a0c:5a80:1b14:b500:abb:f9d1:7bc2:3db8? ([2a0c:5a80:1b14:b500:abb:f9d1:7bc2:3db8])
        by smtp.gmail.com with ESMTPSA id l5-20020a5d6745000000b001f1e4e40e42sm5589858wrw.77.2022.03.07.05.57.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 05:57:48 -0800 (PST)
Message-ID: <fcdaacf58296dfd826bfdbbd5ef3a06b6e05a456.camel@redhat.com>
Subject: Re: [PATCH 0/2] mm/page_alloc: Remote per-cpu lists drain support
From:   Nicolas Saenz Julienne <nsaenzju@redhat.com>
To:     Mel Gorman <mgorman@suse.de>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, frederic@kernel.org, tglx@linutronix.de,
        mtosatti@redhat.com, linux-rt-users@vger.kernel.org,
        vbabka@suse.cz, cl@linux.com, paulmck@kernel.org,
        willy@infradead.org
Date:   Mon, 07 Mar 2022 14:57:47 +0100
In-Reply-To: <20220303114550.GE4363@suse.de>
References: <20220208100750.1189808-1-nsaenzju@redhat.com>
         <20220303114550.GE4363@suse.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi Mel,
Thanks for having a look at this.

On Thu, 2022-03-03 at 11:45 +0000, Mel Gorman wrote:
> On Tue, Feb 08, 2022 at 11:07:48AM +0100, Nicolas Saenz Julienne wrote:
> > This series replaces mm/page_alloc's per-cpu page lists drain mechanism with
> > one that allows accessing the lists remotely. Currently, only a local CPU is
> > permitted to change its per-cpu lists, and it's expected to do so, on-demand,
> > whenever a process demands it by means of queueing a drain task on the local
> > CPU. This causes problems for NOHZ_FULL CPUs and real-time systems that can't
> > take any sort of interruption and to some lesser extent inconveniences idle and
> > virtualised systems.
> > 
> 
> I know this has been sitting here for a long while. Last few weeks have
> not been fun.

No problem.

> > Note that this is not the first attempt at fixing this per-cpu page lists:
> >  - The first attempt[1] tried to conditionally change the pagesets locking
> >    scheme based the NOHZ_FULL config. It was deemed hard to maintain as the
> >    NOHZ_FULL code path would be rarely tested. Also, this only solves the issue
> >    for NOHZ_FULL setups, which isn't ideal.
> >  - The second[2] unanimously switched the local_locks to per-cpu spinlocks. The
> >    performance degradation was too big.
> > 
> 
> For unrelated reasons I looked at using llist to avoid locks entirely. It
> turns out it's not possible and needs a lock. We know "local_locks to
> per-cpu spinlocks" took a large penalty so I considered alternatives on
> how a lock could be used.  I found it's possible to both remote drain
> the lists and avoid the disable/enable of IRQs entirely as long as a
> preempting IRQ is willing to take the zone lock instead (should be very
> rare). The IRQ part is a bit hairy though as softirqs are also a problem
> and preempt-rt needs different rules and the llist has to sort PCP
> refills which might be a loss in total. However, the remote draining may
> still be interesting. The full series is at
> https://git.kernel.org/pub/scm/linux/kernel/git/mel/linux.git/ mm-pcpllist-v1r2

I'll have a proper look at it soon.

Regards,

-- 
Nicolás Sáenz

