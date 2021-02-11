Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B76ECC433DB
	for <linux-rt-users@archiver.kernel.org>; Thu, 11 Feb 2021 14:10:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7051964E92
	for <linux-rt-users@archiver.kernel.org>; Thu, 11 Feb 2021 14:10:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231866AbhBKOJt (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 11 Feb 2021 09:09:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:54060 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232111AbhBKOH0 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 11 Feb 2021 09:07:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613052357;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yig++rq9kqM5bA/u6hJwVc8qI8xuBAZ8b5SvOiX/+d8=;
        b=GOZXZDqAMyzIE6IEzQ57JtsGtpdB4PYK1xIzsKTlDXLORT2FOnRFa4yC6RhznyTrBMToQ5
        1nkLPgAtsPR/s9dN0Z3v9VYVTyqNTlOk9aReyjPLj+IWYHVTo3Vvc3Buupbj0+qbJr2v9B
        UjtItC9RdtrbU7Zy5+ktMdn92+MK0Wk=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-280-lEC5o7YNNpWPo7-f3PkQbw-1; Thu, 11 Feb 2021 09:05:56 -0500
X-MC-Unique: lEC5o7YNNpWPo7-f3PkQbw-1
Received: by mail-qt1-f200.google.com with SMTP id p20so4183929qtn.23
        for <linux-rt-users@vger.kernel.org>; Thu, 11 Feb 2021 06:05:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yig++rq9kqM5bA/u6hJwVc8qI8xuBAZ8b5SvOiX/+d8=;
        b=Jh81LDVd/65geirvSj+5yTVg/qWHXuLV5d5HwKM2LGGDd80YfvPqr/Ub2NgIHKlfPj
         7158nSGxGUsAfI9yx7XRuunV/hcM4EMHyYhq1DgBKh/uMLRyant7wnRCeFxQQ4a4XEvx
         EBU6dYwp4XAUE00RGMyoloUZ4Nx09E2Z8BmfIstf4+fSddcbDBz5xmxp0a12bgIE7mcD
         sGUHZzrqg6u7MLTxnWlE4vCuaaLggkAVqjb+oPNlfbOZSqcdstbP0k+Zbg1CWizGik+4
         ZbDHTLHbiWcvPrh6IjIXQ3vEzX3noGzzGlwjjopzT3w3oRWpIqHZqbdiXdD2IlNNTeHs
         6W+w==
X-Gm-Message-State: AOAM533nQUA1UnrhtzL8CGjYpT3orBV9fPsjOZdbg597jZXHME/HlU61
        b6ShH2rKeA4/t1Jy/8rsE5Bkgd2ZRadGRq2PuQielC3rA2MqBK57O8wbxSHZHfskx1AeS1GELtp
        QwU8ms/eYp51otlK1vh+VqX0qkT4=
X-Received: by 2002:ac8:7250:: with SMTP id l16mr7714220qtp.13.1613052356036;
        Thu, 11 Feb 2021 06:05:56 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyqN9dUl91n9GPmTMR11ujo4h1pEa8SJf6Q+4zc2hCfftG9fKakEYKTNZccKByIipFkdVBcyA==
X-Received: by 2002:ac8:7250:: with SMTP id l16mr7714186qtp.13.1613052355714;
        Thu, 11 Feb 2021 06:05:55 -0800 (PST)
Received: from xz-x1 (bras-vprn-toroon474qw-lp130-20-174-93-89-182.dsl.bell.ca. [174.93.89.182])
        by smtp.gmail.com with ESMTPSA id r17sm3512071qta.78.2021.02.11.06.05.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Feb 2021 06:05:55 -0800 (PST)
Date:   Thu, 11 Feb 2021 09:05:53 -0500
From:   Peter Xu <peterx@redhat.com>
To:     John Kacur <jkacur@redhat.com>
Cc:     RT <linux-rt-users@vger.kernel.org>,
        Daniel Wagner <dwagner@suse.de>,
        Clark Williams <williams@redhat.com>,
        Pradipta Kumar Sahoo <psahoo@redhat.com>
Subject: Re: [PATCH] rt-tests: oslat: print version string
Message-ID: <20210211140553.GA142818@xz-x1>
References: <20210211044221.27851-1-jkacur@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210211044221.27851-1-jkacur@redhat.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Wed, Feb 10, 2021 at 11:42:21PM -0500, John Kacur wrote:
> During the streamlining of the command line options something went awry
> with the version. The author of oslat wishes to always print the version
> string. This allows us to just exit in the case of -v

Thanks.  It's just that if we need to recover "-v" behavior it's simply to just
add that print() back, imho. Sorry if I seemed to have made that request
"stronger". :)

> 
> Fixes e411219d27b1
> 
> Reported-by: Pradipta Kumar Sahoo <psahoo@redhat.com>
> Reported-by: Reported-by: Peter Xu <peterx@redhat.com>
> 
> Signed-off-by: John Kacur <jkacur@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu

