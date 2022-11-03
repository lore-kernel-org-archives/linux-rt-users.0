Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C19B2C4332F
	for <linux-rt-users@archiver.kernel.org>; Thu,  3 Nov 2022 07:59:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbiKCH67 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 3 Nov 2022 03:58:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231168AbiKCH6u (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 3 Nov 2022 03:58:50 -0400
Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2AB938B2
        for <linux-rt-users@vger.kernel.org>; Thu,  3 Nov 2022 00:58:49 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3EFC55E374;
        Thu,  3 Nov 2022 08:58:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
        t=1667462326; h=from:subject:date:message-id:to:cc:mime-version:content-type:
         in-reply-to:references; bh=ksmVbBhDVTsf65/2uwyUtdHO0r96B79TJux3DTE6pXk=;
        b=PzVmhNeoRGCAQuwBNeDrw9AaaF4TO1tqiUf95LzMEb5HSoYdfgzC2iOCWztSb5jZKryLEv
        +lUc/O5Aa12VKt3s7k8MCSteRGF/ji+IXh0N8YEM/OWczihj7657EKv+JcF6MQeSz47XXp
        8AdS0pn8vlHPS++eV93VmzP/C9CT28s3m20lqZEViYacZ0oDk1j6pDxyhd/5+ava6DCmWQ
        HX4eTp5U3z/giQ4yAVRM+fg+as1pLi8oKmlTtHRp5ZcR/N1YanBF16Fs9s9t1iTYdhjKX0
        O7+zrXli106wpuzHKAQ0PXN7XOnZebhtKO6SM5b/lCyQc4H8OIdCarB+Gg3L3w==
Date:   Thu, 3 Nov 2022 08:58:45 +0100
From:   Daniel Wagner <wagi@monom.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        homas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>,
        Pavel Machek <pavel@denx.de>
Subject: Re: [PATCH RT 0/3] timers: backport timer bits
Message-ID: <20221103075845.5ubmjpajbbnp5fcm@beryllium.lan>
References: <20221024105416.nflnrqhmzsyqqdzz@carbon.lan>
 <20221031155006.1651995-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221031155006.1651995-1-bigeasy@linutronix.de>
X-Last-TLS-Session-Version: TLSv1.3
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi Sebastian,

On Mon, Oct 31, 2022 at 04:50:03PM +0100, Sebastian Andrzej Siewior wrote:
> I've been looking at sleeping-while-atomic splats in
> v4.19.255-rt114-rc1.
> It received a backport of an intermediate state of the timers patches
> which were part of v5.0 during the development. It remained unchanged in
> the v5.2 cycle and got merged slightly different upstream in v5.4.
> 
> This is a small series for v4.19.255-rt114-rc1 which contains the patch,
> that was merged in v5.4 and the two fixes that followed on top.

Thanks a lot for looking into it. With these patches the sleep in atomic
context is gone and the quick test results are also looking good. I let
it run a bit longer than usual just to make sure.

Daniel

