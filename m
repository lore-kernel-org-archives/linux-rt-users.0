Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C6035F8AB
	for <linux-rt-users@vger.kernel.org>; Fri,  8 May 2026 07:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778227016; cv=none; b=bX30FCxg0Selxn+qHQSiQMU3vvtEx8bd1ZhrB5yHK9J680sf2SDrGcsP3t8jp2jzU9p1nOg9Nkm1cEUM32Uf8nc0zXryrBDijqPRamneU5yUBtcA3hiY6c9A/2g+mOV3LyvTXVjwcmKpJnxqHL81jNpl0RMFye4EZhWUbjznqeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778227016; c=relaxed/simple;
	bh=yU7jjOZSoEe1/4dkyUgvqaUYWURf1f+Ubks3UZaUTS8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Tr/LBU/Fc+a4rHDkawG+PuGX+IqHvIA0M7Pp+UW1OR4b4DI9oapliy89bIpfdQrZ+6wLZSvXih0X1z3R7vWKQSVEHfQUgjlK3w9XYHEVYzhVZ1qTl1GeYXBWzaZiU8Ci/35T6U8uSD7cclLvcexQJ4tDEwlIz/Bq1kMr6y1suas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DNlboE4p; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DNlboE4p"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-449cdc12a8aso192554f8f.2
        for <linux-rt-users@vger.kernel.org>; Fri, 08 May 2026 00:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778227013; x=1778831813; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bMxbgVUoPP4wt0fjYdzdFOi78nKz476tRMZZcFG9CRo=;
        b=DNlboE4pHu6azW6hvzuJSPS+awte8M57rz44U+lsuAw8I6xo3qwSvq4+KXWA5Rj/Ck
         j78Yf+o/jKvvZwvBfJAgB1m44hBkYj5ygNjs74UlXrBnB2mAWpdhxrGNv5naLhBtHwV6
         OL66DPa1kjsN2lYNQjOP9c1bU5ZLYDn0KjwgRJqi2cUcRV5UbSWlBogPi0JYcQuRlXdm
         iZRuetjxfeSBXHxxthxULGiKSJSees/VF3SbjZYavARfBdEcpYA/EOj93Pmq4fM1Ywo9
         Si7f+UNd+MSDr8auMgGPq2g3z/YvTe/5R61/MpUzFgU0bn952a1OErZ6awC0iUvP3uzx
         53JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778227013; x=1778831813;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bMxbgVUoPP4wt0fjYdzdFOi78nKz476tRMZZcFG9CRo=;
        b=ZT+M3IJiRzByYmGteNXFSwh4zCX1AEVgRIljYdi9XySejt5il1OmT+e0ptW/D8JIZ4
         hW+JgPYI/g8fSuoWFwWeJr/4ZkLkWAfHU3zswsHITcVHYgGR+nlHTCQeM4D2A93VsBlf
         L/bOqaRP9CKVf2Cy6yKTM8B3rgnGyZT+d4+Y6Dq1rE9CPB1nqFFHgmi0xjPuxVG8dalV
         hPLk3JyZcMnxQrCcovpZLp4PXIx+RoKbbL+QWyxYkBB+FgSRin6A/JTwA6yCqwPiMhRS
         6Og83L+sGV8NSG9WVXtO/aUJ42++BLpG39cF/HUCoxtf2Gq0jk5clsYbOnrltF4srRD2
         Qt8Q==
X-Forwarded-Encrypted: i=1; AFNElJ+D1CfGT2EEu1RmlOx88p5uG0n0Njfa+TnE3A3qpTL9zPb1dHkdnsHRFL8RgokK0b7jLO7gxaroDIM4tVVHDw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzqvjs52tk1tN0uqNs3nj7MMY1cF12xntfTPShO1tAHMoFaG6Na
	yCKBGt6fv2rMXuohPfPe7FX5tSezrOiETGjtmBd7qFhlPS5gsW72y4MtbZ95qQ==
X-Gm-Gg: AeBDiet9FAaAfT2UHseiWDi1BvneioUATUj2uQd4nFzTvE0ryeEPqZEeWojKWZkeUSv
	o4TkrOp+NBjAGiIVJOc+rT2o8mPST4b5D05bkJPyk8AypT7523mzioPVGSQDB3aTBzM5SI5jnwy
	bCH6/Hc/6l/NGOzh/gcsK55CAYk9samygMM8KpC8LJEamus3NRQSnThmhpzt+Anvpa6WgW3ZYBm
	xF5+LgEAFeKyMovQORi+Tlex9pGJZNNTtUFs1cwoF6vVYepMa0Db35VrchlaPWzAmaVIynSFZoM
	+EMTM0LV+ovDLavPycJLxcrzF7zToadWX1WYRQisxpIUAFRGvpRWED1WLanhQov8PZS5UrqCkuC
	3P+nwHGq/rAtHlQjprqffa56ktJftGES5SJypGuHRabBSLba3MuhXgs2IeAytMaidPvaJ6nkuHV
	toGEEG1hLULpmk0XepGuMkIA08Olmr0RljqxH5H/DGhyj8goar9HKjPkIBe9RZbCOX2h2Ul3gIe
	knTeL088XSsZVxF6xmO
