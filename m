Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9CEDC54EBE
	for <linux-rt-users@archiver.kernel.org>; Mon, 16 Jan 2023 18:59:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233575AbjAPS7h (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 16 Jan 2023 13:59:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233570AbjAPS7b (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 16 Jan 2023 13:59:31 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCA7025E06
        for <linux-rt-users@vger.kernel.org>; Mon, 16 Jan 2023 10:58:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673895525;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=y4Ntw2SqniyX4vGXDT/rZGS2sJ6PkV9tfoMs31yrqT8=;
        b=Cf1hxendvPtp+mDAX3CCmnENCHxpAYIldrS9ysAy5H1mXqWzmn340MqRQ8Row/WyXJKiAu
        a7kvzsNvpc2z6EpwU6bVBvX3GwVmf2MtsAdVhjEvV5/WtilCkuegwY+923+u8LL9gifHIX
        wxLB4fcp1ROEIPqt6wxyb4585optQ30=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-235-d8K0f5N8PqKCbMIXI3eHLg-1; Mon, 16 Jan 2023 13:58:44 -0500
X-MC-Unique: d8K0f5N8PqKCbMIXI3eHLg-1
Received: by mail-qv1-f69.google.com with SMTP id nh4-20020a056214390400b004e36a91ecffso14982365qvb.19
        for <linux-rt-users@vger.kernel.org>; Mon, 16 Jan 2023 10:58:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y4Ntw2SqniyX4vGXDT/rZGS2sJ6PkV9tfoMs31yrqT8=;
        b=k1AH25Pi3Gi1plgxVxYQdZS0TX/OfUeg4HA9lkROHfV0lsKEXAHOAOgJFambNWi7HU
         34dAN1kF/5W6gSI7dtGGLrtA2Qlm/5UtLMy39EZpWN44yyLR+aP8+aWwv7YO+DgFmj3n
         rVHvGGfJ3g62qbV/Qy8BUSBscx1cvrSQ0xQpZeIvNwpBoNmXJq5qrZEHzBKdfYgefJef
         WyH144OFaCy5Fzxr+yDUmJw0pjgYrXvSqhmdCEfAImU+tADNKvteQ+0PmaIo34ij82xs
         ABHUjFAWS4SoD0J+s5Tn0Kw9vs71+oTSSbOkQpaxxqU7ULBU3HGTr74pO/gHTyeJOaW1
         wCUw==
X-Gm-Message-State: AFqh2koo90tSfetH5mYUMjtsXdAJA8mAs/RRybDWtkNDk5GLeCLRfnR/
        LNTlQjFsFUP+PO3O7F1MnGqkZxtuDCKxWSVbnvCgb4IB58iwqvKL6CvS9HPg9SW0PgytfU68pQQ
        2n00ilex3RehzNlvmu7Py3lzSw3I=
X-Received: by 2002:a0c:9781:0:b0:534:fe24:db67 with SMTP id l1-20020a0c9781000000b00534fe24db67mr964301qvd.16.1673895524096;
        Mon, 16 Jan 2023 10:58:44 -0800 (PST)
X-Google-Smtp-Source: AMrXdXt0g6WZeLnLOPNUF1ySL4ZszfgUZaIxTnBceMQkDL87rRdL71LXMDOOsGetG65nFdm5XnTPPA==
X-Received: by 2002:a0c:9781:0:b0:534:fe24:db67 with SMTP id l1-20020a0c9781000000b00534fe24db67mr964288qvd.16.1673895523880;
        Mon, 16 Jan 2023 10:58:43 -0800 (PST)
Received: from fionn (bras-base-rdwyon0600w-grc-14-76-71-123-7.dsl.bell.ca. [76.71.123.7])
        by smtp.gmail.com with ESMTPSA id u8-20020a05620a430800b006b615cd8c13sm18804991qko.106.2023.01.16.10.58.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jan 2023 10:58:43 -0800 (PST)
Date:   Mon, 16 Jan 2023 13:58:42 -0500 (EST)
From:   John Kacur <jkacur@redhat.com>
To:     "Ahmed S. Darwish" <darwi@linutronix.de>
cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH] rt-numa: Use a reasonable default max CPU value.
In-Reply-To: <Y8WaaXViNE5dEuyc@lx-t490>
Message-ID: <25a775d-77e-e76e-a626-1e6c605e1df3@redhat.com>
References: <Y7/aS/dW0H0CK8Oe@linutronix.de> <5515f090-51cf-37fd-68a-66283fb0c639@redhat.com> <Y8WaaXViNE5dEuyc@lx-t490>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Mon, 16 Jan 2023, Ahmed S. Darwish wrote:

> On Mon, 16 Jan 2023, John Kacur wrote:
> >
> > On Thu, 12 Jan 2023, Sebastian Andrzej Siewior wrote:
> >
> > > numa_num_task_cpus() returns here > 100 CPUs while the system has only
> > > 32 populated. The BIOS assumes that I can probably use larger CPUs (with
> > > more cores) on the socket so the number of "configured CPUs" is rather
> > > high.
> > > For default configuration, only with the -S option, it makes sense to
> > > use the current affinity instead looking at the number of possible CPUs
> > > which could be brought online. It still depends on the affinity of the
> > > created threads if the additional CPUs can be used. In a container setup
> > > this may not be the case.
> > >
> > > Use sched_getaffinity() to figure out the number of possible CPUs.
> ...
> >
> > In cyclictest we have
> >
> > 	if (num_threads == -1)
> > 		num_threads = get_available_cpus(affinity_mask);
> >
> >
> > But the num_threads can be set to -1 in OPT_THREADS too,
> > not just for OPT_SMP
> 
> A sane default for --smp, which is almost-always used in sane cyclictest
> invocations, is still valuable IMHO.
> 
> Thanks,
> 
> --
> Ahmed S. Darwish
> Linutronix GmbH
> 

Okay, not sure how that adds to the conversation. I'm all for "sane" 
defaults for --smp too, but we care about other kinds of invocations too. 
As soon as I get a patch that doesn't break other things as well, I'll 
apply it.

John

