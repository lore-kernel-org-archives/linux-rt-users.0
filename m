Received: from 6.mo575.mail-out.ovh.net (6.mo575.mail-out.ovh.net [46.105.63.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92BB117557
	for <linux-rt-users@vger.kernel.org>; Sun, 13 Oct 2024 11:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.105.63.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728819240; cv=none; b=c+B0sout0Lq8Al3DSlFKeeFNqSvexBxS45uq3NwaiefR+HyMdtJ2APNhroFunCAO0FCjkHL7iYRLGFOJX//VR/XROopnDtMFZ4TnU5TFUKMWxBQ9kasERIaq22doHSnNwdJunEm2G/OiJhyKLhLaSYs04VGlEDHrywcxV6SnW5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728819240; c=relaxed/simple;
	bh=JEYtVZNgqEwOisqM7ZPk3VAg9kyYVJji+bvx/DJHXRY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cdjtEXaMwKTppMckD572B+LGYVe8KH/hVuPjGULzggHFInUEEqSIJwanzSKzgV2v1pyr8Wb0SxBAVj1iRtxWnOunlL8sRO6qgfn2ao11Ahtp/DIdHJKyF6V7Vw/P1iHs0rWmYSZnWIAH0puNStN643rTAl9hpoh1tWTaBN9TT2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chaudron-nautique.fr; spf=pass smtp.mailfrom=chaudron-nautique.fr; dkim=pass (2048-bit key) header.d=chaudron-nautique.fr header.i=@chaudron-nautique.fr header.b=MwPi9B5e; arc=none smtp.client-ip=46.105.63.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chaudron-nautique.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chaudron-nautique.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=chaudron-nautique.fr header.i=@chaudron-nautique.fr header.b="MwPi9B5e"
Received: from director5.ghost.mail-out.ovh.net (unknown [10.109.176.128])
	by mo575.mail-out.ovh.net (Postfix) with ESMTP id 4XRGSW5ndJz1gFv
	for <linux-rt-users@vger.kernel.org>; Sun, 13 Oct 2024 10:14:51 +0000 (UTC)
Received: from ghost-submission-55b549bf7b-rzxql (unknown [10.108.42.20])
	by director5.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 6753C1FE0A;
	Sun, 13 Oct 2024 10:14:51 +0000 (UTC)
Received: from chaudron-nautique.fr ([37.59.142.101])
	by ghost-submission-55b549bf7b-rzxql with ESMTPSA
	id 0hfwAZudC2eudwMAPwvCcQ
	(envelope-from <vanvan@chaudron-nautique.fr>); Sun, 13 Oct 2024 10:14:51 +0000
Authentication-Results:garm.ovh; auth=pass (GARM-101G004bb476012-543b-44b6-85d4-4ea7730aa722,
                    F63C65DFB3ED813617D7D987839DAEECD6EF4C60) smtp.auth=vanvan@chaudron-nautique.fr
X-OVh-ClientIp:82.64.108.188
Message-ID: <315b21ba-e53f-4f3d-9739-25547821feba@chaudron-nautique.fr>
Date: Sun, 13 Oct 2024 12:14:30 +0200
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: kernel module and priority or affinity
To: Alison Chaiken <achaiken@aurora.tech>
Cc: linux-rt-users@vger.kernel.org
References: <f2da9d69-09a6-4086-953b-a24f355f0033@chaudron-nautique.fr>
 <CAFzL-7vvEjkyyD4NfJWqeqxmsgq05ZMh2Bx6cPqitEsM3WpkCg@mail.gmail.com>
Content-Language: en-US
From: Le Chaudron Nautique <vanvan@chaudron-nautique.fr>
In-Reply-To: <CAFzL-7vvEjkyyD4NfJWqeqxmsgq05ZMh2Bx6cPqitEsM3WpkCg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 11356670888132463516
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeftddrvdegfedgvdeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdejnecuhfhrohhmpefnvgcuvehhrghuughrohhnucfprghuthhiqhhuvgcuoehvrghnvhgrnhestghhrghuughrohhnqdhnrghuthhiqhhuvgdrfhhrqeenucggtffrrghtthgvrhhnpeefjefgvefffefgiedttedttdeggedugffggfejhfeiveeiledtieetfeefudeivdenucffohhmrghinheplhhinhhugihfohhunhgurghtihhonhdrohhrghenucfkphepuddvjedrtddrtddruddpkedvrdeigedruddtkedrudekkedpfeejrdehledrudegvddruddtudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepvhgrnhhvrghnsegthhgruhgurhhonhdqnhgruhhtihhquhgvrdhfrhdpnhgspghrtghpthhtohepuddprhgtphhtthhopehlihhnuhigqdhrthdquhhsvghrshesvhhgvghrrdhkvghrnhgvlhdrohhrghdpoffvtefjohhsthepmhhoheejhedpmhhouggvpehsmhhtphhouhht
DKIM-Signature: a=rsa-sha256; bh=Vj2ruk35OxrDtIJUkJQYjNbKaSbXxtY9bENVWLty9X4=;
 c=relaxed/relaxed; d=chaudron-nautique.fr; h=From;
 s=ovhmo4169961-selector1; t=1728814492; v=1;
 b=MwPi9B5e5XKdJ5DLAJwGgAD6UYSHQ5oM6MoZlASj1Z8IUKAJXKpIxfNgIDNwXdMsAnDPYrNz
 Ijzm+u5cN8jpZtjnKqHdl2Qn5eDWiYMPzVSNDWUCOwM6cfI9SI1kvdTICQBtZTTNWxPUKjHY2rW
 hy0csOuGnGdeHD9yYL4/heX0Aj+E3vJOk6QbJzzonRUSYcVsn93NI44wGMiLy5zQfarRQNPB84W
 1wXTwpEKeE6T1edXcnQ85PVsmDaUU2nBOhPBoNh+RtObVQLeTP3MZ2GD1NwRyjq+2A0Z/jQA2A1
 945jJKJTJcl4ihkQpLXJLyH54wO5jKasIFOaZ75Wra3GQ==

Thanks a lot.

I think the chrt command is the one I was missing.

I will try to set this up on a raspberry Pi 4b, with the current 6.12 
kernel, and maybe later move it to a more robust device if necessary.

The major difficulty I have in my understanding, is sometimes the limit 
between userspace and kernel :

I would believe pthread is for userspace and kthread for kernel ? And 
the management of pthread would be done by sched fonctions, that of 
kthread with chrt ?

And kthreads are seen as "tasks" with ps where pthread won't be seen, 
only the main process ?


As for the interrupts priorities, the top-half will be 50, but I would 
still be able to use a different priority for the bottom half if I use 
threaded irqs ?


I don't think I will even need to manage priorities in the first system 
since with only one encoder, the isolation and affinity should be plenty 
enough, but I'd like to start in the correct direction if I want to try 
more complex later.

Thanks for your help.

Mathieu

Le 09/10/2024 à 21:10, Alison Chaiken a écrit :
> Le Chaudron Nautique <vanvan@chaudron-nautique.fr> wrote:
>> after a lot of reading, I believe I'm still missing something concerning
>> "priority" level (or is it my understanding of the kernel ?).
> Welcome to the PREEMPT_RT community.   The best resource for getting started is
> the RT wiki: https://wiki.linuxfoundation.org/realtime/start   When
> you post to ask questions, it's a good idea to mention which kernel
> version and which architecture you're using.
>
>> I would like to set up the reading of an encoder (via GPIO) and the
>> triggering of an output with RT to be able to define the max speed.
>> Every thing else can be non-RT
>>
>> If it write a kernel module (I used the site of embetronix for that) to
>> manage the GPIO interrupts and output, what is the "priority" of this
>> module (since interrupts are priority 50 I assume ? I believe we can't
>> change this value)
> Interrupt threads are by default assigned the SCHED_FIFO priority 50
> by the kernel.  The thread(s) created by  the module will run as
> SCHED_OTHER unless you set SCHED_FIFO from userspace with "man 1
> chrt."   The priority can be manipulated with either "man 1 taskset"
> or good old "nice."   View the threads with, for example,
>
>       $ ps -elFy | grep "\["
>
>> If I use cpu isolation / interruts cpu affinity, is that equivalent to
>> dedicate a cpu to this module ? Or will it still sometimes be "busy"
>> with other cpus ?
>>
>> If I am not mistaken, it is not possible to manage affinity between
>> kernel module and cpu, it is only for the treads or interrupt by masking ?
> There are many complex and subtle approaches that you can try, but
> odds are good since your use case sounds simple that some combination
> of chrt and taskset will solve your problem.  If not, read the RT wiki
> carefully about other possibilities.
>
>> Thanks for your help.
>>
>> Mathieu
> Good luck,
> Alison Chaiken
> Aurora Innovation
-- 
