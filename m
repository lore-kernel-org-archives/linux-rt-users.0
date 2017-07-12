From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: hrtimers with ARM architected timer
Date: Wed, 12 Jul 2017 12:32:15 -0500
Message-ID: <447aa980-ef0c-6307-d347-866e3cd054bb@ti.com>
References: <HK2PR0601MB139370058E9696E9648BC8CCF5AF0@HK2PR0601MB1393.apcprd06.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
To: Phil Edworthy <phil.edworthy@renesas.com>,
        rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from lelnx194.ext.ti.com ([198.47.27.80]:63422 "EHLO
        lelnx194.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753913AbdGLRcT (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 12 Jul 2017 13:32:19 -0400
In-Reply-To: <HK2PR0601MB139370058E9696E9648BC8CCF5AF0@HK2PR0601MB1393.apcprd06.prod.outlook.com>
Content-Language: en-US
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi

On 07/12/2017 08:55 AM, Phil Edworthy wrote:
> Hi,
> 
> I'm new to rt-linux, so please forgive me if I ask some dumb questions.
> I have searched for a while, but not found what I am looking for.
> 
> I'm trying out the rt-linux patches (v4.9.35) on an out-of-tree BSP for
> a new ARM Cortex A7 device. When I tried cyclictest, it complained that
> I don't have High Resolution timers, so I checked and sure enough
> /proc/timer_list showed the timer resolution is 10ms. I've checked my
> kernel config and I have enabled hrtimers.
> 
> This device uses the ARM architected timer (CONFIG_ARM_ARCH_TIMER)
> running at a lowly 6.25MHz.
> 
> So, how can I tell if a driver is supposed to support hrtimers?
> If the ARM architected timer driver does support hrtimers, what could
> stop them being used?


Most probably you do not have at least one tick_broadcast timer enabled.
See:
tick_check_oneshot_change()->tick_is_oneshot_available()

Alternative option for me was:
     disable CONFIG_GENERIC_CLOCKEVENTS_BROADCAST

-- 
regards,
-grygorii
