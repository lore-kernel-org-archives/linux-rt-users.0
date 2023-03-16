Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B04B4C7618A
	for <linux-rt-users@archiver.kernel.org>; Thu, 16 Mar 2023 07:09:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbjCPHJo (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 16 Mar 2023 03:09:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbjCPHJY (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 16 Mar 2023 03:09:24 -0400
Received: from mail.nearlyone.de (mail.nearlyone.de [IPv6:2a01:4f8:1c1e:abde::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6559EACB89;
        Thu, 16 Mar 2023 00:09:01 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 44D4DDACE8;
        Thu, 16 Mar 2023 08:08:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
        t=1678950535; h=from:subject:date:message-id:to:cc:mime-version:content-type:
         in-reply-to:references; bh=Z7oCDIHNrtzpdbzXpbRVaq82NCnKSNTk39HFZI1OEp0=;
        b=kuhFkgIt74my2CoyM/p9yMdIb35whS6x3ciUsSS8wZdUN/eun1EGdieLEae/TSBmEXhzSe
        JmNM8mFD+CAPwIVJcdubytkLN19pyC430iIJw5SftpKx2XJ8B4U0pC4a998IdL+YDIuMg+
        2sRftpokccMC7bRqRaNKoshST7o36YBKAYqUYmM/NdfE4FULO0SFTdNL5Y1DbiAIiDLqHc
        W12WtkFnovCWjeOEYIphUMNfizTNd/pZVMcnB36nFu15IUDooV1ADyiQCSi3uy1Dege+DC
        Yo1ghRydIjPZHgBjJsoM870T+qpLSpkCmRPhCIpSqs5zRBCRn6VAXup21zwk4Q==
Date:   Thu, 16 Mar 2023 08:08:50 +0100
From:   Daniel Wagner <wagi@monom.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     "Brennan Lamoreaux (VMware)" <brennanlamoreaux@gmail.com>,
        linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        blamoreaux@vmware.com, frederic.martinsons@gmail.com,
        srivatsa@csail.mit.edu, vsirnapalli@vmware.com,
        amakhalov@vmware.com, keerthanak@vmware.com, ankitja@vmware.com,
        bordoloih@vmware.com, srivatsab@vmware.com,
        Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 4.19-rt] workqueue: Fix deadlock due to recursive locking
 of pool->lock
Message-ID: <20230316070850.q3bj3g7likfbg7jl@beryllium.lan>
References: <20230228224938.88035-1-brennanlamoreaux@gmail.com>
 <20230313093641.pxvwFHCJ@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230313093641.pxvwFHCJ@linutronix.de>
X-Last-TLS-Session-Version: TLSv1.3
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Mon, Mar 13, 2023 at 10:36:41AM +0100, Sebastian Andrzej Siewior wrote:
> On 2023-02-28 14:49:38 [-0800], Brennan Lamoreaux (VMware) wrote:
> > Upstream commit d8bb65ab70f7 ("workqueue: Use rcuwait for wq_manager_wait")
> > replaced the waitqueue with rcuwait in the workqueue code. This change
> > involved removing the acquisition of pool->lock in put_unbound_pool(),
> > as it also adds the function wq_manager_inactive() which acquires this same
> > lock and is called one line later as a parameter to rcu_wait_event().
> 
> Daniel, I double checked and this patch is correct - the backport was
> faulty. Could you please pick it up and release an update?

Sure. I've updated the v4.19-rt branch and added this patch. Running local tests
now.
