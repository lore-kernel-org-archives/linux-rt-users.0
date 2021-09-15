Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23622C433F5
	for <linux-rt-users@archiver.kernel.org>; Wed, 15 Sep 2021 12:17:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0EDCB61244
	for <linux-rt-users@archiver.kernel.org>; Wed, 15 Sep 2021 12:17:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236487AbhIOMSf (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 15 Sep 2021 08:18:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51193 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237562AbhIOMSe (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 15 Sep 2021 08:18:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631708234;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1KYsEiBSzL8G5aqTLV+lYDqvpKLeBxPmDRiIsgOAXJM=;
        b=drL2E3F/zDDN0+ARoYjXCmLMQR+lPi/5KyFk6o3cpx1gNtA8aVofe6hRDAYMYl1BG69+f7
        MEfumdf985TKOk8LU+0RuhBAshRnk29/2mW9SEQg7+vYEH+tQtMPZ7LJYTFKgCVaKatAES
        OQuiPkCIRTSt3rGnxq+cSgbj9tZg8X8=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-601-B1Hecth_NJeYt0O6e-7SXA-1; Wed, 15 Sep 2021 08:17:11 -0400
X-MC-Unique: B1Hecth_NJeYt0O6e-7SXA-1
Received: by mail-qv1-f69.google.com with SMTP id w13-20020a05621412ed00b0037cc26a5659so2059501qvv.1
        for <linux-rt-users@vger.kernel.org>; Wed, 15 Sep 2021 05:17:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=1KYsEiBSzL8G5aqTLV+lYDqvpKLeBxPmDRiIsgOAXJM=;
        b=mqUlC3b2EVLw6r2eXkLVBMgsmC9afwKxlh9+qjPR3B+hA/TESXpHdX/LJEzRo1VK/r
         g9EcTYBImb1jwJET8xNHY2cr86PXTXtBYMRn1tlarsML8PNbOzzusOtXflpAQ/pKZenI
         ETbeGRtxz2/5iZc5o7zTmMH7A9FSPTUD9wkocnhufBJYCsHVEDnlfuxxWC1ymdJBqWcn
         VUoYnJ4JDcyvtmr2zfwlUXakbpKRYLDAieSf0snHJ+/MKpAWpYc8Iunhcy/x708XnGHQ
         1aSNgG9Htqn8XWD6lVl5Sm+ji2znptg7jwL6RcIuCJXY1PVZlI5zyRmQU4fkPxjHhIoM
         gV+g==
X-Gm-Message-State: AOAM532D/g+1gd2ngMCFBk78HXnXjr+XQrbseWdQePkhpxjtjTAO5mio
        oSaE/7Jmk797p1MRr7wRbnL9lAvsjPFjux1Rt5FZuW42b9yfZfYGcqc84pryl4hyqF0Io4OTc5D
        BsuboUhHn7AbhG0biHWXprfeWTn0=
X-Received: by 2002:a05:622a:15d0:: with SMTP id d16mr9416751qty.185.1631708230820;
        Wed, 15 Sep 2021 05:17:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx/zw3B9Fo6AHvrlWD2PVhqccXfB1irw1s3DDIYitnSpTj91NYHr9ymgMjbjPX0BoiaYD3GDw==
X-Received: by 2002:a05:622a:15d0:: with SMTP id d16mr9416741qty.185.1631708230600;
        Wed, 15 Sep 2021 05:17:10 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-09-184-147-143-99.dsl.bell.ca. [184.147.143.99])
        by smtp.gmail.com with ESMTPSA id l13sm9817155qkp.97.2021.09.15.05.17.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Sep 2021 05:17:10 -0700 (PDT)
Date:   Wed, 15 Sep 2021 08:17:08 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Punit Agrawal <punitagrawal@gmail.com>
cc:     punit1.agrawal@toshiba.co.jp, linux-rt-users@vger.kernel.org
Subject: Re: [PATCH 3/5] rteval: kernel.py: Add support for kthreads running
 with deadline policy
In-Reply-To: <87v9326xd5.fsf@stealth>
Message-ID: <3382122d-6381-c664-af6e-461f7b992be@redhat.com>
References: <20210901080816.721731-1-punitagrawal@gmail.com> <20210901080816.721731-4-punitagrawal@gmail.com> <3ec9f755-404c-88b4-8efb-a29fb18f392@redhat.com> <87v9326xd5.fsf@stealth>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Wed, 15 Sep 2021, Punit Agrawal wrote:

> Hi John,
> 
> John Kacur <jkacur@redhat.com> writes:
> 
> > On Wed, 1 Sep 2021, Punit Agrawal wrote:
> >
> >> From: Punit Agrawal <punit1.agrawal@toshiba.co.jp>
> >> 
> >> When running rteval on a system with kthreads running with "deadline"
> >> policy, an exception is encountered when parsing the output of "ps".
> >> 
> >>     [DEBUG] cmd: /usr/bin/ps -eocommand,pid,policy,rtprio,comm
> >>     Traceback (most recent call last):
> >>     ...
> >>       File "...rteval/rteval/sysinfo/kernel.py", line 60, in kernel_get_kthreads
> >> 	ret_kthreads[v[0]] = {'policy' : policies[bytes.decode(v[1])],
> >>       KeyError: 'DLN'
> >> 
> >> The kernel uses deadline policy for "schedutil" cpufreq governor
> >> threads. Fix the crash in rteval by adding support for "deadline" to
> >> the list of policies.
> >> 
> >> Signed-off-by: Punit Agrawal <punit1.agrawal@toshiba.co.jp>
> >> ---
> >>  rteval/sysinfo/kernel.py | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >> 
> >> diff --git a/rteval/sysinfo/kernel.py b/rteval/sysinfo/kernel.py
> >> index 97ad9402b13e..f2e9d72ac2ef 100644
> >> --- a/rteval/sysinfo/kernel.py
> >> +++ b/rteval/sysinfo/kernel.py
> >> @@ -44,7 +44,7 @@ class KernelInfo:
> >>  
> >>  
> >>      def kernel_get_kthreads(self):
> >> -        policies = {'FF':'fifo', 'RR':'rrobin', 'TS':'other', '?':'unknown'}
> >> +        policies = {'DLN': 'deadline', 'FF':'fifo', 'RR':'rrobin', 'TS':'other', '?':'unknown'}
> >>          ret_kthreads = {}
> >>          self.__log(Log.DEBUG, "getting kthread status")
> >>          cmd = '%s -eocommand,pid,policy,rtprio,comm' % getcmdpath('ps')
> >> -- 
> >> 2.32.0
> >> 
> >> 
> >
> > Signed-off-by: John Kacur <jkacur@redhat.com>
> 
> It looks like this patch and the other one converting hackbench memory
> check to a warning was missed when applying the rest of the series -
> John, could you please pick these as well.
> 
> Thanks,
> Punit
> 

I added the patch to support deadline policy, the other one had already 
been added, I just hadn't pushed upstream yet, but I just did so, so go 
ahead and pull.

John

