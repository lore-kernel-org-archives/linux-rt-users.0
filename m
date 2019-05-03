Return-Path: <SRS0=ow8w=TD=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30EC2C43219
	for <linux-rt-users@archiver.kernel.org>; Fri,  3 May 2019 08:23:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C1F32087F
	for <linux-rt-users@archiver.kernel.org>; Fri,  3 May 2019 08:23:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726041AbfECIXN (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 3 May 2019 04:23:13 -0400
Received: from mail.monom.org ([188.138.9.77]:41178 "EHLO mail.monom.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725777AbfECIXN (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 3 May 2019 04:23:13 -0400
Received: from mail.monom.org (localhost [127.0.0.1])
        by filter.mynetwork.local (Postfix) with ESMTP id 60D0D500890;
        Fri,  3 May 2019 10:23:11 +0200 (CEST)
Received: from [192.168.154.175] (ppp-93-104-162-82.dynamic.mnet-online.de [93.104.162.82])
        by mail.monom.org (Postfix) with ESMTPSA id 2264F500709;
        Fri,  3 May 2019 10:23:11 +0200 (CEST)
Subject: Re: [PATCH 00/10] Some more stable-rt-tools fixes
To:     Tom Zanussi <zanussi@kernel.org>
Cc:     linux-rt-users@vger.kernel.org
References: <cover.1556825097.git.tom.zanussi@linux.intel.com>
From:   Daniel Wagner <wagi@monom.org>
Message-ID: <00f3ea64-3ead-5f28-b128-508167b15621@monom.org>
Date:   Fri, 3 May 2019 10:23:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <cover.1556825097.git.tom.zanussi@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi Tom,

On 5/2/19 9:33 PM, Tom Zanussi wrote:
> I just did my first srt tools backport release for 3.18 - as promised,
> here's the set of patches for the things I ran into.

Thanks for the fixes. All patches applied. I updated the unit test to 
matches the changes. Everything looks good!

Thanks,
Daniel
