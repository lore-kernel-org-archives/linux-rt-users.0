Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D7DEC433EF
	for <linux-rt-users@archiver.kernel.org>; Mon, 13 Sep 2021 18:39:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C99D610A6
	for <linux-rt-users@archiver.kernel.org>; Mon, 13 Sep 2021 18:39:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240137AbhIMSlC (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 13 Sep 2021 14:41:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49719 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240058AbhIMSlB (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 13 Sep 2021 14:41:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631558385;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aGPnTIrKnY49PfybpWFOHtL5f/FNWAoWwj8ISJiaKmI=;
        b=KOFcxN2rZOWXD65WNGV1rhqUNB/E9glQHEYj5OODj2yDr7AtYZ2NsMPoLsPv+qDyAoPHXP
        RapUYwpLMqoobvQMCNIdVssIgnWDUFG8bKBqd3l1PoQt2rjJMnUMfgNK6rxbziMfTX+oPd
        wWxczz+TxYzJ84Z4rnMaJ8/8vi+HC9w=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-513-Nc2HQx8XPb-sJu5AtmsnOQ-1; Mon, 13 Sep 2021 14:39:44 -0400
X-MC-Unique: Nc2HQx8XPb-sJu5AtmsnOQ-1
Received: by mail-il1-f197.google.com with SMTP id m15-20020a056e021c2f00b0022c598b86c3so16375634ilh.22
        for <linux-rt-users@vger.kernel.org>; Mon, 13 Sep 2021 11:39:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=aGPnTIrKnY49PfybpWFOHtL5f/FNWAoWwj8ISJiaKmI=;
        b=wEE0phAcjVwujBeFVi36ndURq59klyKAbtSDmdtaCfaMutiJxp2k3MxyZcTXi6OUcB
         7O9kTnZ2EpaHhb5eJjXWHCiB+ZqlJMR2IBhkaPfuaTJYqnUmX10Qo2cT/rav+BoWeKI8
         sMSDFo9cerNvKWtaZz2ykMiR6sebUByzKrKomXdR0bZKSh7BfhxIRO9HLh5+jHdbnB/m
         Y6WY6Kz8pr4VNRWPb/Kg2dUovI7BK1Zvai7KFHIxnTitYOLafngh6WCK8OiVjR6GH4kV
         nVHWxuytRoGA1kRB1uvTETfHkmHdHXXIg7MvkxPNQow9V+dNZIR2ZcPVkwAWlEFNEsF+
         PDSQ==
X-Gm-Message-State: AOAM531J2FpYLHcf3aniy2pKSxl4jUooUrlB0290ueuWlhsyIu9Q109T
        7RR20KcHrWgG18WV/lm4oCo94tXpcZSwBKpQmpOehrZNDg+jB6G4jNfpI6zdMt1ZOjQfk8Ym5sm
        YWo9f3DrSEOcud8SoLpn55SsaeBY=
X-Received: by 2002:a5d:9693:: with SMTP id m19mr10444736ion.181.1631558383441;
        Mon, 13 Sep 2021 11:39:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJysrSBM+zATH9oMgxZW+ot9v5wIEwfFl47BF0kDkvfw/bddKQ/MFHEDXANfwpbBXqomeZOsWA==
X-Received: by 2002:a5d:9693:: with SMTP id m19mr10444722ion.181.1631558383293;
        Mon, 13 Sep 2021 11:39:43 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-09-184-147-143-99.dsl.bell.ca. [184.147.143.99])
        by smtp.gmail.com with ESMTPSA id z4sm1023084iln.4.2021.09.13.11.39.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 11:39:43 -0700 (PDT)
Date:   Mon, 13 Sep 2021 14:39:41 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Peter Xu <peterx@redhat.com>
cc:     Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        linux-rt-users@vger.kernel.org, williams@redhat.com
Subject: Re: [PATCH v2 1/3] oslat: Rename cpu_mhz/cpu_hz to
 counter_mhz/counter_hz
In-Reply-To: <YT9m5wvfB24aQujM@t490s>
Message-ID: <62eaff5-f4f5-92d5-72e2-ff40f062afb@redhat.com>
References: <20210913083908.48408-1-nsaenzju@redhat.com> <c12367eb-8766-6826-b2d8-70cafbf04e4e@redhat.com> <YT9m5wvfB24aQujM@t490s>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Mon, 13 Sep 2021, Peter Xu wrote:

> On Mon, Sep 13, 2021 at 09:35:29AM -0400, John Kacur wrote:
> > Waiting for a Signed-off-by: from Peter Xu before I integrate these.
> 
> All 3 patches:
> 
> Reviewed-by: Peter Xu <peterx@redhat.com>
> 
> Thanks,
> 
> -- 
> Peter Xu
> 
> 

Pushed upstream

