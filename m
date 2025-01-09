Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A5E206F3E
	for <linux-rt-users@vger.kernel.org>; Thu,  9 Jan 2025 08:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736411970; cv=none; b=OVLxnGtO6rwlIvXsZC4PA0qoUgA26XGkfZcMK8Bf67rjjZVNJu91KcDgF8NsbpeFDHhivU3vTt3g3s75HiBXdj+TbpcYbtuhOSeE50qD5GCjT0cTJaZ+y4umxatXMfFYdiBVCdf/CdV14v7spegQSXSZ9aNNkk53huIv+cwHy40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736411970; c=relaxed/simple;
	bh=e/A3l8sCpAs2kZgSXpWBFQLf0vbEO8gtO1gW92xjNtA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=o267+L2+YHaUTg3Ug7JOYR7Dwh4foMNShBkdQgMbDzTgsrWtlD2fPWY+isXfV5/lmIqWfUmGobtQyex87HXxy9vh2BrczarD6CKAh3yM20qsOcVKtpxLC+s8aeeDlm9yzcfHvTyjT3snWDjteb6oxxprao6p92I37Ziqn/vHj+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=mista.tapas@gmx.net header.b=Iig0BbxA; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=mista.tapas@gmx.net header.b="Iig0BbxA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1736411956; x=1737016756; i=mista.tapas@gmx.net;
	bh=qcF7EycuROUt0WlqyuGmIRx817MyumfKKfrx/LoR9WM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Iig0BbxA4eTsTnOGStxr57dON/Q61tAtgj+obOAEXPW+5LufmV55hx/+g1PZOTpq
	 ttm689Mj28iI9BUazmBGMmHv6rjIke2L5GJWwQWZPxQN1vQczeEBA+AiYludeuAcn
	 SOe6tyw0eVKMVm7a8P9qbrKr2lIMvLVeBYLKazVAhZZNtWDz7zbLJj0jFGeIxc+9z
	 4GDT1HuruCROKqrS4IQme2zDJYHzhPQPuPmuAUnl7Y0sE8mNklEHOr1PmPmfZUj6E
	 28AUX88BnVzio3LQBfjZoeu632K9Gbr8WeUV8lLG7qLI0Z2X1DIa0WyKLKKsSSCDX
	 kL5OFWzb+Sew8oGnAg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [129.70.76.171] ([129.70.76.171]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MhD2Y-1tzvt82It8-00ifgl; Thu, 09
 Jan 2025 09:39:16 +0100
Message-ID: <91fd6206-ec8d-4336-8e64-64464d88548e@gmx.net>
Date: Thu, 9 Jan 2025 09:39:16 +0100
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Raspberry Pi 5 and PREEMPT_RT (6.13.0-rc3)
To: John Ogness <john.ogness@linutronix.de>, linux-rt-users@vger.kernel.org
References: <d445e582-4e49-4135-9d94-f52d72ec5df6@gmx.net>
 <84bjx6h2kd.fsf@jogness.linutronix.de>
Content-Language: en-US
From: Florian Paul Schmidt <mista.tapas@gmx.net>
In-Reply-To: <84bjx6h2kd.fsf@jogness.linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:VpQcinl69/WmlwxWxcPn6+v3Yd8pKE56BY79nTREo5RsOJ+R+U0
 lEcUofpAcfP4WVuh79oBFk7PXIRozRtA6E7A4U1szbmcTqIXW5huWPLrePQPm7HbncggPSN
 7OUdUjMYWYK6M+EcJemSgh1WDCCg+6myuXZlN9tCjDNdj+44AkcVXBgjkj9BcNYsdNATYTg
 RG4UCdJVcDVeBmHsly6sA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:msIWPYEhHtk=;jgKofqr1AVSxoSW7ytQX6N7uFmA
 Slxzp31dYjL48d0gAa6+d1wjH7w/G3eQWw6Wy9NACdTmVm5IA3jLMA2BWKhtOYERDstRjDpal
 qNy4QScGPRj8EPYGYYGD2+0mY6UprxJKH1scgErcJP4kJHOt5brW4zwxuWjO0/mpUm+odnH6e
 9+v8upGELnPEjiC1aap0f2xmNKctrrKCA2dagf87m4FruI2qHxmPfbsmAD8lMf3WBMr9Nrn57
 CdpAJJKvl65JZQNNtr6NEpVJVdqF+3SM5we9vjhvJ2vzyMZXT91emhYN0HuDdWtZ5Oz7MWedW
 hWTlYfV82+OXs1A/xnolpLg9YnWFNB5KiasFSRRv+QHFKAEUZqG9GixRZVZRjeq50X+bdv3on
 D+PNHwe50TmzBjUGxnTeamXQ93LZ8i6IR0D5KyzaqO0yHKbb1QgBXusakvWxkP4KH5u+zuW8Y
 9t3FzM+zxI6nCd2CF324TbWN/O5Tz1cjflp++BHOJuHUfTk/weNL5x9bqr6PhCHKj30NV9vt3
 RJMqQtFW17BBT+YONGK15FYMHzTy0KWqK+0hPv7ZJ3G76M6Ya7rm1KhlQWrQcT2iXkhVADwnE
 apsEcxBNrPTH1etR4r//TPfZdlujomt5jhgRs/YXFbxAcTLyT4mUjQdpKtoQQhDbDCU8nUEr8
 Qhoi6/qPtaihjerrDsEyb7VvMnnh06DLV1jVP2pgp8E7TTEechGe8zKS2XJI6ybVdGbjlLXSX
 m/sV8nrvkOp3+2tVW1Rv3m/SP4cdssLcWqUcuQ8kKutjP++PtiCVqch8Qdo4juwqWDrqs057e
 CnXloyTPBTLe+GyTTsV8Uc5F+7sKPlOLYG0XIIAWHIgqdyQb3F2pDPFZ+prL9ryUVyxOdFpRb
 eC7dgpEMCxk3ZHq+4PMOktwfGQ8EaxATTEuf9AE4ycZbdty60gl/2U+fcmjtltBa/M7+ct5cg
 yohfi17EyvusHdBMa8IiyLbNCVIqgWN9xbwjnQKNh+Mh/641yONj8sFGOmZ1sKFwTrxY2PBpb
 1kwujiJNymIIHUh6TRr4F9/v/2Ib50IQaDNXCIXt77od/Q01v4KK1gVQxbkyabRk6r9bqrNk5
 AiJf3mCgJhnHtNSv6s3eNn++e9k0Zh

Hi John again, Hi list :)

