Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85867C433EF
	for <linux-rt-users@archiver.kernel.org>; Tue, 14 Sep 2021 18:36:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F0AE60F44
	for <linux-rt-users@archiver.kernel.org>; Tue, 14 Sep 2021 18:36:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbhINShT (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 14 Sep 2021 14:37:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25983 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229728AbhINShR (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 14 Sep 2021 14:37:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631644560;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/8x1p5+nsyE85zlfRBnVZ6RSbiSJlKjKOA5S3qcXFoI=;
        b=dFAJ2BTxHsk3HjvQn6G19URlJLcr8rS3GJJ3/rO39QS3kOy5sqnS9kLxNxgfO0cgkDWMst
        kznXgxyvYZlwjBsji0Ho6ZXc1rA1dgp7Sx3DkxataVc3IF2sdjdpFOaLCTe58OvlzHQ+RM
        Q+SYvvYhgXYtdL21mG3EF4Ax6w8hnZc=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-205-ixhzKKBfN9qIbeiDQyj0yA-1; Tue, 14 Sep 2021 14:35:58 -0400
X-MC-Unique: ixhzKKBfN9qIbeiDQyj0yA-1
Received: by mail-qt1-f199.google.com with SMTP id q19-20020ac87353000000b0029a09eca2afso61332632qtp.21
        for <linux-rt-users@vger.kernel.org>; Tue, 14 Sep 2021 11:35:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=/8x1p5+nsyE85zlfRBnVZ6RSbiSJlKjKOA5S3qcXFoI=;
        b=4SydBuiZ79PTqlVUiKpnWy9pwqkkIgBv7sm0I3p9e9YqjRwcQtafdtnY2OzGziEjxl
         zW3ZItQI+OuBwkWCifI+ozzv3XjJeS6oz8yP2Gu4VyYMJ9MajJMB9XTR7xRHfcwzsuoS
         NiWX5JpEaUvI1A4hSZumdGd1549YBSyZrUFMe3+S63VJGLf8ysOKS44zLY+V6BVu4aSN
         xrULLf3MfbCQjBe4u6OkHvoXeBOX+OvVEKrQr00JXxkv238g7HXT9UFetd67kXvHI/rw
         6W4tsT24Q9a8Hi1H7yh6WILxWMmGi4w5RYYvqNb/fUL036v/oA/EBmPN5dcbP+U+MQVi
         8tgQ==
X-Gm-Message-State: AOAM533HOOUjJh4tER/tuySjQVKo88OjoHQ6wfZmVnSn76rZasXIjTah
        h5fMKxXonwn+oMxGLA+m/5x0KmPoPbdr+DmtY9XbqR3FI3BwFmAYvE6xKY9GorwOSWhzD2vICWX
        x8q4UKiobQLwR5Gs8ft3ir8oJHoI=
X-Received: by 2002:ae9:f44c:: with SMTP id z12mr6315403qkl.433.1631644558347;
        Tue, 14 Sep 2021 11:35:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyqiYUIcdGC2u3Eht+mDVHzK0H6MKlcrGNx00NCIIFEQwoQDDdX8xvbUAQQSIeoSeRuaVNQEw==
X-Received: by 2002:ae9:f44c:: with SMTP id z12mr6315385qkl.433.1631644558209;
        Tue, 14 Sep 2021 11:35:58 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-09-184-147-143-99.dsl.bell.ca. [184.147.143.99])
        by smtp.gmail.com with ESMTPSA id e5sm6735318qts.0.2021.09.14.11.35.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 11:35:57 -0700 (PDT)
Date:   Tue, 14 Sep 2021 14:35:56 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Peter Xu <peterx@redhat.com>
cc:     Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        linux-rt-users@vger.kernel.org, williams@redhat.com,
        Punit Agrawal <punitagrawal@gmail.com>
Subject: Re: [PATCH] oslat: Avoid out-of-order memory accesses to precede
 counter read
In-Reply-To: <YUDjYX7V8L+B8rxH@t490s>
Message-ID: <16a169d-ca5-1bd-934d-fe68ea750b9@redhat.com>
References: <20210914175542.338429-1-nsaenzju@redhat.com> <YUDjYX7V8L+B8rxH@t490s>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Tue, 14 Sep 2021, Peter Xu wrote:

> On Tue, Sep 14, 2021 at 07:55:42PM +0200, Nicolas Saenz Julienne wrote:
> > In arm64 it's possible for the processor to access memory appearing in
> > program order after the read of the counter before the counter has been
> > read. This would skew the counter value to a later point than intended.
> > 
> > Fix this my adding an isb() following the counter read instruction.
> > 
> > Suggested-by: Punit Agrawal <punitagrawal@gmail.com>
> > Signed-off-by: Nicolas Saenz Julienne <nsaenzju@redhat.com>
> 
> Acked-by: Peter Xu <peterx@redhat.com>
> 
> -- 
> Peter Xu
> 
> 
Signed-off-by: John Kacur <jkacur@redhat.com>

