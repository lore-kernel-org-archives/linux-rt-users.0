Return-Path: <SRS0=1Nl2=SM=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 136B8C10F11
	for <linux-rt-users@archiver.kernel.org>; Wed, 10 Apr 2019 08:55:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E05ED217D6
	for <linux-rt-users@archiver.kernel.org>; Wed, 10 Apr 2019 08:55:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728640AbfDJIz2 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 10 Apr 2019 04:55:28 -0400
Received: from mail.manjaro.org ([176.9.38.148]:55032 "EHLO manjaro.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726856AbfDJIz2 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 10 Apr 2019 04:55:28 -0400
Received: from localhost (localhost [127.0.0.1])
        by manjaro.org (Postfix) with ESMTP id 6869431379D1;
        Wed, 10 Apr 2019 10:55:27 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at manjaro.org
Received: from manjaro.org ([127.0.0.1])
        by localhost (manjaro.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 1TISAtN5Fgk6; Wed, 10 Apr 2019 10:55:25 +0200 (CEST)
Subject: Re: firefix core dump with linux 5.0.3_rt1-2
From:   Bernhard Landauer <bernhard@manjaro.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Ralf Mardorf <ralf.mardorf@alice-dsl.net>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
References: <dcf61b0e-31ca-0848-84c5-b200a15f3a89@manjaro.org>
 <20190328115559.275af3c3@archlinux>
 <f5d4ea60-aa23-a294-3850-42f35ca3d76d@manjaro.org>
 <20190328120022.bhwijbp2roizysiw@linutronix.de>
 <82482272-6912-c1d4-4a11-550a962f632c@manjaro.org>
 <1e1974c5-2ad3-98db-d160-577594a471e1@manjaro.org>
 <4ddfde7a-122b-5f18-f41a-b5e967217510@manjaro.org>
 <20190329083400.m4kx4spuvysoszlm@linutronix.de>
 <4f5db7b4-e129-075a-f5f7-81fc0c0a1d82@manjaro.org>
 <20190408153014.q5hnrz3dwphudeq2@linutronix.de>
 <9c56b47b-042c-d799-5e61-c114b77355fc@manjaro.org>
 <1df65102-3ccc-fa4b-635d-262a81133430@manjaro.org>
Message-ID: <d46fbb6d-92dc-84ef-a2a5-ea12dc8a3a43@manjaro.org>
Date:   Wed, 10 Apr 2019 10:55:24 +0200
MIME-Version: 1.0
In-Reply-To: <1df65102-3ccc-fa4b-635d-262a81133430@manjaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US-large
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

So no. The patch definitely doesn't solve the issue I'm afraid. Just
tested now and situation is still the same.

On 10.04.19 09:27, Bernhard Landauer wrote:
> Oh dang! Appologies. I just realize I didn't actually apply the patch ... ;)
> Stay tuned please. Have to rebuild once more. ...
>
> On 10.04.19 09:23, Bernhard Landauer wrote:
>>> Does this help?
>>>
>> I'm afraid not. The issue is still unchanged for me.
>>
>> regards
>> Bernhard
>>
