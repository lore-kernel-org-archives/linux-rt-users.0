Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBDBCC433EF
	for <linux-rt-users@archiver.kernel.org>; Tue,  7 Jun 2022 06:01:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236910AbiFGGBS (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 7 Jun 2022 02:01:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234924AbiFGGBQ (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 7 Jun 2022 02:01:16 -0400
Received: from mail.nearlyone.de (mail.nearlyone.de [IPv6:2a01:488:66:1000:2ea3:7291:0:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17265D771C
        for <linux-rt-users@vger.kernel.org>; Mon,  6 Jun 2022 23:01:11 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B4BF15CD08;
        Tue,  7 Jun 2022 08:01:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
        t=1654581669; h=from:subject:date:message-id:to:cc:mime-version:content-type:
         in-reply-to:references; bh=MdPnIeQ16mapr2QZ+xvXdBHhibVpviVCA80Xkts0bBg=;
        b=GCYwkQDNYJSaelpxuLlF0ShjGOX00SFN/uzqFkpZeGufTdbscrbWfGTOemBy96/wy1a8jJ
        kacW8EwD16Z6Odo3eRPgAoWJUOBEYGHRVk+zpJau7qZBKtUcW/EcyfXmfUgo3kG+7Nb5dY
        iSz2RpxUqFAZgYqWiGLTqWZmwuPDWHKRG2m4Pki5YYgFX7+1eRz6suZBRISq9MXq5Y1Swd
        VZDrJdCfCFHh2VJFLw7YivjH9Jjl0tbgFS2clPBbNNOcgqx36NGIWeB8UpLNy5zcn9xUKt
        XcY1MFvP+8wxWCounqd82DcoLrHy5Lto0YgWL6PU26H0kNGE+Gar1UVE44OAmA==
Date:   Tue, 7 Jun 2022 08:01:06 +0200
From:   Daniel Wagner <wagi@monom.org>
To:     Ralf Mardorf <ralf.mardorf@alice-dsl.net>
Cc:     linux-rt-users@vger.kernel.org
Subject: Re: [ANNOUNCE] 4.19.245-rt109
Message-ID: <20220607060106.fee27fea4svhshvv@beryllium.lan>
References: <165346390046.11398.18138245986252936857@beryllium.lan>
 <20220605141849.200cf9e0@archlinux>
 <20220605144133.604d15a5@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220605144133.604d15a5@archlinux>
X-Last-TLS-Session-Version: TLSv1.3
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi Ralf,

On Sun, Jun 05, 2022 at 02:41:48PM +0200, Ralf Mardorf wrote:
> On Sun, 5 Jun 2022 14:18:49 +0200, Ralf Mardorf wrote:
> >Hi Daniel,
> >
> >again it's no joy to import your key ;).
> 
> Pardon, my bad.

No worries. gpg is certainly a tool I will never enjoy.

> 4.19.240-rt108 was seemingly signed by Clark Williams, so I could build
> it without your signature. I forgot to add you to the array of the
> build script before building 4.19.245-rt109.

Correct, Clark took over the release while I was on holiday.

> I'm using different build scripts and you are still not added to all of
> them.
> 
> $ pacman -Q linux-rt{-cornflower,-pussytoes,-securityink,}|cut -d\  -f2
> 4.19.230_rt103-0.300
> 4.19.240_rt108-0.300
> 4.19.237_rt107-0.300
> 4.19.235_rt106-0.1000
> 
> So something on my side went wrong between keyboard and chair ;).

So the first release I did was v4.19.233-rt105. So that means
4.19.230-rt103 should be signed by Clark, the other ones by me.
Clark and I are using the same release scripts which should make the
results more consistent. Not sure where we diverge here.

Thanks,
Daniel
