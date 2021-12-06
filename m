Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55505C433EF
	for <linux-rt-users@archiver.kernel.org>; Mon,  6 Dec 2021 09:53:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241569AbhLFJ5I (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 6 Dec 2021 04:57:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241535AbhLFJ5I (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 6 Dec 2021 04:57:08 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6A72C061746
        for <linux-rt-users@vger.kernel.org>; Mon,  6 Dec 2021 01:53:39 -0800 (PST)
Date:   Mon, 6 Dec 2021 10:53:36 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1638784417;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=M5JydUcDGhqwlCWeai7mvg75YN21+KkgwffU7KjOpFA=;
        b=mSZSLuf7VSyyGTu2qxf3uXHQ+KK9Z83CLnSDsQE/C+8Ai9RsLBzCyk6HmPh64zN+5p6A56
        gCOBuSWwOTbWeXRWpUxefL57Uhzi51ABXksnBaI1NvVqa9WopWgWXU21gAqaiPY6zWyhxR
        vDNsbbeCqL7whs1+DKF+zm1ybbcKav2funQYCQmvu77VhvIvZum+fLKdvqpTppjlLidrzr
        bKuqQ/tj5p06BJEB0I7ij0ium0ilamFusSDU7/a+GI/wie3y8ORGUsndKaZCY3/RA1KPod
        +IoLQ3JZyy1HoWU2SJJh0efULzWscU67L713PqZOh53qPpysdXzsXmeHbfgwzA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1638784417;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=M5JydUcDGhqwlCWeai7mvg75YN21+KkgwffU7KjOpFA=;
        b=qDH7V1vy+7Cu5NCMhp7Nx5AffQ7hRUhl0ZLIz/04zYPUYoiWG++d00qWNyUYJgT1FJXoDC
        fm4KZLbXqHGRUsBA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "S. Baerwolf" <stephan@matrixstorm.com>
Cc:     linux-rt-users@vger.kernel.org
Subject: Re: [ANNOUNCE] 5.10.83-rt58
Message-ID: <20211206095336.6dulalbdphfxwt74@linutronix.de>
References: <YalDQe/lyXqAxB0K@uudg.org>
 <06a8466c-9962-4caf-51c2-1cc79c1205e6@matrixstorm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <06a8466c-9962-4caf-51c2-1cc79c1205e6@matrixstorm.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2021-12-05 12:49:27 [+0000], S. Baerwolf wrote:
> Where can I get your RSA publickey
> "9354064999728D31D464D140F394A423F8E67C26" for verification?

All keys used for the uploads are located in a repository at
   git://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git

> BR Stephan

Sebastian
