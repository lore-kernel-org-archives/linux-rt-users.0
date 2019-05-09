Return-Path: <SRS0=OpkQ=TJ=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C15F9C04AB1
	for <linux-rt-users@archiver.kernel.org>; Thu,  9 May 2019 07:56:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95ADA2173C
	for <linux-rt-users@archiver.kernel.org>; Thu,  9 May 2019 07:56:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725963AbfEIH4n (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 9 May 2019 03:56:43 -0400
Received: from smtpi-sp-244.kinghost.net ([177.185.201.244]:56023 "EHLO
        smtpi-sp-244.kinghost.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbfEIH4m (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 9 May 2019 03:56:42 -0400
X-Greylist: delayed 724 seconds by postgrey-1.27 at vger.kernel.org; Thu, 09 May 2019 03:56:41 EDT
Received: from t460s.bristot.redhat.com (198.red-83-43-182.dynamicip.rima-tde.net [83.43.182.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: daniel@bristot.eti.br)
        by smtpi-sp-244.kinghost.net (Postfix) with ESMTPSA id E3E4E6000F0F;
        Thu,  9 May 2019 04:56:28 -0300 (-03)
Subject: Re: Real-time micro-conference proposal for Linux Plumbers 2019
To:     Tiejun Chen <tiejunc@vmware.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
References: <5ef34142-2b55-28ff-612d-0ec7b0c521d1@redhat.com>
 <BYAPR05MB5878261BB896A489AA521A65C5320@BYAPR05MB5878.namprd05.prod.outlook.com>
From:   Daniel Bristot de Oliveira <daniel@bristot.me>
Message-ID: <02b2eb1e-b88b-3ade-1e0d-741bf92939b1@bristot.me>
Date:   Thu, 9 May 2019 09:56:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <BYAPR05MB5878261BB896A489AA521A65C5320@BYAPR05MB5878.namprd05.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SND-ID: E3DhL4HZvWApxdeEu0+R3k19tF2vhIUMcvigv4x0qidpkEMv/61pVU+Ic2kX
        C2E5z/9xJ4WEtUyKW/eV3FZ7zmaiZL4jAC+FYM/DXGPSGG7DqAs9XBU+/eo9
        udhih1mYnG7sSSJQBijp+M+K8KbGT/z5M++/0vjTAnYVY6gB7KdUD4ZyhPri
        9E42HUJiHA4tzc5CCcDASDvK743SPRtS+XJZA93uLyrU8Ev3TaGi7yi1mClz
        FiN040pt0PTJzXHsm8eHBOetU+p7y/rPmmGOFAqpBABMu5/b3YihuOfTtnYe
        +v+dCQc+0P4o/3HJk/UcXO7KUPzDB1qv3jPvMFg40zF0jsVY7mE6eyBXfgZ1
        0AmjwXEOwVNQdyidskmxJAkvmjkbBaE7eOdJYqOlRVlv8QsKtnjiGJ55URGP
        PQNET6b6yB+yvwv5ZC8a8He3Gs1I2DsShwO/Z2lyJcZVuGzhAw==
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi Tiejun!

On 5/8/19 6:37 AM, Tiejun Chen wrote:
> Hi Daniel,
> 
> I hope we can discuss if-how Preempt-RT kernel can be tuned to benefit container/docker. It would involve any potential new interfaces, tools/utilities, etc, and how to make Preempt-RT work very well with some Linux secure features.  Actually I tried to discuss this last year but for some reasons I did attend real-time micro-conference 2018, unfortunately. I hope we can have such a topic and I'd like to work on that as well.

Yeah, this is a hot topic! Are you planning to attend to Plumber this year? If
so, would you mind to prepare 3 or 4 slides introducing the problem to "warm-up"
the discussion at the MC?

Thanks!

-- Daniel

> 
> Thanks
> Tiejun
