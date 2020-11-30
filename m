Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 681ABC63777
	for <linux-rt-users@archiver.kernel.org>; Mon, 30 Nov 2020 19:11:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A3DE206ED
	for <linux-rt-users@archiver.kernel.org>; Mon, 30 Nov 2020 19:11:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="aV8HTBx2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728443AbgK3TL3 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 30 Nov 2020 14:11:29 -0500
Received: from mout.gmx.net ([212.227.15.18]:35993 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726063AbgK3TL3 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 30 Nov 2020 14:11:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1606763364;
        bh=l+UULV6G5zk6dwIWZ5k74YCwsLwFtbtmxgzGJZBYupw=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=aV8HTBx27h3TO/n6lQUtsvpDerHRkVcF6t/CMiLo0OvTRIyEpuAeUmZjYdHKsl5DK
         Sj1IXkJfjiLuhrFextj/U+ZMVyvMIQl2kbdzPFAkRNFQxwestTUA96D8r3NgQlo5kU
         48spj5LhC36j57gUBbPLZNxGE/okrOfYdDRTSI1Q=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.221.151.20]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MgvrL-1kG0a12szF-00hP23; Mon, 30
 Nov 2020 20:09:24 +0100
Message-ID: <e1260d25c623f940138230dc2ebaad471c61f116.camel@gmx.de>
Subject: Re: scheduling while atomic in z3fold
From:   Mike Galbraith <efault@gmx.de>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Oleksandr Natalenko <oleksandr@natalenko.name>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-rt-users@vger.kernel.org
Date:   Mon, 30 Nov 2020 20:09:22 +0100
In-Reply-To: <20201130163214.3zdlppkkd7dnnpzp@linutronix.de>
References: <f1c39a0504310a97e42b667fc4d458af4a86d97a.camel@gmx.de>
         <e38055ffe19751ba63f1c9beceae222438bcac59.camel@gmx.de>
         <20201129112922.db53kmtpu76xxukj@spock.localdomain>
         <90c4857c53b657147bfb71a281ece9839b0373c2.camel@gmx.de>
         <20201130132014.mlvxeyiub3fpwyw7@linutronix.de>
         <856b5cc2a3d4eb673743b52956bf1e60dcdf87a1.camel@gmx.de>
         <20201130145229.mhbkrfuvyctniaxi@linutronix.de>
         <05121515e73891ceb9e5caf64b6111fc8ff43fab.camel@gmx.de>
         <20201130160327.ov32m4rapk4h432a@linutronix.de>
         <2658a2a26e53826687cd7b22f424e2d3319423dd.camel@gmx.de>
         <20201130163214.3zdlppkkd7dnnpzp@linutronix.de>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:UHx7Dco6B5uW6R576n2ewPuvuV+tW6V41Fpt7zBnZSJ/bz2Z2lW
 U2QH5AW8ISerShQ2TJ/Zlz1X02D6ySHeismj93Cu9cAE+tnejDIge2SbbhcfUvVYAvFWADN
 5TmfGjsEOJd08o28Ycd1cQtgnAj7Z8O97+PtDZbFPaQaiMUvsxuXGMLc5ri8wt5C3iwPYR/
 ixHNB6/UE1mty/CpeBYKw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:U/jGnV58I20=:JPpStcYtqIqo7RJ1Ouno4d
 NipNiQmVw4O7aDP437vr3StHctwDZAjgvqX6OBfVuBXm5C1Ntq3YaUZDeTPyROh06CAvQCTgc
 cKk4TUly+MqBeb6L9CXdX0o2dTaeRbC88/0ftx/G/BXkq849vzFmDhVg0k/yCzybT/B5GxXB8
 Sj0rLLaLkURI/3b7WA+iy2OM791Tg6GWYCGaBA5Xg1v2g7qwZXJKSNyoI7xk0G3SkGFsXhOCo
 XkiTMNBS5TQRkIQoNixHKjrrmz7FlEdxJKZTMHZtyWZNpa9erT+Q408w4kjRze5oQQsb6rg9l
 tu6xDGM+uKjn8MJr0EPisjyBTfXblpe+ARxy6YGX0op4P7WXd2LIsvnWmIwTf5rP+7mrBoX70
 +SoxpCoF9783yr70H3T+FTh1YDfwAL5FyNoIh7Psr/TIASOhWe3G0Dn7YERH2fD7k6m078+zF
 qCAUaEtBuNQnrbvvJlZKxGFv8J1MwYu6FdI1WFyVXX7CffkQVh/i4wWiEJ2O9+z7QdHCZfQWW
 His6zNtymcl0WeqHjHxAWraCaG2ct2FFyHuGCUbK9uxKiLMjG5UK+lMNQHJRVtsa38KTWc41Q
 3jUplEaKyija7vAHVaO1CnL9mEMuYIHZ2vFr02Y5vEdU4Hptq+QpYzdbA/sIRCDtJ5ZVtCHFT
 aFaevY68HlUDDmRVmZjKf+EmM+3OD1mlxoK1NRocsX1QC0NWoFkQuIa8Mk6yRoHs3ln6Idzsj
 hEb9ZHA+2SimGOsG/2rKcATQ0GqfR86PKrJcJ0KnlBiurNkrXkS1UeUsOcMj3Bo1sbCTgEx+1
 9B0vnFQdzXtPcTkuuftwLvBsBqHNgDmn2uaAPp9Zp/F+B18dW11CKPpk4AqdQDhMMGU1UuFW3
 2NmAcwwgFhLpMzWbJX6g==
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Mon, 2020-11-30 at 17:32 +0100, Sebastian Andrzej Siewior wrote:
> On 2020-11-30 17:27:17 [+0100], Mike Galbraith wrote:
> > > This just passed. It however killed my git-gc task which wasn't done=
.
> > > Let me try tomorrow with your config.
> >
> > FYI, I tried 5.9-rt (after fixing 5.9.11), it exploded in the same way=
,
> > so (as expected) it's not some devel tree oopsie.
>
> v5.9 has the same missing local-lock init due to merged local-lock
> upstream. I don't remember when this get_cpu_ptr() came it.

Looks like get_cpu_ptr() arrived in 4.14.

I patched up zswap/z3fold in my old 5.1-rt tree (old forward port of
4.19-rt), turned them on with a script, and it all worked fine, so the
RT zswap allergy lies somewhere upstream of there it seems.

If I were to start merging zswap and friends forward, I'd likely
eventually meet whatever RT is allergic to.  I might try that, but
won't be the least surprised if it turns into a god awful mess of
dependencies.

Hopping forward in rt branches first and patching them up will bracket
the little bugger a lot quicker.

	-Mike

