Received: from 189.cn (ptr.189.cn [183.61.185.102])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4A30107A9;
	Wed, 26 Jun 2024 02:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=183.61.185.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719368229; cv=none; b=G3HflCi6jaW2ZhQ/U8pNkwldCmIsGFVHggKsW32ZwiPuoIURwgyMKOgILgh2wMkzi2pm912zu/xjr2Xv630gdhqjWAwyQxApyBIk3Mj907evuRqgwjO+AFGMMYjAxoVHwS1bEefMIv/TArqA73/VQxH8c/y7iAQMnIBll4Q8O3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719368229; c=relaxed/simple;
	bh=tlcw8aSshlygV70DbaFNvWk2OVZVjfrhVekR+bj8bdA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N5gHKCOV1QLF5gwPvrBrvPluUSegL7C+FyJf9pHHRadiJQZVRvsmdalAt5kvqX/JAlzxXLPgOElR+0Y1vjP9IexwNsQdFL8Tea7Q0v1hLT79+KvvoznvsdEALLR6sCDZMMVflCz5aUWpRLfTCL4ggRfirj/aw3pTlAmvp6yJhXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=189.cn; spf=pass smtp.mailfrom=189.cn; arc=none smtp.client-ip=183.61.185.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=189.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=189.cn
HMM_SOURCE_IP:10.64.8.41:55936.402325363
HMM_ATTACHE_NUM:0000
HMM_SOURCE_TYPE:SMTP
Received: from clientip-39.156.73.12 (unknown [10.64.8.41])
	by 189.cn (HERMES) with SMTP id B418A1004AA;
	Wed, 26 Jun 2024 10:17:02 +0800 (CST)
Received: from  ([39.156.73.12])
	by gateway-153622-dep-9dc64869d-vfmk8 with ESMTP id e32d2edd7bff4f9cb5e5bf0ad5bc101e for rostedt@goodmis.org;
	Wed, 26 Jun 2024 10:17:04 CST
X-Transaction-ID: e32d2edd7bff4f9cb5e5bf0ad5bc101e
X-Real-From: chensong_2000@189.cn
X-Receive-IP: 39.156.73.12
X-MEDUSA-Status: 0
Sender: chensong_2000@189.cn
Message-ID: <c56fce75-8528-4230-a5bb-34f920931298@189.cn>
Date: Wed, 26 Jun 2024 10:17:00 +0800
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: a question about how to debug this case in ftrace
To: Steven Rostedt <rostedt@goodmis.org>, Andrew Halaney <ahalaney@redhat.com>
Cc: Derek Barbosa <debarbos@redhat.com>, pmladek@suse.com,
 john.ogness@linutronix.de, senozhatsky@chromium.org,
 linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 williams@redhat.com, jlelli@redhat.com
References: <ZnGlt4uQRP_4nWu4@debarbos-thinkpadt14sgen2i.remote.csb>
 <6802e81c-1926-4195-812a-1a5fe13bcdde@189.cn>
 <xiune2bsqgin5ksk33q5bkihuz5qrv5casjofdyopes55zfcpc@uvvnlwxb4wcp>
 <20240625094406.42acfacf@rorschach.local.home>
Content-Language: en-US
From: Song Chen <chensong_2000@189.cn>
In-Reply-To: <20240625094406.42acfacf@rorschach.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Steven,

Some mobile manufactures used to reserve a space in emmc to dump message 
before oops, your work is smarter than this for it's getting rid of 
dependency of hardware.

I look forward to trying it when it comes out, many thanks.

BR

Song

在 2024/6/25 21:44, Steven Rostedt 写道:
> On Tue, 25 Jun 2024 08:20:15 -0500
> Andrew Halaney <ahalaney@redhat.com> wrote:
> 
>> So I ended up doing a sequence like:
>>
>>      tracing_off();
>>      ftrace_dump(DUMP_ALL);
> 
> I've done that several times too.
> 
>>
>> in the softlockup code when it was detected. Ideally I wanted to look at
>> the vmcore and look at the ftrace data in there (since debugging printk
>> by using printk is a little confusing), but there was a makedumpfile bug
>> I hit... so I went with the hacky route to prove to myself what was
>> going on. I think since then that's been resolved. Hope that helps!
> 
> You may be interested in some work I'm doing that allows you to read
> the ring buffer from a previous kernel after a crash.
> 
> https://lore.kernel.org/linux-trace-kernel/20240612231934.608252486@goodmis.org/
> 
> I also have a way to ask for any memory, that should be able to get the
> same location most times, via a "reserve_mem=" kernel command line
> parameter.
> 
> https://lore.kernel.org/linux-trace-kernel/20240613233415.734483785@goodmis.org/
> 
> They are both destined for the next merge window. After that, I have
> one more patch that ties the two together, so that you can have a
> kernel command line of:
> 
>   reserve_mem=12M:4096:trace trace_instance=bootmap@trace
> 
> and then when you boot up, you would have a trace instance that would
> be mapped to that memory. If your machine doesn't clear memory after a
> crash, you can read the data from the crash on the next boot.
> 
> -- Steve
> 
> 
