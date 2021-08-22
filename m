Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17E22C4338F
	for <linux-rt-users@archiver.kernel.org>; Sun, 22 Aug 2021 16:36:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1D40610A5
	for <linux-rt-users@archiver.kernel.org>; Sun, 22 Aug 2021 16:36:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbhHVQgl (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sun, 22 Aug 2021 12:36:41 -0400
Received: from mout.gmx.net ([212.227.15.18]:51149 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229460AbhHVQgl (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Sun, 22 Aug 2021 12:36:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1629650149;
        bh=GvelHfGxIVkLHwCywJm2aTZySFriCd8Hy85ax3eiYxI=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=eDwLCgFSG6e1IzUmugjtgBKL9zTGGIRsA7dTgmcdce6nQjJNc2Ud0PRtKfo8//L/5
         KwpW/KVnDg6w6P0RB1zvrvyqi/6jFn/WQhCqUsXKaapwDV/9MEpCWJhy8oP+X9PMvS
         ETTp5Dy5QdjuKUnM3idYCUEcCKlDiO2/oWug+TCs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.146.50.154]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MTABZ-1mTYXC2KD9-00UbRa; Sun, 22
 Aug 2021 18:35:49 +0200
Message-ID: <34f1e1dadb2c3d19389427303da6ea53e321e726.camel@gmx.de>
Subject: Re: [patch] kcsan: Make it RT aware
From:   Mike Galbraith <efault@gmx.de>
To:     linux-rt-users <linux-rt-users@vger.kernel.org>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>
Date:   Sun, 22 Aug 2021 18:35:48 +0200
In-Reply-To: <dc0cb448d46f465bb0064b1c301cb0b3ab4f8492.camel@gmx.de>
References: <dc0cb448d46f465bb0064b1c301cb0b3ab4f8492.camel@gmx.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.3 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:PgST/7K2g7VYk5ZBclV4STy/WWBXhaHwdQh230Aesee3PGf4kFL
 12PsETQZ1S5GiXP2Obi+iCezgvCS7iFdulmcPZLImxqm29StPlMrQJdq8QyjxpBRv8dQUPF
 aoHRr4bNUvzb4sUAPJT6ABCMK149DIY6mG36sHDD8smZDU+ms2DAGdZ6jMPWkZdN5PDxxzT
 YBKM7g4MBcCrteF7syNGw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:NzHLopz+RCM=:8cqkHWT1WtV/dqJbbm00jF
 y1F9v6Dks7XBU0OPVzgo1e2LKOdJb+yE1izm2HDtdT9wGjLuyMWGWY+G1pmYmxHf83JlctQ0y
 NTwPxvgVoWmyPsiuFEQYmOaW6rNIeHojyJt57ABU0yFtCiWT8PVUQ1smlzERG0JlwxErW8pyL
 ILoMalTp2dFWroXvQsqHRoriF7tW0aqsbvCCpllVD5uxmpoFxX6FKkjFWu5H009giKsPx06jd
 zzberXLykmtuzumpOosNXRrD8ap+o3oPtpqTm7z2KuCFL4ch2x0gYtzWVvvV0EH54ZSrhV4sh
 Ye0oAv6rHntdFp4jwyDXeHgmVN77cWDmYNLqgWKqmMkhDrkR26hCKQbjygzQQivVl7bFiSXo/
 h3oe5iNevY+zubUAr6lvVBJw2LXN5hMHSc6XUj8Pa1cobBzSp2h+txzCMs4h/+WGPxRY7h1s/
 wuad5/mSKDBa/bmuOdZ/x00tFXyJ9TB43qRC6UPMuyOkCp/e3itdnxoUB+ooIeWXJtR66l5Zb
 UcdXzBY+K9rolELd7bWv6A+1LcfT/A5wHYIC9x/s4uW47GVk1KFPT+y1jQM5Gb4MyK//WeSK+
 MmO2jXFwEpbpCsnQBa9fSBwRD8Xfkn2vUctuM3+CuoXmWRZr7DL3ZPdRJXC4Mt5BswM61kD5p
 KfLRK8ds4KW84VrStq1uVmNZL/6PQ4Ww0y9HDnlg0z6+CoMM5Q7d4cZdgv6XX8ZWNo6COLyyO
 b/QFYEiVHe7dN5mK+O9StK3q4Ik0OttzDYjv4EczQKVyc+W/bnLKaqb8OSatei7dqPN1AgatN
 OEnwxvoaR1uqBcMk1ya72/6V4MHVArslx0zYlDVv7GqJ5Wdn0qkeicAEQ7A2+eaY/UTZZBg5n
 x7cirJfdFAqNVOm636du0oBCrJwrcvGsBq/FrfhCZR1z3RaguX1WLahnhglGN6jordzezvjLN
 LaBc8Bp6042KHWpdBoCcsRjTpq7lxPj1xYL/4hueuiK8SKuSl/GIu6rQdPgWRYbqG+v0Kb5Dk
 8Eh+k6AR4zYaQep5skpY1dOLaOvT774a0sRqsJrWDWEk23eUTSpTNkVNyNcwQjvLwxsltMXMw
 uSGtH/yCvNYRpTTbOJ2dlsQr49FkXWcKrDE
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On second thought, burn both patches.  Making K[AC]SAN work with RT
ain't worth the warts.

	-Mike

