Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99137C433F5
	for <linux-rt-users@archiver.kernel.org>; Thu,  9 Sep 2021 18:04:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 793FE6113A
	for <linux-rt-users@archiver.kernel.org>; Thu,  9 Sep 2021 18:04:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243214AbhIISFy (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 9 Sep 2021 14:05:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52506 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242867AbhIISFu (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 9 Sep 2021 14:05:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631210679;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7EX0cSLb6fTGp/aQMn3dNWmpKkFZMxnIlL1OL2aIQc8=;
        b=JrHX5NqdEJj2/+LpfacRoLxKnnPZwtDJ7ho//ASm1GoaEGrBwhlpju/e+l+GdtC1MTd79C
        FcAfv36JtkU4xNRO6e7cVBoa7SpsmBIYcQJ2PODHy8k7SMaWuTdlHQDRfCRz2mUi1xXIMo
        z2ZIjw/7n0NosaRgMNdaXLZzRab82bg=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-533-rP7VLreFN36GukaNMw3rzg-1; Thu, 09 Sep 2021 14:04:38 -0400
X-MC-Unique: rP7VLreFN36GukaNMw3rzg-1
Received: by mail-io1-f72.google.com with SMTP id a9-20020a5ec309000000b005baa3f77016so2586098iok.1
        for <linux-rt-users@vger.kernel.org>; Thu, 09 Sep 2021 11:04:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7EX0cSLb6fTGp/aQMn3dNWmpKkFZMxnIlL1OL2aIQc8=;
        b=6cYq7mdlhLtf4J19rGb9z7K7teqIhBW/QRzHThiyjkU2WVpJGRrRdwAEDCV8+Co9RP
         FYHt6J5BZ2txkIyWIvkZuJKQv8gAcvavilp0jr2GwpJicgUxhAkmtJH/j9l/hKQ6q1s8
         OyXlgJ+WM9q+H9z9pqUktnSMoFH0RQsiWh4ZZ8LTE/Wdbupn/KOEWXcxIOSPzXUuKlc0
         Ql/9JDlUIhwdBNPpPbIsMF9unwf8c2cN9CVrete5WTZDDpMkeeP7VK7xMCl/xG41MlM7
         zApUqmUxeNzbGrCOT+LTQtxKGjZ2cEUH0kvIr1JxBMhVlsByOUjme/F54T3geCgY19ik
         +yPA==
X-Gm-Message-State: AOAM530uQ4ren4sm/SklBTsCu8+52k6l3Cme2Ha4ekcPsBDlxYYhFLH8
        JFyCPeNqjiODSix0sAwTgVHlRu7kxeVGhvv98/LyBOEFVPxV1KdbDDNqH7VQ4BQHOB5VyeZUD6D
        hqQ9U402UruTBP1HfmaSECQoFVcg=
X-Received: by 2002:a92:d406:: with SMTP id q6mr3360970ilm.166.1631210677346;
        Thu, 09 Sep 2021 11:04:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy+i50MRf0tnY1PlxTHNT8FAok8bG1jb4hFwhkxISuTk0fI22H/MuAIe++gnCOPclpigWsSwQ==
X-Received: by 2002:a92:d406:: with SMTP id q6mr3360955ilm.166.1631210677096;
        Thu, 09 Sep 2021 11:04:37 -0700 (PDT)
Received: from t490s ([2607:fea8:56a3:500::ad7f])
        by smtp.gmail.com with ESMTPSA id f14sm666014ile.82.2021.09.09.11.04.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 11:04:36 -0700 (PDT)
Date:   Thu, 9 Sep 2021 14:04:35 -0400
From:   Peter Xu <peterx@redhat.com>
To:     nsaenzju@redhat.com
Cc:     linux-rt-users@vger.kernel.org, williams@redhat.com,
        jkacur@redhat.com
Subject: Re: [PATCH 3/3] oslat: Allow for arch specific timer frequency
 measurements
Message-ID: <YTpMs1bvQKbADZEb@t490s>
References: <20210908100209.118609-1-nsaenzju@redhat.com>
 <20210908100209.118609-3-nsaenzju@redhat.com>
 <YTj95hq7BzfWsK2v@t490s>
 <2518d9f959f16de10229a67e4917699f8605d947.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2518d9f959f16de10229a67e4917699f8605d947.camel@redhat.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Thu, Sep 09, 2021 at 12:29:17PM +0200, nsaenzju@redhat.com wrote:
> > I'm also wondering the diff between the two methods on arm64 and whether
> > there's a huge difference on the numbers.
> 
> There isn't much, after rounding the end result in MHz is the same regardless
> of the method used. IIUC, gettimeoftheday() uses the frequency register's value
> to scale the counter measurements. So it makes sense for the results to be
> coherent.
> 
> I figured it's cleaner to get the data from the source instead of inferring it
> with extra math.

Fair enough.  Thanks,

-- 
Peter Xu

