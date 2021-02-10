Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CE9BC433E6
	for <linux-rt-users@archiver.kernel.org>; Wed, 10 Feb 2021 19:27:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0CC064E7A
	for <linux-rt-users@archiver.kernel.org>; Wed, 10 Feb 2021 19:27:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234658AbhBJT1j (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 10 Feb 2021 14:27:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:49028 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234654AbhBJT1d (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 10 Feb 2021 14:27:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612985167;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=H6BTB+51K0hJrhlPMWpQWtLXCx809PnPdYJK6Un+q1w=;
        b=aYvzS3xpHcW4QJrCKwnwXHYS50wTRGfbWw1nF/fGamIlT8F5wQaSP3XukNYa6/ITAap0ri
        iiTLvzhqL1UiKc1F25MDTeb0M5cvO+FdZ4v8QJOfJw6tKWg70qCptnNjA8mOIbrknS26AQ
        ayEMmuCd4o8E9JvMuRP6JHetPH4E7cU=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-350-spCuCJy6MdakVsYtdCGilw-1; Wed, 10 Feb 2021 14:26:06 -0500
X-MC-Unique: spCuCJy6MdakVsYtdCGilw-1
Received: by mail-qt1-f200.google.com with SMTP id f5so2393771qtf.15
        for <linux-rt-users@vger.kernel.org>; Wed, 10 Feb 2021 11:26:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=H6BTB+51K0hJrhlPMWpQWtLXCx809PnPdYJK6Un+q1w=;
        b=af/k+QUkzjgJOnGFqYju3vvemhWZ0jqjxU5PHI/An44VRC33/YHPcWdRSBGBsTAVu2
         gPyVcFAe7HFTovehvr1qJ3f2FjTX4vIQD8iCxbCo4bUPdW4fnfCliiRlYtlCSOLeH+zX
         M6eAq52BwTRoXdZd+kOu1Ua9hhtyBYg7yeBVOTAbs5wcfzBH2e/LvJX54RfmAbTzzcue
         GuQlvav897jFPowlAGwfTZ1IExi31j4pFuF+BHLizUvXkqRORfGGaRRjCH2PrhEdaENX
         wSBOqpau5uA73Ch1MyDqkghiT24ghF7jZcw5t7QQtCJ6rQiwsy8f/uNIMJ718aEceoXY
         /vyA==
X-Gm-Message-State: AOAM531GrQ+dLolDRcYevhcCb/NtkXjz60IS96kZOpw99k6HTSZp1SZS
        oW18mOT9L2qBjtZuTotM1tpUINydxTN/PEK7UD1d/sOpdIIRWXCq3qX1hifdUVidk2NyZojNPW5
        tXLznvcG/05e8AYgcoe4lPr8dSjY=
X-Received: by 2002:a37:4114:: with SMTP id o20mr5028762qka.184.1612985165650;
        Wed, 10 Feb 2021 11:26:05 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyYat/Q+bM3tnsjFspTmiKKEDZ1hfLZr6Xztot4CwpAlOjLjYoMyCWSe3UlT+UBAV8zS1PctA==
X-Received: by 2002:a37:4114:: with SMTP id o20mr5028752qka.184.1612985165458;
        Wed, 10 Feb 2021 11:26:05 -0800 (PST)
Received: from xz-x1 (bras-vprn-toroon474qw-lp130-20-174-93-89-182.dsl.bell.ca. [174.93.89.182])
        by smtp.gmail.com with ESMTPSA id v135sm2230448qka.98.2021.02.10.11.26.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 11:26:05 -0800 (PST)
Date:   Wed, 10 Feb 2021 14:26:03 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Daniel Wagner <dwagner@suse.de>
Cc:     John Kacur <jkacur@redhat.com>,
        Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH rt-tests 1/2] oslat: Print version string
Message-ID: <20210210192603.GT103365@xz-x1>
References: <20210210165407.9770-1-dwagner@suse.de>
 <20210210165407.9770-2-dwagner@suse.de>
 <9c2916d8-14ab-3465-97fa-2a9b52c83b1e@redhat.com>
 <20210210173353.pqeu2sm33qs7hjna@beryllium.lan>
 <20210210175302.GP103365@xz-x1>
 <20210210181504.z6ckihv5zghexrne@beryllium.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210210181504.z6ckihv5zghexrne@beryllium.lan>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Wed, Feb 10, 2021 at 07:15:04PM +0100, Daniel Wagner wrote:
> > It's great idea to have JSON format for all the tools.  However I just don't
> > see why "-v"/"--version" is related to your machine readable output work.
> > Could you exlaborate?  Thanks,
> 
> I've added long options support to many rt-tests in the mentioned
> series. I would like to base this fix on top of this work.

My opinion probably don't even matter here... but I tend to agree with John
that the fix and your work is separated.  If there's must a rebase, it would be
better to rebase the big series upon the fix rather than the other way round,
simply because a fix is normally more important than a new feature (if not
talking about this "-v" thing, the other --cpu-list issue should be important).

Appreciate all the refactoring works on oslat happened and ongoing, it would
just be even nicer if the touched code path can be smoked so we don't miss
anything important.

Thanks again.

-- 
Peter Xu

