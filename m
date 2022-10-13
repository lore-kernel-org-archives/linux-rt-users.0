Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BF76C433FE
	for <linux-rt-users@archiver.kernel.org>; Thu, 13 Oct 2022 16:14:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbiJMQOE (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 13 Oct 2022 12:14:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiJMQOD (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 13 Oct 2022 12:14:03 -0400
Received: from smtp.centurylink.net (mail.onyx.syn-alias.com [206.152.134.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0E231372B4
        for <linux-rt-users@vger.kernel.org>; Thu, 13 Oct 2022 09:14:02 -0700 (PDT)
Feedback-ID: dfw:ctl:res:onyx
X-Authed-Username: aGlnaGxhYkBxLmNvbQ==
X-Rcptto: linux-rt-users@vger.kernel.org
Authentication-Results:  smtp04.onyx.dfw.sync.lan smtp.user=highlab@q.com; auth=pass (LOGIN)
Received: from [174.16.217.19] ([174.16.217.19:25753] helo=bifrost)
        by smtp.centurylink.net (envelope-from <seb@highlab.com>)
        (ecelerity 3.6.25.56547 r(Core:3.6.25.0)) with ESMTPSA (cipher=AES256-GCM-SHA384) 
        id 27/9D-31038-94938436; Thu, 13 Oct 2022 12:14:01 -0400
Received: from openwrt.lan ([10.0.0.1]:54346 helo=[10.0.0.109])
        by bifrost with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <seb@highlab.com>)
        id 1oj0qO-007rl5-Pa; Thu, 13 Oct 2022 10:14:00 -0600
Message-ID: <f87020ae-916f-06a9-2cba-fe4854724cd4@highlab.com>
Date:   Thu, 13 Oct 2022 10:14:00 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: SCHED_OTHER > SCHED_FIFO?
Content-Language: en-US
To:     Christophe Blaess <mailist@logilin.fr>,
        linux-rt-users@vger.kernel.org
References: <ea166a37-09c2-04ab-fda8-98a6b29608ab@highlab.com>
 <CAMLffL-Zr6aj6LojpbKfHEHjV=y=P3dRhBL4=Fh0+X-SKFg-UQ@mail.gmail.com>
 <adfcede2-0da1-233d-09d7-004688e39178@highlab.com>
 <c1ac2662-07b7-36e6-eca5-992ac6e5452e@logilin.fr>
From:   Sebastian Kuzminsky <seb@highlab.com>
In-Reply-To: <c1ac2662-07b7-36e6-eca5-992ac6e5452e@logilin.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Vade-Verdict: clean
X-Vade-Analysis-1: gggruggvucftvghtrhhoucdtuddrgedvfedrfeektddguddttdcutefuodetggdotefrodftvfcurfhr
X-Vade-Analysis-2: ohhfihhlvgemucfujgfpteevqfftpdevvffnpdfgpfggqdevvffnpdfqfgfvnecuuegrihhlohhuthem
X-Vade-Analysis-3: uceftddunecunecujfgurhepkfffgggfuffvfhfhjggtgfesthekredttdefjeenucfhrhhomhepufgv
X-Vade-Analysis-4: sggrshhtihgrnhcumfhuiihmihhnshhkhicuoehsvggssehhihhghhhlrggsrdgtohhmqeenucggtffr
X-Vade-Analysis-5: rghtthgvrhhnpeelleduieegfedtffelhfffheelveehueektdehgeejffettddujeevfeefudffkeen
X-Vade-Analysis-6: ucfkphepudejgedrudeirddvudejrdduleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
X-Vade-Analysis-7: ihhnvghtpedujeegrdduiedrvddujedrudelpdhhvghlohepsghifhhrohhsthdpmhgrihhlfhhrohhm
X-Vade-Analysis-8: pehsvggssehhihhghhhlrggsrdgtohhmpdhrtghpthhtohepmhgrihhlihhstheslhhoghhilhhinhdr
X-Vade-Analysis-9: fhhrpdhrtghpthhtoheplhhinhhugidqrhhtqdhushgvrhhssehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-Vade-Analysis-10: pdhmthgrhhhoshhtpehsmhhtphdtgedrohhnhiigrdgufhifrdhshihntgdrlhgrnhdpnhgspghrtghp
X-Vade-Analysis-11: thhtohepvddpihhspghnrgepthhruhgvpdgruhhthhgpuhhsvghrpehhihhghhhlrggssehqrdgtohhm
X-Vade-Client: CTL
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 10/13/22 00:07, Christophe Blaess wrote:
> Hi
> 
> On 13/10/2022 01:25, Sebastian Kuzminsky wrote:
>> Thanks for the suggestion, but it gives results that are only slightly 
>> better:
> 
> 
> It will probably make no difference as you run your task on an isolcpu 
> but did you set  `sysctl  kernel.sched_rt_runtime_us=-1`

Wow, this plus Clark's suggestion to run with SCHED_FIFO priority 2 
fixed it, thank you!!

With those two changes I now get identical, awesome results with 
SCHED_OTHER:0 and SCHED_FIFO:2 (running on an isolcpu):

> $ sudo sysctl kernel.sched_rt_runtime_us=-1
> kernel.sched_rt_runtime_us = -1
> $ sudo ./busy 
> using PTHREAD_EXPLICT_SCHED to set SCHED_FIFO (with highest priority)
> scheduling policy: SCHED_FIFO
> scheduling parameter priority: 2 (min=1, max=99)
> cpu affinity: 3
> after 10000 iterations:
>     min=54001 cycles (1000.019 us, 1.000 ms)
>     avg=54002.001 cycles (1000.037 us, 1.000 ms)
>     max=54004 cycles (1000.074 us, 1.000 ms)
> OK: worst latency < 2 ms
> 
> using PTHREAD_INHERIT_SCHED to keep SCHED_OTHER (with default priority)
> scheduling policy: SCHED_OTHER
> scheduling parameter priority: 0 (min=0, max=0)
> cpu affinity: 3
> after 10000 iterations:
>     min=54001 cycles (1000.019 us, 1.000 ms)
>     avg=54002.001 cycles (1000.037 us, 1.000 ms)
>     max=54004 cycles (1000.074 us, 1.000 ms)
> OK: worst latency < 2 ms

Thank you Christophe and Clark!


-- 
Sebastian Kuzminsky
