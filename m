Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1781C43334
	for <linux-rt-users@archiver.kernel.org>; Sun,  5 Jun 2022 13:02:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343852AbiFENCN (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sun, 5 Jun 2022 09:02:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343842AbiFENCM (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Sun, 5 Jun 2022 09:02:12 -0400
X-Greylist: delayed 1195 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 05 Jun 2022 06:02:06 PDT
Received: from mail92c50.megamailservers.eu (mail74c50.megamailservers.eu [91.136.10.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 153FA6270
        for <linux-rt-users@vger.kernel.org>; Sun,  5 Jun 2022 06:02:03 -0700 (PDT)
X-Authenticated-User: ralf.mardorf@o2mail.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megamailservers.eu;
        s=maildub; t=1654432920;
        bh=18Y/S1vZQkpgPkWzW9C6UxmWeO8QyZcAuzYMfmaJjEw=;
        h=Date:From:To:Subject:In-Reply-To:References:From;
        b=fDJrEAcXbIZm+DB+pv6pzGlLhuigy/NCFxFIq+I0fepyZgmooe5gVJ51MX5XDq1Kp
         6s2yv7sxT8ugj9vrD2Jp5+GYnmH+fdwkxkHEv6wks/KZxSXyfymu4M8OwoFdCC8Sl0
         Ou2eZI4cMEmMtXZG2oS+2OHPe4GPzGscUGFIkndo=
Feedback-ID: ralf.mardorf@al
Received: from archlinux (dynamic-078-049-021-039.78.49.pool.telefonica.de [78.49.21.39])
        (authenticated bits=0)
        by mail92c50.megamailservers.eu (8.14.9/8.13.1) with ESMTP id 255CfwYp022087
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 5 Jun 2022 12:42:00 +0000
Date:   Sun, 5 Jun 2022 14:41:48 +0200
From:   Ralf Mardorf <ralf.mardorf@alice-dsl.net>
To:     Daniel Wagner <wagi@monom.org>, linux-rt-users@vger.kernel.org
Subject: Re: [ANNOUNCE] 4.19.245-rt109
Message-ID: <20220605144133.604d15a5@archlinux>
In-Reply-To: <20220605141849.200cf9e0@archlinux>
References: <165346390046.11398.18138245986252936857@beryllium.lan>
        <20220605141849.200cf9e0@archlinux>
X-Mailer: Claws Mail (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CTCH-RefID: str=0001.0A742F17.629CA498.002B,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-CTCH-VOD: Unknown
X-CTCH-Spam: Unknown
X-CTCH-Score: 0.000
X-CTCH-Rules: 
X-CTCH-Flags: 0
X-CTCH-ScoreCust: 0.000
X-Origin-Country: DE
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Sun, 5 Jun 2022 14:18:49 +0200, Ralf Mardorf wrote:
>Hi Daniel,
>
>again it's no joy to import your key ;).

Pardon, my bad.

4.19.240-rt108 was seemingly signed by Clark Williams, so I could build
it without your signature. I forgot to add you to the array of the
build script before building 4.19.245-rt109.

I'm using different build scripts and you are still not added to all of
them.

$ pacman -Q linux-rt{-cornflower,-pussytoes,-securityink,}|cut -d\  -f2
4.19.230_rt103-0.300
4.19.240_rt108-0.300
4.19.237_rt107-0.300
4.19.235_rt106-0.1000

So something on my side went wrong between keyboard and chair ;).

Regards,
Ralf
