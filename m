From: Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [PATCH 2/2] rt: Increase/decrease the nr of migratory tasks when
 enabling/disabling migration
Date: Mon, 26 Jun 2017 14:16:10 +0200
Message-ID: <f7f9ee0a-706c-04d4-a21f-65bf6c214fde@redhat.com>
References: <cover.1498068819.git.bristot@redhat.com>
 <a6c37371135c028dda5fb09133e093b234576ee3.1498068819.git.bristot@redhat.com>
 <20170622083830.5thlni7wy6ggdbh5@gmail.com>
 <5c90773d-1283-d3de-4282-e3855331d4e4@redhat.com>
 <20170622194943.ho4yekdqqeg2qiva@gmail.com>
 <ba3011dc-4437-b0ea-4537-83051b83c914@redhat.com>
 <20170624064157.tc7xogi4aa5t7maf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
        "Luis Claudio R . Goncalves" <lgoncalv@redhat.com>,
        Clark Williams <williams@redhat.com>,
        Luiz Capitulino <lcapitulino@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-qt0-f180.google.com ([209.85.216.180]:35105 "EHLO
        mail-qt0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752081AbdFZMQP (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 26 Jun 2017 08:16:15 -0400
Received: by mail-qt0-f180.google.com with SMTP id f92so73013399qtb.2
        for <linux-rt-users@vger.kernel.org>; Mon, 26 Jun 2017 05:16:15 -0700 (PDT)
In-Reply-To: <20170624064157.tc7xogi4aa5t7maf@gmail.com>
Content-Language: en-US
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 06/24/2017 08:41 AM, Ingo Molnar wrote:
>> +enum inc_dec_migratory {
>> +	DEC_NR_MIGRATORY = -1,
>> +	INC_NR_MIGRATORY = 1,
>> +};
>> +
>> +static inline void
>> +inc_dec_nr_migratory(struct task_struct *p, enum inc_dec_migratory id)
>> +{
>> +	if (unlikely((p->sched_class == &rt_sched_class ||
>> +		      p->sched_class == &dl_sched_class) &&
>> +		      p->nr_cpus_allowed > 1)) {
>> +		if (p->sched_class == &rt_sched_class)
>> +			task_rq(p)->rt.rt_nr_migratory += id;
>> +		else
>> +			task_rq(p)->dl.dl_nr_migratory += id;
>> +	}
>> +}
> How about just 'long delta', pass in +1 or -1 and do away with the 
> inc_dec_migratory complication?

Ack! I am cooking a v2 using a long delta, rather than the
inc_dec_migratory complication (yeah, I exaggerated hehe).

Thanks!

-- Daniel
