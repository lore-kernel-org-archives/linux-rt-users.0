Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 392F4C433EF
	for <linux-rt-users@archiver.kernel.org>; Thu, 25 Nov 2021 14:57:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355802AbhKYPA6 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 25 Nov 2021 10:00:58 -0500
Received: from gateway23.websitewelcome.com ([192.185.49.179]:30046 "EHLO
        gateway23.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1355913AbhKYO66 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 25 Nov 2021 09:58:58 -0500
X-Greylist: delayed 1515 seconds by postgrey-1.27 at vger.kernel.org; Thu, 25 Nov 2021 09:58:58 EST
Received: from cm13.websitewelcome.com (cm13.websitewelcome.com [100.42.49.6])
        by gateway23.websitewelcome.com (Postfix) with ESMTP id 25337948AA
        for <linux-rt-users@vger.kernel.org>; Thu, 25 Nov 2021 08:30:30 -0600 (CST)
Received: from gator4132.hostgator.com ([192.185.4.144])
        by cmsmtp with SMTP
        id qFlemQypMHrvkqFlemBq67; Thu, 25 Nov 2021 08:30:30 -0600
X-Authority-Reason: nr=8
Received: from host-79-34-250-122.business.telecomitalia.it ([79.34.250.122]:43166 helo=[10.0.0.34])
        by gator4132.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <bristot@kernel.org>)
        id 1mqFlc-0044qe-Pz; Thu, 25 Nov 2021 08:30:29 -0600
Message-ID: <65848fd0-0b37-dde6-fa5a-259c07b69f34@kernel.org>
Date:   Thu, 25 Nov 2021 15:30:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH V7 05/14] rtla/osnoise: Add the hist mode
Content-Language: en-US
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Tao Zhou <tao.zhou@linux.dev>, Ingo Molnar <mingo@redhat.com>,
        Tom Zanussi <zanussi@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-rt-users@vger.kernel.org, linux-trace-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1635535309.git.bristot@kernel.org>
 <1d9826696a1e8c3584158c0dd570b8b22db708db.1635535309.git.bristot@kernel.org>
 <20211124171212.537b43c3@gandalf.local.home>
 <20211124171503.584c8dd2@gandalf.local.home>
 <f815794d-bfb6-3e76-3572-3c1cc059c492@kernel.org>
 <20211125092018.17e36369@oasis.local.home>
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <20211125092018.17e36369@oasis.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4132.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - kernel.org
X-BWhitelist: no
X-Source-IP: 79.34.250.122
X-Source-L: No
X-Exim-ID: 1mqFlc-0044qe-Pz
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: host-79-34-250-122.business.telecomitalia.it ([10.0.0.34]) [79.34.250.122]:43166
X-Source-Auth: kernel@bristot.me
X-Email-Count: 3
X-Source-Cap: YnJpc3RvdG1lO2JyaXN0b3RtZTtnYXRvcjQxMzIuaG9zdGdhdG9yLmNvbQ==
X-Local-Domain: no
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 11/25/21 15:20, Steven Rostedt wrote:
> On Thu, 25 Nov 2021 14:45:30 +0100
> Daniel Bristot de Oliveira <bristot@kernel.org> wrote:
> 
>>> Or do you think that 1d should be the default, and we have:
>>>
>>> 	tracefs_hist_alloc()	-- 1d histogram
>>> 	tracefs_hist_alloc_2d()	-- 2d histogram
>>> 	tracefs_hist_alloc_nd()	-- Nd histogram?
>>>
>>> ??  
>>
>> IMHO, the function names in your second email sound more intuitive, i.e.,
>> tracefs_hist_alloc()/tracefs_hist_alloc_2d()/tracefs_hist_alloc_nd().
>>
>>> We haven't tagged it yet, so we could change it again (and then your code
>>> will work as is).  
>>
>> two birds with a single stone :-)
> 
> Just to confirm (confused by "second email" above), you prefer that we
> update the API to:
> 
> 	tracefs_hist_alloc()
> 	tracefs_hist_alloc_2d()
> 	tracefs_hist_alloc_nd()
> 
> Right?

Right!

-- Daniel

> Thanks,
> 
> -- Steve
> 

