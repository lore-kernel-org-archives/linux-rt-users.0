Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BDC92E040D
	for <linux-rt-users@vger.kernel.org>; Mon,  4 May 2026 07:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777881229; cv=none; b=K24900WxpUDWD3wxrr5zd2AEMbiJYo5yTePCp4F9SN0hM7xTbXA81ZeGYpv9TLCdGlVZrUq59ZPz6YK+eepbDuPxK1DzFcYR+jDuaAv2GNkbt5GdKy2A5Y30CFhWp8pDHn1FHO8HRuEY5r5sDY1bMViJNnwy30Ao/LwcC/U7A7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777881229; c=relaxed/simple;
	bh=x+qSfoaIcbbTFqTu9cNIfmDT9uN1phNh4CCE5qSQRSg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=XTdiYLjeHxTEKuTYVwmlpea4KNz1B70gSimoWxpFKmrHoqZmncePgPhuyCvd5N8NAtDwcQL5vkgLQtXyKKGFis+SN7FZ7gUYLO/t4LetbCbDwHhnTo2MwBOpW/K4Xq3vPmRzsFvA72lt7Xla83wsbmrGD3jUolOX8YpMEEkioYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aRnrdFek; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aRnrdFek"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-483708b697cso4896715e9.3
        for <linux-rt-users@vger.kernel.org>; Mon, 04 May 2026 00:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777881226; x=1778486026; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DOVg3InKVTPB7x5MSdkMPQvwKgtck5mbGQevkLbGQDE=;
        b=aRnrdFekNzaCGGBleTE592xBiqHo2TH+7H5Doj7mMJ4FhUMHrZygCrQ5tu/UmVND9p
         9/cEhJjstqpHXueGZK6BVRhM7tCBkH8vjiZwo7t49FexPWc5PjLIPBzmxH3TQiQz21wc
         JmUBbIb7qD7LeU5oTxCP93f9uUMKlTeAnpRfue9Mz3yLJP29vOG2cs4ZoruGApcq+hMH
         211ukGBS5GgF1nOYG85bRxY2ZxrvmUhDKBhpO+f9ZHhRusjDIiSdOjS/HdeMOsFIh9xC
         4+W8YndaWuHEH69HXVm4OVwPOm0uV7D54qDwQE4he89Hfq9lEOWXQEpmte4SjkL9i3B7
         ctBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777881226; x=1778486026;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DOVg3InKVTPB7x5MSdkMPQvwKgtck5mbGQevkLbGQDE=;
        b=iLmBPS/7Ck2yTJBSc3NeLdlngpW/Zbdrik/1hZRqjk51NScenNN4G9rBq+JRyFSanO
         R394+mDJ/LigFJHwn6JJz9WSJBjO4tJ7sgWhrhz8BvhX30mGxDTkG7VAYVkyp+b3cbr8
         x6MeV5Jzx6RWMhksnXJgkh4O3Vz1YiJLDywUfPwbCArntPpqrA0GbGv0pkkRe9OBXZlt
         NxmV0J/xjZgTJyICtdNnnBvLbwUPte/CDp0lK5yf72HZRMq+rSFYHrHrAuzyZg9BbKm/
         sNt/9z8kpffIn3zKb3PLRL/Ns9T6H6PKGFRpqgZuS3qsvmiiPrWOHe269yhpqZZHlc78
         12TQ==
X-Forwarded-Encrypted: i=1; AFNElJ9qVWV5/96xNJxBwTYF8mvSneZex9pIh1rDU2EFzf2KE/MoeTwQMexIfOv9pcFaCUYfAtg5jqiKq1Ph9SDqvw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7QKPdx9z667xGehqYdizLo3Stln0109cJ5UOCiv7vHEFJJeff
	6WW33DLk9adQBz4Ke4D1jTpG0fWykutApveZ/VZGM5ykkFZofgPhTZY5
X-Gm-Gg: AeBDies+qflMyTHWpx+6nyBxAMFgDHmAOxDk5ieZRK60Uq6FJeAu7afLUI3ixikbQDp
	jM4Qp7IeB0T+tHIe/rXTOf5jULzKWU6AfvXSmQWwPSSWL/OR6+HIAdpiUgDvbcPqhBxiYo4VOJv
	HwVjoOs0GNiAibdpS5ZMrm+grFiYGEIHONbGCswOgtBl32jgPyFs/NdnGEl1OOit97m5PY6JZqh
	a8eFmbzLp9LFNy1ADBk/9qcir6FqNQuld+jlja1qNL147Js1nAXMrAqvbb2aFhQiQXDRr4zwMWp
	iofuUH16WsV0qRgdAMMyNCUm+yUP/OK8CvtlQ5JpuslzSzds4Eltgo0rHsgMQ2BcvR7yWThTHPP
	zxtEX2D/wTIR3CnxpfNy2bSoOxbnXGR94l9SxvRg9uP7wUZcva+eP41R8dS2U6klZsY5gqNUk/0
	CxKyJrCN67cFj3dGotpady/y6rzQPWTuTOau60bv/TqcLkqCR7ubTGKewPlxDExrFDWirz0xEjb
	/vdGCSTIujkTOsLKXCVfxFUzcrIbg==
X-Received: by 2002:a05:600c:4f0b:b0:487:1fbb:5a28 with SMTP id 5b1f17b1804b1-48a9852e356mr64156235e9.1.1777881226278;
        Mon, 04 May 2026 00:53:46 -0700 (PDT)
Received: from [192.168.0.110] (dslb-088-068-075-055.088.068.pools.vodafone-ip.de. [88.68.75.55])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-44a8f424032sm23506486f8f.15.2026.05.04.00.53.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 May 2026 00:53:45 -0700 (PDT)
Message-ID: <08b8969f-d79d-4c9b-8499-f3180fdd832f@gmail.com>
Date: Mon, 4 May 2026 09:53:44 +0200
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Question about SCHED_DEADLINE and cgroupv2/cpuset interaction
To: Gabriele Monaco <gmonaco@redhat.com>, linux-rt-users@vger.kernel.org
References: <ceba9f1b-0694-44ec-bdc9-a443d2127102@gmail.com>
 <d93c4b5e7dfb1ea784d8f0f7851f37f7bee2cacf.camel@redhat.com>
Content-Language: en-US
From: Tobias Jakobi <tobias.jakobi.lr@gmail.com>
In-Reply-To: <d93c4b5e7dfb1ea784d8f0f7851f37f7bee2cacf.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello Gabriele,

thanks for your feedback!

On 4/29/26 16:47, Gabriele Monaco wrote:
> Hi Tobias,
>
> giving my 2 cents here.
>
> On Tue, 2026-04-28 at 15:52 +0200, Tobias Jakobi wrote:
>> For the RT work we have these slices.
>>
>> root@cm4-fat:/etc/systemd/system# cat workload.slice
>> [Slice]
>> AllowedCPUs=2-3
>>
>> root@cm4-fat:/etc/systemd/system# cat workload-core2.slice
>> [Slice]
>> AllowedCPUs=2
>>
> Applying the configuration above, I get both slices as member
> partitions (not root):
>
> head /sys/fs/cgroup/workload.slice/{,*/}cpuset.cpus.partition
> ==> /sys/fs/cgroup/workload.slice/cpuset.cpus.partition <==
> member
>
> ==> /sys/fs/cgroup/workload.slice/workload-core2.slice/cpuset.cpus.partition <==
> member
>
> Running your example in either slice doesn't work in my case.
> That's because in the admission control we "Don't allow tasks with an
> affinity mask smaller than the entire root_domain to become
> SCHED_DEADLINE" [1].

Actually I saw this comment during my investigation. But I disregarded 
it quickly, reasons see below.

