Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CD45C433F5
	for <linux-rt-users@archiver.kernel.org>; Tue, 14 Sep 2021 18:01:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C65661029
	for <linux-rt-users@archiver.kernel.org>; Tue, 14 Sep 2021 18:01:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231725AbhINSCc (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 14 Sep 2021 14:02:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31572 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230092AbhINSC2 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 14 Sep 2021 14:02:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631642469;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3VFDTiYoRlzqKicgJ4/TFx2uKS2MR5n6U8naB6Hc7Vc=;
        b=ggpiQ9S38VjMGm/H1tBO+8c0gOlywnRDNYTdUtTmBBZKFwbDtsiIJbx2A7kBpXUuNQfzmx
        LyE8PWiYheiqzcbocvMR4zj0gGtAehjRlWT834gjSk5hv1H2PYLmKOSNKjsTUITRTld7PF
        Qx8+CrzwdTkR3lGdV9kahB5I4p2Esl0=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-497-8EGhwLZoPRuA7mJhMSyByQ-1; Tue, 14 Sep 2021 14:01:08 -0400
X-MC-Unique: 8EGhwLZoPRuA7mJhMSyByQ-1
Received: by mail-io1-f71.google.com with SMTP id e18-20020a6b7312000000b005be766a70dbso16889503ioh.19
        for <linux-rt-users@vger.kernel.org>; Tue, 14 Sep 2021 11:01:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3VFDTiYoRlzqKicgJ4/TFx2uKS2MR5n6U8naB6Hc7Vc=;
        b=cFHdR0SFHIpd6V5uCuNLlz4EFFsYcaYPX60efrstcS3B/zY6OWUEY8rky5V46EKtR/
         WyvLIDXyPVbGLQwtuHlR/ShpsZhsZ2ketNXwDeSt87s3BXsWRF0fxCQVTtpNx6TaLw/T
         +U/smsoyJA4qP8eWuKk/wqXRdUNUzqNiIwJr+o8GpvAdWOpyAlJ5zCBgTU8K5aZ69lU7
         Q/a47x2K21R0lcDpIi+ALwjTHum4blF4z6E2oJIHXV2X0onsHFHLY+BCNkVYqF2y5g6K
         omP9fB1nRmMzXa9ih8kxMC0f8fxcmmjLZplT/W56Vw9QIDGi7XdXd/zqEz12LceWHjJG
         qbBg==
X-Gm-Message-State: AOAM533HriHiKcWbSp8giJF8mjnNrVcZT/Yvfry7pqZB/6z9wadMorvI
        x85owAG5BL69myvmoiR4YJE8tl8LbEwKPdgxgorOq7ZYxOPiO5CsATQw0SGzuTxmXW6d8KS9pwZ
        LeYIfZVw1jt62BW6Rb9ig/0RztqM=
X-Received: by 2002:a05:6638:14cf:: with SMTP id l15mr15600438jak.8.1631642467564;
        Tue, 14 Sep 2021 11:01:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyNTD3sI+K8LSInPshZeuGeEclDDWRggxV9m08JblPlHnXoPVdbjOI8oGhhX5fWd+8Dq1ETAg==
X-Received: by 2002:a05:6638:14cf:: with SMTP id l15mr15600422jak.8.1631642467342;
        Tue, 14 Sep 2021 11:01:07 -0700 (PDT)
Received: from t490s ([2607:fea8:56a2:9100::d35a])
        by smtp.gmail.com with ESMTPSA id r13sm7737191ilh.80.2021.09.14.11.01.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 11:01:06 -0700 (PDT)
Date:   Tue, 14 Sep 2021 14:01:05 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Nicolas Saenz Julienne <nsaenzju@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, williams@redhat.com,
        jkacur@redhat.com, Punit Agrawal <punitagrawal@gmail.com>
Subject: Re: [PATCH] oslat: Avoid out-of-order memory accesses to precede
 counter read
Message-ID: <YUDjYX7V8L+B8rxH@t490s>
References: <20210914175542.338429-1-nsaenzju@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210914175542.338429-1-nsaenzju@redhat.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Tue, Sep 14, 2021 at 07:55:42PM +0200, Nicolas Saenz Julienne wrote:
> In arm64 it's possible for the processor to access memory appearing in
> program order after the read of the counter before the counter has been
> read. This would skew the counter value to a later point than intended.
> 
> Fix this my adding an isb() following the counter read instruction.
> 
> Suggested-by: Punit Agrawal <punitagrawal@gmail.com>
> Signed-off-by: Nicolas Saenz Julienne <nsaenzju@redhat.com>

Acked-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu

