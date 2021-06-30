Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6531C11F67
	for <linux-rt-users@archiver.kernel.org>; Wed, 30 Jun 2021 03:05:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96BFA61945
	for <linux-rt-users@archiver.kernel.org>; Wed, 30 Jun 2021 03:05:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232417AbhF3DIK (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 29 Jun 2021 23:08:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:46253 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232067AbhF3DIJ (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 29 Jun 2021 23:08:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625022340;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rxIFx6C3+QRwKG1nZIdSQtYB1eztOHu7LSbWEXAADy0=;
        b=GFNLuosYhPNIK8/c5zZYK2iyKJuX0y4c8GcxAHGuNlithimbygSBczj18HINI5WXxb3Lzm
        p8fh9jYPCGIrqwCmlGSe3wmpFuc1d3o2mEIPq9jtKMJiesu+wvVez4Of41EGYQjLM3zy+U
        kzJuiF8mtfHg1Q8xeRjR4yHWdkH4rys=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-244-5lFYWWB3NGeRPPs1trXY4Q-1; Tue, 29 Jun 2021 23:05:39 -0400
X-MC-Unique: 5lFYWWB3NGeRPPs1trXY4Q-1
Received: by mail-qv1-f72.google.com with SMTP id u40-20020a0cb9280000b0290290c3a9f6f1so451339qvf.0
        for <linux-rt-users@vger.kernel.org>; Tue, 29 Jun 2021 20:05:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=rxIFx6C3+QRwKG1nZIdSQtYB1eztOHu7LSbWEXAADy0=;
        b=MoxAPkLxYRWGs79Fqf/DLOX+FlFe403B0K3iETTTQKbzYWeG8sVb6axdECGKpFbCqF
         7Lf3lWKGLABmgKkEaEk4//mJci+pNnQZwh8tHFjOUxVbr+QhCOYtjiaSYkewYNLAm3EJ
         F65kNBVKwlG25pLixT5Q3njiihq8d2rU/CYYFAvRb5+wNCZb6bLnKGe1Xms8jQbFqn9x
         EwwNbxYVwO9bgz+NumGC8feWrRl1mv+xxLvGNpyrLtgLy7pJpCSx1NPiebY+PRSezosy
         Vs5SZ02DipCYEVZr6GNTXC5UOSqtbJUNglnLw0/tSaTP+MGbjlS9v18Ij0CS6hJMbJ7W
         17yA==
X-Gm-Message-State: AOAM532DxiEvhIHCOhIo0lsYTRmT+v5dDNHwi/PCDdj7fny0WP0DkUi0
        H9eL5V+kp4LSm8//dlSHcklD0hPnaRaCSR1Cun3CU+ZTk0m/4Xd3ZFCe1UzfL2Bx+n92eAY4kmY
        Op6ywhny32urrsJBkN2CCP+RgVTo=
X-Received: by 2002:a37:b85:: with SMTP id 127mr34580798qkl.2.1625022338697;
        Tue, 29 Jun 2021 20:05:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw057WesQ3/Io6rBk1rpG7YmiOha5HKrs94zlOP7DOpM4RQ3Ge1OB9BTNq3wDBFx2M4tyGatA==
X-Received: by 2002:a37:b85:: with SMTP id 127mr34580789qkl.2.1625022338570;
        Tue, 29 Jun 2021 20:05:38 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-10-174-88-120-156.dsl.bell.ca. [174.88.120.156])
        by smtp.gmail.com with ESMTPSA id p64sm6454395qka.114.2021.06.29.20.05.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jun 2021 20:05:38 -0700 (PDT)
Date:   Tue, 29 Jun 2021 23:05:37 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Kurt Kanzenbach <kurt@linutronix.de>
cc:     Daniel Wagner <dwagner@suse.de>,
        Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org, Mike Galbraith <efault@gmx.de>
Subject: Re: [PATCH rt-tests v1 1/2] rt-utils: Call get_timestmap() in
 rt_init()
In-Reply-To: <87r1gl6uhm.fsf@kurt>
Message-ID: <801072c7-a6c9-ccb0-471-d89d51b2cc3d@redhat.com>
References: <20210628201203.30974-1-dwagner@suse.de> <20210628201203.30974-2-dwagner@suse.de> <87r1gl6uhm.fsf@kurt>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Tue, 29 Jun 2021, Kurt Kanzenbach wrote:

> Hi Daniel,
> 
> On Mon Jun 28 2021, Daniel Wagner wrote:
> > Move the get_timestamp() from rt_test_start() to rt_init(). The idea
> > of rt_test_start() was to get the start timestamp right before the
> > 'main loop' for the test starts. At least for cyclictest the
> > rt_test_start() was placed wrongly so that the first test cycle could
> > hit the pagefault when strftime() wrote into the tsbuf.
> >
> > We don't have an exact semantic description what start test timestamp
> > means, so the simplest thing to avoid any further problems with it, is
> > to take the timestamp right at the beginning when the program
> > starts. Most test programs have a very short setup phase anyway.
> >
> > Reported-by: Mike Galbraith <efault@gmx.de>
> > Signed-off-by: Daniel Wagner <dwagner@suse.de>
> 
> This fixes the issue for me:
> 
> Tested-by: Kurt Kanzenbach <kurt@linutronix.de>
> 
> Thanks,
> Kurt
> 

thanks, added

