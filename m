Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7275AC433EF
	for <linux-rt-users@archiver.kernel.org>; Tue, 15 Feb 2022 08:47:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233545AbiBOIrw (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 15 Feb 2022 03:47:52 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230218AbiBOIrv (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 15 Feb 2022 03:47:51 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BCBF1EBDF4
        for <linux-rt-users@vger.kernel.org>; Tue, 15 Feb 2022 00:47:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644914860;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a4UdifMYSS3/zhcng0VskO4a/iClBAxoJzpoK0nsepA=;
        b=D8jASPwRjAkFyb0a5qiwNN5aVqFPOUIiNVuHJeGMYUffWClvaaVXXaQU1cGn+7govWGpW8
        i44BaDfyUinJFS2YLVXd1bBYm08JPlZDo1fujJuUtjirJMmLuCBMO1TZYDWtVbUKHzdtvG
        dV67r6dw0zC6wTOVkQQ7wnyNp22bz1o=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-552-1aPStXVzOoui6jPYarkRYQ-1; Tue, 15 Feb 2022 03:47:39 -0500
X-MC-Unique: 1aPStXVzOoui6jPYarkRYQ-1
Received: by mail-wm1-f69.google.com with SMTP id c7-20020a1c3507000000b0034a0dfc86aaso1034607wma.6
        for <linux-rt-users@vger.kernel.org>; Tue, 15 Feb 2022 00:47:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=a4UdifMYSS3/zhcng0VskO4a/iClBAxoJzpoK0nsepA=;
        b=gQUH5MwY9/zLzkJEVed0mepnY+YjG3AsxIwSaqEm2PP+tOUerHlyfBgAqvhX9xrCXd
         5Xcg8D3OXCQn0iMijO9kPY7XWAsXhpwhP48wux7TxN3A1flmH/umwDpzP+wfIxslCN8M
         2DlX8SpPIiJ2FF/zAJPdWA4xar0N8e4oAE20bynPpGuKF3uvMFSyteH+YSKHBgA+ZKwz
         366Rx9Kwfr/N3IE08u7iFT7TKiaDBwp321uVNcDJI149XkaEmSzyVJwhdqUkIExH8GLa
         TislwsiU7RdsckIOmJUOMwIJL8TAdmFVc98M5MRqgn7L+2cIr3fJsK1BJ6BaPDlKinaK
         EhUw==
X-Gm-Message-State: AOAM532Pym4IiagPNmjSPMf9zrZ2as578qDmIkYze1FzKYAFvqFwFmjv
        8vx3LeQBbedUz9B/eQcvt5B/mZ49CxxKOJGQbD3tlVkdMcWnLcHxsE0OAxc1/wiH3/CXIRpVdXN
        FyxDpiWjjqMkiliw4ZD/xTIStwZE=
X-Received: by 2002:a05:600c:220b:b0:37b:ec02:32c4 with SMTP id z11-20020a05600c220b00b0037bec0232c4mr2160352wml.11.1644914857875;
        Tue, 15 Feb 2022 00:47:37 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxQH/cUi47rF7Dz/C2hD5pM34xuVhSFpBfvoq9RjatP0EnS4lddQ+g8Lgo9AlCHPsD4UxJJfQ==
X-Received: by 2002:a05:600c:220b:b0:37b:ec02:32c4 with SMTP id z11-20020a05600c220b00b0037bec0232c4mr2160335wml.11.1644914857642;
        Tue, 15 Feb 2022 00:47:37 -0800 (PST)
Received: from ?IPv6:2a0c:5a80:1204:1500:37e7:8150:d9df:36f? ([2a0c:5a80:1204:1500:37e7:8150:d9df:36f])
        by smtp.gmail.com with ESMTPSA id p15sm17252917wma.27.2022.02.15.00.47.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 00:47:37 -0800 (PST)
Message-ID: <2374bbca7651b671ec934fa5c630cbe3eed3b496.camel@redhat.com>
Subject: Re: [PATCH 2/2] mm/page_alloc: Add remote draining support to
 per-cpu lists
From:   Nicolas Saenz Julienne <nsaenzju@redhat.com>
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, frederic@kernel.org, tglx@linutronix.de,
        mgorman@suse.de, linux-rt-users@vger.kernel.org, vbabka@suse.cz,
        cl@linux.com, paulmck@kernel.org, willy@infradead.org
Date:   Tue, 15 Feb 2022 09:47:35 +0100
In-Reply-To: <YgKQfsznPUDN34un@fuller.cnet>
References: <20220208100750.1189808-1-nsaenzju@redhat.com>
         <20220208100750.1189808-3-nsaenzju@redhat.com>
         <YgKQfsznPUDN34un@fuller.cnet>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.3 (3.42.3-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Tue, 2022-02-08 at 12:47 -0300, Marcelo Tosatti wrote:
> > Changes since RFC:
> >  - Avoid unnecessary spin_lock_irqsave/restore() in free_pcppages_bulk()
> >  - Add more detail to commit and code comments.
> >  - Use synchronize_rcu() instead of synchronize_rcu_expedited(), the RCU
> >    documentation says to avoid it unless really justified. I don't think
> >    it's justified here, if we can schedule and join works, waiting for
> >    an RCU grace period is OK.
> 
> https://patchwork.ozlabs.org/project/netdev/patch/1306228052.3026.16.camel@edumazet-laptop/
> 
> Adding 100ms to direct reclaim path might be problematic. It will also
> slowdown kcompactd (note it'll call drain_all_pages for each zone).

I did some measurements on an idle machine, worst case was ~30ms. I agree that
might too much for direct reclaim, so I'll switch back to expedited and add a
comment.

> >  - Avoid sparse warnings by using rcu_access_pointer() and
> >    rcu_dereference_protected().
> > 
> >  include/linux/mmzone.h |  22 +++++-
> >  mm/page_alloc.c        | 155 ++++++++++++++++++++++++++---------------
> >  mm/vmstat.c            |   6 +-
> >  3 files changed, 120 insertions(+), 63 deletions(-)
> > 
> > diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> > index b4cb85d9c6e8..b0b593fd8e48 100644
> > --- a/include/linux/mmzone.h
> > +++ b/include/linux/mmzone.h
> > @@ -388,13 +388,31 @@ struct per_cpu_pages {
> >  	short expire;		/* When 0, remote pagesets are drained */
> >  #endif
> >  
> > -	struct pcplists *lp;
> > +	/*
> > +	 * As a rule of thumb, any access to struct per_cpu_pages's 'lp' has
> > +	 * happen with the pagesets local_lock held and using
> > +	 * rcu_dereference_check(). If there is a need to modify both
> > +	 * 'lp->count' and 'lp->lists' in the same critical section 'pcp->lp'
> > +	 * can only be derefrenced once. See for example:
> 
> Typo.

Noted.

Thanks!

-- 
Nicolás Sáenz

