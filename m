Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF917C43334
	for <linux-rt-users@archiver.kernel.org>; Fri, 24 Jun 2022 15:50:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232215AbiFXPuc (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 24 Jun 2022 11:50:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231669AbiFXPub (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 24 Jun 2022 11:50:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AA3D14B1FF
        for <linux-rt-users@vger.kernel.org>; Fri, 24 Jun 2022 08:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656085829;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=q1zAL95W6AgQ7o2C1t9C5eQgRPUg9jpxe4MUJjDnb8k=;
        b=cGILu2ukqAg+T3pymStpz3X4rAXn/SJMcTktP/JThq0/QMeNbRurNFHEvzymJAxlRNPnxn
        VeJuvIu8oM+ODq+A8vhEYtE52qVXVCFVkphscfuEEJdJlfea78eBQXOFNuHbsxRZWl8ZfL
        sUgykMcP96uawlvn3uP+w8CKNu9WXSI=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-465-SCuswc7lNwuP-8RP9vDFfA-1; Fri, 24 Jun 2022 11:50:28 -0400
X-MC-Unique: SCuswc7lNwuP-8RP9vDFfA-1
Received: by mail-qv1-f70.google.com with SMTP id m7-20020ad45dc7000000b0047042480dbfso2914774qvh.9
        for <linux-rt-users@vger.kernel.org>; Fri, 24 Jun 2022 08:50:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=q1zAL95W6AgQ7o2C1t9C5eQgRPUg9jpxe4MUJjDnb8k=;
        b=4RxBzJsizM/r441fPqdgDD7jtJA/CFJ4SV8r67pb7BkfF0AW3a0e5uHOtK5WjjqD2j
         Y7EgfyRF1JHxRWtUUoywtsOIjdWVPLnikfb/BLWEQXVhBw8jU5pajkkui/PkgNqrD6Qs
         a1XDiL9ZK4aiWKYjO3GMZ8inntNRlScHymmfOdWLdQXDyqBND4rySkIR2ot2crtnZqVG
         mTgBqTuLC6+kEA5EaT4DxZvLUzIMx09B350AQ+v/nMBx5kKKx2U5pIKgz7bYX3coRvv4
         tV04h2FNh8DUpMD35kPvlaaMGctPfLsgqj9W1KjAw2xSSQAt7c4vqUkmv0F0X41fc1mO
         RBTQ==
X-Gm-Message-State: AJIora9vUwm0hupfkn0qGhZLZQD8cHdYUfNhDPMOlxHgWbPXN8vFBbu0
        iKuUZp+gapxqTKOQAxLfd5DUzM+RqlKT3TgaB1/hpJrJTll1dDQ4eU33kPS5NNTU8XAZQys0gIq
        AvJ9ioLHOpz7gBSG+4vNFZ/eW22M=
X-Received: by 2002:a0c:a944:0:b0:470:85e2:dc1c with SMTP id z4-20020a0ca944000000b0047085e2dc1cmr6542226qva.8.1656085827737;
        Fri, 24 Jun 2022 08:50:27 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uBFKq5s7VDnRBYKmF3QkinWUMFPyNZ4hCEMRYnXMCS17IIqpOc+8HOoKQDAWfq3fBFU5kyfg==
X-Received: by 2002:a0c:a944:0:b0:470:85e2:dc1c with SMTP id z4-20020a0ca944000000b0047085e2dc1cmr6542204qva.8.1656085827466;
        Fri, 24 Jun 2022 08:50:27 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-09-184-147-143-93.dsl.bell.ca. [184.147.143.93])
        by smtp.gmail.com with ESMTPSA id ay37-20020a05620a17a500b006a7137330e2sm2153037qkb.132.2022.06.24.08.50.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jun 2022 08:50:26 -0700 (PDT)
Date:   Fri, 24 Jun 2022 11:50:25 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Gautam Thaker <ghthaker@gmail.com>
cc:     linux-rt-users@vger.kernel.org
Subject: Re: cyclictest count value seems incorrect...
In-Reply-To: <CA+1+E3XngtGKoc72x5okmFmv0nt3omU=RUFXbH0C0X3yKMfH+A@mail.gmail.com>
Message-ID: <c8494b31-2a0-c8a7-8be3-0e7ce6653@redhat.com>
References: <CA+1+E3XngtGKoc72x5okmFmv0nt3omU=RUFXbH0C0X3yKMfH+A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Wed, 22 Jun 2022, Gautam Thaker wrote:

Please always include the version in bug reports

> I ran the following 3 hour test using cyclictest. The count for T:0
> that I saw when I returned to my screen in the morning seemed
> puzzling. Because I use the '-M' option it display updates when there
> is a new maximum on any CPU. Does the output as shown mean on CPU 0
> the maximum value of 26 happened on count 168704 and as it never
> increased after that the C: xxx is simply not updated?

It looks to me that for some reason processor 0 was printed twice and the 
second one is correct.

> 
> I wish even with -M option at end of the display would do a final
> update. Because of -M the only things that will update on the last
> screen update would be count values, but this would be useful.


> 
> 
> node-0> date; sudo ./cyclictest  -d  0 -p 90  -S -D 3h  -m -M; date
> Tue Jun 21 21:37:22 MDT 2022
> # /dev/cpu_dma_latency set to 0us
> policy: fifo: loadavg: 0.00 0.03 0.04 2/166 5380
> policy: fifo: loadavg: 0.16 0.03 0.01 2/170 5702
> T: 0 ( 5368) P:90 I:1000 C: 168704 Min:      3 Act:    5 Avg:    5 Max:      26
> T: 0 ( 5368) P:90 I:1000 C:9742264 Min:      3 Act:    6 Avg:    5 Max:      61
> T: 1 ( 5369) P:90 I:1000 C:9742261 Min:      3 Act:  132 Avg:    5 Max:     132
> T: 2 ( 5370) P:90 I:1000 C:9742257 Min:      3 Act:   13 Avg:    5 Max:      67
> T: 3 ( 5371) P:90 I:1000 C:9742254 Min:      3 Act:    6 Avg:    5 Max:      91
> T: 4 ( 5372) P:90 I:1000 C:9742245 Min:      3 Act:    6 Avg:    5 Max:      59
> T: 5 ( 5373) P:90 I:1000 C:9742247 Min:      3 Act:   10 Avg:    5 Max:      41
> T: 6 ( 5374) P:90 I:1000 C:9742244 Min:      3 Act:    7 Avg:    5 Max:      67
> T: 7 ( 5375) P:90 I:1000 C:9742241 Min:      3 Act:    7 Avg:    5 Max:      29
> Wed Jun 22 00:37:22 MDT 2022
> 

