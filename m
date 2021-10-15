Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ADE3C433F5
	for <linux-rt-users@archiver.kernel.org>; Fri, 15 Oct 2021 13:08:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25BD560F9D
	for <linux-rt-users@archiver.kernel.org>; Fri, 15 Oct 2021 13:08:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239242AbhJONKJ (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 15 Oct 2021 09:10:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54613 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239196AbhJONKI (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 15 Oct 2021 09:10:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634303282;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bZ06J7qlL1UbGo2O7Ptb0LzmibUfdwoD4Qf7q+xIQWk=;
        b=JUYcEpnfsmBQ2Zwsz07JgOxiEw+bv7m+LP3WXscAw7NC07lBWaknKHXAnI9BeEeuN+Tq6z
        nNSdAXdSw0fRTpDDrVSyLtFYSLHFz3nfeeYuy1EVyK7SsYlzOIIPa67iqaxBKXMzttaA7U
        oDSKe6Ba+wl2iFMKi3q6wpFDklTYeGw=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-459-hQa2Q8GvOxm5J5GW5F4o4A-1; Fri, 15 Oct 2021 09:08:00 -0400
X-MC-Unique: hQa2Q8GvOxm5J5GW5F4o4A-1
Received: by mail-il1-f197.google.com with SMTP id c11-20020a928e0b000000b0024eb114af51so4125300ild.22
        for <linux-rt-users@vger.kernel.org>; Fri, 15 Oct 2021 06:08:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=bZ06J7qlL1UbGo2O7Ptb0LzmibUfdwoD4Qf7q+xIQWk=;
        b=omXRS9sIbAc+1Vw9ZFumG1xludMnIsHiTobHsEigrryCzkUug6fOAtjm0hWP0QUoOk
         YDUqGKOrU1RDxNUwEROI7lOGavz6VrARfH2aLAviKU+nMV8dlGCatsJOYcylMjWXddIR
         BbDUJ5nb+O2vDy4mfzWeYaA26taLIqikQ1WlLNvG/VbeQhm5xzCkdVLD8dBBD/zJv5vr
         yvIyPizueY1/KHDjo1j9xz97CUM8jf1Km8BzsE7Us2fLXpRGws8Ozv+UuckpQdTCgkEi
         Dv6BqIoKptZ5sV8hygLvzREcnaQPMEA1fyCKmJdk16bUUxpY5ojBhjeOw7T8UCQXJY7X
         bptw==
X-Gm-Message-State: AOAM533m3rOLXePvvh5szVen5qLwPp83ef9o/ks3XhCcmxq+0zuMHQ6y
        14yJHmdvJMPPeijytbT8UQX61csBE1lh1FKHQGfHx1Hdp+2a4IKpb30EmBQ4//3NUKsp8zz8nq7
        xyXxXSF9rzof9Z7ugU0dnGIhZiQo=
X-Received: by 2002:a6b:208:: with SMTP id 8mr3743022ioc.46.1634303280230;
        Fri, 15 Oct 2021 06:08:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzg34YejlcjsncDSCoTZzlXs8BfFiM/v+F1ykKTal1tRPuqEO6euR5QgjFu5LSxlYI31shv3w==
X-Received: by 2002:a6b:208:: with SMTP id 8mr3742998ioc.46.1634303280008;
        Fri, 15 Oct 2021 06:08:00 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-09-184-147-143-99.dsl.bell.ca. [184.147.143.99])
        by smtp.gmail.com with ESMTPSA id e14sm2565994ioe.37.2021.10.15.06.07.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 06:07:59 -0700 (PDT)
Date:   Fri, 15 Oct 2021 09:07:57 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Punit Agrawal <punitagrawal@gmail.com>
cc:     Punit Agrawal <punit1.agrawal@toshiba.co.jp>, williams@redhat.com,
        linux-rt-users@vger.kernel.org
Subject: Re: [RFC 4/7] rt-tests: cyclictest: Drop unnecessary variable
 "bufsize"
In-Reply-To: <87lf2u1znk.fsf@stealth>
Message-ID: <f679a887-7257-ee54-c6c9-8330feacdf4@redhat.com>
References: <20211014071247.4165329-1-punitagrawal@gmail.com> <20211014071247.4165329-5-punitagrawal@gmail.com> <d6cff5d3-1a9b-2b92-6a10-65b3b3af7d89@redhat.com> <87lf2u1znk.fsf@stealth>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Fri, 15 Oct 2021, Punit Agrawal wrote:

> John Kacur <jkacur@redhat.com> writes:
> 
> > On Thu, 14 Oct 2021, Punit Agrawal wrote:
> >
> >> From: Punit Agrawal <punit1.agrawal@toshiba.co.jp>
> >> 
> >> Two copies of "bufsize", initialised with the same value are declared
> >> in enclosed blocks. Remove the redundant declaration.
> >> 
> >> Signed-off-by: Punit Agrawal <punit1.agrawal@toshiba.co.jp>
> >> ---
> >>  src/cyclictest/cyclictest.c | 1 -
> >>  1 file changed, 1 deletion(-)
> >> 
> >> diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
> >> index 721d242a1da0..9c67a3ce3034 100644
> >> --- a/src/cyclictest/cyclictest.c
> >> +++ b/src/cyclictest/cyclictest.c
> >> @@ -2054,7 +2054,6 @@ int main(int argc, char **argv)
> >>  			memset(stat->values, 0, bufsize);
> >>  			par->bufmsk = VALBUF_SIZE - 1;
> >>  			if (smi) {
> >> -				int bufsize = VALBUF_SIZE * sizeof(long);
> >>  				stat->smis = threadalloc(bufsize, node);
> >>  				if (!stat->smis)
> >>  					goto outall;
> >> -- 
> >> 2.32.0
> >> 
> >> 
> > NACK: two different scopes, two different variables.
> 
> If they had different values or if the inner scope was not dependent
> (nested) I would agree.
> 
> But no strong opinion - I'll drop this one.
> 

I had another look at this and realize that I am wrong.
bufsize is just a buffer size passed to threadalloc
which does the malloc which gives the two different addresses we
are concerned with. Go ahead and submit this one and I'll sign-off
on it.

Thanks

John



