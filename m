Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F897C64E8A
	for <linux-rt-users@archiver.kernel.org>; Mon, 30 Nov 2020 16:38:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8F292073C
	for <linux-rt-users@archiver.kernel.org>; Mon, 30 Nov 2020 16:38:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="IK8S0ZeL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726421AbgK3QiU (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 30 Nov 2020 11:38:20 -0500
Received: from mout.gmx.net ([212.227.15.19]:50323 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725859AbgK3QiU (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 30 Nov 2020 11:38:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1606754177;
        bh=n6Y2W4rKnB4UZf9mhDmqlAqXFeT8oK+EdkAMYCo5tUo=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=IK8S0ZeLM/MSkTaw8S8DDG2N1/cOAuCQzkm7odPa4bGv4Bu0132b3EDeE6sVPk6Jw
         2qJ8IEVPlfcMs0Vg9p3nsvqyLSBefSaLGtnWGlHgGOnZp4zvCZldq7IEWuVLYAuQ00
         XlW1TKZH/jqKRyyfnwHirAk01X0NfK0R2SsPB7B8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.221.151.20]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M8ygO-1knbNv1SB4-0066Nm; Mon, 30
 Nov 2020 17:36:17 +0100
Message-ID: <aa1ac4f7ae4aed8af07b61f914eb69a1827e8e4d.camel@gmx.de>
Subject: Re: scheduling while atomic in z3fold
From:   Mike Galbraith <efault@gmx.de>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Oleksandr Natalenko <oleksandr@natalenko.name>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-rt-users@vger.kernel.org
Date:   Mon, 30 Nov 2020 17:36:14 +0100
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
X-Provags-ID: V03:K1:UoUeJf6rmuIJWUM1pcvR85nJLnWdH58+CVIx/BX2bazMvB5Lnjc
 TPW9orgp6Gll9BjDQt4EYieCuhL3WwR+cRLeTFnk4Xzy9LbGjtVMTpJMCWs8FuGlOsdHXJt
 A1y3O3nowZAqncOgkST4pV6Qid0YcsTyjlGuZEDXwPM1MK3q1v/DBnIJFsoNxIj8/d92Vow
 0wTcqNPaMV2IfhzPQyohQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:4QCU3caEoLg=:JgE5esJTfND4P8HBFs3EfR
 PM7jNsDs6xnXjXrrlSwj5ZAylt0EQ4AAf/ZlYmttaZe/Jz1uM59DrTwFpiQE4o4BKdqUKzgpu
 MgZsFfb+WEDk8XEQgAsbMnayNek/iaSB2LOtwwXF6krc4RWGDA6GWiQtv8Vl45tl10GnU/Ode
 ceIDEzmQVnu1WVQXJoFngfTlwR5XT/N+HLljhjYOdnzZtlSkjATVJudjc59Ru3OXVBao6t4/7
 9I6QVg2UqRJsSenE4fGvUTM0ydcm5+3mu5C1cTH5voFjYwG5UsVTJyZwh7YNx8Fjte1O02bl7
 hdkjkTEY8r0yMo72c6h2WzapsCFyxzH+RHF1FTCA7Jk/rPvBqp4FJROxbkaBQ/GVn/nYSSpv3
 9YaChINgTSKQvMeAWXyg1nShUmn75WVXFVFVV/vayoXIDZ7/jie+V545p66OoAES0p4fbPZR+
 xHoG6SVhUPwZtwjApubfrP0qKiSXVFbgYpKbsuwMnyOlcfLMKHi5QJAbXMrwoicPD959cgpUa
 gRnqc+7I6+PnNjS/7zAe4O49nXmur36sEgfuSjG5Ziz4QUfcYXksD0hId1EzmeEGp1d41gNuV
 A+UoHI6iQXvtZ7kf4UiCRSW1GgdIuqV/L3+Dw5SCY32mj/PG3BNxO0K+AUk8ZCHgH0sbQ0AsW
 aBOeMox3kKyMyi2RTqrVVb0SGBCO5h/gQ/ZPsdNQzDEmD0efJEAGhzeEEKajFALXBtHVHwuSo
 jSUe/tqHZXNjdHrZloD1XMNIJ6FDSyBtsz+MKw9aVWdXFvjTA7hQdviLPzk8W6JM143IYXoDR
 r9tv88BkAXyJcsc9w1OHyh/UQUprVg/YRQdPsXiT6zQc4U92x/g7PV5K2uuIPtY3RVwnWvmT7
 XX8rCbqhl7YBAnt97A3Q==
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

This was with your test patch applied.

	-Mike

