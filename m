From: "Shi, Yang" <yang.shi@linaro.org>
Subject: Re: [RFC PATCH] kernfs: create raw version kernfs_path_len and
 kernfs_path
Date: Fri, 26 Feb 2016 12:23:17 -0800
Message-ID: <56D0B435.4080309@linaro.org>
References: <1456510505-6620-1-git-send-email-yang.shi@linaro.org>
 <20160226135628.09ce727c@gandalf.local.home> <56D0A97E.90706@linaro.org>
 <56D0AEAC.3070002@linaro.org> <20160226151503.39d39e45@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: gregkh@linuxfoundation.org, tj@kernel.org, lizefan@huawei.com,
	tglx@linutronix.de, bigeasy@linutronix.de,
	linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
	linaro-kernel@lists.linaro.org
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-pf0-f179.google.com ([209.85.192.179]:34941 "EHLO
	mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754003AbcBZUXT (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 26 Feb 2016 15:23:19 -0500
Received: by mail-pf0-f179.google.com with SMTP id w128so9723099pfb.2
        for <linux-rt-users@vger.kernel.org>; Fri, 26 Feb 2016 12:23:19 -0800 (PST)
In-Reply-To: <20160226151503.39d39e45@gandalf.local.home>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 2/26/2016 12:15 PM, Steven Rostedt wrote:
> On Fri, 26 Feb 2016 11:59:40 -0800
> "Shi, Yang" <yang.shi@linaro.org> wrote:
>
>
>> BTW, it sounds this is not the only point where kernfs_node could be
>> updated, __kernfs_remove should need synchronize_sched too.
>>
>
> Question is, can the kernfs of a cgroup be removed while the cgroup is
> still active?

Hmm, it sounds unlikely to me.

Yang


>
> I don't see the kernfs_rename_lock being held anywhere in that
> remove. If it can be an issue there with this patch, then it's an issue
> today, because the kernfs_mutex is not held by the tracepoint.
>
> -- Steve
>