Anyway, I saw this term "root_domain" being mentioned a few times in the 
documentation 
(https://www.kernel.org/doc/Documentation/scheduler/sched-deadline.rst). 
But only there. It is not mentioned at all in the rest of the docs. Nor 
have I found a definition for it. Might as well ask this here, what 
exactly is this root_domain supposed to be? Yes, there is this comment 
for struct root_domain in sched/sched.h, but honestly, without heavy 
knowledge about the scheduler codebase this tells me almost nothing... :-(

> In short that's to make the admission control able to give guarantees.
>
> Setting the partition as root:
>
> echo root > /sys/fs/cgroup/workload.slice/cpuset.cpus.partition
> echo root > /sys/fs/cgroup/workload.slice/workload-core2.slice/cpuset.cpus.partition
>
> Fixes the issue in my case.
> I don't really know how to specify that in systemd and I'm assuming
> your version/configuration of systemd was somehow setting workload-
> slice as root automatically, that's likely why it was working.
>
> Could you try this on your side?

Sure, as I said above I disregarded the comment in syscalls.c after 
fiddling with this.

So, first of all, when doing nothing on top of what systemd does, then 
both cpuset.cpus.partition are member. What I did not mention in the 
initial mail was that I tried to change the partition type. 
Unsuccessfully however.

root@cm4-fat:/sys/fs/cgroup/workload.slice# echo root > 
cpuset.cpus.partition
root@cm4-fat:/sys/fs/cgroup/workload.slice# echo root > 
workload-core2.slice/cpuset.cpus.partition
root@cm4-fat:/sys/fs/cgroup/workload.slice# cat cpuset.cpus.partition
root invalid (partition config conflicts with housekeeping setup)
root@cm4-fat:/sys/fs/cgroup/workload.slice# cat 
workload-core2.slice/cpuset.cpus.partition
root invalid (Invalid cpu list in cpuset.cpus.exclusive)
root@cm4-fat:/sys/fs/cgroup/workload.slice# grep . cpuset.*
cpuset.cpus:2-3
cpuset.cpus.effective:2-3
cpuset.cpus.partition:root invalid (partition config conflicts with 
housekeeping setup)
cpuset.mems.effective:0
root@cm4-fat:/sys/fs/cgroup/workload.slice# cd workload-core2.slice/
root@cm4-fat:/sys/fs/cgroup/workload.slice/workload-core2.slice# grep . 
cpuset.*
cpuset.cpus:2
cpuset.cpus.effective:2
cpuset.cpus.partition:root invalid (Invalid cpu list in 
cpuset.cpus.exclusive)
cpuset.mems.effective:0

I then remembered reading something in the systemd documentation about 
cgroup delegation and that changing anything cgroup related right under 
systemd's nose was asking for trouble. I guess this is what "partition 
config conflicts with housekeeping setup" is supposed to tell me here?

After I wasn't getting anywhere here I focused on the bandwidth check. 
And since the whole thing worked after disabling the check, I 
disregarded the root_domain/partition idea.

But I guess the real cause is the root_domain then?

With best wishes,
Tobias

>
> Cheers,
> Gabriele
>
> [1] -
> https://elixir.bootlin.com/linux/v7.0.1/source/kernel/sched/syscalls.c#L627
>
>> Note that core2 is a child of workload, i.e. on the cgroup level it
>> looks like this.
>>
>> root@cm4-fat:~# find /sys/fs/cgroup/ -name workload\*.slice
>> /sys/fs/cgroup/workload.slice
>> /sys/fs/cgroup/workload.slice/workload-core2.slice
>>
>> So what's exactly this problem I'm seeing? It's this here.
>>
>> root@cm4-fat:~# systemd-run --slice=workload-core2.slice --pty chrt
>> --sched-runtime 100000 --sched-period 200000 --deadline 0 echo this
>> works
>> Running as unit: run-p676-i976.service; invocation ID:
>> d59dc443f66f46a6ba2dfd125e04f830
>> Press ^] three times within 1s to disconnect TTY.
>> chrt: failed to set pid 0's policy: Operation not permitted
>>
>> What works however is this here.
>>
>> root@cm4-fat:~# systemd-run --slice=workload.slice --pty chrt
>> --sched-runtime 100000 --sched-period 200000 --deadline 0 echo this
>> works
>> Running as unit: run-p670-i970.service
>> Press ^] three times within 1s to disconnect TTY.
>> this works
>>
>> I double checked the slice settings, and they apply.
>>
>> root@cm4-fat:~# systemd-run --slice=workload.slice --pty bash -c
>> 'grep
>> Cpus_allowed_list /proc/$BASHPID/status'
>> Running as unit: run-p727-i1027.service
>> Press ^] three times within 1s to disconnect TTY.
>> Cpus_allowed_list:      2-3
>>
>> Once again for the core2 slice.
>>
>> root@cm4-fat:~# systemd-run --slice=workload-core2.slice --pty bash -
>> c
>> 'grep Cpus_allowed_list /proc/$BASHPID/status'
>> Running as unit: run-p732-i1032.service
>> Press ^] three times within 1s to disconnect TTY.
>> Cpus_allowed_list:      2
>>
>> This really puzzled here. Why would this work for AllowedCPUs=2-3,
>> but
>> not for AllowedCPUs=2?
>>
>> I then dove in the documentation and the code, trying to understand
>> where the -EPERM was coming from. I finally decided to disable the
>> bandwidth check that the kernel performs.
>>
>> root@cm4-fat:~# echo -1 > /proc/sys/kernel/sched_rt_runtime_us
>> root@cm4-fat:~# systemd-run --slice=workload-core2.slice --pty chrt
>> --sched-runtime 100000 --sched-period 200000 --deadline 0 echo this
>> works
>> Running as unit: run-p760-i1060.service
>> Press ^] three times within 1s to disconnect TTY.
>> this works
>>
>> And voila, suddenly everything works. I fail to understand though why
>> the bandwidth check fails here. I mean, 100000 / 200000, that's fifty
>> percent, so the check should pass.
>>
>> And apparantly the ratio itself doesn't seem to have any effect. I
>> enabled the check again and reduced the runtime so that the ratio is
>> just 5%. Still the same.
>>
>> root@cm4-fat:~# echo 950000 > /proc/sys/kernel/sched_rt_runtime_us
>> root@cm4-fat:~# systemd-run --slice=workload-core2.slice --pty chrt
>> --sched-runtime 1000 --sched-period 200000 --deadline 0 echo this
>> works
>> Running as unit: run-p838-i1138.service
>> Press ^] three times within 1s to disconnect TTY.
>> chrt: failed to set pid 0's policy: Operation not permitted
>>
>> I looked around some more, made sure that CONFIG_RT_GROUP_SCHED=n,
>> but
>> the more I think about, the more I get the impression that I totally
>> misunderstand how the bandwidth check works.
>>
>> To be explicit, by bandwidth check I mean the line that is found in
>> section 4.1. here:
>> https://www.kernel.org/doc/Documentation/scheduler/sched-deadline.rst
>>
>> Would be nice if someone could shed some light on this. Thanks in
>> advance!
>>
>> With best wishes,
>> Tobias Jakobi
>>
