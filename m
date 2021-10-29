Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66A1FC433EF
	for <linux-rt-users@archiver.kernel.org>; Fri, 29 Oct 2021 16:04:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42AE0610E5
	for <linux-rt-users@archiver.kernel.org>; Fri, 29 Oct 2021 16:04:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbhJ2QHZ (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 29 Oct 2021 12:07:25 -0400
Received: from gateway34.websitewelcome.com ([192.185.149.46]:37155 "EHLO
        gateway34.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229607AbhJ2QHY (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 29 Oct 2021 12:07:24 -0400
Received: from cm14.websitewelcome.com (cm14.websitewelcome.com [100.42.49.7])
        by gateway34.websitewelcome.com (Postfix) with ESMTP id DF2C427E1D5F
        for <linux-rt-users@vger.kernel.org>; Fri, 29 Oct 2021 11:04:20 -0500 (CDT)
Received: from gator4132.hostgator.com ([192.185.4.144])
        by cmsmtp with SMTP
        id gUMemtS2gIWzGgUMem1f0O; Fri, 29 Oct 2021 11:04:20 -0500
X-Authority-Reason: nr=8
Received: from host-79-27-6-113.retail.telecomitalia.it ([79.27.6.113]:40440 helo=[10.0.0.44])
        by gator4132.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <bristot@kernel.org>)
        id 1mgUMd-001U4B-MR; Fri, 29 Oct 2021 11:04:19 -0500
Message-ID: <7c4174c7-350d-7922-b82e-862c5fa7477b@kernel.org>
Date:   Fri, 29 Oct 2021 18:04:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH V6 11/20] rtla/osnoise: Add the hist mode
Content-Language: en-US
To:     Steven Rostedt <rostedt@goodmis.org>, Tao Zhou <tao.zhou@linux.dev>
Cc:     Ingo Molnar <mingo@redhat.com>, Tom Zanussi <zanussi@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-rt-users@vger.kernel.org, linux-trace-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1635284863.git.bristot@kernel.org>
 <fede3c3805cb7a70bd7c8d60ba2c5ce290cc6e1e.1635284863.git.bristot@kernel.org>
 <YXmWTOXHYXFduayt@geo.homenetwork>
 <20211027142918.487cd143@gandalf.local.home>
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <20211027142918.487cd143@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4132.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - kernel.org
X-BWhitelist: no
X-Source-IP: 79.27.6.113
X-Source-L: No
X-Exim-ID: 1mgUMd-001U4B-MR
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: host-79-27-6-113.retail.telecomitalia.it ([10.0.0.44]) [79.27.6.113]:40440
X-Source-Auth: kernel@bristot.me
X-Email-Count: 17
X-Source-Cap: YnJpc3RvdG1lO2JyaXN0b3RtZTtnYXRvcjQxMzIuaG9zdGdhdG9yLmNvbQ==
X-Local-Domain: no
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 10/27/21 20:29, Steven Rostedt wrote:
> On Thu, 28 Oct 2021 02:11:24 +0800
> Tao Zhou <tao.zhou@linux.dev> wrote:
> 
>>> +	/* one histogram for IRQ and one for thread, per cpu */
>>> +	for (cpu = 0; cpu < nr_cpus; cpu++) {
>>> +		data->hist[cpu].samples = calloc(1, sizeof(*data->hist) * (entries + 1));  
>> @samples is a pointer to int and used for int array. The "sizeof(*data->hist)"
>> should be "sizeof(int)" or am I totally wrong.
> Or standard approach is: 
> 
> 		data->hist[cpu].samples = calloc(1, sizeof(*data->hist->samples) * (entries + 1));

Fixed in the next version, thanks!

-- Daniel
