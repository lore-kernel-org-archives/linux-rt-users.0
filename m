Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57677C07E99
	for <linux-rt-users@archiver.kernel.org>; Fri,  9 Jul 2021 18:08:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D96C613D1
	for <linux-rt-users@archiver.kernel.org>; Fri,  9 Jul 2021 18:08:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbhGISLd (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 9 Jul 2021 14:11:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:53200 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229735AbhGISLc (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 9 Jul 2021 14:11:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625854128;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/QePRUrqeXJg3elGZlQDDRYHyXbKu/kVjxmkAZ9JaTo=;
        b=agGZuM3xUfuU9L2dJBKTa7BM33MdvVe4BuH8LucDNOtOsndIJPZUb2L+h8kpfQdXj4Eg/u
        q/cJ4twD3/ccqOUsYYKvLu5kqKhu73vSO7izwwUqxeQt1d1UOH1eTNUltHK/FzjcbNCWCV
        sffuudTGq1wPYKiuk/vQZT6mfX3mTNE=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-554-7zV6CYpONuupNjCVtCwBXw-1; Fri, 09 Jul 2021 14:08:47 -0400
X-MC-Unique: 7zV6CYpONuupNjCVtCwBXw-1
Received: by mail-qv1-f69.google.com with SMTP id q10-20020a056214018ab029027751ec9742so6956896qvr.7
        for <linux-rt-users@vger.kernel.org>; Fri, 09 Jul 2021 11:08:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=/QePRUrqeXJg3elGZlQDDRYHyXbKu/kVjxmkAZ9JaTo=;
        b=qB410QRZ/aW8CRiN7eG/PQHMvb0Tk/eCf2MeCI2HP+wxov8IvoGYAKuJk/7VCaq8ih
         4zw1bzrX/u5gMVHYVWi5Q3cCuwzqiD78ABvb+FZmbRZayJTbuUBAZFkBQkviSgK8EHTj
         DwpHm6h0RT5aEm3vmG0EeuD+0Pq+arQPBXxTchY64hQQcg43bewG3lgCmrvw5mF6PxCF
         ilrPmv25FNXh6g/ejTri3hSCZ+NJJSYGrzICMKVDTJgn6wnWpF/Nwo5j8iOURk8VToMM
         DZ2bQMEVR+RbTEsBiILsNlhkiLbc4b8Zhi7X3kK0NOdqQweKOBUoDtsUvAL/WmyOtdNe
         lW7g==
X-Gm-Message-State: AOAM531h1kcLIyZEozzU47LGlNTvFgYcnJnZRiiShV18fBdKLbyovp1C
        hUluv/wpQ3e7/PX2Ab1nBTz2rsEi0/xvv1eo6DMPvCP/PZau5V5YtEAYUQkOj50ldTIH7Q7YXQK
        2n7knr+/+tYEGTsVJhqZfg7gMOJk=
X-Received: by 2002:ac8:6898:: with SMTP id m24mr17418762qtq.97.1625854127225;
        Fri, 09 Jul 2021 11:08:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwtqE8IRRpnCh9jYqBiE3CnnsQ3hLkHtGJoPmgccTY4fw3cCiDAIxGAazycTIR1l1oKy2W3Hw==
X-Received: by 2002:ac8:6898:: with SMTP id m24mr17418751qtq.97.1625854127094;
        Fri, 09 Jul 2021 11:08:47 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-07-184-147-141-243.dsl.bell.ca. [184.147.141.243])
        by smtp.gmail.com with ESMTPSA id 11sm2770646qkp.115.2021.07.09.11.08.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jul 2021 11:08:46 -0700 (PDT)
Date:   Fri, 9 Jul 2021 14:08:45 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Peter Xu <peterx@redhat.com>
cc:     Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        linux-rt-users@vger.kernel.org, williams@redhat.com
Subject: Re: [PATCH 1/2] oslat: Remove redundant include
In-Reply-To: <YOXoFUS8TljxgPYn@t490s>
Message-ID: <b207f7f-3fff-4020-9727-58e2ec8ac6cb@redhat.com>
References: <20210707084849.304329-1-nsaenzju@redhat.com> <YOXoFUS8TljxgPYn@t490s>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Wed, 7 Jul 2021, Peter Xu wrote:

> On Wed, Jul 07, 2021 at 10:48:48AM +0200, Nicolas Saenz Julienne wrote:
> > inttypes.h is already included above.
> > 
> > Signed-off-by: Nicolas Saenz Julienne <nsaenzju@redhat.com>
> 
> Reviewed-by: Peter Xu <peterx@redhat.com>
> 
> -- 
> Peter Xu
> 
> 
Thanks, added

