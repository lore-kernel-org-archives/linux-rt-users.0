Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C17D4C00A5A
	for <linux-rt-users@archiver.kernel.org>; Tue, 17 Jan 2023 23:46:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbjAQXp7 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 17 Jan 2023 18:45:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjAQXpe (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 17 Jan 2023 18:45:34 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F1766A49
        for <linux-rt-users@vger.kernel.org>; Tue, 17 Jan 2023 14:50:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673995848;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3ObKU7O3BSEw35QpsA7CzEwshqqhOyObYoYelY5e2Jk=;
        b=SHBrj3e0m6T303zsdLtRF5Koc/th83UnaT4wThzqBgim8uNjoo7S5JczveoyYZlVSQYe7H
        Nz1zr3g7s8iY5+3LLgerTb3ayZnPqLJ5LEDPfLDjpLLmGH8I8YMr9EWBFAoFVjy4ABtFNP
        Jh90+7YbySHsWp7iARKzjEeonmRU1Xc=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-517-_XZVSelhOQyWjliScRiuSg-1; Tue, 17 Jan 2023 17:50:41 -0500
X-MC-Unique: _XZVSelhOQyWjliScRiuSg-1
Received: by mail-qt1-f197.google.com with SMTP id k8-20020ac84788000000b003b631e8cc4dso2417680qtq.16
        for <linux-rt-users@vger.kernel.org>; Tue, 17 Jan 2023 14:50:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3ObKU7O3BSEw35QpsA7CzEwshqqhOyObYoYelY5e2Jk=;
        b=M3/bCpwyOAVw3wZ1uM48lQsxBGQkxwavQ8tjeUST7SXKuvAXWrQIT39lGReJq9MANH
         Yz/sQ0VGjDh1t2hnl4rJkD212jU8h4YDC7j0GyDB3fjAlkL1HJUBPS2ii3d2fXG12Acb
         IL3HHIhQLf+QsRa1zuzoNLrj21NCwdQ23aBjxeTsA0M6/yjsLkHw6sIpt+r4hVDZO/uU
         pmaVHUdATTgb1uvZVgxDFI8FCRua1yyN7l3PqYfDON6NNjdpj40NCncA5KeuWX+tg+v7
         IQbxfcHlmpbqSf4hpTPv2zUV9c+c9rUgNilN4p9Hs45CpSIwfheSk2hqX4JZkqQNmPb/
         meJg==
X-Gm-Message-State: AFqh2kqTSuxHqAlAzkI5IUMv+HC8P58ixUz6wJ5g0lryuvALV9o1sm8H
        qu1v8xojWI2AvOk/xF+Ep7G9+FeyZgsnIXNJgsAGzbYmVutHxJ7LlAOuW4/uxj0y9tubUElEwZa
        Qy6NxmkXaeKesfqWO9WbdjwJXTDI=
X-Received: by 2002:a05:622a:2591:b0:3b6:32ed:54e6 with SMTP id cj17-20020a05622a259100b003b632ed54e6mr5763129qtb.6.1673995841089;
        Tue, 17 Jan 2023 14:50:41 -0800 (PST)
X-Google-Smtp-Source: AMrXdXt4/FfYZ/OBDBS/9cYWAnoQwg76FpoW+SjiOJL5/IivnHWqHsXzXXF3UPh0RnbjaXKn4YRVYA==
X-Received: by 2002:a05:622a:2591:b0:3b6:32ed:54e6 with SMTP id cj17-20020a05622a259100b003b632ed54e6mr5763115qtb.6.1673995840876;
        Tue, 17 Jan 2023 14:50:40 -0800 (PST)
Received: from fionn (bras-base-rdwyon0600w-grc-14-76-71-123-7.dsl.bell.ca. [76.71.123.7])
        by smtp.gmail.com with ESMTPSA id i8-20020ac860c8000000b003b644e8e3a3sm842790qtm.23.2023.01.17.14.50.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 14:50:40 -0800 (PST)
Date:   Tue, 17 Jan 2023 17:50:06 -0500 (EST)
From:   John Kacur <jkacur@redhat.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
cc:     "Ahmed S. Darwish" <darwi@linutronix.de>,
        Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH] rt-numa: Use a reasonable default max CPU value.
In-Reply-To: <Y8Zh3h17Fu1uChsa@linutronix.de>
Message-ID: <b48eb073-d752-c1f0-2b51-d6ecc369c3c1@redhat.com>
References: <Y7/aS/dW0H0CK8Oe@linutronix.de> <5515f090-51cf-37fd-68a-66283fb0c639@redhat.com> <Y8WaaXViNE5dEuyc@lx-t490> <25a775d-77e-e76e-a626-1e6c605e1df3@redhat.com> <Y8Zh3h17Fu1uChsa@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Tue, 17 Jan 2023, Sebastian Andrzej Siewior wrote:

> On 2023-01-16 13:58:42 [-0500], John Kacur wrote:
> > 
> > Okay, not sure how that adds to the conversation. I'm all for "sane" 
> > defaults for --smp too, but we care about other kinds of invocations too. 
> > As soon as I get a patch that doesn't break other things as well, I'll 
> > apply it.
> 
> BROKEN IT IS.

Well something is broken isn't it? But could it be your BIOS then?
This does work for most people on most machines.

The thing I'm always on the look out for is making sure a fix for one 
problem doesn't cause problems elsewhere.

> 
> I want to use that and not fix every time I use it. Using
> 	-S -p 90 -d0 -m
> 
> are already a lot of options just for a simple test to use all CPUs on a
> system. This used to work on this machine. Now it starts way more
> threads than I have CPUs. I accept that this might be something that
> someone wants to test so he can use -t 100. But the simple test that is
> no longer working. srsly. Starting more threads than the current
> available online CPUs or even CPU affinity makes no sense since the
> results with equal priority distribution or not reproducible.

Right, your patch said
"For default configuration, only with the -S option"

So, I looked at the code, and thought, this could be called
for OPT_THREADS as well as for OPT_SMP

That's the only thing I asked you to address.

However, taking a step back, I think it will work fine for OPT_THREADS as 
well. In fact we used to do it that way, it got changed here.

commit 76ad600da83771dc4985b4a9db1f63344bb364cb

with what certainely seemed like a sane clean-up.

So, I'm just going to do a little more testing, and make sure
it doesn't break rteval, and then I'll likely apply your patch.

John

> 
> > John
> 
> Sebastian
> 

