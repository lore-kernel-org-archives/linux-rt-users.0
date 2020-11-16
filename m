Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82767C4742C
	for <linux-rt-users@archiver.kernel.org>; Mon, 16 Nov 2020 11:51:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09EB12224B
	for <linux-rt-users@archiver.kernel.org>; Mon, 16 Nov 2020 11:51:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=natalenko.name header.i=@natalenko.name header.b="iEJ6si+0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729157AbgKPKcC (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 16 Nov 2020 05:32:02 -0500
Received: from vulcan.natalenko.name ([104.207.131.136]:43364 "EHLO
        vulcan.natalenko.name" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728511AbgKPKcC (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 16 Nov 2020 05:32:02 -0500
X-Greylist: delayed 43142 seconds by postgrey-1.27 at vger.kernel.org; Mon, 16 Nov 2020 05:31:56 EST
Received: from mail.natalenko.name (vulcan.natalenko.name [IPv6:fe80::5400:ff:fe0c:dfa0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vulcan.natalenko.name (Postfix) with ESMTPSA id 9157F89DC2F;
        Mon, 16 Nov 2020 11:31:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=dkim-20170712; t=1605522713;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RW9+DZxPbG7BPXx8z5i8KVwGDSEimGw3DWXVhERnpPQ=;
        b=iEJ6si+0pRehtmcVyRKN+0L/8E99U+vHsJAkGJP/9UShessO1gWdT6JHwjWJnUT65PloUV
        PJ4IPqoxhcF+30tVqH0zWqmUu8HB2My+ANxoYawMwy7LuXtNaoCozApr8hgnWUDx9xRetz
        KOaUSms5gZ3DzQ58+kJaCf1M+yghJWA=
MIME-Version: 1.0
Date:   Mon, 16 Nov 2020 11:31:53 +0100
From:   Oleksandr Natalenko <oleksandr@natalenko.name>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org
Subject: Re: WARNING at kernel/sched/core.c:2013
 migration_cpu_stop+0x2e3/0x330
In-Reply-To: <41d6aca71c6a52df8437cdb7b4a1b1c4@natalenko.name>
References: <a1fd0d9c6c8cd90a74879b61467ae48d@natalenko.name>
 <jhj3619y63v.mognet@arm.com>
 <41d6aca71c6a52df8437cdb7b4a1b1c4@natalenko.name>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <9fca17b11bdf298d43bd4789f61f90ef@natalenko.name>
X-Sender: oleksandr@natalenko.name
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 16.11.2020 11:27, Oleksandr Natalenko wrote:
> Not sure whether the check is legitimate, but FWIW I've managed to put
> a test task [1] (it spawns a lot of threads and applies affinity) into
> a permanent unkillable D state here:

Just to make it clear: I neither applied your patch nor saw a splat this 
time, just a D state only.

-- 
   Oleksandr Natalenko (post-factum)
