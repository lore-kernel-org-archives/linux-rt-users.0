Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF458C433DB
	for <linux-rt-users@archiver.kernel.org>; Fri, 19 Feb 2021 17:17:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78F9D64E67
	for <linux-rt-users@archiver.kernel.org>; Fri, 19 Feb 2021 17:17:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbhBSRRB (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 19 Feb 2021 12:17:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:50812 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229644AbhBSRRA (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 19 Feb 2021 12:17:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613754933;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=USzreUy0CQegxcSAJSWuGiLVqmM3LNJlcgpaFuVZqrs=;
        b=Ws/G6h8n9/TwvqX+k/W1K3FGrd2+Go7E8g7XvvO6vZ443D+4AA2j5b5yz3mffyNzBo4luD
        6EGg9wZKFI1OObpKYYagjgAmN8NoesQamQpS3I5mr4pQFaTEoPjxPGEXh+3azGvuz9Z9eL
        nPyktZcGYX8dDoMi64LHUmpVlMMybgg=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-218-X44R9wuyPMWRkW9lLVHGUw-1; Fri, 19 Feb 2021 12:15:31 -0500
X-MC-Unique: X44R9wuyPMWRkW9lLVHGUw-1
Received: by mail-qv1-f70.google.com with SMTP id t18so3592427qva.6
        for <linux-rt-users@vger.kernel.org>; Fri, 19 Feb 2021 09:15:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=USzreUy0CQegxcSAJSWuGiLVqmM3LNJlcgpaFuVZqrs=;
        b=dcHi2t/N4pOaNjE48k4ejKEeOA3TjC8L9pnM6tvcK/LPc3JzHH7mzL5nOxgwX3xW5a
         +rW4SgX+ELjEvQbxGCQBeAgE1AVbYOBCL5uZ9Sik3pYXHTGhK3RnKTNoVhEmEFjpmGeD
         cj4KCSYRWl522fQQ1d7MR6gMvJ9qLPRvcZpHasN069/uNbTFJ863uzVm3siAsx7a1onQ
         o1kTz9niQeMA3DK4p/7Eh1EX+xX/0a0OQvTa8tnrsJ6PG4bU99i6/zkuOB/6pZsO6mTD
         oixXVsPNWjggM6OAHHyyHfby6Yvkwt2Ekjl3k9xOWvBxxZTIXcOL2jbLCm9ev6/TGUiP
         ZNDw==
X-Gm-Message-State: AOAM532H9stLNZzNsEx80mccaFxiR03sO6Ha4ZXvEQkVM/MWkyftTcOF
        +EzTCozHZVWr9CVvjVFPZ4+83Ohx5GJoXAPYNJ6jy/UaELLTDk0Hk5S/B7uNk8RH0Wdv1Kwi5Xn
        KOggKp13eCBYbCpKs4WVAmlfMSao=
X-Received: by 2002:a37:d0b:: with SMTP id 11mr10140949qkn.267.1613754931369;
        Fri, 19 Feb 2021 09:15:31 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxZgoOE8xHcfccYSj1Hzs82KIW+HC9sS4oj6NhCN3fWhNlkFRx49cYdqW4eafX+Gy5olqfiIQ==
X-Received: by 2002:a37:d0b:: with SMTP id 11mr10140933qkn.267.1613754931132;
        Fri, 19 Feb 2021 09:15:31 -0800 (PST)
Received: from xz-x1 (bras-vprn-toroon474qw-lp130-25-174-95-95-253.dsl.bell.ca. [174.95.95.253])
        by smtp.gmail.com with ESMTPSA id v12sm4594680qtw.73.2021.02.19.09.15.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Feb 2021 09:15:30 -0800 (PST)
Date:   Fri, 19 Feb 2021 12:15:29 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Daniel Wagner <dwagner@suse.de>
Cc:     linux-rt-users@vger.kernel.org,
        Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>,
        Pradipta Kumar Sahoo <psahoo@redhat.com>,
        Mike Stowell <mstowell@redhat.com>
Subject: Re: [PATCH] oslat: Fix --cpu-list won't allow to schedule on all
 possible cores
Message-ID: <20210219171529.GH6669@xz-x1>
References: <20210218192729.116427-1-peterx@redhat.com>
 <20210219081611.xsugonlz7dl4zhvx@beryllium.lan>
 <20210219152417.GE6669@xz-x1>
 <20210219162019.giw2yy25vjuzc56f@beryllium.lan>
 <20210219163930.GG6669@xz-x1>
 <16b412ed-eaad-e305-faee-709eb75f79cf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <16b412ed-eaad-e305-faee-709eb75f79cf@suse.de>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Fri, Feb 19, 2021 at 05:49:47PM +0100, Daniel Wagner wrote:
> Hi Peter,
> 
> On 19.02.21 17:39, Peter Xu wrote:
> > Now I tried to fix it but it seems you don't really like my fix.
> 
> Sorry I didn't want to say I don't like your fix. I just said, I would
> appreciate if things would stay consistent. But then it seems there is
> not much interest in this.
> 
> > Would you propose yours instead?  I would be more than glad if your version is
> > better then I'm happy to drop mine.  Otherwise I'll still prefer to have this
> > patch merged to unbreak it first.
> 
> I don't care too much. If this patch fixes your problem don't let me
> stop you.

It's not really my problem, I can compile my own binary.  It's just that I want
to have it working as usual for anyone using it.  Also it'll be great to have
it fixed sooner for our downstream so our QE won't be affect.  I don't want the
unbreak to be delayed by any further cleanup idea anymore - I am totally not
against that, but again I think they can be done on top of a working tree.

Sorry if my wording was too harsh - I apologize for that.

Thanks,

-- 
Peter Xu