On 12/20/2024 3:05 PM, John Ogness wrote:
> There are various kernel configurations that affect latency. But I am
> curious... Why do you think a maximum latency of 80us on an $80 board is
> large? What maximum latencies are you expecting? And why do you think it
> is not "under control"?

I played around some more and coincidentally found a way to trigger even
longer latencies:

stress -m 4 --vm-stride 16 --vm-bytes 512000000 --vm-keep -c 4

This gives me latencies in excess of 500 us. I even saw 800 us once or
so in my tests.. The traces still look fine. Here's one for 438us:

rtla timerlat hit stop tracing
## CPU 3 hit stop tracing, analyzing it ##
   IRQ handler delay:                                         0.00 us
(0.00 %)
   IRQ latency:                                             439.58 us
   Blocking thread:
                           stress:1706
     Blocking thread stack trace
                 -> timerlat_irq
                 -> __hrtimer_run_queues
                 -> hrtimer_interrupt
                 -> arch_timer_handler_phys
                 -> handle_percpu_devid_irq
                 -> generic_handle_domain_irq
                 -> gic_handle_irq
                 -> call_on_irq_stack
                 -> do_interrupt_handler
                 -> el0_interrupt
                 -> __el0_irq_handler_common
                 -> el0t_64_irq_handler
                 -> el0t_64_irq
=2D-----------------------------------------------------------------------
      IRQ latency:                                          439.58 us (100=
%)


A Raspberry Pi 4 seems to be less susceptible to this stress test. There
the maximum latencies go to ca. 200 us. I will try a couple of kernels
including the one in the OSADL farm.

Kind regards,
FPS

=2D-
https://blog.dfdx.eu

