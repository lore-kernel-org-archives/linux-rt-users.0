Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E4B2C433E2
	for <linux-rt-users@archiver.kernel.org>; Mon, 22 Mar 2021 15:51:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 661E2619A9
	for <linux-rt-users@archiver.kernel.org>; Mon, 22 Mar 2021 15:51:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbhCVPul (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 22 Mar 2021 11:50:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbhCVPu0 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 22 Mar 2021 11:50:26 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED80BC061574
        for <linux-rt-users@vger.kernel.org>; Mon, 22 Mar 2021 08:50:25 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id l13so12640410qtu.9
        for <linux-rt-users@vger.kernel.org>; Mon, 22 Mar 2021 08:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=Ae0gLiv4DvfDsc5UvHvmSZ9ZeIJF8+gRsXqf0px48BQ=;
        b=pPMriVj0xOQYl9d/Hed1OaNgFR3wCGbioHUz2Fu9hL/xPgLZOMQKfqBvq8uDI/zNEc
         3GHtuKW/ckFU6e2Ru6XAN9qjkIjDaRZBRukO3i7YIIKzA5V9f87665sI6+ZXIqktQo8y
         3T/NQOAYImhBgd0iuN1dFZm9QhBlj2TSc1l3Syipyy9TmzADJGaEs+WMeVOXqHRhY1x0
         ouD2POKBfJAfXiSCj4/UNZQN7qckEEn8wJsyrZSVzSF2i2jGRPDVd9/REn8aNS8GLFbu
         R/yF8sIIk12+h+Q/03k35p762OeKx92WEBFgmvE/wVnun0FP1E0e1EKc4AJjy40nx2hd
         alWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:mime-version;
        bh=Ae0gLiv4DvfDsc5UvHvmSZ9ZeIJF8+gRsXqf0px48BQ=;
        b=WxEiVGdHw4XQMzDIc12cmhWOQlGAg+4tjpq9bY1v//tnUDkawBHXX85n31tlFVXm1e
         4jvsytQkONgMKUraXpwOa+8Jm+i8VhV5liYw0Vxhg39qDvYWJgWms/lUn7B9lL+24XCF
         +/B/qGSze/+phy1B1IVmy61cz0l/Ao8Wx1vdV4+8f+S3iBpJkG67ZtNWwbF5wpoi7wdK
         ezdD23xJNM2BwQQ+Oxrfak2GjOylnczh3j64ktw0wL88jxUgK8AHJFSYPYU+Yiys7mai
         lVEY7t/RRL1FggUIdy8V9MP5qhmUpON1xCyerBkjkjNmHvGPiVDYt1sF7xHGtVuER+mh
         gkxg==
X-Gm-Message-State: AOAM5323mAdU33yhklvmAvJN6wbZBPbU/HVJPrKtYgbK2vupdK0oVjpP
        khUanOj89+Sn/gKEcwtjISY=
X-Google-Smtp-Source: ABdhPJy3azZdLterrvoR6tEqC31ImT2+pIADKmRdaQkNhi02ghbP0kwQnSsc9OzCtITpgftZlyO1CQ==
X-Received: by 2002:a05:622a:1192:: with SMTP id m18mr480435qtk.27.1616428225208;
        Mon, 22 Mar 2021 08:50:25 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-06-184-147-140-29.dsl.bell.ca. [184.147.140.29])
        by smtp.gmail.com with ESMTPSA id o36sm8200637qtd.89.2021.03.22.08.50.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 08:50:24 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
Date:   Mon, 22 Mar 2021 11:50:18 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Daniel Wagner <dwagner@suse.de>
cc:     Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH rt-tests v3 00/33] JSON cleanups and more tests updated
In-Reply-To: <20210320183829.1318-1-dwagner@suse.de>
Message-ID: <535838-37b6-d43c-b147-cb4c5528c4ff@redhat.com>
References: <20210320183829.1318-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Sat, 20 Mar 2021, Daniel Wagner wrote:

> v3:
>   - rebase
>   - two patches splitted into per test program change
>   - commit messsage added
>   
> v2:
>   - added 'return_code' to the common section of the JSON output
>   - dropped 'inversion' as we have 'return_code' in pip_stress
>   - dropped 'success' as we have 'return code in ssdd
> 
> All patches are also available at:
> 
>   https://github.com/igaw/rt-tests/tree/json-output-2021-03-20
> 
> Daniel Wagner (33):
>   cyclictest: Remove unused include header
>   cyclicdeadline: Remove unused include header
>   signaltest: Add missing --output usage info
>   rt-util: Add rt_init function
>   cyclictest: Initialize rt-util
>   oslat: Initialize rt-util
>   pmqtest: Initialize rt-util
>   ptsematest: Initialize rt-util
>   rt-migrate-test: Initialize rt-util
>   cyclicdeadline: Initialize rt-util
>   signaltest: Initialize rt-util
>   sigwaittest: Initialize rt-util
>   svematest: Initialize rt-util
>   rt-util: Remove superfluous arguments from rt_write_json
>   rt-util: Introduce rt_test_start()
>   cyclictest: Record start of test execution
>   oslat: Record start of test execution
>   pmqtest: Record start of test execution
>   ptesematest: Record start of test execution
>   rt-migrate-test: Record start of test execution
>   cyclicdeadline: Record start of test execution
>   signaltest: Record start of test execution
>   sigwaittest: Record start of test execution
>   svsematest: Record start of test execution
>   rt-util: Add return_code to common section of JSON output
>   pip_stress: Move test result output to main
>   pip_stress: Return failure code if test fails
>   pip_stress: Prepare arg parser to accept only long options
>   pip_stress: Add JSON output feature
>   pi_stress: Prepare command line parser for long options only
>   pi_stress: Add JSON output feature
>   ssdd: Add quiet command line option
>   ssdd: Add JSON output feature
> 
>  src/cyclictest/cyclictest.c           |  5 +-
>  src/include/rt-utils.h                |  6 +-
>  src/lib/rt-utils.c                    | 85 ++++++++++++++++-----------
>  src/oslat/oslat.c                     |  6 +-
>  src/pi_tests/pi_stress.c              | 65 ++++++++++++++++----
>  src/pi_tests/pip_stress.c             | 40 +++++++++----
>  src/pmqtest/pmqtest.c                 |  4 +-
>  src/ptsematest/ptsematest.c           |  4 +-
>  src/rt-migrate-test/rt-migrate-test.c |  4 +-
>  src/sched_deadline/cyclicdeadline.c   |  6 +-
>  src/signaltest/signaltest.c           |  5 +-
>  src/sigwaittest/sigwaittest.c         |  4 +-
>  src/ssdd/ssdd.c                       | 43 +++++++++++---
>  src/svsematest/svsematest.c           |  4 +-
>  14 files changed, 199 insertions(+), 82 deletions(-)
> 
> -- 
> 2.30.2
> 
> 

Thanks Daniel! On this right away.

John
