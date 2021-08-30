Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB3EDC432BE
	for <linux-rt-users@archiver.kernel.org>; Mon, 30 Aug 2021 12:54:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B17FC60525
	for <linux-rt-users@archiver.kernel.org>; Mon, 30 Aug 2021 12:54:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232993AbhH3MzR (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 30 Aug 2021 08:55:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39783 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232454AbhH3MzP (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 30 Aug 2021 08:55:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630328061;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1i6azDhNhyJFaQqO6sKUAGavy+urMA7TE8YC9C5+dMc=;
        b=Vdqv3BbQoQ1gfrONilv89+FU49zm5kwvzakREniZhLyV24y9YhPpE5RM1Z0Bw83jzxxCew
        Fs/1dZSNUIgaR5aAoI9opoNgyXnifbQqFctPElx4xZPVpSYn0FG1VJl1YMuymRyRYK32Eg
        1c8vraSpk5cc95XeyxETo3VBNBJhHqE=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-213-O3EtrnL1PzWRt9sehY5JzA-1; Mon, 30 Aug 2021 08:54:20 -0400
X-MC-Unique: O3EtrnL1PzWRt9sehY5JzA-1
Received: by mail-qt1-f198.google.com with SMTP id i25-20020ac87659000000b0029f4cca46ccso159153qtr.3
        for <linux-rt-users@vger.kernel.org>; Mon, 30 Aug 2021 05:54:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=1i6azDhNhyJFaQqO6sKUAGavy+urMA7TE8YC9C5+dMc=;
        b=ED3sUfgo6ZxxZ5urcjHx44fSoWRNGbhXwUIAgSpn/5eAB2jpIxKo4S3R0p2JfBovJ+
         RbMAk/18k/7X1tb/+1xzxQD9aJrM2gO9zJCfpC3C3CJl71L8n3QJy0R+9lyaGuUkUtXe
         smNdJd65XHm+ff/G8QoP/ZLUxBjlt7TCplmDNHQ+CdRsIjwwsb+GdCQP1GV3lDw9sCN5
         NoSlyjMEdPReDLA0MwX+puV5he0uLGwbeAWdnfzAJVr7uKQiQRcC61WTYrDARd+MLBnQ
         DBuiZV5alb+BDn34yNveLdvJONXbYyjN49EcxounNe1L2ESYisHQ1Ev4pfUUQlc6Xt55
         ZQdw==
X-Gm-Message-State: AOAM532DkFq7R1AN3ry5ecZr0XtQZ43z99+gTusyblcl3DeZoeJB0PSI
        7LzTaKkHIJVvxwhyD5MkDSOyiTuyx2PCupOad+MOFtdvuvLtm2Ij1nIkDRPj5XSzGr6CUNmRi0V
        EhxrHhlUikgBPqBCiTm4XX+XjvhM=
X-Received: by 2002:ac8:5845:: with SMTP id h5mr20437360qth.91.1630328059921;
        Mon, 30 Aug 2021 05:54:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJynJrCWOVdAgGBHPC5amOHOSVLkx/iy5t/WhnyiQuGkWslfhf+VXWp0VAM+Xf9bdzBAAXKDwA==
X-Received: by 2002:ac8:5845:: with SMTP id h5mr20437349qth.91.1630328059746;
        Mon, 30 Aug 2021 05:54:19 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-09-184-147-143-99.dsl.bell.ca. [184.147.143.99])
        by smtp.gmail.com with ESMTPSA id s10sm11101676qko.134.2021.08.30.05.54.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 05:54:19 -0700 (PDT)
Date:   Mon, 30 Aug 2021 08:54:18 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Daniel Wagner <wagi@monom.org>
cc:     Daniel Wagner <dwagner@suse.de>,
        Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH rt-tests v3 1/1] rt-numa: Use sched_getaffinity() instead
 of pthread_getaffinity_np()
In-Reply-To: <20210829195824.y6sxfey2hazr2mko@beryllium.lan>
Message-ID: <6293e08b-6147-eaf6-a53-b8d55a1a8172@redhat.com>
References: <20210719081505.520-1-dwagner@suse.de> <20210719081505.520-2-dwagner@suse.de> <c85f2cf8-4c30-3171-223-b6a95853637a@redhat.com> <20210829195824.y6sxfey2hazr2mko@beryllium.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Sun, 29 Aug 2021, Daniel Wagner wrote:

> Hi John,
> 
> On Fri, Aug 27, 2021 at 01:09:41PM -0400, John Kacur wrote:
> > -Some minor fixes to the description
> 
> Thanks a lot. Do you plan to do a release soon? I'd like to update the
> versions in LAVA's test-definition test suite. And it's way simpler to
> base it on a released version.
> 
> Thanks,
> Daniel
> 

I hadn't planned on doing so, but I can do so if it will help you out.
I can probably get to this, this afternoon my time, or if not, then 
tomorrow.

Could you provide a link to LAVA again so I don't have to go looking for 
it.?

Thanks

John

