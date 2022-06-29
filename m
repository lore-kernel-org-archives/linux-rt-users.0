Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E8E6C433EF
	for <linux-rt-users@archiver.kernel.org>; Wed, 29 Jun 2022 17:03:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231776AbiF2RDM (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 29 Jun 2022 13:03:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbiF2RDL (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 29 Jun 2022 13:03:11 -0400
Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAD691209F
        for <linux-rt-users@vger.kernel.org>; Wed, 29 Jun 2022 10:03:08 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 20AAE5DD59;
        Wed, 29 Jun 2022 19:03:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
        t=1656522186; h=from:subject:date:message-id:to:cc:mime-version:content-type:
         in-reply-to:references; bh=wmHtYRgO/SWYIZRLXmZ+cSlzv0+JA+BV1JwQXEF1L7I=;
        b=JOjrqEqk/mHImL3rMwWblkX5HG/JKv2NGvhlrEleowHO5wEcWufu+zzNQV7NSrTksi/tXp
        SG8+YVFn4mgFPdCZHs4uZuKCK5uap4004yMOM5V3k5ycPnoq9mKCvoWa2wfZKVHPBZ+viw
        EKiJO77G82oQJOr6gZ0u/xFEw8o+y/1P6753hULR4ANUQ/Grk9k3PSnziTcdNUjieix26P
        t+oCCBfQeMtY4XBW6ZloD/mUfkG5ewrgE01xS09j6aBJ4auX9c9ZkPnJrAYVwfYyvkr7yx
        YGMiLDPVPIKRMH/nhJXwVLo969dx9h7T2rQbCwSAG0AVQiMZW0H9bZOwyRMcTg==
Date:   Wed, 29 Jun 2022 19:03:04 +0200
From:   Daniel Wagner <wagi@monom.org>
To:     John Kacur <jkacur@redhat.com>
Cc:     Song Chen <chensong_2000@189.cn>, linux-rt-users@vger.kernel.org,
        williams@redhat.com
Subject: Re: [PATCH v2] sched_deadline/cyclicdeadline add tracelimit
Message-ID: <20220629170304.abppmxmie7yq3kmh@beryllium.lan>
References: <1655448052-12537-1-git-send-email-chensong_2000@189.cn>
 <20220629065848.zpppngaem7qqazzf@beryllium.lan>
 <8d2bbda3-492-a5c9-4efc-722bddbc7bf6@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8d2bbda3-492-a5c9-4efc-722bddbc7bf6@redhat.com>
X-Last-TLS-Session-Version: TLSv1.3
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Wed, Jun 29, 2022 at 11:34:40AM -0400, John Kacur wrote:
> @Danel Wagner, is that just a comment or would you like a Reviewed-by ?

I just noticed that several option have been added to various tools an
no one cared to add them to the manual patches. Makes a bit sad after
spending time syncing all man pages up.
