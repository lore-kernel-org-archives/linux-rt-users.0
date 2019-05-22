Return-Path: <SRS0=tVcw=TW=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9369CC282CE
	for <linux-rt-users@archiver.kernel.org>; Wed, 22 May 2019 11:43:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 402DC2173C
	for <linux-rt-users@archiver.kernel.org>; Wed, 22 May 2019 11:43:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=dkim.kinghost.net header.i=@dkim.kinghost.net header.b="WS4Aw5qS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728450AbfEVLn1 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 22 May 2019 07:43:27 -0400
Received: from smtpi-sp-232.kinghost.net ([177.185.201.232]:41857 "EHLO
        smtpi-sp-232.kinghost.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727464AbfEVLn1 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 22 May 2019 07:43:27 -0400
Received: from t460s.bristot.redhat.com (unknown [193.205.81.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: daniel@bristot.eti.br)
        by smtpi-sp-232.kinghost.net (Postfix) with ESMTPSA id A430F6000E0D;
        Wed, 22 May 2019 08:43:09 -0300 (-03)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; 
 d=dkim.kinghost.net; i=@dkim.kinghost.net; q=dns/txt; 
 s=king1; t=1558525398; h=subject : to : cc : references : 
 from : message-id : date : mime-version : in-reply-to : 
 content-type : content-transfer-encoding : subject : from 
 : date; bh=qrvuM7U5KpjfU4CVTUL6ca1r25zCJ2bQmhyDzV0bWtA=; 
 b=WS4Aw5qSBt6bAEvV51Yj2LUoG5trgC1uQpPqNsfRaC+I9Pk/sfy/AyeD
 nppQpDCuKfWCk/1tm/Rsm3gPCEAY1VQHamofRudcfJCzeWfFLSbTRMCBGU
 VHFmwd3cyUM1KwcLipK3OEL+8/MIXq31pAGvpZiildS1/dDKrZBhmYneY=
Subject: Re: Real-time micro-conference proposal for Linux Plumbers 2019
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-rt-users@vger.kernel.org, dhaval.giani@oracle.com,
        Frederic Weisbecker <fweisbec@gmail.com>
References: <5ef34142-2b55-28ff-612d-0ec7b0c521d1@redhat.com>
 <d0d44fb3-ac4a-c0c4-a9ce-76736ca70e31@bristot.me>
 <20190522010523.GO8945@kernel.org>
From:   Daniel Bristot de Oliveira <daniel@bristot.me>
Message-ID: <4d4b57cf-5672-1052-5e19-2eaf57bf8092@bristot.me>
Date:   Wed, 22 May 2019 13:43:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190522010523.GO8945@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SND-ID: E3DhL4HZvWApxdeEu0+R3k19tF2vhIUMcvigv4x0qidpkEMv/61pVU+Ic2kX
        C2E5z/9xJ4WEtUyKW/eV3FZ7zvScFxePFa14LSue53pHuZl1ipaxjYVtTiUr
        FyOksIttuLh95wvMzlGVK7dvaDbGlgjyKeVVfnUBcw8D6/MIjsv68ARNUk/7
        S/UCLTfRosni2Fs2/YcqBOjeqHfowfrBy+OZ7uMuQWCCSprAdID06URyumoP
        1rQUZTS/FkWjFitr92Ed+S2FdIFVCVRNqKbLMeBe/mvYhrkgPvEB5kTEe4VB
        fnb+0ZtaAzkVAHXUItmphNVae0vuPNJeAUuHLr8D/tWMKaW3a99p4VqwDvmQ
        M5Dm20U+5PiJciR1hL0tOhwknhe2sZzxx1Jh9uodfTs7NsNSsLI2NAYVr1Zo
        VtXlqwlh2N6oLYc3bZlk4ntQyGUejbahPezHmEumDAyyR1b50kau9PUS+ZIv
        cqD66zOzKoDxtE4Ziy+ijsMdtRqQgc4MbWBGNknDTTsTlViUb5glCOfQK8BY
        y6pXpLUSmNzpi6w=
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On 5/22/19 3:05 AM, Arnaldo Carvalho de Melo wrote:
> Em Tue, May 21, 2019 at 03:07:54PM +0200, Daniel Bristot de Oliveira escreveu:
>>
>>
>> On 5/3/19 8:53 AM, Daniel Bristot de Oliveira wrote:
>>> Hi all!
>>>
>>
>> Hi all!
>>
>> Good news from OSPM!
>>
>> I just talked to Frederic Weisbecker, and he is proposing talking about the
>> softirq rework that we need - as a step to the -rt merge!
>>
>> Dhaval Giani is also mentioning the possibility of talking about their needs
>> w.r.t proxy execution!
>>
>> Anyone else with a good idea? stable-rt people??? :-)
> 
> Has anyone thought about how BPF interacts with CONFIG_PREEMPT_RT_FULL?

I've heard that there are some preempt_disable sections around BPF code, right?

That is interesting too! (as people are more and more prone to use BPF to do
_put a complex thing here_).

-- Daniel
