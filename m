Return-Path: <SRS0=3N3c=R7=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC612C43381
	for <linux-rt-users@archiver.kernel.org>; Thu, 28 Mar 2019 11:30:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0A012075E
	for <linux-rt-users@archiver.kernel.org>; Thu, 28 Mar 2019 11:30:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbfC1Laf (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 28 Mar 2019 07:30:35 -0400
Received: from mail.manjaro.org ([176.9.38.148]:52664 "EHLO manjaro.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726173AbfC1Lae (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 28 Mar 2019 07:30:34 -0400
Received: from localhost (localhost [127.0.0.1])
        by manjaro.org (Postfix) with ESMTP id DDCA930F2E83;
        Thu, 28 Mar 2019 12:30:33 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at manjaro.org
Received: from manjaro.org ([127.0.0.1])
        by localhost (manjaro.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id f_eAqkRg0jTE; Thu, 28 Mar 2019 12:30:31 +0100 (CET)
Subject: Re: firefix core dump with linux 5.0.3_rt1-2
To:     Ralf Mardorf <ralf.mardorf@alice-dsl.net>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
References: <dcf61b0e-31ca-0848-84c5-b200a15f3a89@manjaro.org>
 <20190328115559.275af3c3@archlinux>
From:   Bernhard Landauer <bernhard@manjaro.org>
Message-ID: <f5d4ea60-aa23-a294-3850-42f35ca3d76d@manjaro.org>
Date:   Thu, 28 Mar 2019 12:30:30 +0100
MIME-Version: 1.0
In-Reply-To: <20190328115559.275af3c3@archlinux>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US-large
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

@Ralf
> does Manjaro use additional patches, maybe those used by linux-rt from
> AUR?
Our PKGBUILD can be seen here:
https://gitlab.manjaro.org/packages/community/realtime-kernels/linux50-rt/raw/master/PKGBUILD


As you can see we did not (yet) apply the nf-tables patch
Apart from that Manjaro only uses the bootsplash patches and the same
add-sysctl patch as the AUR

Our config can be found here:
https://gitlab.manjaro.org/packages/community/realtime-kernels/linux50-rt/raw/master/config.rt

@Sebastian

> Is this only related to 5.0-RT or are also previous RT versions
> affected?
>
My alternative is 4.19.31_rt18. No such issue with this one.
> This is not helpful. Do you have an reproducer?
>
Afraid not. Could you instruct what to get, how to use?

regards
Bernhard


