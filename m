Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EF39C433EF
	for <linux-rt-users@archiver.kernel.org>; Fri, 10 Sep 2021 14:27:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C3B16108B
	for <linux-rt-users@archiver.kernel.org>; Fri, 10 Sep 2021 14:27:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233926AbhIJO2V (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 10 Sep 2021 10:28:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56398 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233120AbhIJO2U (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 10 Sep 2021 10:28:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631284029;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pC1V4vat8UiVqDBtLG8wgb2eXRp6Y20C4jHsf7TY+co=;
        b=Phv0ib83bOR4nQHVofmqgB+e5L+DqrmtL+0LRmnnZzwysa84LZPMpJmJDhnKKligUMusG/
        cbR6FktGOwrBz/SaDZyB+SlwleDJc0wukuxJBVrrgKTxPbVq6pocx2bS9VjG9+K/GYEFRu
        IWfzX3ckpUXxWS9GgGmRL13OnCukYsM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-145-icpUa4nZNSGy9dS_u9y3Zw-1; Fri, 10 Sep 2021 10:27:08 -0400
X-MC-Unique: icpUa4nZNSGy9dS_u9y3Zw-1
Received: by mail-wm1-f72.google.com with SMTP id z26-20020a1c4c1a000000b00300ec9d8d77so489599wmf.5
        for <linux-rt-users@vger.kernel.org>; Fri, 10 Sep 2021 07:27:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=pC1V4vat8UiVqDBtLG8wgb2eXRp6Y20C4jHsf7TY+co=;
        b=1dNMll9dm5sUGQtbmOGwntCc8egGnPCX68GInoFFFLnzb6zisF2Sh92dPWh3Kgfz8e
         EyYUMV9DiTmIxwwIvSoHznCvpSgohvid83jVILr5kyYY0MxmazjpYs8aE+P/TtmWKjMw
         QWeIwOEtzlKNIQDJS/KcaPkcnY0mBF3XB7CJl4npPMsBS0xAforP3waHHrvZ5Obc7s5e
         GNqZ9ijAVSJqsMfA3/X6WgeIJZvTJoGWr+zT2PK10X2zEriKb8pnHszFi6ET7HqIjs9m
         5r/5V8H4sdTUmXXtuZOqrhyM4/cjvipqlZI02XuKXd2aI/7R0linWvnpcU7NqMOFBh21
         LKwg==
X-Gm-Message-State: AOAM531DRKgf81L0J9hwkAGtUo+vYektO7Mv4Gi0CiuzQk6KoFmH7AdY
        LOWoMWYtpTXTtzTh/jRINf5ygD4iy1L+8Tkl67jwlG79igwDZmcmqGJoTRYyU92FXBBNMWBwgGU
        QOqjSS2HfwUxKNgQo6voFicxGLaU=
X-Received: by 2002:a1c:c913:: with SMTP id f19mr8640867wmb.86.1631284026934;
        Fri, 10 Sep 2021 07:27:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy3JYOa24r5uZMLNzR7rCUjLc2bNu8ke06Bo7kdGsuDoCkUR2oVEIvb71aEdLziNCsO45NaQw==
X-Received: by 2002:a1c:c913:: with SMTP id f19mr8640854wmb.86.1631284026777;
        Fri, 10 Sep 2021 07:27:06 -0700 (PDT)
Received: from ?IPv6:2a0c:5a80:1f0d:6700:7eb9:ffb3:3868:81d7? ([2a0c:5a80:1f0d:6700:7eb9:ffb3:3868:81d7])
        by smtp.gmail.com with ESMTPSA id n13sm3991771wmq.3.2021.09.10.07.27.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Sep 2021 07:27:06 -0700 (PDT)
Message-ID: <1f3916ebd3bb9d886dee56404127308a7be8098e.camel@redhat.com>
Subject: Re: [PATCH 2/3] oslat: Add aarch64 support
From:   nsaenzju@redhat.com
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, williams@redhat.com,
        jkacur@redhat.com
Date:   Fri, 10 Sep 2021 16:27:05 +0200
In-Reply-To: <YTtekExun9GoaFvc@t490s>
References: <20210908100209.118609-1-nsaenzju@redhat.com>
         <20210908100209.118609-2-nsaenzju@redhat.com> <YTj8Qgawnh1xPrDJ@t490s>
         <466f7d726df2dfec8ac83a9d3f603439e3cec1b1.camel@redhat.com>
         <YTpMe2+58YxJ0IFM@t490s>
         <6a2eba408dc4260a47c1acfe743474bb39aa93bd.camel@redhat.com>
         <YTtekExun9GoaFvc@t490s>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Fri, 2021-09-10 at 09:33 -0400, Peter Xu wrote:
> On Fri, Sep 10, 2021 at 02:19:40PM +0200, nsaenzju@redhat.com wrote:
> > > I also don't understand why you explicitly removed the compiler barrier.  IIUC
> > > when without it the compiler could move these instructions to be before/after
> > > other instructions generated in the c code.  That may not really happen in
> > > practise, but just curious why the explicit removal.
> > 
> > I removed it too as I see no justification for it. There is nothing, except for
> > the actual timestamp values (which are safe as they come from an mrs), that
> > could suffer from the compiler prefetching the value, or reordering accesses.
> > I'll add a comment on the commit message.
> 
> Again I have no solid example, but wondering whether when without compiler
> barrier the compiler would be legal to compile this code clip:
> 
>   t1 = frc();
>   a = 1;
>   t2 = frc();
> 
> into something like:
> 
>   t1 = frc();
>   t2 = frc();
>   a = 1;
> 
> It's just that iiuc compiler barrier has 0 overhead to us.  No strong opinion
> anyways.

My understanding is that can only happen when the expression to right of 'a'
has no dependencies with t2. And at that stage, do we really care? Well, yes,
for example if you're measuring how long it took to assign a, which is similar
to what we do:

	workload_fn workload = g.workload->w_fn;
	frc(&t1)
	workload()
	frc(&t2)

But in that case the compiler is forced to handle the indirect function call
and IIUC there is little optimization todo, so we're safe without barriers.

That said, I don't feel overly confident about all this, and there is little
downside to the compiler barriers, so I'll just add them.

-- 
Nicolás Sáenz

