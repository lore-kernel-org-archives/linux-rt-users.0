Received: from 8.mo550.mail-out.ovh.net (8.mo550.mail-out.ovh.net [178.33.110.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7794DBA33
	for <linux-rt-users@vger.kernel.org>; Sun, 20 Oct 2024 16:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.33.110.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729443372; cv=none; b=HQb9fWk0rKVlnBdQ4r4dLnJpj9VY6bT2BfKdJAbs74tRu8pI/yf4dvTxQluV09VAykQCv+zybhnz/tg8om3NbgP4jNW3KiXbddOFfqpQBUI8kd9u8NGDC335zCqMY/KV2urb3fiJIShYgMesN5T6XMwzb8imuABN8rYDC4B0SD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729443372; c=relaxed/simple;
	bh=X4G+mtQesOYHl4MWxkRRM7oBJ0OvpSB/pBlND+cr7RQ=;
	h=Message-ID:Date:MIME-Version:Subject:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bt2Y0JQmgBk5PDsTlKUiuRjtZq73Xb9VHLdjTWKA9/BLn5xRmJ6+3TFKFtDWTM8/US7GTzIDw9oJ9twRAZGhYLQ8PW/ri/WuPmA5Ds/dqDWg2WaqDj/mKuhzzr5CtOBfnshwXBl03nF825g3gUXodwyB9q0Uz2UvyybUo0L3oFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chaudron-nautique.fr; spf=pass smtp.mailfrom=chaudron-nautique.fr; dkim=pass (2048-bit key) header.d=chaudron-nautique.fr header.i=@chaudron-nautique.fr header.b=ajsD3grm; arc=none smtp.client-ip=178.33.110.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chaudron-nautique.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chaudron-nautique.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=chaudron-nautique.fr header.i=@chaudron-nautique.fr header.b="ajsD3grm"
Received: from director7.ghost.mail-out.ovh.net (unknown [10.109.148.164])
	by mo550.mail-out.ovh.net (Postfix) with ESMTP id 4XWkgZ6Vyxz1SSZ
	for <linux-rt-users@vger.kernel.org>; Sun, 20 Oct 2024 16:39:54 +0000 (UTC)
Received: from ghost-submission-5b5ff79f4f-gkdtr (unknown [10.111.174.161])
	by director7.ghost.mail-out.ovh.net (Postfix) with ESMTPS id A52CB1FE8F
	for <linux-rt-users@vger.kernel.org>; Sun, 20 Oct 2024 16:39:54 +0000 (UTC)
Received: from chaudron-nautique.fr ([37.59.142.110])
	by ghost-submission-5b5ff79f4f-gkdtr with ESMTPSA
	id acvTFVoyFWeHXAAAWtkRCQ
	(envelope-from <vanvan@chaudron-nautique.fr>)
	for <linux-rt-users@vger.kernel.org>; Sun, 20 Oct 2024 16:39:54 +0000
Authentication-Results:garm.ovh; auth=pass (GARM-110S00447933fe2-28dc-437d-b8cf-7a00149b5943,
                    028229169B7038227A33080F0C6F0BF3E95D058E) smtp.auth=vanvan@chaudron-nautique.fr
X-OVh-ClientIp:82.64.108.188
Message-ID: <a6575573-0057-4e16-83dc-13fc2c4e3f68@chaudron-nautique.fr>
Date: Sun, 20 Oct 2024 18:39:31 +0200
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: kernel module and priority or affinity
Cc: linux-rt-users@vger.kernel.org
References: <f2da9d69-09a6-4086-953b-a24f355f0033@chaudron-nautique.fr>
 <CAFzL-7vvEjkyyD4NfJWqeqxmsgq05ZMh2Bx6cPqitEsM3WpkCg@mail.gmail.com>
 <315b21ba-e53f-4f3d-9739-25547821feba@chaudron-nautique.fr>
 <06da12f70419f50ec31d3a04b9d570198f829e2b.camel@redhat.com>
Content-Language: en-US
From: Le Chaudron Nautique <vanvan@chaudron-nautique.fr>
In-Reply-To: <06da12f70419f50ec31d3a04b9d570198f829e2b.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 3628212451495103388
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 30
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehjedguddtvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecumhhishhsihhnghcuvffquchfihgvlhguucdlfedtmdenucfjughrpefkffggfgfuvehfhfgjtgfgsehtkeertddtvdejnecuhfhrohhmpefnvgcuvehhrghuughrohhnucfprghuthhiqhhuvgcuoehvrghnvhgrnhestghhrghuughrohhnqdhnrghuthhiqhhuvgdrfhhrqeenucggtffrrghtthgvrhhnpedvieevtdelueeihfeuheevhfejfeeitddtfffgudeuueetheeigfefvdegueeiieenucfkphepuddvjedrtddrtddruddpkedvrdeigedruddtkedrudekkedpfeejrdehledrudegvddruddutdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepvhgrnhhvrghnsegthhgruhgurhhonhdqnhgruhhtihhquhgvrdhfrhdpnhgspghrtghpthhtohepuddprhgtphhtthhopehlihhnuhigqdhrthdquhhsvghrshesvhhgvghrrdhkvghrnhgvlhdrohhrghdpoffvtefjohhsthepmhhoheehtddpmhhouggvpehsmhhtphhouhht
DKIM-Signature: a=rsa-sha256; bh=A09JX5rn02KE9TVQew5kwbgaWU6fnt17Bp9XgfvWU14=;
 c=relaxed/relaxed; d=chaudron-nautique.fr; h=From;
 s=ovhmo4169961-selector1; t=1729442395; v=1;
 b=ajsD3grmt63oftrUiT5UNUxbzvwPcONRJPENBa+QiLLq9CcddAQTaBr88rd7NJw5GE262bxx
 4651C61l2EGeS2Xo8nzVvYtpAX6yHzLC9OFyb8CV7nv2JBTzZhC5HsddLximHToQoiU3kXIi/5y
 2AkmJnhSL5K8ar3/h41QWv1nUU/EAmXwtW5afFohgPpQL5YKOwNQTOYLmfnT/YWnViJxL8dN3lG
 bQRM39FvG1U+h1g2EJrQb0w73Fo1fKfv+FaJvyLJ06vuBW1lJI6bBnDHUH2Drv40SQZQ2+c4dvu
 QK4tXBcHhCQ59j+2SqWkqTA0TB1W1VoCAm6+TSa2Dxo8w==


Le 18/10/2024 à 03:28, Crystal Wood a écrit :
> On Sun, 2024-10-13 at 12:14 +0200, Le Chaudron Nautique wrote:
>> Thanks a lot.
>>
>> I think the chrt command is the one I was missing.
>>
>> I will try to set this up on a raspberry Pi 4b, with the current 6.12
>> kernel, and maybe later move it to a more robust device if necessary.
>>
>> The major difficulty I have in my understanding, is sometimes the limit
>> between userspace and kernel :
>>
>> I would believe pthread is for userspace and kthread for kernel ? And
>> the management of pthread would be done by sched fonctions, that of
>> kthread with chrt ?
> chrt is just a command-line tool that calls the sched functions.  The
> type of thread doesn't matter.
>   
>> And kthreads are seen as "tasks" with ps where pthread won't be seen,
>> only the main process ?
> Only because there's no kernel "process" to group them under.  You can
> see all threads in ps with the H option.
>
>> As for the interrupts priorities, the top-half will be 50, but I would
>> still be able to use a different priority for the bottom half if I use
>> threaded irqs ?
> Bottom halves aren't individual threads, so you can't set that kind of
> priority.  The bottom half should typically run in the IRQ thread that
> raised it, though it could also run in ksoftirqd.  If you're writing
> this driver, it's better to avoid bottom halves entirely, and use other
> mechanisms such as workqueues or kthreads to defer work.
>
> -Crystal
>
>
Thanks, it's a bit more clear now. You're right, in my case I won't even 
need bottom half.

-- 
