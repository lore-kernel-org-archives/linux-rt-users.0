Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECA69C43334
	for <linux-rt-users@archiver.kernel.org>; Fri, 15 Jul 2022 16:25:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232953AbiGOQZ2 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 15 Jul 2022 12:25:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232537AbiGOQZ1 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 15 Jul 2022 12:25:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6DD27459A4
        for <linux-rt-users@vger.kernel.org>; Fri, 15 Jul 2022 09:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657902325;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=C/jpnED633ZsSP1NNP2cdcCa2WPIYMcmmwldeae0ovE=;
        b=dxiEAU03GZVbTQVjY1ZjLiX/RGQhIv+EoJlIZnXrWXCT7EytEmeBNh/7YZRWe3zk4kRXfp
        1ztmthHFxxoHq0amx6LD19vmiLzqwXpFSsC79L2nCVVZQMMT6ewQQLDH/j5MQvFxFB1bVW
        YBrjTucDU+xaqWUNkNJFdi97FH2DaB8=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-7-QTcPjr5SNqy46NO02SNL-w-1; Fri, 15 Jul 2022 12:25:24 -0400
X-MC-Unique: QTcPjr5SNqy46NO02SNL-w-1
Received: by mail-qt1-f198.google.com with SMTP id u10-20020ac858ca000000b0031eb2399323so3910169qta.16
        for <linux-rt-users@vger.kernel.org>; Fri, 15 Jul 2022 09:25:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=C/jpnED633ZsSP1NNP2cdcCa2WPIYMcmmwldeae0ovE=;
        b=MUXcybfzH/amxpLpPFtI3XQkAMt6l9j/ay+y704DDNwmG+1xMGNqUAtsNTCj/i4Fly
         d6n5YNlB7TcNVHSlm1z9PjEXxkEW/TqH1VIAhMKdizbLMDJg3nKVK1rf/XhbmkBILmdH
         N0OQWnr8lyLVLcJvkicM1oEgOlWeNiQknuxFZcXd0R/rAuJwcXTaAbTQXAmgKAo/9BFz
         1OMI+NDc2rtucBZmH+Yly97DZM8RCsE3Ib8AEyqE9mAcc9FWgrKdIjLkYfkCTegHH4bY
         QdF1F2DRgNbB2jmFTfMxV7Itw5zJEPhQ9GjcEQuTmxHlBDcXr99Crp5hBHWMFJaioCM7
         h3yg==
X-Gm-Message-State: AJIora9xJlk3xh+bDcfVAxVChqaTOyLcEKbZiJcO2IXoJY7b0N8VDhUk
        dSvG4jILJBQamJKIEhqOZwZQ5nrpcgDpae3y8VVfuDCsvA6ACPiHiDN/O8CiF3S5sT2BzUSxys0
        UzsEU4LHA+P34sixpkgddXrgmtPU=
X-Received: by 2002:a05:620a:254e:b0:6b4:8dd1:e4b6 with SMTP id s14-20020a05620a254e00b006b48dd1e4b6mr10647402qko.39.1657902323384;
        Fri, 15 Jul 2022 09:25:23 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tO7J7z7h3AoFGODQSgxM5h6UQrVEcQZtHl8dFnNkXcfqsjcVvN0EXfE2zHcxdhHhtZe0i0iQ==
X-Received: by 2002:a05:620a:254e:b0:6b4:8dd1:e4b6 with SMTP id s14-20020a05620a254e00b006b48dd1e4b6mr10647387qko.39.1657902323109;
        Fri, 15 Jul 2022 09:25:23 -0700 (PDT)
Received: from lleshchi.bos.csb (cpe-24-198-132-134.maine.res.rr.com. [24.198.132.134])
        by smtp.gmail.com with ESMTPSA id x9-20020a05620a448900b006b59f4f66d6sm4287464qkp.112.2022.07.15.09.25.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jul 2022 09:25:22 -0700 (PDT)
Date:   Fri, 15 Jul 2022 12:25:20 -0400
From:   Leah Leshchinsky <lleshchi@redhat.com>
To:     Manasi Godse <magodse@redhat.com>
Cc:     jkacur@redhat.com, linux-rt-users@vger.kernel.org,
        kcarcia@redhat.com
Subject: Re: [PATCH] rteval: Add option for downloading kernel
Message-ID: <YtGU8IgVtQoYbyiq@lleshchi.bos.csb>
References: <20220713202531.398854-1-magodse@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220713202531.398854-1-magodse@redhat.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Tested with -S options linux-5.19-rc6, linux-5.17.1.tar.xz, linux-5.17.1.tar.gz, linux-5.17.1, 5.17.1,
results in proper download. Errors properly when -S option specified without argument.
Error message produced when kernel version specified is already downloaded. Option to overwrite properly
creates .bkup file in directory while download is in process, and deletes .bkup file once download is complete.
su -c "./rteval-cmd --duration=1s -S linux-5.17.1.gz -S linux-5.18.1"
results in evaluation of second argument. When download matches default kernel, does not download kernel again.
Various misspellings are also handled (llinux--5.17.1..gz). Not found versions result in error message.

Currently, the program exits after the download is complete. Future improvements may include allowing for additional
actions once the -S option is executed.

Tested-by: Leah Leshchinsky <lleshchi@redhat.com>

