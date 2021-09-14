Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB4D7C433F5
	for <linux-rt-users@archiver.kernel.org>; Tue, 14 Sep 2021 12:48:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8674860F58
	for <linux-rt-users@archiver.kernel.org>; Tue, 14 Sep 2021 12:48:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232664AbhINMuL (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 14 Sep 2021 08:50:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:42868 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233231AbhINMtj (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 14 Sep 2021 08:49:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631623702;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Mn+ygWSH/7UdGRjYA5G3DJPGQr3saXHl9TM2CskrAzc=;
        b=ge42txkLaS1ro8AfpBDDXzV2uqWeN9bV0aO3Vz8VScDL2or6Hm7eYkPknI1Rd9YHb54pQj
        SOXHaL41YtBIjFO6ib/ppi3YiL6TR52gG66vYareGNfcPi+wncMXfxmWbKsy8qe67Qz3DW
        noQ6Rm7CRS2JjAoCE1P+qDkt82bs8PE=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-43-X331zEmFMdqWCP4cMUyoIQ-1; Tue, 14 Sep 2021 08:48:20 -0400
X-MC-Unique: X331zEmFMdqWCP4cMUyoIQ-1
Received: by mail-il1-f197.google.com with SMTP id w12-20020a92ad0c000000b00227fc2e6eaeso18434073ilh.4
        for <linux-rt-users@vger.kernel.org>; Tue, 14 Sep 2021 05:48:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=Mn+ygWSH/7UdGRjYA5G3DJPGQr3saXHl9TM2CskrAzc=;
        b=tVRrX/z+7PaIjQ056pVnMkmYjUZ3Yro7ei/X+PPCGLskm3IsIxH6lASkxoFDTf5pvX
         B1iHEkvi3i+rIGiDXgyIJCa6O5EaldkP+RF+iwRscXFc+0LXEd1PvEGb6Gc5UYWVcgIp
         /N7iK2SsevfH36E6921Xy4lTM+c5XsG+cJf8/8KsGZuBGrpe7/HAYK2XnHnibAJmnPi2
         DTRTAFZ9pJGk/X46ROUgDK6uORIbwxG5kAkZ6FrsmNkHs4acrIkH7qLdkn+fm6+VrDHI
         Z80LdcZQKMc26c1sHp+3HIvjRUQ+1Z5T+scOB9xGxSkVKaoDqBqZFgE0J3lxGYq/blns
         EeTw==
X-Gm-Message-State: AOAM533E8mBH+CJ/Um98bjvjVbg3RQBsegSjrjsnS7Omuu9EYz1GHTvz
        1N5hXJZC+XAB+z7TMi25dJjUt3liNKI2Jz95mbGJGAeynZmJPX/HfGJ0FuFfuTKgdf8Iyu9mTgf
        dcMAPbfYdH62Q49P8qElQoZhs4/U=
X-Received: by 2002:a92:8702:: with SMTP id m2mr11552588ild.250.1631623700310;
        Tue, 14 Sep 2021 05:48:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzuqT9fjCr/nPfW3F4r3rrsHQMUf7Yh5bRpEOle+rAfmIT4wZcsd9Sz6OhITP7KB3WDZyhzEw==
X-Received: by 2002:a92:8702:: with SMTP id m2mr11552578ild.250.1631623700132;
        Tue, 14 Sep 2021 05:48:20 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-09-184-147-143-99.dsl.bell.ca. [184.147.143.99])
        by smtp.gmail.com with ESMTPSA id m13sm6598777ilh.43.2021.09.14.05.48.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 05:48:19 -0700 (PDT)
Date:   Tue, 14 Sep 2021 08:48:18 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     nsaenzju@redhat.com
cc:     Punit Agrawal <punitagrawal@gmail.com>,
        Peter Xu <peterx@redhat.com>, linux-rt-users@vger.kernel.org,
        williams@redhat.com
Subject: Re: [PATCH v2 2/3] oslat: Add aarch64 support
In-Reply-To: <fe15dafd9a6b6ee0d7f8a9f53e9acb6f4288046f.camel@redhat.com>
Message-ID: <99d2fe5c-5845-7b63-bb7-ea462103556@redhat.com>
References: <20210913083908.48408-1-nsaenzju@redhat.com> <20210913083908.48408-2-nsaenzju@redhat.com> <87ee9r9b5e.fsf@stealth> <fe15dafd9a6b6ee0d7f8a9f53e9acb6f4288046f.camel@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463756286-1234994261-1631623699=:4131"
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463756286-1234994261-1631623699=:4131
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Tue, 14 Sep 2021, nsaenzju@redhat.com wrote:

> On Tue, 2021-09-14 at 10:52 +0900, Punit Agrawal wrote:
> > Hi Nicolas,
> > 
> > Apologies for the late comment. I just caught up with the thread.
> 
> No worries, thanks for the input!
> 
> [...]
> 
> > > +static inline void frc(uint64_t *pval)
> > > +{
> > > +	/*
> > > +	 * This isb() is required to prevent that the counter value
> > > +	 * is speculated.
> > > +	 */
> > > +	__asm__ __volatile__("isb" : : : "memory");
> > > +	__asm__ __volatile__("mrs %0, cntvct_el0" : "=r" (*pval) :: "memory");
> > > +
> > 
> > Although the isb() ensures completion of instructions before the counter
> > is read, I think there is still the problem of speculative execution of
> > instructions after the counter read being moved forward. See the
> > examples in Arm ARM DDI 0487F.b Section D11.2.2 "The Virtual counter"
> > 
> > So from my understanding the problem would be something like below -
> > 
> > isb()
> > ...  <-  speculatively executed instructions from after the counter read
> > mrs %0, cntvct_el0
> > 
> > This would skew the counter value to a later point than what is intended
> > - a following isb() would address the issue.
> 
> For the record, here's what the Arm ARM states:
> 
>   Accesses to memory appearing in program order after the read of the counter
>   are executed before the counter has been read. [...]
> 
>   To ensure that a memory access only occurs after a read of the counter, the
>   following sequence should be used:
> 
>     MRS Xn, CNTVCT_EL0
>     ISB
>     LDR Xa, [Xb] ; this load will be executed after the timer has been read"
> 
> As stated in the commit description, I made sure the program logic can't suffer
> from this. I hadn't thought of the timing angle though. I doubt we'll see any
> difference, given we have a 1us granularity, but I don't mind adding it for the
> sake of correctness.
> 
> @John Should I send a v3 of the series or a separate patch adding the extra
> isb().
> 
> -- 
> Nicolás Sáenz
> 
> 

I already integrated and pushed your v2 patch, so you should pull the code 
from upstream and then create a new patch to add the isb()

Thanks

John
---1463756286-1234994261-1631623699=:4131--

