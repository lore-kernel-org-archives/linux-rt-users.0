Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA091C432BE
	for <linux-rt-users@archiver.kernel.org>; Fri, 27 Aug 2021 07:31:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE97360F92
	for <linux-rt-users@archiver.kernel.org>; Fri, 27 Aug 2021 07:31:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244451AbhH0Hck (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 27 Aug 2021 03:32:40 -0400
Received: from mail.nearlyone.de ([46.163.114.145]:34040 "EHLO
        mail.nearlyone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244198AbhH0Hch (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 27 Aug 2021 03:32:37 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7659860B92;
        Fri, 27 Aug 2021 09:31:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
        t=1630049508; h=from:subject:date:message-id:to:cc:mime-version:content-type:
         in-reply-to:references; bh=i+Y9JPMVRmKpUMRZlKBsnBA9ZVtGf0gZiw1ulvbySUU=;
        b=ZdVoBnOKPlIXIA+qe+lazyV2uJwU0UP4krwBcbBpOAdDztqigZ3GmOF+b3EfJInEquPdhn
        ur3iRUIytCrq62nXGH5MNXjOKClg25meQS7wHyrpnzGVFZHCFn8hueGz89uAF79L1gwIEA
        +xUMcEbdsSEFzg6gKB4EcPkWg9Cbh13knWk+sTZgTN7qp/+buHu0qaxEYu6N3n8W7SePEN
        n4j+r8uYUO01/W8sRpaP0a/oXKvmXf9lrYuPltWbuCVeMOW5NLucGz9ZkRNiU9ioaJFoGJ
        2fAfKUaKAxxl7CykbdDP8KXOkwlXYaObx1HQlBxIzb/HOO68F4JMXIrorYjQZw==
Date:   Fri, 27 Aug 2021 09:31:45 +0200
From:   Daniel Wagner <wagi@monom.org>
To:     Daniel Wagner <dwagner@suse.de>
Cc:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>, linux-rt-users@vger.kernel.org
Subject: Re: [PATCH rt-tests v3 1/1] rt-numa: Use sched_getaffinity() instead
 of pthread_getaffinity_np()
Message-ID: <20210827073145.7crjzoyw3bzago4u@carbon.lan>
References: <20210719081505.520-1-dwagner@suse.de>
 <20210719081505.520-2-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210719081505.520-2-dwagner@suse.de>
X-Last-TLS-Session-Version: TLSv1.3
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Mon, Jul 19, 2021 at 10:15:05AM +0200, Daniel Wagner wrote:
> pthread_getaffinity_np() prevents static builds as glibc does not
> expose it for this configuration. Instead use sched_getaffinity()
> directly as pthread_getaffinity_np() is just a fancy glibc wrapper
> around sched_getaffinity().
> 
> Static builds helps in in situation where the rootfs is minimal
> and does for example not ship libnuma.
> 
> The pthread_getaffinity_np call was introduced by commit
> f240656b056b ("rt-tests: cyclictest: Fix -t without a user specified
> [NUM]")

ping
