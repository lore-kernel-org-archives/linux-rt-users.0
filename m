Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A32CC433E0
	for <linux-rt-users@archiver.kernel.org>; Wed, 10 Feb 2021 16:10:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C28D64E66
	for <linux-rt-users@archiver.kernel.org>; Wed, 10 Feb 2021 16:10:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbhBJQKU (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 10 Feb 2021 11:10:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39718 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230489AbhBJQKT (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 10 Feb 2021 11:10:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612973332;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NO0KSNPQOdc278ECCT5j4ZRPv2CGNj6mh9bJrpcIoYo=;
        b=aFEoziIgWIAZGVpcCFbyWqLep3CMGm9LkGtLIjYUqNdL5EieQToCa7hDSwpu9oU8sLkPde
        VOHfRy+RQL+8Hhh7zKkdeRW9tCXgnrkjYFUHlLgmCduXZwNdGb3ZcipRyoi8pB+11KUQwI
        myuZsu8CsKZU8LTuwvTszTG6oVqVjvY=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-435-HckwO35fO7mezu7457ZEBg-1; Wed, 10 Feb 2021 11:08:50 -0500
X-MC-Unique: HckwO35fO7mezu7457ZEBg-1
Received: by mail-qt1-f199.google.com with SMTP id f7so1881654qtd.9
        for <linux-rt-users@vger.kernel.org>; Wed, 10 Feb 2021 08:08:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NO0KSNPQOdc278ECCT5j4ZRPv2CGNj6mh9bJrpcIoYo=;
        b=O/wh23WNbOj64L+pUAJ1nLLGqTlhfSkiA9dz2ie6gQUt8QlmNO0iosdWVVHIM2KYmG
         MNNL61BL7JfWVmDP052sz24pWp0cZxkxiF4J39Kk3FTHw5BZx2JiMUJCndTzO3o1zG9K
         r0Pj40o4nwGcA8S549vqpsz/OaLLxr2wWBKkAhLhC4UMmX7xxvpyJtMK1QBdN58gq+q6
         g7GvXCRcnpOLqnTwenQYDE+BKqLcaJFSSKTjQvt8+1QUO8BgLi3/bDD/EPepl8XvrRbv
         P1TU/qkfuobfp25X+iSAgH1XuXitKFw7zZwpKY+p0P9CNr7pZNXFtg92AzUMyA1JZb/r
         c4LA==
X-Gm-Message-State: AOAM531o74yIOJhmbGHMxqprxvnxWgmvwsSOgvPgJ3Js+J1k2G8xf7Go
        S+cdjySMkvUe92ZdYv8biSQEWQxPcnsbX+ADD3EQb3knDmTpXATUsK6htUVnEATOMZ3winsWTgE
        4TF8w1AD6FMW02KZlnI6ufHbCkvk=
X-Received: by 2002:ac8:7950:: with SMTP id r16mr3384494qtt.130.1612973330052;
        Wed, 10 Feb 2021 08:08:50 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzt23xAwDWCFpkMjD6xfI1ngOONKJBtm0UD7D39iSn7VrFAMTKR5NNh5Miwq5wlrPuhQIRS3g==
X-Received: by 2002:ac8:7950:: with SMTP id r16mr3384482qtt.130.1612973329881;
        Wed, 10 Feb 2021 08:08:49 -0800 (PST)
Received: from xz-x1 (bras-vprn-toroon474qw-lp130-20-174-93-89-182.dsl.bell.ca. [174.93.89.182])
        by smtp.gmail.com with ESMTPSA id s136sm1680133qka.106.2021.02.10.08.08.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 08:08:49 -0800 (PST)
Date:   Wed, 10 Feb 2021 11:08:47 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Daniel Wagner <dwagner@suse.de>
Cc:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>, linux-rt-users@vger.kernel.org
Subject: Re: [rt-tests v2 11/18] ptsematest: Streamline usage output and man
 page
Message-ID: <20210210160847.GI103365@xz-x1>
References: <20201007085653.11961-1-dwagner@suse.de>
 <20201007085653.11961-12-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201007085653.11961-12-dwagner@suse.de>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Wed, Oct 07, 2020 at 10:56:46AM +0200, Daniel Wagner wrote:
> Signed-off-by: Daniel Wagner <dwagner@suse.de>

Hi, Daniel,

This seems to have broken oslat with "oslat -v".  Would you help recover the
old behavior somehow?

Thanks,

-- 
Peter Xu

