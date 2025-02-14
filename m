Received: from mwweb08oc.mail2world.com (mwweb08oc.mail2world.com [74.202.142.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437EC261567
	for <linux-rt-users@vger.kernel.org>; Fri, 14 Feb 2025 12:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.202.142.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739536874; cv=none; b=b4d4w2slCNqtICDL9eQkmrIxRg08m+R1V73/99c3JgGdQUgfM3qsEegXbl4gl55ED84RigYx4yZIpTNm1XeJvzrD58yJfI38/OgdATjIVek8BdSL31adxc3N0gaembiIs9jaR4idGhGNHwH3cQBDd9fnB8uyIB64obX6KdXOoRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739536874; c=relaxed/simple;
	bh=hUpR075yi9+3NYvbkzMxUDPktM3kdobxc8G8rAx2ET0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ukTE+m4Ef4v5EVepUxhqt2Szv3IwIMUco8+TMyYaFp4xurReaZfiTWkTf5fTa2+30HBNrI5AvpsOaZsj4Ru7/Liv1/Zd/HzLk43nrIkqjT6vY/rFgp1qJ6KvgSAiqZuliWbtZAHiBQLJaZkqXGWSL8RjE7GHI6y3VQjI5yyR59U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shentel.net; spf=pass smtp.mailfrom=shentel.net; arc=none smtp.client-ip=74.202.142.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shentel.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shentel.net
Received: from mail pickup service by mwweb08oc.mail2world.com with Microsoft SMTPSVC;
	 Fri, 14 Feb 2025 04:40:05 -0800
auth-sender:gheskett@shentel.net
Received: from 204.111.66.52 unverified ([204.111.66.52]) by mwweb08oc.mail2world.com with Mail2World SMTP Server; 
	Fri, 14 Feb 2025 04:40:04 -0800
Message-ID: <e007fa80-a353-484a-8317-df940fe8ff96@shentel.net>
Date: Fri, 14 Feb 2025 07:40:03 -0500
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: Raspberry Pi 5 and PREEMPT_RT (6.13.0-rc3)
To: Mike Galbraith <efault@gmx.de>, Florian Paul Schmidt
 <mista.tapas@gmx.net>, Leon Woestenberg <leon@sidebranch.com>
Cc: John Ogness <john.ogness@linutronix.de>, linux-rt-users@vger.kernel.org
References: <d445e582-4e49-4135-9d94-f52d72ec5df6@gmx.net>
 <84bjx6h2kd.fsf@jogness.linutronix.de>
 <cb569b76-e0ac-4063-9956-ab6307594d86@gmx.net>
 <CAMjhiJjpnP4Nr5YmgntPd43gndBXnh_DOjW_davDVG2fu0F4sQ@mail.gmail.com>
 <ecb3c326-9d5e-4a39-b9eb-5cc318596eb0@gmx.net>
 <f3960a1aa11022f4e049d62b738b4989974e73db.camel@gmx.de>
 <fe289947-7f41-4810-ab37-6d40c0081135@gmx.net>
 <deea066a4bd4703ed395287b627666da990cbbda.camel@gmx.de>
Content-Language: en-US
From: gene heskett <gheskett@shentel.net>
In-Reply-To: <deea066a4bd4703ed395287b627666da990cbbda.camel@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CTCH-Spam: Unknown
X-CTCH-RefID: str=0001.0A00212D.67AF39A5.007B,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-OriginalArrivalTime: 14 Feb 2025 12:40:05.0932 (UTC) FILETIME=[932836C0:01DB7EDD]

On 2/14/25 04:05, Mike Galbraith wrote:
> On Fri, 2025-02-14 at 09:31 +0100, Florian Paul Schmidt wrote:
>> Hi again!
>>
>> On 1/14/2025 11:28 AM, Mike Galbraith wrote:
>>
>> [...]
>>
>>> This seems rather odd, one core diddling memory is the worst case.  Any
>>> arm experts out there know why that would be?
>>>
>>> pi5, locked at 2.4GHz:
>>>
>>> taskset -c 3 stress -m 1 --vm-bytes 1G --vm-stride 16 --vm-keep --timeout 60s;killall cyclictest
>>>
>>> T: 0 (23157) P:99 I:1000 C:  63421 Min:      1 Act:   12 Avg:   27 Max:    1378
>>> T: 1 (23158) P:99 I:1500 C:  42327 Min:      1 Act:   32 Avg:   29 Max:    1734
>>> T: 2 (23159) P:99 I:2000 C:  31744 Min:      1 Act:   18 Avg:   28 Max:    1353
>>> T: 3 (23160) P:99 I:2500 C:  25393 Min:      1 Act:   11 Avg:    6 Max:      39
>>>
>> I wonder if there is still a way to save the day, i.e. use the RPI5 as a
>> somewhat capable RT-system by
>>
>> 1. making sure that the RT load does not do anything nasty - this is
>> mostly under the users' control since they can setup their RT load to
>> not do this.
> I think that's the answer, don't expect miracles from cute/dinky boxen.
>
> Beating crap out of any box is only useful for finding limits, has
> nothing to do with "RT capable".  A box is RT capable iff a given RT
> load's hard constraints can be met on that box.  Both of our stress
> results show only that if you need amazing memory performance, dinky
> pi5 is not for you :)
>
> 	-Mike

This is all well and good Mike, you are actively researching the arm 
stuff which needs some TLC.

A decade+ back up the log, I undertook to run an old Sheldon lathe with 
a pi3b. Using a mesa 7i90HD spi card and a trio of 7i42TA's to isolate 
the 5 volts from the 3.3 logic in the 7i90HD. Worked fairly well but 
stuttered a bit from running out of data. So I switched it to an rpi4b 
which does the job nicely. Then I changed the steppers to 50 volt 
stepper/servo's and threw out the pid's. That where its still at today. 
The servo's doubled the speeds. But that pi is still running on a 64Gig 
SD card. Enter the bananapi-m5 with a builtin m2 like soldered on 
memory, only 4Gb but many times faster than the micro sd card. How would 
that work if the bpi-m5 were to boot and run from the m2 memory it has? 
Bears investigating IMO. I am booting them from micro-sd on my 3d 
printers, running them quite well. Finding how to boot from the m2, is 
well hidden if possible at all. Hints appreciated.  Thanks Mike.

Cheers, Gene Heskett, CET.

-- 
"There are four boxes to be used in defense of liberty:
  soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author, 1940)
If we desire respect for the law, we must first make the law respectable.
  - Louis D. Brandeis

