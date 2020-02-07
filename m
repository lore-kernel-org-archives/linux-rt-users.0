Return-Path: <SRS0=JiWK=33=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 878DFC2D0B1
	for <linux-rt-users@archiver.kernel.org>; Fri,  7 Feb 2020 06:14:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66D0320838
	for <linux-rt-users@archiver.kernel.org>; Fri,  7 Feb 2020 06:14:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbgBGGO0 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 7 Feb 2020 01:14:26 -0500
Received: from mx0a-00000d04.pphosted.com ([148.163.149.245]:23154 "EHLO
        mx0a-00000d04.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726465AbgBGGO0 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 7 Feb 2020 01:14:26 -0500
Received: from pps.filterd (m0102889.ppops.net [127.0.0.1])
        by mx0a-00000d04.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01769SvB029538;
        Thu, 6 Feb 2020 22:13:51 -0800
Received: from mx0a-00000d03.pphosted.com (mx0a-00000d03.pphosted.com [148.163.149.244])
        by mx0a-00000d04.pphosted.com with ESMTP id 2xyhq04jry-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Feb 2020 22:13:51 -0800
Received: from pps.filterd (m0190089.ppops.net [127.0.0.1])
        by mx0a-00000d03.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0176DCBr002116;
        Thu, 6 Feb 2020 22:13:50 -0800
Received: from codegreen8.stanford.edu (codegreen8.stanford.edu [171.67.224.10])
        by mx0a-00000d03.pphosted.com with ESMTP id 2xyhngvb42-1
        (version=TLSv1 cipher=AES256-SHA bits=256 verify=NOT);
        Thu, 06 Feb 2020 22:13:50 -0800
Received: from codegreen8.stanford.edu (localhost.localdomain [127.0.0.1])
        by codegreen8.stanford.edu (Postfix) with ESMTP id 93E2678;
        Thu,  6 Feb 2020 22:13:49 -0800 (PST)
Received: from smtp.stanford.edu (smtp4.stanford.edu [171.67.219.72])
        by codegreen8.stanford.edu (Postfix) with ESMTP id 8489878;
        Thu,  6 Feb 2020 22:13:49 -0800 (PST)
Received: from cm-mail.stanford.edu (cm-mail.stanford.edu [171.64.197.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp.stanford.edu (Postfix) with ESMTPS id 7D8BF21D0F;
        Thu,  6 Feb 2020 22:13:49 -0800 (PST)
Received: from localhost.localdomain (c-73-189-214-134.hsd1.ca.comcast.net [73.189.214.134])
        (authenticated bits=0)
        by cm-mail.stanford.edu (8.14.4/8.14.4) with ESMTP id 0176DkPJ003086
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
        Thu, 6 Feb 2020 22:13:48 -0800
Cc:     nando@ccrma.Stanford.EDU, LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [ANNOUNCE] v5.4.17-rt9
To:     Mike Galbraith <efault@gmx.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20200204165811.imc5lvs3wt3soaw2@linutronix.de>
 <cda47e2f-fd9d-c4c8-7991-64fef38af0ef@ccrma.stanford.edu>
 <1581055866.25780.7.camel@gmx.de>
From:   Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Message-ID: <a6a9ba66-4e63-8156-2e49-291087d9e847@ccrma.stanford.edu>
Date:   Thu, 6 Feb 2020 22:13:46 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <1581055866.25780.7.camel@gmx.de>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
x-proofpoint-stanford-dir: outbound
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-06_04:2020-02-06,2020-02-06 signatures=0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-06_04:2020-02-06,2020-02-06 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0
 mlxlogscore=999 priorityscore=1501 mlxscore=0 clxscore=1011 malwarescore=0
 spamscore=0 impostorscore=0 adultscore=100 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002070044
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2/6/20 10:11 PM, Mike Galbraith wrote:
> On Thu, 2020-02-06 at 15:59 -0800, Fernando Lopez-Lezcano wrote:
>> On 2/4/20 8:58 AM, Sebastian Andrzej Siewior wrote:
>>> Dear RT folks!
>>>
>>> I'm pleased to announce the v5.4.17-rt9 patch set.
>>
>> Thanks!
>> I see a continuous stream of these:
> 
> (snips gripage)
> 
> Yup, d67739268cf0 annoys RT locking if lockdep is enabled.  The below
> shut it up for my i915 equipped lappy.

Wow, Mike, thanks!, will try it out and report...
(might take me a couple of days)

-- Fernando


> drm/i915/gt: use a LOCAL_IRQ_LOCK in __timeline_mark_lock()
> 
> Quoting drm/i915/gt: Mark up the nested engine-pm timeline lock as irqsafe
> 
>      We use a fake timeline->mutex lock to reassure lockdep that the timeline
>      is always locked when emitting requests. However, the use inside
>      __engine_park() may be inside hardirq and so lockdep now complains about
>      the mixed irq-state of the nested locked. Disable irqs around the
>      lockdep tracking to keep it happy.
> 
> This lockdep appeasement breaks RT because we take sleeping locks between
> __timeline_mark_lock()/unlock().  Use a LOCAL_IRQ_LOCK instead.
> 
> Signed-off-by: Mike Galbraith <efaukt@gmx.de>
> ---
>   drivers/gpu/drm/i915/gt/intel_engine_pm.c |    7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> 
> --- a/drivers/gpu/drm/i915/gt/intel_engine_pm.c
> +++ b/drivers/gpu/drm/i915/gt/intel_engine_pm.c
> @@ -38,12 +38,15 @@ static int __engine_unpark(struct intel_
>   }
> 
>   #if IS_ENABLED(CONFIG_LOCKDEP)
> +#include <linux/locallock.h>
> +
> +static DEFINE_LOCAL_IRQ_LOCK(timeline_lock);
> 
>   static inline unsigned long __timeline_mark_lock(struct intel_context *ce)
>   {
>   	unsigned long flags;
> 
> -	local_irq_save(flags);
> +	local_lock_irqsave(timeline_lock, flags);
>   	mutex_acquire(&ce->timeline->mutex.dep_map, 2, 0, _THIS_IP_);
> 
>   	return flags;
> @@ -53,7 +56,7 @@ static inline void __timeline_mark_unloc
>   					  unsigned long flags)
>   {
>   	mutex_release(&ce->timeline->mutex.dep_map, 0, _THIS_IP_);
> -	local_irq_restore(flags);
> +	local_unlock_irqrestore(timeline_lock, flags);
>   }
> 
>   #else
> 
> 


