Return-Path: <SRS0=CUgu=T6=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3EDAC28CC0
	for <linux-rt-users@archiver.kernel.org>; Thu, 30 May 2019 10:10:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9993F256DC
	for <linux-rt-users@archiver.kernel.org>; Thu, 30 May 2019 10:10:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=megamailservers.eu header.i=@megamailservers.eu header.b="BFmxxJUZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbfE3KKP (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 30 May 2019 06:10:15 -0400
Received: from mail222c50.megamailservers.eu ([91.136.10.232]:35072 "EHLO
        mail33c50.megamailservers.eu" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725440AbfE3KKP (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 30 May 2019 06:10:15 -0400
X-Greylist: delayed 365 seconds by postgrey-1.27 at vger.kernel.org; Thu, 30 May 2019 06:10:14 EDT
X-Authenticated-User: ralf.mardorf@o2mail.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megamailservers.eu;
        s=maildub; t=1559210645;
        bh=p4lSvLj7XAL+63SDjtwbMkFu3+19Kui3XiIeIC6xmNY=;
        h=Date:From:To:Subject:In-Reply-To:References:From;
        b=BFmxxJUZywLQvymZz9QwVvk5m/cCWrbr8jROEUeQt4pWxsFoojIHfk1HzUlkBC6qd
         Os1FZCP1esFWqx+vcRju3Lt89O0h4h38suk/SlqOaEG0/qgJwAu4vhmDiMIpyQGTyw
         Su4eeLZiiyj5jXXJ18tk62eEOs7AIKk0O9DrSPy4=
Feedback-ID: ralf.mardorf@al
Received: from archlinux (x2f37976.dyn.telefonica.de [2.243.121.118])
        (authenticated bits=0)
        by mail33c50.megamailservers.eu (8.14.9/8.13.1) with ESMTP id x4UA43K2017691
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=NO)
        for <linux-rt-users@vger.kernel.org>; Thu, 30 May 2019 10:04:05 +0000
Date:   Thu, 30 May 2019 12:03:53 +0200
From:   Ralf Mardorf <ralf.mardorf@alice-dsl.net>
To:     linux-rt-users@vger.kernel.org
Subject: Re: [ANNOUNCE] 4.19.37-rt20
Message-ID: <20190530120353.51ea4cc7@archlinux>
In-Reply-To: <20190528184857.2b9442c7@gandalf.local.home>
References: <20190528184857.2b9442c7@gandalf.local.home>
X-Mailer: Claws Mail (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CTCH-RefID: str=0001.0A0B020B.5CEFAA95.0078,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-CTCH-VOD: Unknown
X-CTCH-Spam: Unknown
X-CTCH-Score: 0.000
X-CTCH-Rules: 
X-CTCH-Flags: 0
X-CTCH-ScoreCust: 0.000
X-CSC:  0
X-CHA:  v=2.3 cv=F/95iJpN c=1 sm=1 tr=0 a=2U0B/qQtigaJa4RHvcp0NA==:117
        a=2U0B/qQtigaJa4RHvcp0NA==:17 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19
        a=kj9zAlcOel0A:10 a=VwQbUJbxAAAA:8 a=07Mv6I_FA7WSBY5vjgEA:9
        a=CjuIK1q_8ugA:10 a=pRQRx_yQ9a0A:10 a=AjGcO6oz07-iQ99wixmX:22
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Tue, 28 May 2019 18:48:57 -0400, Steven Rostedt wrote:
>4.19.37-rt20 stable release.
>
>  http://www.kernel.org/pub/linux/kernel/projects/rt/4.19/patch-4.19.37-rt20.patch.xz
>
>+++ b/localversion-rt
>@@ -1 +1 @@
>--rt19
>+-rt20-rc1

Stable release of release candidate 1 :D?

-- 
pacman -Q linux{,-rt{-pussytoes,-cornflower,,-securityink}}|cut -d\  -f2
5.1.5.arch1-2
5.0.14_rt9-0
5.0.10_rt7-0
5.0.7_rt5-1
4.19.37_rt20-0
