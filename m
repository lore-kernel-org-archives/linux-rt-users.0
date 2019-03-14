Return-Path: <SRS0=rL3Y=RR=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9510EC43381
	for <linux-rt-users@archiver.kernel.org>; Thu, 14 Mar 2019 07:10:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6ACBB2184E
	for <linux-rt-users@archiver.kernel.org>; Thu, 14 Mar 2019 07:10:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727162AbfCNHJ5 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 14 Mar 2019 03:09:57 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33727 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726610AbfCNHJ4 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 14 Mar 2019 03:09:56 -0400
Received: by mail-wm1-f68.google.com with SMTP id c13so6112731wmb.0
        for <linux-rt-users@vger.kernel.org>; Thu, 14 Mar 2019 00:09:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+Aj8OTmPajxdr27wOgArDDDfg/uUox4NIQcMNv5EFKE=;
        b=ZKD9xjbIWAVWMx/Eu0/VC45Ppf41cI3txZSvEzU5Z1cA2menQAe5dY4ewGpKq1wofN
         0C4SfyKbZBeoIr4bHcmqJ5i6mD57LlVlEHvafjH4TDHfr/UdMNcBunVWqJFcyX3inHtC
         +hDkncCRr3PkLO1xXEZq/hkd8AKJrL2AugL1GtG3PNFTcZx7t/2pjFoQ4mGo0lkQ3p+l
         EkvX15Nx+R52ATLu8ef8mAIVfGcw8DFn8c29XaYoDGLddWp0OIQWiyQyndSoE8kuna5m
         ByxDkGToj0120YTTMCNFQdY5BE+gZpumEgnch3mK9nxjulSjQf3obgjgjbH4nmTNNyK6
         wpFA==
X-Gm-Message-State: APjAAAUlYWD0Umm+5BwfjL+OANyxZLJ/NPWGbIx5kbyaMFX9p4xJBrMg
        PH/JR3Bb8idrBIDzwXIn7DYzVg==
X-Google-Smtp-Source: APXvYqxOLmKj5LtZcgBOUMsbw3gBuw3a3gM9rIzmxPpbcRf+KU+rOwlBuiDFxGWGy9eTyxO52zop3A==
X-Received: by 2002:a1c:c00a:: with SMTP id q10mr1385168wmf.90.1552547394884;
        Thu, 14 Mar 2019 00:09:54 -0700 (PDT)
Received: from localhost.localdomain ([151.15.240.16])
        by smtp.gmail.com with ESMTPSA id h10sm2789890wmf.2.2019.03.14.00.09.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Mar 2019 00:09:54 -0700 (PDT)
Date:   Thu, 14 Mar 2019 08:09:51 +0100
From:   Juri Lelli <juri.lelli@redhat.com>
To:     tglx@linutronix.de, bigeasy@linutronix.de
Cc:     linux-rt-users@vger.kernel.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org, bristot@redhat.com,
        williams@redhat.com
Subject: Re: [RFC PATCH RT] x86/tsc: Add option to disable tsc clocksource
 watchdog
Message-ID: <20190314070951.GC31405@localhost.localdomain>
References: <20190307120913.13168-1-juri.lelli@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190307120913.13168-1-juri.lelli@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi,

On 07/03/19 13:09, Juri Lelli wrote:
> Clocksource watchdog has been found responsible for generating latency
> spikes (in the 10-20 us range) when woken up to check for TSC stability.
> 
> Add an option to disable it at boot.

Gentle ping.

Does this make any sense?

Thanks,

- Juri
