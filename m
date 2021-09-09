Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CB92C433F5
	for <linux-rt-users@archiver.kernel.org>; Thu,  9 Sep 2021 09:41:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32E3B611AF
	for <linux-rt-users@archiver.kernel.org>; Thu,  9 Sep 2021 09:41:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233055AbhIIJmj (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 9 Sep 2021 05:42:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:28457 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229927AbhIIJmi (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 9 Sep 2021 05:42:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631180489;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ch7qu9gF4mPGDdIwI/DTv52Z3TPZB2MKLEUroo+Ya1Q=;
        b=UQGsAV7TWqYZNHV2OKCRJzfVGcU9UN3IWFQ7ofsDfuvbYoyl3k/nWlUHxk0bPQeL3OsiPG
        KwPE4m4TkgEzJCPUemVlCwaPVqmuMpH5J3BLSww98MBKroO8LXhe7u2/91EP92fKfZ34XK
        otiq19bjhjXaltJmH3AfSkoiIp8G6js=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-20-tJcIahjAM-6qh7iEo5xREA-1; Thu, 09 Sep 2021 05:41:26 -0400
X-MC-Unique: tJcIahjAM-6qh7iEo5xREA-1
Received: by mail-wr1-f69.google.com with SMTP id d10-20020adffbca000000b00157bc86d94eso320338wrs.20
        for <linux-rt-users@vger.kernel.org>; Thu, 09 Sep 2021 02:41:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=Ch7qu9gF4mPGDdIwI/DTv52Z3TPZB2MKLEUroo+Ya1Q=;
        b=G52P+MmFmMY48hR3yzvr+cwnBA0bFvDYfsnuOj5e1ZbA4UI+7hFtCTMMyd2dDu7G3I
         BrylA0g4pTLun1aefi66xLy6qts+ry9MjNsTXnYcqczglg3WClYCSUQ5TeHEvMVfwfUl
         mrDXLB+w0TwCOFdOhLXw5tyml2H4alA/RT5NBK5T8BBLU2MGzGR9l2DQmhQSMmh4/c6d
         HiaiyG3jOv75AvCZZK8H1VZZPhvLybaTuvTP7ZcFI3c16gjejxyAKzYstfQRVPjoTitF
         EyWXEx6956XtE8Ia6m9HyX/Da+0dt90D9QHMc4YglRMduW5EtUfqszjOkDKqMdL8f4/Z
         rd4w==
X-Gm-Message-State: AOAM532/u1us9phRJjo2Ka3bsmuwXP3oacus2k/GHkwtptMt9aXojDF7
        wyAOu22boYkTh228W258ImIl1/pzVvc3tlYT/BMgehQW8GYOdQcfJU9kpQ5yW75OVr40RUw9CrA
        Ssi0YVsxIL7o9x5BNoem6DeuMJLc=
X-Received: by 2002:a7b:c7d4:: with SMTP id z20mr1938328wmk.172.1631180485177;
        Thu, 09 Sep 2021 02:41:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyCk5iCEHhNmDkHyvkcmTmwTDbY+knsqTO6FV+w9V7D+XWxYssL6RZ20047t+Pjsli7K/roIg==
X-Received: by 2002:a7b:c7d4:: with SMTP id z20mr1938319wmk.172.1631180484991;
        Thu, 09 Sep 2021 02:41:24 -0700 (PDT)
Received: from ?IPv6:2a0c:5a80:3811:7600:8004:a383:c7c9:7f11? ([2a0c:5a80:3811:7600:8004:a383:c7c9:7f11])
        by smtp.gmail.com with ESMTPSA id m1sm1053768wmq.10.2021.09.09.02.41.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 02:41:24 -0700 (PDT)
Message-ID: <c6f2c1e5f3b41714349373278b64aac91c5c35fc.camel@redhat.com>
Subject: Re: [PATCH 1/3] oslat: rename cpu_mhz/cpu_hz to timer_mhz/cpu_hz
From:   nsaenzju@redhat.com
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, williams@redhat.com,
        jkacur@redhat.com
Date:   Thu, 09 Sep 2021 11:41:22 +0200
In-Reply-To: <YTj4Pb0peVbzFQQa@t490s>
References: <20210908100209.118609-1-nsaenzju@redhat.com>
         <YTjLaZez4azBeYLI@t490s>
         <dc800f41878a9240cc9b9629ed1a4c1551514fac.camel@redhat.com>
         <YTj4Pb0peVbzFQQa@t490s>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Wed, 2021-09-08 at 13:51 -0400, Peter Xu wrote:
> On Wed, Sep 08, 2021 at 06:30:50PM +0200, nsaenzju@redhat.com wrote:
> > Hi Peter, thanks for having a look at this! And sorry in advance for the long
> > documentation dump.
> 
> It's actually great to reference the documents, thanks for that. I'd appreciate
> if you can also add some more explanation into commit message too, may not be
> the full copy-paste of the document though, just with the explicit x86/ppc
> examples to show this is not for arm-only idea?

Will do.

> Note there's a typo in subject too:
> 
>   oslat: rename cpu_mhz/cpu_hz to timer_mhz/cpu_hz
>                                             ^^^ timer

Noted.

> > 
> > On Wed, 2021-09-08 at 10:40 -0400, Peter Xu wrote:
> > > Hello, Nicolas,
> > > 
> > > On Wed, Sep 08, 2021 at 12:02:07PM +0200, Nicolas Saenz Julienne wrote:
> > > > 'cpu_mhz' in oslat actually represents the frequency at which the high
> > > > frequency timer we measure with ticks. There is no need for it to match
> > > > the CPU frequency, nor will do on all supported architectures. So rename
> > > > it to 'timer_mhz' in order to better match reality.
> > > 
> > > But right now "cpu_mhz" is indeed the cpu frequency per mhz, isn't it?  As I
> > > believe that's how "time stamp counter" defined on x86. :)
> > 
> > Sadly I don't think this is really the case. In some cases TSC might match
> > CPU's base frequency, but it depends on the processor family and other
> > factors[1]. Also, the same applies for PPC64[2].
> > 
> > My reading is that, in general, we are only safe to assume we're getting a
> > constant monotonically increasing timer unrelated from CPU's actual frequency.
> > 
> > > I don't know what's the corresponding register for aarch64 to read the
> > > processor clock cycles out, I did a quick google and it tells me PMCCNTR, but
> > > I've no solid idea.  Or do you mean for some reason we can't read that info out
> > > from aarch64?
> > 
> > Sadly PMCCNTR isn't available at Exception Level 0 (user-space) and AFAIU we're
> > stuck with CNTVCT_EL0.
> 
> Fair enough.
> 
> Though I still think the name "timer" is vague - timer normally means to me
> that there's a setup+invoke procedure, and there can be overhead.  While all
> these monotonically increasing registers (either real or virtual) should not
> have those, we just read some counter out.
> 
> How about "clock_[m]hz"?  It does not necessarily to be a property of the
> processor, but it's indeed a clock at least in electronics terms.

How about 'counter_[m]hz'? If not I'm fine with 'clock_[m]hz'.

-- 
Nicolás Sáenz

