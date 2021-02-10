Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FDEFC433DB
	for <linux-rt-users@archiver.kernel.org>; Wed, 10 Feb 2021 16:27:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18F6160C3F
	for <linux-rt-users@archiver.kernel.org>; Wed, 10 Feb 2021 16:27:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232314AbhBJQ1f (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 10 Feb 2021 11:27:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45905 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232171AbhBJQ1b (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 10 Feb 2021 11:27:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612974364;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=q9pSQuVZpgYNSD4cpLnya8CRoH22lnI1p/awrGwJqec=;
        b=U/ZSxpU/6J/ttsZ/WFHW8KMd8P+nQnUWxahsiRBYwDDEr0AZUywXDx3uLxS+ltbNEv3uPq
        AS0If70s8FZ7baepG0bExCLvPjyrJ4NWIx4hv4uiP9WZAO5y4Hzg/LJtzmCrY3DjmzLOPc
        4DnaDbBRJbXUr7X1w6u1/6fIBgQGrbo=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-597--D0KwX3ZMdqofDRuoBKdLg-1; Wed, 10 Feb 2021 11:26:03 -0500
X-MC-Unique: -D0KwX3ZMdqofDRuoBKdLg-1
Received: by mail-qv1-f72.google.com with SMTP id e6so1731086qva.16
        for <linux-rt-users@vger.kernel.org>; Wed, 10 Feb 2021 08:26:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=q9pSQuVZpgYNSD4cpLnya8CRoH22lnI1p/awrGwJqec=;
        b=G3it6/EvpCbzEij+sTmg1AcS0MFCbSmq49U7m9KuiCjBWcbhR6ZVAARqBGBCMom2oY
         NNAwkVwINmWqGV1udlEQiLO6W82hAxNQmnuEInzurag3zhZPBy4e+809MRJ52nCjq2JV
         xga1FWOO/A9VTcGcilxIKcdvwwfp54+/C9yPTd3j4FguLJZXjdnYiVmvaJHfFC+NOs4b
         Ef8PbUgYugReFNQn4uTTJZUvF7VggDVijNkrf2hlWNYrXX6bculbxbYQHKsgszjNzBPc
         YASmgzmO+UQXBUVsWhzdn/hW2KUuqPmyXSfo99rflxGV2SJD7uLicU96rC8nqh2hkU7D
         ZXFQ==
X-Gm-Message-State: AOAM533q+c59O5k4GKFZYvPiXFZj8S4A3kQIFlNXAvpctz2NaTWfAC/M
        DwqRs97DoCjfkcgmw1e+C37clrhjRDJAisZ/AnSExH47uPQYC/9cTgz1zPRO0h+LNtGZ9xbWKs1
        6ag9u4+Yav54D3JwxKf84Ygpa7Z4=
X-Received: by 2002:ad4:5be9:: with SMTP id k9mr3658604qvc.18.1612974362386;
        Wed, 10 Feb 2021 08:26:02 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyX9UqipWkCmNn3eksFNVSPkzgF2imRCXF3zfqzxu2DPdYKAVvukVc91t6l/ER0+tYoQbQWSg==
X-Received: by 2002:ad4:5be9:: with SMTP id k9mr3658529qvc.18.1612974361439;
        Wed, 10 Feb 2021 08:26:01 -0800 (PST)
Received: from xz-x1 (bras-vprn-toroon474qw-lp130-20-174-93-89-182.dsl.bell.ca. [174.93.89.182])
        by smtp.gmail.com with ESMTPSA id x4sm1717076qkx.136.2021.02.10.08.26.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 08:26:00 -0800 (PST)
Date:   Wed, 10 Feb 2021 11:25:59 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Daniel Wagner <dwagner@suse.de>
Cc:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>, linux-rt-users@vger.kernel.org
Subject: Re: [rt-tests v2 11/18] ptsematest: Streamline usage output and man
 page
Message-ID: <20210210162559.GJ103365@xz-x1>
References: <20201007085653.11961-1-dwagner@suse.de>
 <20201007085653.11961-12-dwagner@suse.de>
 <20210210160847.GI103365@xz-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210210160847.GI103365@xz-x1>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Wed, Feb 10, 2021 at 11:08:47AM -0500, Peter Xu wrote:
> On Wed, Oct 07, 2020 at 10:56:46AM +0200, Daniel Wagner wrote:
> > Signed-off-by: Daniel Wagner <dwagner@suse.de>
> 
> Hi, Daniel,
> 
> This seems to have broken oslat with "oslat -v".  Would you help recover the
> old behavior somehow?

To be explicit, I didn't mean only "oslat -v".  It dumps nothing now which
definitely is not right..  Also I explicitly dump version for every oslat run
because I wanted that to be with the output, so when user reports issue with
oslat we'll always know which version is it.  So besides the "oslat -v"
breakage, I'd really appreciate if you can add the version dump back with every
oslat run, too.

Thanks,

-- 
Peter Xu

