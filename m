Received: from 20.mo583.mail-out.ovh.net (20.mo583.mail-out.ovh.net [91.121.55.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823721C878E
	for <linux-rt-users@vger.kernel.org>; Mon,  7 Oct 2024 10:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.121.55.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728298171; cv=none; b=juZv3WQQPN5QUoeFil+5pcavfggikIBUoW3u/720dNvVcqGcAVzapNhTl0d2PveT3+49KUDITpH/43/SQ9TvmFWMDUM6nxwf0m1pYNtZ11CzCAjgJNAtNuXTPEqrGVDYD+PzLXtoniJ72/LzOetAMcgRHYMvMjZG3Ewyiy1EoVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728298171; c=relaxed/simple;
	bh=JynbA6WbipiME6NxE4m7CRHqnl7xZhqTHlCLWW58pO8=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=owG7S7hLJcoR/NAx5BuxwieCMXyb668NDQITaCMF1fRAS489GZxDO/W8wqYTC/wnnmYv3jU8w3qC7XPgdGHKN52Yz3HzXjYsKHAEQDRerD2oOmDFRbmiZqhl1qh5wyrT2Nn/hYy2EcGs2fS8o+Yo4WnqbMxQyzny5KwkcducWrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chaudron-nautique.fr; spf=pass smtp.mailfrom=chaudron-nautique.fr; dkim=pass (2048-bit key) header.d=chaudron-nautique.fr header.i=@chaudron-nautique.fr header.b=XgK9tOZA; arc=none smtp.client-ip=91.121.55.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chaudron-nautique.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chaudron-nautique.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=chaudron-nautique.fr header.i=@chaudron-nautique.fr header.b="XgK9tOZA"
Received: from director7.ghost.mail-out.ovh.net (unknown [10.109.139.201])
	by mo583.mail-out.ovh.net (Postfix) with ESMTP id 4XMbM221ynz1VbN
	for <linux-rt-users@vger.kernel.org>; Mon,  7 Oct 2024 10:42:22 +0000 (UTC)
Received: from ghost-submission-55b549bf7b-hcrth (unknown [10.110.101.176])
	by director7.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 10EE01FEC4
	for <linux-rt-users@vger.kernel.org>; Mon,  7 Oct 2024 10:42:21 +0000 (UTC)
Received: from chaudron-nautique.fr ([37.59.142.101])
	by ghost-submission-55b549bf7b-hcrth with ESMTPSA
	id d9bmMw27A2diUAQAjGl8Ew
	(envelope-from <vanvan@chaudron-nautique.fr>)
	for <linux-rt-users@vger.kernel.org>; Mon, 07 Oct 2024 10:42:21 +0000
Authentication-Results:garm.ovh; auth=pass (GARM-101G004ee07d8b7-69e2-4d82-ae15-db95e3d67149,
                    176FFB521F46F6134C0E377701CBA16F67FAFFF7) smtp.auth=vanvan@chaudron-nautique.fr
X-OVh-ClientIp:82.64.108.188
Message-ID: <f2da9d69-09a6-4086-953b-a24f355f0033@chaudron-nautique.fr>
Date: Mon, 7 Oct 2024 12:42:04 +0200
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-rt-users@vger.kernel.org
Content-Language: en-US
From: Le Chaudron Nautique <vanvan@chaudron-nautique.fr>
Subject: kernel module and priority or affinity
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 13478710737356704668
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeftddrvddvledgfeduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucenucfjughrpefkffggfgfvhffutgfgsehtjeertddtvdejnecuhfhrohhmpefnvgcuvehhrghuughrohhnucfprghuthhiqhhuvgcuoehvrghnvhgrnhestghhrghuughrohhnqdhnrghuthhiqhhuvgdrfhhrqeenucggtffrrghtthgvrhhnpeelkeetiedvjefgtddtvdffvdeiieejgeeludduvdffhefhkeetleejhfejgeeiveenucfkphepuddvjedrtddrtddruddpkedvrdeigedruddtkedrudekkedpfeejrdehledrudegvddruddtudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepvhgrnhhvrghnsegthhgruhgurhhonhdqnhgruhhtihhquhgvrdhfrhdpnhgspghrtghpthhtohepuddprhgtphhtthhopehlihhnuhigqdhrthdquhhsvghrshesvhhgvghrrdhkvghrnhgvlhdrohhrghdpoffvtefjohhsthepmhhoheekfedpmhhouggvpehsmhhtphhouhht
DKIM-Signature: a=rsa-sha256; bh=w1QaNfNp7Qy+ZGXCPuRjQEoOziQy+lnvPNRrMoZrpEE=;
 c=relaxed/relaxed; d=chaudron-nautique.fr; h=From;
 s=ovhmo4169961-selector1; t=1728297742; v=1;
 b=XgK9tOZAl/qNzsfF9ROOKAZH95nogemKH6kTPWUYnys9me3lrnDpKfvnoxuAFgh/rcO2DpK4
 9fD2Z8iS4BZIulB1CUGEP3aUCDYW6X+iQgXL7+DIQVK8o3yOzHlkQhaDIwf3HULPQyDQ+JW8srR
 dfgCY+9MR2y0wTYwAlJelOXLRBR4YQbGZjuja9VSWesyLxjXZx2ghE+viaTY0RntnofL8zFOM6g
 3cTGujb7QvbiSyF5uJBf/dah0boGinjIZtdEl0l8sB0H7euA02g27HlGlqyrPkII9wJXSn8e5Hk
 oy2g3hV9K00nMjno9NDPz0eggWzBekE5kw6b/iGzORmAg==

Hello,

after a lot of reading, I believe I'm still missing something concerning 
"priority" level (or is it my understanding of the kernel ?).

I would like to set up the reading of an encoder (via GPIO) and the 
triggering of an output with RT to be able to define the max speed. 
Every thing else can be non-RT

If it write a kernel module (I used the site of embetronix for that) to 
manage the GPIO interrupts and output, what is the "priority" of this 
module (since interrupts are priority 50 I assume ? I believe we can't 
change this value)

If I use cpu isolation / interruts cpu affinity, is that equivalent to 
dedicate a cpu to this module ? Or will it still sometimes be "busy" 
with other cpus ?

If I am not mistaken, it is not possible to manage affinity between 
kernel module and cpu, it is only for the treads or interrupt by masking ?

Thanks for your help.

Mathieu

-- 
