Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9501AC433EF
	for <linux-rt-users@archiver.kernel.org>; Mon, 24 Jan 2022 13:14:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234938AbiAXNOD (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 24 Jan 2022 08:14:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:43657 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242984AbiAXNNh (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 24 Jan 2022 08:13:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643030016;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fVs0ujk+EjVk5n7wjEMKsl3asE24/bjqqSeECyU54Z4=;
        b=Yka5+3pqyanNZCMBTeNPuXKkhiIf+O5uMXZ7cRbDa+9Q94Q+xAKzWk+Gm11sXWBImM6RQG
        nwg24bEi35ao56jqTUyIAWyG/1Cy8n0XZH05yYJ72soUn4gG2u8nB0hOa4L3YK/ARyxvt4
        syokWkwhtFGDsLCMuvmW4XEXr/TnRcc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-650-TPEv10eIN0SwkO5eZSQmXQ-1; Mon, 24 Jan 2022 08:13:33 -0500
X-MC-Unique: TPEv10eIN0SwkO5eZSQmXQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 95B7E1091DA1;
        Mon, 24 Jan 2022 13:13:32 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-2.gru2.redhat.com [10.97.112.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5DDDE78A99;
        Mon, 24 Jan 2022 13:13:32 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id 99A6D416D5CA; Mon, 24 Jan 2022 09:58:31 -0300 (-03)
Date:   Mon, 24 Jan 2022 09:58:31 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-rt-users@vger.kernel.org, John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH] rt-numa: optionally ignore runtime cpumask
Message-ID: <Ye6id4lSKMcqAZ65@fuller.cnet>
References: <YerAW90QwEg9yXAb@fuller.cnet>
 <Yer4kB0fmR41u19Y@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yer4kB0fmR41u19Y@linutronix.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Fri, Jan 21, 2022 at 07:16:48PM +0100, Sebastian Andrzej Siewior wrote:
> On 2022-01-21 11:16:59 [-0300], Marcelo Tosatti wrote:
> > 
> > use_current_cpuset() function does:
> > 
> > /*
> >  * After this function is called, affinity_mask is the intersection of
> >  * the user supplied affinity mask and the affinity mask from the run
> >  * time environment
> >  */
> > static void use_current_cpuset(int max_cpus, struct bitmask *cpumask)
> > 
> > However, when using isolcpus kernel command line option, the CPUs 
> > specificied at isolcpus= are not part of the run time environment
> > cpumask.
> > 
> > This causes "cyclictest -a isolatedcpus" to fail with:
> > 
> > WARN: Couldn't setaffinity in main thread: Invalid argument
> > FATAL: No allowable cpus to run on
> > # /dev/cpu_dma_latency set to 0us
> > 
> > To fix this, add an environment variable IGNORE_RUNTIME_CPU_AFFINITY_MASK
> > that when set to a value other than 0, will override the runtime cpu
> > affinity mask (retrieved with numa_sched_getaffinity) with a bit set
> > for each CPU in numa_num_configured_cpus:
> 
> This looks hacky and not documented. What about using all CPUs which
> part of current affinity mask by default. 

You mean "using all CPUs which are part of the current affinity mask by
default" ? (where current affinity mask would mean user specified CPU
mask).

> And then either specify the
> requested CPU mask or use explicitly all CPUs.

Do you mean to drop 

        /*
         * Clear bits that are not set in both the cpuset from the
         * environment, and in the user specified affinity.

And just attempt to use the user specified mask? (which will then return
failure to the user in which case he can correct it).


