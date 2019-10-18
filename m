Return-Path: <SRS0=Yxvf=YL=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9751CA9EA9
	for <linux-rt-users@archiver.kernel.org>; Fri, 18 Oct 2019 18:18:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C18CB21835
	for <linux-rt-users@archiver.kernel.org>; Fri, 18 Oct 2019 18:18:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502534AbfJRSSp (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 18 Oct 2019 14:18:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58862 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394221AbfJRSSo (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 18 Oct 2019 14:18:44 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 914AF756;
        Fri, 18 Oct 2019 18:18:44 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-59.bos.redhat.com [10.18.17.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D65E21001B00;
        Fri, 18 Oct 2019 18:18:43 +0000 (UTC)
Subject: Re: [PATCH RT] kernel/sched: Don't recompute cpumask weight in
 migrate_enable_update_cpus_allowed()
To:     Scott Wood <swood@redhat.com>, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Juri Lelli <jlelli@redhat.com>
References: <20191011140908.5161-1-longman@redhat.com>
 <0979a9a345e47be69783a2183dd31911e9fc755e.camel@redhat.com>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <fc777b62-63e2-8391-ce02-3fa7b88db27a@redhat.com>
Date:   Fri, 18 Oct 2019 14:18:43 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <0979a9a345e47be69783a2183dd31911e9fc755e.camel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Fri, 18 Oct 2019 18:18:44 +0000 (UTC)
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 10/12/19 3:06 AM, Scott Wood wrote:
> On Fri, 2019-10-11 at 10:09 -0400, Waiman Long wrote:
>> At each invocation of rt_spin_unlock(), cpumask_weight() is called
>> via migrate_enable_update_cpus_allowed() to recompute the weight of
>> cpus_mask which doesn't change that often.
>>
>> The following is a sample output of perf-record running the testpmd
>> microbenchmark on an RT kernel:
>>
>>   34.77%   1.65%  testpmd  [kernel.kallsyms]  [k] rt_spin_unlock
>>   34.32%   2.52%  testpmd  [kernel.kallsyms]  [k] migrate_enable
>>   21.76%  21.76%  testpmd  [kernel.kallsyms]  [k] __bitmap_weight
>>
>> By adding an extra variable to keep track of the weight of cpus_mask,
>> we could eliminate the frequent call to cpumask_weight() and replace
>> it with simple assignment.
> Can you try this with my migrate disable patchset (which makes
> amigrate_enable_update_cpus_allowed() be called much less often) and see if
> caching nr_cpus_allowed still makes a difference?
>
> -Scott

With lazy migrate_disable, I do think my patch will no longer be necessary.

Thanks,
Longman

