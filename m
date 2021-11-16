Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 687C1C433F5
	for <linux-rt-users@archiver.kernel.org>; Tue, 16 Nov 2021 09:37:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50FD961BFB
	for <linux-rt-users@archiver.kernel.org>; Tue, 16 Nov 2021 09:37:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233087AbhKPJkV (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 16 Nov 2021 04:40:21 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:43036 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233059AbhKPJkU (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 16 Nov 2021 04:40:20 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4E20B218A4;
        Tue, 16 Nov 2021 09:37:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637055443; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xeWxRcaT8PuG3nRTAHWZSftWsY+fuS0E6ePdI33r+IQ=;
        b=jcfhYd+aqSX1a1C3PRTqybPI+Rx63fOkHxdX3pD+KQlQy2MmzUCCPqk/sfFLYyyhExu8vD
        YXd9UaDgoEm1TxUKXDJhuEj7qno+QpB+4zPGu35hj4dWiCdjalvA9syivseoWJx1dfGn8l
        US1E6MKlcBdh9Un7CDM4E+xt7xCaPB4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637055443;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xeWxRcaT8PuG3nRTAHWZSftWsY+fuS0E6ePdI33r+IQ=;
        b=I5+HHclDdjygE2K+VacG1OyFdHwq6th7l2oyoKQn8DjnzCtZThkYhBJSA9Smv4sJyl6b2m
        YKYaW02phpAuMEBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2972913BFD;
        Tue, 16 Nov 2021 09:37:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id z+YmCdN7k2H2EAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 16 Nov 2021 09:37:23 +0000
Message-ID: <5057a47c-dcdd-5420-9e09-7ade50553dd0@suse.cz>
Date:   Tue, 16 Nov 2021 10:37:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: hackbench score comparison between 5.10.75-rt47 and 5.14.14-rt21
Content-Language: en-US
To:     'Sebastian Andrzej Siewior' <bigeasy@linutronix.de>,
        Chanho Park <chanho61.park@samsung.com>
Cc:     linux-rt-users@vger.kernel.org,
        'Thomas Gleixner' <tglx@linutronix.de>
References: <CGME20211103031549epcas2p34418a4e6218ca93da57a0c373691bd41@epcas2p3.samsung.com>
 <009301d7d061$1a1bbeb0$4e533c10$@samsung.com>
 <20211103091349.m7dvgqpbc2epgbi3@linutronix.de>
 <000001d7d1e6$47eebaf0$d7cc30d0$@samsung.com>
 <20211112140045.p4bybe4uxy7xwj4i@linutronix.de>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20211112140045.p4bybe4uxy7xwj4i@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 11/12/21 15:00, 'Sebastian Andrzej Siewior' wrote:
> On 2021-11-05 10:41:40 [+0900], Chanho Park wrote:
>> Hi,
> Hi,
> 
>> I checked the same test on my aarch64 target. I'll do more realistic
>> benchmark such as compile bench.
>> 
>> <5.10.73-rt54 aarch64>
>> root@euto-v9-sadk:~# hackbench -l 10000
>> Time: 24.994
>> 
>> <5.15.0-rt17 aarch64 w/o CONFIG_SLUB_CPU_PARTIAL>
>> root@euto-v9-sadk:~# hackbench -l 10000
>> Time: 31.372
>> 
>> <5.15.0-rt17 aarch64 w/ CONFIG_SLUB_CPU_PARTIAL>
>> root@euto-v9-sadk:~# hackbench -l 10000
>> Time: 35.269
> 
> The last two are equal, is that on purporse?

I see the first of last two is without SLUB_CPU_PARTIAL and the second with
SLUB_CPU_PARTIAL, so not equal?

> Any feedback on v5.14-rc3-rt1 and v5.14-rc3-rt2? v5.13-rt1 should be
> identical to you 5.10 numbers.
> 
>> Best Regards,
>> Chanho Park
> 
> Sebastian
> 

