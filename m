From: "Shi, Yang" <yang.shi@linaro.org>
Subject: Re: [RFC V4 PATCH] trace: writeback: replace cgroup path to cgroup
 ino
Date: Sun, 6 Mar 2016 19:32:26 -0800
Message-ID: <56DCF64A.3070409@linaro.org>
References: <1456996137-8354-1-git-send-email-yang.shi@linaro.org>
 <20160304125224.GG13868@htj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: gregkh@linuxfoundation.org, lizefan@huawei.com, tglx@linutronix.de,
	rostedt@goodmis.org, bigeasy@linutronix.de,
	linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
	linaro-kernel@lists.linaro.org
To: Tejun Heo <tj@kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-pf0-f180.google.com ([209.85.192.180]:36182 "EHLO
	mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751798AbcCGDce (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 6 Mar 2016 22:32:34 -0500
Received: by mail-pf0-f180.google.com with SMTP id 63so71322176pfe.3
        for <linux-rt-users@vger.kernel.org>; Sun, 06 Mar 2016 19:32:34 -0800 (PST)
In-Reply-To: <20160304125224.GG13868@htj.duckdns.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Steven,

Any comment on this one? I'm supposed it will be taken by your tracing tree?

Thanks,
Yang


On 3/4/2016 4:52 AM, Tejun Heo wrote:
> On Thu, Mar 03, 2016 at 01:08:57AM -0800, Yang Shi wrote:
>> commit 5634cc2aa9aebc77bc862992e7805469dcf83dac ("writeback: update writeback
>> tracepoints to report cgroup") made writeback tracepoints print out cgroup
>> path when CGROUP_WRITEBACK is enabled, but it may trigger the below bug on -rt
>> kernel since kernfs_path and kernfs_path_len are called by tracepoints, which
>> acquire spin lock that is sleepable on -rt kernel.
>
> Acked-by: Tejun Heo <tj@kernel.org>
>
> Thanks.
>

