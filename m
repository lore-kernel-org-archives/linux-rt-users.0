Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AEC2C433EF
	for <linux-rt-users@archiver.kernel.org>; Mon, 21 Mar 2022 08:36:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345323AbiCUIhm (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 21 Mar 2022 04:37:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345321AbiCUIhl (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 21 Mar 2022 04:37:41 -0400
Received: from mail.nearlyone.de (mail.nearlyone.de [IPv6:2a01:488:66:1000:2ea3:7291:0:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E685D27B0D
        for <linux-rt-users@vger.kernel.org>; Mon, 21 Mar 2022 01:36:16 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8B3615CF87;
        Mon, 21 Mar 2022 09:36:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
        t=1647851774; h=from:subject:date:message-id:to:cc:mime-version:content-type:
         in-reply-to:references; bh=ugDVMYXmMB9ZZoB1nDvIy1FMepaOCb+NPtS4lDWMFnA=;
        b=HLr667LxDwwi3MZBn//Zg2dVcUwGcHkJDUcsqWpZ3OJS6s6McXHJmzVvW/CouFpVE6B5Si
        Fw6HR99BmtHkqd+dzzibnx/0Kmi6xbinOVTPclm0gTcHN0PNcDtvNTiCooG6FaGUUjHjDV
        Opc0Qi1G7Chxcl0uOu7xiqXthxD7azwA3LTTLpvTsBWoyfgNWrAI1AA+0d/0a1RDHGZ3au
        DNUFHAmVBwnhWZoW+/0/RKdb810g8LQL9yEWzr87uMHNgNaCaGN5WtnFHWNmRaKhRdGUgx
        ALJjYs1X9KkqGJYq42oJh4ZAJC2k9ZVAgMwONqIVA2BoS8bo2rItWOoc3nRvXA==
Date:   Mon, 21 Mar 2022 09:36:11 +0100
From:   Daniel Wagner <wagi@monom.org>
To:     Ralf Mardorf <ralf.mardorf@alice-dsl.net>
Cc:     linux-rt-users <linux-rt-users@vger.kernel.org>
Subject: Re: [ANNOUNCE] 4.19.233-rt105
Message-ID: <20220321083611.ikxq26ax55nqavei@beryllium.lan>
References: <164698646082.13723.1987519373498826881@beryllium.lan>
 <20220318060151.411f6789@archlinux>
 <20220318084800.6f5xs4rnp5kw6lxo@carbon.lan>
 <20220318102051.483333f2@archlinux>
 <20220318102718.1347247d@archlinux>
 <20220318094535.azlclmxubdbmusss@carbon.lan>
 <20220318180057.7a223148@archlinux>
 <20220318184249.39b17ee0@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220318184249.39b17ee0@archlinux>
X-Last-TLS-Session-Version: TLSv1.3
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi Ralf,

On Fri, Mar 18, 2022 at 06:42:49PM +0100, Ralf Mardorf wrote:
> >[rocketmouse@archlinux linux-rt]$ gzip -cd
> >patch-4.19.233-rt105.patch.gz | gpg2 --verify
> >patch-4.19.233-rt105.patch.sign - gpg: Signature made Fri 11 Mar 2022
> >09:10:11 CET gpg:                using EDDSA key
> >1B45744BE36280CA7D6BD460E072D068B1F5703E
> >                        ^^^^^^^^^^^^^^^^
> >                        587C5ECA5D0A306C.asc

It's a subkey hence the file name wont match. The file name is the
finger print and not the subkey.

> >Importing your key from a keyserver (e.g. from
> >hkp://keyserver.ubuntu.com) isn't an issue at all.
> >
> >The rt-patch was either signed with another key (E072D068B1F5703E
> >instead of 587C5ECA5D0A306C) or the uploaded patch is malicious.

Did you import 587C5ECA5D0A306C.asc from korg? It should contain all my
public keys (incl. the subkeys). At least this is what I think I did
when trying to follow (outdated, very outdated, complete useless or
wrong) documentation.

Hope this helps,
Daniel

ps: I have very strong feelings when it comes to gpg and no they are not
the good ones.
