Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45ACAC433DB
	for <linux-rt-users@archiver.kernel.org>; Wed, 10 Feb 2021 16:38:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07D3F64E87
	for <linux-rt-users@archiver.kernel.org>; Wed, 10 Feb 2021 16:38:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232323AbhBJQhy (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 10 Feb 2021 11:37:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:21078 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232675AbhBJQfb (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 10 Feb 2021 11:35:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612974844;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cJ+k4/wbCtDjR82AWqK9XsMAIoP3WbNGgyQUryq8YXs=;
        b=geCzq8uIO/AL8EFOU/10jx1aO/ulRKpWoZADdhCYm918vjMkI+wEdHdalAjl1YDaJtSKlT
        82VzoGkVqPHz7TLdI7v3gEWAjsQm8L3NWvJvHD0H9Q5Qb+jxWP0+QkFmi4Kvf2XJOmIck0
        1rgXKtls1ex0aO68uEUdE9sryZpyLOc=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-150-NV9xnkJzNja1aK-k1Cyfgw-1; Wed, 10 Feb 2021 11:33:59 -0500
X-MC-Unique: NV9xnkJzNja1aK-k1Cyfgw-1
Received: by mail-qt1-f199.google.com with SMTP id d10so1943420qtx.8
        for <linux-rt-users@vger.kernel.org>; Wed, 10 Feb 2021 08:33:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cJ+k4/wbCtDjR82AWqK9XsMAIoP3WbNGgyQUryq8YXs=;
        b=VMRJL/USqHYxFhPJf6nwmmy6iPrn6HUT585EAd7aFhe/IF0xr6fqk4RLtOPPo1Awh8
         7SLSO3cCIPYKCmgT5uGdYAjdeMxwpOx1Vhfge6UeSzzUwcRClRL9QZyZC1bEl12zFpb+
         C8buHN5fRuMEH2i5t5NXbk6Mr/+PHPVHfmwt/s7SnLFJZEkuJRpq+ugnJ63xJEQFm2p+
         isxHHmueyNYDOagx0IYbzqYUE5SG3NtCNZxQIjf34DppZNYI9TeCXoKyhGyetwlUJk7r
         FWLqUKGbaJdNG1mrIt7XF5BRqnJCfxHGxOe0+cLrLvzMb98zStDFW7M9NvH+nnzIE7XR
         57/w==
X-Gm-Message-State: AOAM533Z4xLIeL/9ZPtFxS6mVVKwDE/6bSiZRRCFHC8360xioPbZktuk
        xBx/S/1cnW02GtoOvvmHkDc3rQE3CXXsaWbFiYsg4YHBPSm7XXb4FqofkoV6b0H4fZnupYQpEbN
        UhAUAEt+J9YZrAZXzYq4YkPd8FiM=
X-Received: by 2002:ac8:5510:: with SMTP id j16mr1934659qtq.320.1612974838743;
        Wed, 10 Feb 2021 08:33:58 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwhP5Fk9HdfAG4vbFkCWv8CCkmhSdUdOukyfpmA8BzsLRIw4ClL8wUeG+GE8bKGgVcnmHTg8Q==
X-Received: by 2002:ac8:5510:: with SMTP id j16mr1934644qtq.320.1612974838572;
        Wed, 10 Feb 2021 08:33:58 -0800 (PST)
Received: from xz-x1 (bras-vprn-toroon474qw-lp130-20-174-93-89-182.dsl.bell.ca. [174.93.89.182])
        by smtp.gmail.com with ESMTPSA id v135sm1871976qka.98.2021.02.10.08.33.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 08:33:58 -0800 (PST)
Date:   Wed, 10 Feb 2021 11:33:57 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Daniel Wagner <dwagner@suse.de>
Cc:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>, linux-rt-users@vger.kernel.org
Subject: Re: [rt-tests v2 11/18] ptsematest: Streamline usage output and man
 page
Message-ID: <20210210163357.GK103365@xz-x1>
References: <20201007085653.11961-1-dwagner@suse.de>
 <20201007085653.11961-12-dwagner@suse.de>
 <20210210160847.GI103365@xz-x1>
 <20210210162559.GJ103365@xz-x1>
 <20210210163057.ts3zy274abnsnlvn@beryllium.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210210163057.ts3zy274abnsnlvn@beryllium.lan>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Wed, Feb 10, 2021 at 05:30:57PM +0100, Daniel Wagner wrote:
> So this is only about oslat, right? I ask because you respone to the
> email for ptsematest.

Sorry I replied to the wrong subject - yes it's about oslat, only.

Thanks,

-- 
Peter Xu

