Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1373C433EF
	for <linux-rt-users@archiver.kernel.org>; Thu, 23 Jun 2022 10:51:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231344AbiFWKvg (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 23 Jun 2022 06:51:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231327AbiFWKve (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 23 Jun 2022 06:51:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8CFED4B1E2
        for <linux-rt-users@vger.kernel.org>; Thu, 23 Jun 2022 03:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655981492;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Rt62F0DwW/EmXD1WWsZVPFxILSy2pYZ1XM+8hUl5XBA=;
        b=i2h6ef4eHwEmHv8DRCMMFSvOm93csTza5Ki/7CTSfY9cMIAJjtdZ7+rsiWoFk5eo8RbHWx
        bQzUwoZOoh2Vn9HBMO8qvUMlujdvbtljNJip6c9BaL2K3mlaoJI4MWoGNc7KeMmJLyAxXw
        pdmnwewx05pZLLTwI4AJbAv3iyhjwd4=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-413-ovcjf1MzPvGB6-B-_Q15Vg-1; Thu, 23 Jun 2022 06:51:29 -0400
X-MC-Unique: ovcjf1MzPvGB6-B-_Q15Vg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CA92E294EDD5;
        Thu, 23 Jun 2022 10:51:28 +0000 (UTC)
Received: from localhost (ovpn-13-154.pek2.redhat.com [10.72.13.154])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8E7B7C28115;
        Thu, 23 Jun 2022 10:51:27 +0000 (UTC)
Date:   Thu, 23 Jun 2022 18:51:18 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Zhipeng Shi <zhipeng.shi0@gmail.com>
Cc:     linux-mm@kvack.org, linux-rt-users@vger.kernel.org,
        tglx@linutronix.de, shengjian.xu@horizon.ai, schspa@gmail.com,
        longman@redhat.com
Subject: Re: [Question] vmalloc latency in RT-Linux
Message-ID: <YrRFpmk0pxvXanbH@MiWiFi-R3L-srv>
References: <20220621121547.GB37196@ubuntu20>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220621121547.GB37196@ubuntu20>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 06/21/22 at 08:15pm, Zhipeng Shi wrote:
> I noticed in rt-linux, vmalloc has a large latency. This is because the 
> free_vmap_area_lock is held for a long time in the function  
> __purge_vmap_area_lazy. 
> 
> In non-RT-Linux, because the function spin_is_contended is well 
> implemented, so there will be no such problem.
> 
> But in RT-Linux, spin_is_contended simply returns 0. I don't understand 
> why this function was implemented like this before, but in order to
> solve this problem, I thought of two ways.
> 
> The first is to modify the spin_is_contended definition in spinlock_rt.h 
> as shown below, but I'm not sure if the change has side-effects:
> 
> -#define spin_is_contended(lock)    (((void)(lock), 0))
> +static inline int spin_is_contended(spinlock_t *lock)
> +{
> + unsigned long *p = (unsigned long *) &lock->lock.owner;
> +
> + return (READ_ONCE(*p) & RT_MUTEX_HAS_WAITERS);
> +}
> 
> The second is by reducing the number of lazy_max_pages, but it will lead 
> to lower performance of vmalloc.

__purge_vmap_area_lazy() has cond_resched_lock() to reschedule and drop
the lock. From your saying, it's spin_is_contended() which is not
working well to make rescheduling happen during __purge_vmap_area_lazy()
handling. Then the fixing should be done in lock side.

> 
> Guys, Do you have any good ideas?
> 
> Best regards,
> Zhipeng
> 

