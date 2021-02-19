Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 830C6C433DB
	for <linux-rt-users@archiver.kernel.org>; Fri, 19 Feb 2021 16:36:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DC5064E44
	for <linux-rt-users@archiver.kernel.org>; Fri, 19 Feb 2021 16:36:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbhBSQgJ (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 19 Feb 2021 11:36:09 -0500
Received: from mx2.suse.de ([195.135.220.15]:56046 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229612AbhBSQgI (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 19 Feb 2021 11:36:08 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id DEE8EACBF;
        Fri, 19 Feb 2021 16:35:25 +0000 (UTC)
Subject: Re: [rt-tests v2 v2 01/20] cyclictest: Always use libnuma
To:     Christian Eggers <ceggers@arri.de>, John Kacur <jkacur@redhat.com>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Kurt Kanzenbach <kurt.kanzenbach@linutronix.de>,
        Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
References: <20201218161843.1764-1-dwagner@suse.de>
 <20210219161602.j7w6gwk7rao5u3ek@beryllium.lan>
 <f06c535-f340-4b51-2c0-369d88d39236@redhat.com> <4628381.31r3eYUQgx@n95hx1g2>
From:   Daniel Wagner <dwagner@suse.de>
Message-ID: <ba1a049e-3353-185c-6674-077a6b399860@suse.de>
Date:   Fri, 19 Feb 2021 17:35:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <4628381.31r3eYUQgx@n95hx1g2>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 19.02.21 17:27, Christian Eggers wrote:
> Just for clarification: Does this mean that cyclictest shall link against
> libnuma (libnuma can be built on ARM without problems), but not call it
> functions at runtime?

Yes, I think that is the idea of libnuma.