X-Received: by 2002:a05:600c:8b16:b0:48a:5758:7999 with SMTP id 5b1f17b1804b1-48e53293f81mr80145735e9.4.1778227013290;
        Fri, 08 May 2026 00:56:53 -0700 (PDT)
Received: from [192.168.0.110] (dslb-084-060-118-045.084.060.pools.vodafone-ip.de. [84.60.118.45])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e68eef8a9sm17559025e9.8.2026.05.08.00.56.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 May 2026 00:56:52 -0700 (PDT)
Message-ID: <01786b03-87a4-4a7a-a5c0-9924c5d1a166@gmail.com>
Date: Fri, 8 May 2026 09:56:51 +0200
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
 <08b8969f-d79d-4c9b-8499-f3180fdd832f@gmail.com>
 <97cbeb922ebc0e5d157ed541bd3c21749bb06bec.camel@redhat.com>
Content-Language: en-US
From: Tobias Jakobi <tobias.jakobi.lr@gmail.com>
In-Reply-To: <97cbeb922ebc0e5d157ed541bd3c21749bb06bec.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hey Gabriele,

once again thanks for the help!

On 5/5/26 08:56, Gabriele Monaco wrote:
> Hello Tobias,
>
> On Mon, 2026-05-04 at 09:53 +0200, Tobias Jakobi wrote:
>> Actually I saw this comment during my investigation. But I disregarded
>> it quickly, reasons see below.
>>
>> Anyway, I saw this term "root_domain" being mentioned a few times in the
>> documentation
>> (https://www.kernel.org/doc/Documentation/scheduler/sched-deadline.rst).
>> But only there. It is not mentioned at all in the rest of the docs. Nor
>> have I found a definition for it. Might as well ask this here, what
>> exactly is this root_domain supposed to be? Yes, there is this comment
>> for struct root_domain in sched/sched.h, but honestly, without heavy
>> knowledge about the scheduler codebase this tells me almost nothing... :-(
> The reason why you need a root cpuset is the same why you cannot simply taskset:
> if all your tasks can migrate freely you can use as admission control total
> utilisation < number of cpus (kinda, read more in the references if you're
> interested), but if some tasks have constraints on what CPUs they can migrate
> to, that formula is no longer sufficient.
>
> The way this is solved is by splitting scheduling domain into independent
> chunks, and a root partition does exactly that: if you give CPU2 to your root
> partition, no other partition can use CPU2, so you can apply the formula above
> only on that partition (with a single CPU).
>
> Without setting the partition as root, you're saying all tasks in the cpuset can
> only use CPU2, but CPU2 can be used by other cpusets as well, it's impossible to
> guarantee anything on your cpuset in this case because you'd need to consider
> also the others.
>
> You should be able to find more about cpuset partitions in Documentation/admin-
> guide/cgroup-v2.rst

Yeah, that makes things a lot clearer! You need a disjoint union of the 
CPUs, so that you can keep using the scheduling algorithms efficiently.


>
>>> In short that's to make the admission control able to give guarantees.
>>>
>>> Setting the partition as root:
>>>
>>> echo root > /sys/fs/cgroup/workload.slice/cpuset.cpus.partition
>>> echo root > /sys/fs/cgroup/workload.slice/workload-
>>> core2.slice/cpuset.cpus.partition
>>>
>>> Fixes the issue in my case.
>>> I don't really know how to specify that in systemd and I'm assuming
>>> your version/configuration of systemd was somehow setting workload-
>>> slice as root automatically, that's likely why it was working.
>>>
>>> Could you try this on your side?
>> Sure, as I said above I disregarded the comment in syscalls.c after
>> fiddling with this.
>>
>> So, first of all, when doing nothing on top of what systemd does, then
>> both cpuset.cpus.partition are member. What I did not mention in the
>> initial mail was that I tried to change the partition type.
>> Unsuccessfully however.
>>
>> root@cm4-fat:/sys/fs/cgroup/workload.slice# echo root >
>> cpuset.cpus.partition
>> root@cm4-fat:/sys/fs/cgroup/workload.slice# echo root >
>> workload-core2.slice/cpuset.cpus.partition
>> root@cm4-fat:/sys/fs/cgroup/workload.slice# cat cpuset.cpus.partition
>> root invalid (partition config conflicts with housekeeping setup)
>> root@cm4-fat:/sys/fs/cgroup/workload.slice# cat
>> workload-core2.slice/cpuset.cpus.partition
>> root invalid (Invalid cpu list in cpuset.cpus.exclusive)
>> root@cm4-fat:/sys/fs/cgroup/workload.slice# grep . cpuset.*
>> cpuset.cpus:2-3
>> cpuset.cpus.effective:2-3
>> cpuset.cpus.partition:root invalid (partition config conflicts with
>> housekeeping setup)
>> cpuset.mems.effective:0
>> root@cm4-fat:/sys/fs/cgroup/workload.slice# cd workload-core2.slice/
>> root@cm4-fat:/sys/fs/cgroup/workload.slice/workload-core2.slice# grep .
>> cpuset.*
>> cpuset.cpus:2
>> cpuset.cpus.effective:2
>> cpuset.cpus.partition:root invalid (Invalid cpu list in
>> cpuset.cpus.exclusive)
>> cpuset.mems.effective:0
> Here you got other issues though, by making a partition root, you are taking
> exclusivity on it's CPUs, so system tasks cannot use those CPUs any longer,
> pretty much like when you make them (domain) isolated.
> The thing is that unlike isolated CPUs, root domains have load balancing among
> the exclusive CPUs, that fights with the fact 2-3 are also isolated!
>
> Now you have 2 ways how to solve this: as far as I could test, an isolated
> partition counts as root, so you could keep your isolcpus and do:
>
>    echo isolated > /sys/fs/cgroup/workload.slice/workload-core2.slice/cpuset.cpus.partition
>
> OR you could ditch isolcpus entirely (nohz_full can stay) and use root for both,
> since the workload domains are exclusive, this shouldn't really make a
> difference.
OK, so I've proceeded by ditching both isolcpus and nohz_full. Upon 
reading about the tradeoffs (overhead of kernel entry/exit) I decided 
that nohz_full is probably not really helping the team that writes our 
userspace application. An application that makes heavy use of 
socket-based IPC.

Anyway, with these two parameters removed I can setup the partition as root.

I have moved things around a bit, and this is how it currently looks like.

root@cm5-slim:/sys/fs/cgroup/workload.slice# grep . cpuset.*
cpuset.cpus:2-3
cpuset.cpus.exclusive.effective:2-3
cpuset.cpus.partition:root
cpuset.mems.effective:0-7
root@cm5-slim:/sys/fs/cgroup/workload.slice# cd workload-group0.slice
root@cm5-slim:/sys/fs/cgroup/workload.slice/workload-group0.slice# grep 
. cpuset.*
cpuset.cpus:2
cpuset.cpus.effective:2
cpuset.cpus.exclusive.effective:2
cpuset.cpus.partition:root
cpuset.mems.effective:0-7
root@cm5-slim:/sys/fs/cgroup/workload.slice/workload-group0.slice# cd 
../workload-group1.slice
root@cm5-slim:/sys/fs/cgroup/workload.slice/workload-group1.slice# grep 
. cpuset.*
cpuset.cpus:3
cpuset.cpus.effective:3
cpuset.cpus.exclusive.effective:3
cpuset.cpus.partition:root
cpuset.mems.effective:0-7

sched_rt_runtime_us has its default value and I can spawn processes with 
SCHED_DEADLINE in both workload-group0.slice and workload-group1.slice. 
So far, so good!

>
>> I then remembered reading something in the systemd documentation about
>> cgroup delegation and that changing anything cgroup related right under
>> systemd's nose was asking for trouble. I guess this is what "partition
>> config conflicts with housekeeping setup" is supposed to tell me here?
> I don't think systemd is to blame here (it seems not to care about partition
> types at all). But since it doesn't seem to support those it may be a good idea
> to find alternatives (e.g. plain cgroup).

Hmm, I'm not sure if going for plain cgroup is feasible for us. The 
system I'm currently testing on is not the final thing. That's going to 
be some bigger AMD Epyc where each CCD becomes one of the group slices. 
With a lot of processes running inside the slices. The current 
architecture design intends to let systemd do the heavy lifting here.

I think I'm going to at least ask the systemd folks if I'm looking for 
trouble here. At the moment I'm using a small helper service unit that 
sets up the slice/cgroup.

root@cm5-slim:~# systemctl cat workload-compute0.service
# /etc/systemd/system/workload-compute0.service
[Unit]
Description=Spawn compute workload on group 0
Requires=setup-workload-slice@workload-group0.service
After=setup-workload-slice@workload-group0.service

[Service]
Slice=workload-group0.slice
ExecStart=/usr/bin/chrt --sched-runtime 80000 --sched-period 200000 
--deadline 0 /usr/bin/dd if=/dev/urandom of=/dev/zero bs=1M

That is not exactly beautiful, but also not terribly ugly. Also all 
workload service units are auto-generated from a template anyway, so 
it's just a matter of adding something to the template.


>
>> After I wasn't getting anywhere here I focused on the bandwidth check.
>> And since the whole thing worked after disabling the check, I
>> disregarded the root_domain/partition idea.
> Of course also disabling the bandwidth check (like you did initially) works, but
> you don't really want that.
>
>> But I guess the real cause is the root_domain then?
>>
>> With best wishes,
>> Tobias
> I hope I didn't make it more confusing than it actually is!

Not at all! I agree though that it's not easy to wrap you around all 
this the first time around. :-D

With best wishes,
Tobias


>
> Gabriele
>
