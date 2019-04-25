Return-Path: <SRS0=auL/=S3=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 541C9C282E1
	for <linux-rt-users@archiver.kernel.org>; Thu, 25 Apr 2019 06:51:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 334DE218AD
	for <linux-rt-users@archiver.kernel.org>; Thu, 25 Apr 2019 06:51:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729841AbfDYGvh (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 25 Apr 2019 02:51:37 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:56480 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbfDYGvb (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 25 Apr 2019 02:51:31 -0400
Received: from localhost ([127.0.0.1] helo=vostro.local)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <john.ogness@linutronix.de>)
        id 1hJYEB-000655-46; Thu, 25 Apr 2019 08:51:27 +0200
From:   John Ogness <john.ogness@linutronix.de>
To:     Scott Wood <swood@redhat.com>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH] printk: kmsg_dump: remove mutex usage
References: <91d59e3f2074265c834b9a7ea48a7b41292fc9f8.camel@redhat.com>
        <87pnpb79nv.fsf@linutronix.de>
        <1a771e7bfe8f7cc296809307cc75372c7cec42be.camel@redhat.com>
Date:   Thu, 25 Apr 2019 08:51:26 +0200
In-Reply-To: <1a771e7bfe8f7cc296809307cc75372c7cec42be.camel@redhat.com>
        (Scott Wood's message of "Wed, 24 Apr 2019 15:07:25 -0500")
Message-ID: <87v9z2inm9.fsf@linutronix.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2019-04-24, Scott Wood <swood@redhat.com> wrote:
> On Wed, 2019-04-24 at 16:36 +0200, John Ogness wrote:
>> @@ -2830,16 +2829,18 @@ void kmsg_dump(enum kmsg_dump_reason reason)
>>  		if (dumper->max_reason && reason > dumper->max_reason)
>>  			continue;
>>  
>> -		/* initialize iterator with data about the stored records */
>> -		dumper->active = true;
>> +		/*
>> +		 * use a local copy to avoid modifying the
>> +		 * iterator used by any other cpus/contexts
>> +		 */
>> +		memcpy(&dumper_local, dumper, sizeof(dumper_local));
>>  
>> -		kmsg_dump_rewind(dumper);
>> +		/* initialize iterator with data about the stored records */
>> +		dumper_local.active = true;
>> +		kmsg_dump_rewind(&dumper_local);
>>  
>>  		/* invoke dumper which will iterate over records */
>> -		dumper->dump(dumper, reason);
>> -
>> -		/* reset iterator */
>> -		dumper->active = false;
>> +		dumper_local.dump(&dumper_local, reason);
>>  	}
>
> When would a dumper (or anything else that checks it) ever see active be
> false?

A valid question. Originally I wanted to completely remove the active
flag. But really the rt patchset is not the place for these kinds of
changes. I am currently reworking printk (for mainline) and I will
evaluate the purpose/usefulness of the active flag for that work.

>>  	rcu_read_unlock();
>>  }
>> @@ -2951,9 +2952,7 @@ bool kmsg_dump_get_line(struct kmsg_dumper *dumper,
>> bool syslog,
>>  {
>>  	bool ret;
>>  
>> -	mutex_lock(&kmsg_dump_lock);
>>  	ret = kmsg_dump_get_line_nolock(dumper, syslog, line, size, len);
>> -	mutex_unlock(&kmsg_dump_lock);
>>  
>>  	return ret;
>>  }
>> @@ -3105,9 +3104,7 @@ void kmsg_dump_rewind_nolock(struct kmsg_dumper
>> *dumper)
>>   */
>>  void kmsg_dump_rewind(struct kmsg_dumper *dumper)
>>  {
>> -	mutex_lock(&kmsg_dump_lock);
>>  	kmsg_dump_rewind_nolock(dumper);
>> -	mutex_unlock(&kmsg_dump_lock);
>>  }
>>  EXPORT_SYMBOL_GPL(kmsg_dump_rewind);
>>  
>
> Any reason not to get rid of the wrappers now that the lock's gone?

I wanted my patch to be as less intrusive as possible. For my mainline
work I will look into eliminating the wrappers.

John Ogness
