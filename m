Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D6DDC4338F
	for <linux-rt-users@archiver.kernel.org>; Sat, 14 Aug 2021 18:29:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F20D460524
	for <linux-rt-users@archiver.kernel.org>; Sat, 14 Aug 2021 18:29:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238931AbhHNS3y (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sat, 14 Aug 2021 14:29:54 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:60884 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233713AbhHNS3w (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Sat, 14 Aug 2021 14:29:52 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1A1B321EFF;
        Sat, 14 Aug 2021 18:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1628965762; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pBOJ3hxcgsKbFU0ZOokocEo7Rl62uXx2/3KVpDBVQSM=;
        b=CEFtwACknsaZVwf751g/qT36xHLOivQu96BzWYOZzcfSiKRAaWnlglklPr66OdXM/3c3/p
        leWMo5xxja3NH/BghsQ07NdZwCDOSaFtVhJGl+vGh1yNsUjgokioLXQRXp8TSeZDiGv9vG
        qX0lX5qAbesX5jjbNJiGaSl56UW99N4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1628965762;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pBOJ3hxcgsKbFU0ZOokocEo7Rl62uXx2/3KVpDBVQSM=;
        b=hYR8w//bIJv29dU90qDV/us49OOjlRuIkmpJ4yIgjWBVzeRgRs4mABWOoLSXj7XtCXz4BV
        mFh/Pai3WLWv8rDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AC1B413D1B;
        Sat, 14 Aug 2021 18:29:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id jWZpJoELGGGeRgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Sat, 14 Aug 2021 18:29:21 +0000
Subject: Re: [ANNOUNCE] v5.14-rc5-rt8
To:     Mike Galbraith <efault@gmx.de>,
        Clark Williams <williams@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        RT <linux-rt-users@vger.kernel.org>
References: <20210810163731.2qvfuhenolq2gdlv@linutronix.de>
 <20210812151803.52f84aaf@theseus.lan>
 <8c012c35852e98af99a6b6234a3f57ac27cd980a.camel@gmx.de>
 <522000b97adcfbc581e7e5ed1afc94519b1388b8.camel@gmx.de>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <94d74c8a-1e10-2500-468a-11c0ae7e2417@suse.cz>
Date:   Sat, 14 Aug 2021 20:28:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <522000b97adcfbc581e7e5ed1afc94519b1388b8.camel@gmx.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 8/14/21 7:33 AM, Mike Galbraith wrote:
> On Fri, 2021-08-13 at 12:56 +0200, Mike Galbraith wrote:
>> On Thu, 2021-08-12 at 15:18 -0500, Clark Williams wrote:
>>>
>>> Sebastian, et al,
>>>
>>> Got the following panic running v5.14-rc5-rt8:
>>>
>>> ...
>>
>>> Config is attached.
>>>
>>> I was running the rteval script that kicks off parallel kernel builds
>>> and hackbench runs as loads and runs cyclictest with a thread on each
>>> core:
>>>
>>> $ sudo rteval --duration=10m
>>
>> It took my box more than 10 minutes to explode, but with all those
>> debug options turned on, it did manage to do so in fairly short order.
>>
>> Off to build a fixed up 5.13-rt...
> 
> ...and it reproduced.  Transplanted 5.12-rt slub seems stable in both
> 5.1[34]-rt trees FWIW.

Why didn't you see it in earlier testing though? What's different now.

> 	-Mike
> 
> 

