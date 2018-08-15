Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from smtp-sp200-214.kinghost.net ([177.185.200.214]:45523 "EHLO
        smtp-sp200-214.kinghost.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726000AbeHOLSu (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 15 Aug 2018 07:18:50 -0400
Received: from smtp200-farm64.kinghost.net (smtp200-farm64 [127.0.0.1])
        (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
        (No client certificate requested)
        by smtp-sp200-214.kinghost.net (Postfix) with ESMTPS id 4C47613FBC4CE
        for <linux-rt-users@vger.kernel.org>; Wed, 15 Aug 2018 05:21:25 -0300 (BRT)
Received: from smtpi-sp-222.kinghost.net (smtpi-sp-222.kinghost.net [177.185.201.222])
        (using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by smtp200-farm64.kinghost.net (Postfix) with ESMTPS id 4407DB05283D2
        for <linux-rt-users@vger.kernel.org>; Wed, 15 Aug 2018 05:21:24 -0300 (BRT)
Subject: Re: SCHED_DEADLINE as user
References: <pl0fsj$ohn$1@blaine.gmane.org>
From: Daniel Bristot de Oliveira <daniel@bristot.me>
Message-ID: <0ac9fabc-c316-2a59-c3dd-c7b4e4f93209@bristot.me>
Date: Wed, 15 Aug 2018 10:21:14 +0200
MIME-Version: 1.0
In-Reply-To: <pl0fsj$ohn$1@blaine.gmane.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: Tim Blechmann <tim@klingt.org>, linux-rt-users@vger.kernel.org



On 08/15/2018 08:08 AM, Tim Blechmann wrote:
> hi all,
> 
> i wonder, what's the preferred way to obtain SCHED_DEADLINE privileges
> as non-root user?

Hi Tim,

It is still not possible to use sched deadline as a non-root user :-(.

Thanks
-- Daniel

> for SCHED_RR/SCHED_FIFO i'm typically using pam_limits/limits.conf, but
> i haven't found any resources on how SCHED_DEADLINE can be obtained ...
> 
> thanks in advance,
> tim
> 
