Return-Path: <SRS0=pVaS=TG=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1988C04AB1
	for <linux-rt-users@archiver.kernel.org>; Mon,  6 May 2019 07:26:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95FB721530
	for <linux-rt-users@archiver.kernel.org>; Mon,  6 May 2019 07:26:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726394AbfEFH0E (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 6 May 2019 03:26:04 -0400
Received: from smtp-sp200-211.kinghost.net ([177.185.200.211]:52689 "EHLO
        smtp-sp200-211.kinghost.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725828AbfEFH0D (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 6 May 2019 03:26:03 -0400
X-Greylist: delayed 511 seconds by postgrey-1.27 at vger.kernel.org; Mon, 06 May 2019 03:26:02 EDT
Received: from smtpi-sp-236.kinghost.net (smtpi-sp-236.kinghost.net [177.185.201.236])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by smtp-sp200-211.kinghost.net (Postfix) with ESMTPS id A250A1028C563;
        Mon,  6 May 2019 04:17:28 -0300 (-03)
Received: from t460s.bristot.redhat.com (host49-62-dynamic.23-79-r.retail.telecomitalia.it [79.23.62.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: daniel@bristot.eti.br)
        by smtpi-sp-236.kinghost.net (Postfix) with ESMTPSA id CAF936000E09;
        Mon,  6 May 2019 04:17:10 -0300 (-03)
Subject: Re: [patch 0/3] do not raise timer softirq unconditionally
 (spinlockless version)
To:     Marcelo Tosatti <mtosatti@redhat.com>,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Luiz Capitulino <lcapitulino@redhat.com>,
        Haris Okanovic <haris.okanovic@ni.com>
References: <20190415201213.600254019@amt.cnet>
 <20190506032234.GA31395@amt.cnet>
From:   Daniel Bristot de Oliveira <daniel@bristot.me>
Message-ID: <a6be2e0e-52a8-f711-ac37-23f267864710@bristot.me>
Date:   Mon, 6 May 2019 09:17:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190506032234.GA31395@amt.cnet>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SND-ID: E3DhL4HZvWApxdeEu0+R3k19tF2vhIUMcvigv4x0qidpkEMv/61pVU+Ic2kX
        C2E5z/9xJ4WEtUyKW/eV3FZ7zhqtVpQq2rjAS9f/ld8u8XLveOASo+XsFvtl
        fyg1Roh2/gu+MMqdAzdRWQS+64XBwkZTLUA7Ph3GQXSsMww6UD/8S+aanUho
        IQ7tGG0VakRWx37deil8OFZrQKJQyN4BocczqtMGU2CiI3RLchuLbPCoCmKi
        KqI9xnpV7BuyRt6tR5iO/zIbR6bdAogIXhE6ZlJYAlQxzpwu99C3N3CJ08kC
        iVSrHZCwPpv4j9CFgUIqLRaYZ3IZWQH5oknHgj+u36l4SjejbQIvFm5obt98
        575EsUIkk0HIfVdbYdHsx1tgX75FMt0Qvnfc1js83zgnxBdDfA+9852OfC8s
        nH+nsJpoNDaVrjiOj996yvUM33s9yqwtuvfAl2xL0Sp5Mf+3xAjkLEOl7R+y
        X+eLIOXKjqXyvZMlHOmAkAU/GmKsHJXFg6xcnlCUg2ZEbsu7vTG7HTcv/Env
        7SoqTSFM2XKRP6Uv7/3WPxyafXnIFxTm79V0f9heYXZeGAqKnQZD+Inx6rIl
        6m4wHWfHR4bNpgWNWrPobW9jve0ZMORBaQFDAaY1
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On 5/6/19 5:22 AM, Marcelo Tosatti wrote:
> On Mon, Apr 15, 2019 at 05:12:13PM -0300, Marcelo Tosatti wrote:
>> For isolated CPUs, we'd like to skip awakening ktimersoftd
>> (the switch to and then back from ktimersoftd takes 10us in
>> virtualized environments, in addition to other OS overhead,
>> which exceeds telco requirements for packet forwarding for
>> 5G) from the sched tick.
>>
>> The patch "timers: do not raise softirq unconditionally" from Thomas
>> attempts to address that by checking, in the sched tick, whether its
>> necessary to raise the timer softirq. Unfortunately, it attempts to grab
>> the tvec base spinlock which generates the issue described in the patch
>> "Revert "timers: do not raise softirq unconditionally"".
>>
>> tvec_base->lock protects addition of timers to the wheel versus
>> timer interrupt execution.
>>
>> This patch does not grab the tvec base spinlock from irq context,
>> but rather performs a lockless access to base->pending_map.
>>
>> It handles the the race between timer addition and timer interrupt
>> execution by unconditionally (in case of isolated CPUs) raising the
>> timer softirq after making sure the updated bitmap is visible
>> on remote CPUs.
>>
>> This patchset reduces cyclictest latency from 25us to 14us
>> on my testbox. 
>>
>>
> 
> Ping?
> 

Hi Marcelo,

I've been running your patches with lockdep and other debug options and did not
find any problem of this kind. Also, I did not find any kind of timing
regressions in tests with the PREEMPT RT...

-- Daniel
