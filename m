Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C2F1C433DB
	for <linux-rt-users@archiver.kernel.org>; Wed, 10 Feb 2021 17:55:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E482664ED4
	for <linux-rt-users@archiver.kernel.org>; Wed, 10 Feb 2021 17:55:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233343AbhBJRyl (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 10 Feb 2021 12:54:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:31786 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232975AbhBJRyd (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 10 Feb 2021 12:54:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612979587;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nJ4hYEQBFJ4+/yqux/5Ojfv99XyDI8QE9cnrT2JBtCI=;
        b=b0Fn/B9biNK0/E+9RdGdDvhYROSw7bVLDygP/XTRAD0fsBd7g248eF8BQpQtsnQiu+INEN
        reEwy5F5fXGogC6f8jS6a1F+BBiFV2kRshPDe6RJeAOmS4awpOhu8jV5FNAFYr+gT9Wc8b
        UbtmarJishfvb1ssJeifyGxmvWMe8Bo=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-388-xG6vdMpgMvObssAjEhOMvA-1; Wed, 10 Feb 2021 12:53:05 -0500
X-MC-Unique: xG6vdMpgMvObssAjEhOMvA-1
Received: by mail-qv1-f72.google.com with SMTP id a12so2000208qvo.3
        for <linux-rt-users@vger.kernel.org>; Wed, 10 Feb 2021 09:53:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nJ4hYEQBFJ4+/yqux/5Ojfv99XyDI8QE9cnrT2JBtCI=;
        b=dYGtkxl5A18ouHLfmPM6B6DhJEEVGiozp0hQ2KSOChKzWB3ASnvZZIZldjIA0LELsB
         aZxGMZhwfArqIiV7wAp4BqRV18h42AFQ3RHAA5b6i3E//1XQzoeEbHSsQYwzPyNyY/Py
         4534oomwX1LqmBp5094g02WLccvCqntVxjSe+MQVqJtEXotLXK3z2+QyPd9x3QmMiOnB
         FfGjawXFH6Pj98ISYmzbZN/i/mQpxWuGFnZjoXnLyuUkEi/RTtOKts7Q6t7sU+bEduzi
         0/xQNZhqmw0+FbZkKbvetmLfNCVpt4RVVP8oClkPfcOBJvVLe1DH2snVv2nnqm5G64oF
         TzBg==
X-Gm-Message-State: AOAM533THa8iHXQCd1YL+n+k4FX489HFlDS5rp4HVoCLIP9f21Q9X+js
        qN8P+uik9rxK792M7V7rY5eHpZNcuHqt9nRNsgOLRQWGrGEq3zkfKMghfTnVbox3+JgKuJbDTAX
        ehC0x/P+QjbaK0SM32XRCZ34K94E=
X-Received: by 2002:a37:4691:: with SMTP id t139mr4328630qka.274.1612979584447;
        Wed, 10 Feb 2021 09:53:04 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxeknC48cX65nTy2nzJ7cdz9eMX8vHYZIz9anuyyB9aNJ/UOO/B1pjVaDOviUa/OHkAKyNucg==
X-Received: by 2002:a37:4691:: with SMTP id t139mr4328614qka.274.1612979584252;
        Wed, 10 Feb 2021 09:53:04 -0800 (PST)
Received: from xz-x1 (bras-vprn-toroon474qw-lp130-20-174-93-89-182.dsl.bell.ca. [174.93.89.182])
        by smtp.gmail.com with ESMTPSA id m5sm1908584qkk.120.2021.02.10.09.53.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 09:53:03 -0800 (PST)
Date:   Wed, 10 Feb 2021 12:53:02 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Daniel Wagner <dwagner@suse.de>
Cc:     John Kacur <jkacur@redhat.com>,
        Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH rt-tests 1/2] oslat: Print version string
Message-ID: <20210210175302.GP103365@xz-x1>
References: <20210210165407.9770-1-dwagner@suse.de>
 <20210210165407.9770-2-dwagner@suse.de>
 <9c2916d8-14ab-3465-97fa-2a9b52c83b1e@redhat.com>
 <20210210173353.pqeu2sm33qs7hjna@beryllium.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210210173353.pqeu2sm33qs7hjna@beryllium.lan>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Wed, Feb 10, 2021 at 06:33:53PM +0100, Daniel Wagner wrote:
> On Wed, Feb 10, 2021 at 12:28:09PM -0500, John Kacur wrote:
> > It shouldn't be a fall through, we don't want to print the usage.
> 
> Ok. In this case I suggest we introduce for all tolls the long option
> '--version' and print only the version string.
> 
> As I have already added the long parsing option in my series 'Generate
> machine-readable output'. This was a lot of tedious work, so I would
> like to avoid to do it split out for the '--version' option. Thus, could
> you review the series and I could easily fix this problem.

It's great idea to have JSON format for all the tools.  However I just don't
see why "-v"/"--version" is related to your machine readable output work.
Could you exlaborate?  Thanks,

-- 
Peter Xu

