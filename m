Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AF2EC43217
	for <linux-rt-users@archiver.kernel.org>; Tue, 25 Jan 2022 08:59:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1454466AbiAYI7h (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 25 Jan 2022 03:59:37 -0500
Received: from gateway30.websitewelcome.com ([192.185.149.4]:26147 "EHLO
        gateway30.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1454040AbiAYI50 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 25 Jan 2022 03:57:26 -0500
X-Greylist: delayed 1425 seconds by postgrey-1.27 at vger.kernel.org; Tue, 25 Jan 2022 03:57:26 EST
Received: from cm11.websitewelcome.com (cm11.websitewelcome.com [100.42.49.5])
        by gateway30.websitewelcome.com (Postfix) with ESMTP id 7AA18B98F
        for <linux-rt-users@vger.kernel.org>; Tue, 25 Jan 2022 02:33:38 -0600 (CST)
Received: from gator4132.hostgator.com ([192.185.4.144])
        by cmsmtp with SMTP
        id CHGknMrSyINxBCHGknLWie; Tue, 25 Jan 2022 02:33:38 -0600
X-Authority-Reason: nr=8
Received: from host-79-47-126-144.retail.telecomitalia.it ([79.47.126.144]:33426 helo=[10.0.0.238])
        by gator4132.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <bristot@kernel.org>)
        id 1nCHGj-0017BZ-SE; Tue, 25 Jan 2022 02:33:38 -0600
Message-ID: <1c2fe9ac-804e-2068-0800-2cee012b96d3@kernel.org>
Date:   Tue, 25 Jan 2022 09:33:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] docs: Hook the RTLA documents into the kernel docs build
Content-Language: en-US
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        linux-trace-devel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
References: <877dau555q.fsf@meer.lwn.net>
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <877dau555q.fsf@meer.lwn.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4132.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - kernel.org
X-BWhitelist: no
X-Source-IP: 79.47.126.144
X-Source-L: No
X-Exim-ID: 1nCHGj-0017BZ-SE
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: host-79-47-126-144.retail.telecomitalia.it ([10.0.0.238]) [79.47.126.144]:33426
X-Source-Auth: kernel@bristot.me
X-Email-Count: 3
X-Source-Cap: YnJpc3RvdG1lO2JyaXN0b3RtZTtnYXRvcjQxMzIuaG9zdGdhdG9yLmNvbQ==
X-Local-Domain: no
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 1/21/22 01:00, Jonathan Corbet wrote:
> The RTLA documents were added to Documentation/ but never hooked into the
> rest of the docs build, leading to a bunch of warnings like:
> 
>   Documentation/tools/rtla/rtla-osnoise.rst: WARNING: document isn't included in any toctree
> 
> Add some basic glue to wire these documents into the build so that they are
> available with the rest of the rendered docs.  No attempt has been made to
> turn the RTLA docs into proper RST files rather than warmed-over man pages;
> that is an exercise for the future.
> 
> Fixes: d40d48e1f1f2 ("rtla: Add Documentation")
> Signed-off-by: Jonathan Corbet <corbet@lwn.net>

Acked-by: Daniel Bristot de Oliveira <bristot@kernel.org>

Thanks, Jon!

-- Daniel
