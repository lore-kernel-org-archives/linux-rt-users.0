Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73EE6C43217
	for <linux-rt-users@archiver.kernel.org>; Thu, 13 Oct 2022 06:23:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbiJMGXQ (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 13 Oct 2022 02:23:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbiJMGXP (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 13 Oct 2022 02:23:15 -0400
X-Greylist: delayed 924 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 12 Oct 2022 23:23:13 PDT
Received: from 2.mo582.mail-out.ovh.net (2.mo582.mail-out.ovh.net [46.105.76.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E746123440
        for <linux-rt-users@vger.kernel.org>; Wed, 12 Oct 2022 23:23:13 -0700 (PDT)
Received: from player773.ha.ovh.net (unknown [10.108.16.84])
        by mo582.mail-out.ovh.net (Postfix) with ESMTP id 8E2602491F
        for <linux-rt-users@vger.kernel.org>; Thu, 13 Oct 2022 06:07:46 +0000 (UTC)
Received: from blaess.fr (91-160-139-170.subs.proxad.net [91.160.139.170])
        (Authenticated sender: christophe@blaess.fr)
        by player773.ha.ovh.net (Postfix) with ESMTPSA id 4087F2FB4A3D2;
        Thu, 13 Oct 2022 06:07:45 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass (GARM-107S0016c7c0a39-aec6-4afa-b264-c9a69c547177,
                    66E72F3D0A8114BC1A239AE668EB5E9D543277F5) smtp.auth=christophe@blaess.fr
X-OVh-ClientIp: 91.160.139.170
Message-ID: <c1ac2662-07b7-36e6-eca5-992ac6e5452e@logilin.fr>
Date:   Thu, 13 Oct 2022 08:07:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: SCHED_OTHER > SCHED_FIFO?
To:     Sebastian Kuzminsky <seb@highlab.com>,
        linux-rt-users@vger.kernel.org
References: <ea166a37-09c2-04ab-fda8-98a6b29608ab@highlab.com>
 <CAMLffL-Zr6aj6LojpbKfHEHjV=y=P3dRhBL4=Fh0+X-SKFg-UQ@mail.gmail.com>
 <adfcede2-0da1-233d-09d7-004688e39178@highlab.com>
Content-Language: fr
From:   Christophe Blaess <mailist@logilin.fr>
In-Reply-To: <adfcede2-0da1-233d-09d7-004688e39178@highlab.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 12335922330057094300
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvfedrfeejledguddthecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecunecujfgurhepkfffgggfuffvfhfhjggtgfesthekredttdefjeenucfhrhhomhepvehhrhhishhtohhphhgvuceulhgrvghsshcuoehmrghilhhishhtsehlohhgihhlihhnrdhfrheqnecuggftrfgrthhtvghrnhepheetheefhedutdeiudevieefgedugfeiveduiefffedtheehgffggedvvdekveelnecukfhppeduvdejrddtrddtrddupdeluddrudeitddrudefledrudejtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepoehmrghilhhishhtsehlohhgihhlihhnrdhfrheqpdhnsggprhgtphhtthhopedupdhrtghpthhtoheplhhinhhugidqrhhtqdhushgvrhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdfovfetjfhoshhtpehmohehkedvpdhmohguvgepshhmthhpohhuth
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi

On 13/10/2022 01:25, Sebastian Kuzminsky wrote:
> Thanks for the suggestion, but it gives results that are only slightly 
> better:


It will probably make no difference as you run your task on an isolcpu 
but did you set  `sysctl  kernel.sched_rt_runtime_us=-1`


-- 
Christophe
