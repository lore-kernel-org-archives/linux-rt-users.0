From: "Leon Woestenberg" <leon.woestenberg@gmail.com>
Subject: Re: [PATCH -rt] Add schedule_work_prio() and queue_work_prio().
Date: Mon, 30 Jun 2008 18:38:21 +0200
Message-ID: <c384c5ea0806300938ucf1cbc2j39380ee33eb8bf12@mail.gmail.com>
References: <c384c5ea0806281023y6fcfb0f4o1a41aef3856bda9e@mail.gmail.com>
	 <Pine.LNX.4.58.0806300846590.13037@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: RT <linux-rt-users@vger.kernel.org>
To: "Steven Rostedt" <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.245]:17548 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752954AbYF3QiW (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 30 Jun 2008 12:38:22 -0400
Received: by an-out-0708.google.com with SMTP id d40so313816and.103
        for <linux-rt-users@vger.kernel.org>; Mon, 30 Jun 2008 09:38:21 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.58.0806300846590.13037@gandalf.stny.rr.com>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Steven,

On Mon, Jun 30, 2008 at 2:47 PM, Steven Rostedt <rostedt@goodmis.org> wrote:
> On Sat, 28 Jun 2008, Leon Woestenberg wrote:
>> Against 2.6.25.8-rt7, only compile tested.
>>
>> +int queue_work_prio(struct workqueue_struct *wq, struct work_struct
>> *work, int prio)
>>  {
>>       int ret = 0, cpu = raw_smp_processor_id();
>>
>> @@ -184,6 +185,25 @@
>>       }
>>       return ret;
>>  }
>> +EXPORT_SYMBOL_GPL(queue_work_prio);
>
> This function doesn't look like it does anything with the new "prio"
> field.
>
I have submitted a newer patch in a seperate email that fixes this.

Regards,
-- 
Leon
