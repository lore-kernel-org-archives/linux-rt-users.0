Return-Path: <SRS0=hjoW=WL=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FC1CC3A589
	for <linux-rt-users@archiver.kernel.org>; Thu, 15 Aug 2019 13:50:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF98B208C2
	for <linux-rt-users@archiver.kernel.org>; Thu, 15 Aug 2019 13:50:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hT8/qDTo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732478AbfHONuB (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 15 Aug 2019 09:50:01 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38622 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732473AbfHONuB (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 15 Aug 2019 09:50:01 -0400
Received: by mail-wm1-f66.google.com with SMTP id m125so1309756wmm.3
        for <linux-rt-users@vger.kernel.org>; Thu, 15 Aug 2019 06:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=EauJJG/XWc+qJIkKEOF2dy9OeqC4CbeYNXOK22U7JiI=;
        b=hT8/qDToQvR8MWdum0j9OdwN1brRD5ME/temC0XP0YCeHIxe1HhzM3hrTHLEZgFp4P
         1iUTlmJRd/7RlNxL45MqOrSlsvXPAMNp6W2lNOWepvGzCFip/wqdEI/usaFHivB9dsSi
         qRHgRBtfM8z3fpKDuADg62xcRv7HD9Q/VGF215GzQtjVCi6Oj/iWbGdd4Yq9n7i5ZeoQ
         OP5VqmDpX33SZVBbdsKkAbOoNDBOmW0EphR7M+lc1BTEq3cmX//n4+nOhHkL9+viP/7q
         HWV3Wn4d7uMmRNIAHfhDa4vx/GvXD+ztY1Oyh8V6NU0c/u7wg2Kf0WfCjC/9Yg9HTzGE
         A58A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:user-agent:mime-version;
        bh=EauJJG/XWc+qJIkKEOF2dy9OeqC4CbeYNXOK22U7JiI=;
        b=tBpTdfWw6AJ7rRmdibJZL1SdhAQx6V/FNMfTQmp3JEpDfCDM0xNVeT35AiOeBi9+gW
         irgZooBDp/nGochbCkPzzgqfLHeRDObMLqRR357r9KRhK2DG3EUOoqefafF+LCoW4wxJ
         /j97wkThEijNsU9tOLivGzymHGDoQVN/Z8wJDDC1p9HcztWS+odFIl/LIvd9b2dWJqIu
         A++Z8OKWNDl7NuXgrmIGodsiO5xgxoFIJRBba7cCoqvqeCqYM3Prpz8PurAq/S301QVY
         Nfyxz3h1yBiJxzcdXho8GcE/vZR2jcigFKCyjyLA5VKWYabyCSEsF4aNxaaglnwZm6y+
         lBOA==
X-Gm-Message-State: APjAAAXOfv1+4OHzvM+LGSwJeXDEX38ovlofyydvtFz5lcIHAkLfj6/S
        Bz1pj8s3LiB/t2/nH5WvBHg=
X-Google-Smtp-Source: APXvYqy9jb1Gk5pNQJr4kg3pVGVTaqFzYOSvXGdtSevPmHhBikb6waM2EnjdzulgOrtqunPRpQWfgA==
X-Received: by 2002:a1c:7619:: with SMTP id r25mr2924057wmc.153.1565876998919;
        Thu, 15 Aug 2019 06:49:58 -0700 (PDT)
Received: from planxty ([2a02:8108:1700:19dc:b567:5617:6bc1:51bb])
        by smtp.gmail.com with ESMTPSA id f6sm3839304wrh.30.2019.08.15.06.49.57
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 15 Aug 2019 06:49:57 -0700 (PDT)
Date:   Thu, 15 Aug 2019 15:49:49 +0200 (CEST)
From:   John Kacur <jkacur@redhat.com>
X-X-Sender: jkacur@planxty
To:     Rachid Koucha <rachid.koucha@gmail.com>
cc:     williams@redhat.com, linux-rt-users@vger.kernel.org
Subject: Re: Little bug in cyclictest
In-Reply-To: <7e292a1e-b52d-e8c6-37b0-05270df81539@gmail.com>
Message-ID: <alpine.LFD.2.21.1908151544120.11513@planxty>
References: <5d169fe2-b545-ae68-a946-4e36a613cbda@gmail.com> <alpine.LFD.2.21.1908141524020.5420@planxty> <7e292a1e-b52d-e8c6-37b0-05270df81539@gmail.com>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463804494-940569165-1565876997=:11513"
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463804494-940569165-1565876997=:11513
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT



On Wed, 14 Aug 2019, Rachid Koucha wrote:

> Find attach the patch file :
> 
> $ cd rt-tests
> $ patch -p1 < ../cyclictest_affinity_check.patch
> 
> On 14/08/2019 15:25, John Kacur wrote:
> >
> > On Wed, 14 Aug 2019, Rachid Koucha wrote:
> >
> >> Hi,
> >>
> >> First of all, many thanks for such useful tools.
> >>
> >> In the source code of cyclictest, I can see a mistake concerning the
> >> error checking of pthread_setaffinity_np():
> >>
> >> Upon error, pthread functions return an error ant not -1. So, the
> >> following code:
> >>
> >>     if (par->cpu != -1) {
> >>         CPU_ZERO(&mask);
> >>         CPU_SET(par->cpu, &mask);
> >>         thread = pthread_self();
> >>         if (pthread_setaffinity_np(thread, sizeof(mask), &mask) == -1)
> >>             warn("Could not set CPU affinity to CPU #%d\n",
> >>                  par->cpu);
> >>     }
> >>
> >> should be fixed as follow:
> >>
> >> int status;
> >>
> >>     if (par->cpu != -1) {
> >>         CPU_ZERO(&mask);
> >>         CPU_SET(par->cpu, &mask);
> >>         thread = pthread_self();
> >>         if ((status = pthread_setaffinity_np(thread, sizeof(mask), &mask)) != 0)
> >>             warn("Could not set CPU affinity to CPU #%d: %s (%d)\n",                  par->cpu, strerror(status), status);
> >>     }
> >>
> >>
> >> Regards,
> >>
> > Thanks, that looks correct. Please generate a patch and I'll apply it.
> >
> > John Kacur
> 

It would be easy for me to take the attachment and apply the patch, but if 
you want to work or play in the open source world, you have to follow 
certain rules for submitting patches.

The Linux Kernel source has a lot of documentation on how to do this, look 
here if you don't know how to access that

https://www.kernel.org/doc/html/v5.0/process/submitting-patches.html

So, you're going to need to describe the changes, and give your 
signed-off-by and no attachments, you have to use plain text.

Thanks!

John Kacur
---1463804494-940569165-1565876997=:11513--
