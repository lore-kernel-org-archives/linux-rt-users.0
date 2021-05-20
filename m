Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4AC8C433ED
	for <linux-rt-users@archiver.kernel.org>; Thu, 20 May 2021 07:36:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9217C60FDC
	for <linux-rt-users@archiver.kernel.org>; Thu, 20 May 2021 07:36:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbhETHiK (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 20 May 2021 03:38:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbhETHiK (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 20 May 2021 03:38:10 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69D78C061574
        for <linux-rt-users@vger.kernel.org>; Thu, 20 May 2021 00:36:49 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id w12so10476505edx.1
        for <linux-rt-users@vger.kernel.org>; Thu, 20 May 2021 00:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=Nyq+S4eWCM0kpbUqEgDAxybNxEXcc+iLpUvKALwflM4=;
        b=vJdJXe3yG1lJb+0MY2kRTE+nR7U7ijBPPEUamtOahZKInU8R/2i3rx82iLVZX4gHgL
         U/5lR1e9kILBXTArNBZIAjoBFjYRDmzuyM3Z3nBD9Oq8a9gR+eb1Q34dWbvrdkgNLeRo
         f50ELE7AT2qH06e1mk0OW3AdPXvPoQvWfHDMlIjgkgMRMxavXhY9Ae8jPjSAX8qEzqa1
         49j5LMwP8J3WPL+Tz8H3EtJqUPeQNVtwy2Pn3W8WMm3fPc0qLMUSRcFAVNHkwzamy4vx
         CAdnYSxE8lLEGQMlaTp5fFQ4tv8T1VhKN1TeVHowZGyO2EWImte6xmIJ6XrMbq8KW5un
         EZkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=Nyq+S4eWCM0kpbUqEgDAxybNxEXcc+iLpUvKALwflM4=;
        b=t2WHvAKvBidMYIvrHTjkQ260jlgTEFyMbc3O/VIybREjTNx/Ap72GS5hD05xxdKDNa
         qdSA8YlXJCYoLNOmx5F4EASwaKAsaUynRaoX8Ow5+JOeMberfHR/Q9Joys/+j7fQtIWR
         NWGKHZOvpMrlDfWKne+3/tGFKEe6gBpyqadjwUbGA+3hD781Ht1Pq/UPIFvPIwQlTcvm
         vUIKPjXocpZPLT0BBMFFgrY7pZ/1xMkjy5pRBj/OztLF0OyBKe9U7i/Z+hq/lfAgFbL3
         NYMYRqw0uELzfv2MXlzBQL75aD6fiy5xlvMv7wUvd37cUkZNroWJIDW50rV1xc8c5nlJ
         7oUA==
X-Gm-Message-State: AOAM530V7lNIKCIZWCvQHEH2oddqxWo7gBvGtKse/CUaXLWdIOk1wqWp
        +OsAqCqzmFNY0PTkpjei6X8sxS4hFfE=
X-Google-Smtp-Source: ABdhPJwvoVEN4lGO753UQGA4JvAhG5JmAxejalcxE8xf4l2XlzHQjFKwr3zTumPZeFr7LBaDwfqaGA==
X-Received: by 2002:aa7:db57:: with SMTP id n23mr3524453edt.229.1621496208105;
        Thu, 20 May 2021 00:36:48 -0700 (PDT)
Received: from [192.168.1.11] (46-22-16-89-dynamic-cgnat.cust.swissbackbone.net. [46.22.16.89])
        by smtp.gmail.com with ESMTPSA id k9sm1047923edv.69.2021.05.20.00.36.47
        for <linux-rt-users@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 May 2021 00:36:47 -0700 (PDT)
From:   Christoph Mathys <eraserix@gmail.com>
Subject: Network latency on 5.4 and 5.10
To:     linux-rt-users@vger.kernel.org
Message-ID: <6aa61bb9-0443-6da3-0902-9fe700c24017@gmail.com>
Date:   Thu, 20 May 2021 09:36:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi all!

I'm trying to upgrade from 4.9-rt to 5.4-rt (also tried 5.10). I'm 
having a hard time getting networking to perform on the same level as 
4.9 (latency wise). We drive an EtherCAT bus at 4kHz using the igb driver.

On 4.9, I just had to disable coalescing on the nic and increase the 
priority of the irg threads and it performed as desired (more or less 
according to [1] for 3.6+ without task pinning)

Doing the same on 5.4/5.10 does not seem to suffice any more. I get a 
lot of warnings from our code that packets have not been sent or 
received in time for the next control loop iteration.

Any suggestions on what I could try to improve the nic response?

Thanks!
Christoph

[1] 
https://www.osadl.org/Real-time-Ethernet-UDP-worst-case-roun.qa-farm-rt-ethernet-udp-monitor+M514ebdffa90.0.html
