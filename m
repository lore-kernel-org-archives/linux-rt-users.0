Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE70BC432BE
	for <linux-rt-users@archiver.kernel.org>; Tue,  3 Aug 2021 12:40:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97C8860F58
	for <linux-rt-users@archiver.kernel.org>; Tue,  3 Aug 2021 12:40:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235721AbhHCMkZ (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 3 Aug 2021 08:40:25 -0400
Received: from gateway20.websitewelcome.com ([192.185.47.18]:44816 "EHLO
        gateway20.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235998AbhHCMkY (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 3 Aug 2021 08:40:24 -0400
Received: from cm12.websitewelcome.com (cm12.websitewelcome.com [100.42.49.8])
        by gateway20.websitewelcome.com (Postfix) with ESMTP id 40B02401065E8
        for <linux-rt-users@vger.kernel.org>; Tue,  3 Aug 2021 07:23:45 -0500 (CDT)
Received: from gator4132.hostgator.com ([192.185.4.144])
        by cmsmtp with SMTP
        id AtiImXKAkBvjyAtiImMB16; Tue, 03 Aug 2021 07:40:06 -0500
X-Authority-Reason: nr=8
Received: from host-95-239-202-226.retail.telecomitalia.it ([95.239.202.226]:38642 helo=x1.bristot.me)
        by gator4132.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <bristot@kernel.org>)
        id 1mAtiH-0049qA-RO; Tue, 03 Aug 2021 07:40:06 -0500
Subject: Re: [PATCH v2 12/21] libtracefs; Add error message for bad selections
 to SQL sequence
To:     Steven Rostedt <rostedt@goodmis.org>,
        linux-trace-devel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Tom Zanussi <zanussi@kernel.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Clark Williams <williams@redhat.com>
References: <20210803042347.679499-1-rostedt@goodmis.org>
 <20210803042347.679499-13-rostedt@goodmis.org>
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
Message-ID: <f4fc1e3d-2383-f5d3-3938-0e131bf623cb@kernel.org>
Date:   Tue, 3 Aug 2021 14:40:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210803042347.679499-13-rostedt@goodmis.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4132.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - kernel.org
X-BWhitelist: no
X-Source-IP: 95.239.202.226
X-Source-L: No
X-Exim-ID: 1mAtiH-0049qA-RO
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: host-95-239-202-226.retail.telecomitalia.it (x1.bristot.me) [95.239.202.226]:38642
X-Source-Auth: kernel@bristot.me
X-Email-Count: 8
X-Source-Cap: YnJpc3RvdG1lO2JyaXN0b3RtZTtnYXRvcjQxMzIuaG9zdGdhdG9yLmNvbQ==
X-Local-Domain: no
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 8/3/21 6:23 AM, Steven Rostedt wrote:
> From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> 

there is a ; in the subject... "libtracefs;"

-- Daniel
