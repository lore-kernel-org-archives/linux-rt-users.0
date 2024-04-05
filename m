Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB72156F2C
	for <linux-rt-users@vger.kernel.org>; Fri,  5 Apr 2024 08:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712305942; cv=none; b=aXo4pu1fd0vr6HHF4dFWlP550D6vk2peENBa721hPhy0QRI6JNTaUqDIa58AUgpqQPIyP2tiUg9sCY5BqoRutH4TgcZBsH+G8Wv+rTa4e+SsmTuJhWEdUUW2MxipcgtLP0mhKFQKvi2+DJKX9c4qLnBdfmSXMTyu50GECFRpzeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712305942; c=relaxed/simple;
	bh=+kGtj4dEn5KvXkwCyX8IcMwFBXcy2vtXilZoatVL0NI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DvpzJ0lmRca2unKvWQN6OwvP1QaWcyHIKeq6uQWEUB0ypAJaTWNxCYBoVuPw4hd8cXjWES4Ql6txmYy2WhJKZG7V/OAuHyiN5jdfzz8Kp53t9uR/YDWbshmwX9yz92ooEzfMpnq7x9oHgMsvE3PfmoNGcBdvq4z5KqYb40jEAQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=ljETEj64; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="ljETEj64"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Content-Type:MIME-Version:Message-ID:Date:References:
	In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=Vy42hv4uJpcD5GDskQVRyqOkRrYM4wpe7TgjamUYQJs=; b=ljETEj64mzKImJrqOPxvJIgRmn
	ZVxvX43gY+hqlyYoutvxZ6r7xFfBj7Yt3NcjA3PhqH/YogguL13UwZJctLgjvhjxqdFwzpY0DDibB
	+jqcsVMKK7MD5wkSP7YyCKzKqpeu1A++sTyvSeTWhnibYto7URK7i8iXznv1AfwwSd7JsYr4ZqsSi
	i2zCl/nUHuJTE3Led+JRhvGZ92QFynJiqRwLHlj/qvbKOveNT587pTWxs144JkblFAkUCejtfPQKE
	F0KwfP7mFBxHVJRTsDeHt6hcOIuEwd/YOhFd5ip9W11tVb+Twh9ajKS8D40Bnt/HaP3rMx6P/VQT4
	WVWVmNFA==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <esben@geanix.com>)
	id 1rsezi-000B70-GC; Fri, 05 Apr 2024 10:32:18 +0200
Received: from [185.17.218.86] (helo=localhost)
	by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <esben@geanix.com>)
	id 1rsezi-000BpA-7c; Fri, 05 Apr 2024 10:32:18 +0200
From: Esben Haabendal <esben@geanix.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-rt-users@vger.kernel.org,  John Ogness <john.ogness@linutronix.de>
Subject: Re: [RFC PATCH v2 1/2] serial: imx: Introduce timeout when waiting
 on transmitter empty
In-Reply-To: <20240405-lapdog-poison-a8b812f9d588-mkl@pengutronix.de> (Marc
	Kleine-Budde's message of "Fri, 5 Apr 2024 10:06:05 +0200")
References: <cover.1712303358.git.esben@geanix.com>
	<7bfab9fb4313e64d8998a78e49411bdc7f9bd7c7.1712303358.git.esben@geanix.com>
	<20240405-lapdog-poison-a8b812f9d588-mkl@pengutronix.de>
Date: Fri, 05 Apr 2024 10:32:17 +0200
Message-ID: <87a5m85hwu.fsf@geanix.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Authenticated-Sender: esben@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27235/Thu Apr  4 10:24:59 2024)

Marc Kleine-Budde <mkl@pengutronix.de> writes:

> On 05.04.2024 09:56:37, Esben Haabendal wrote:
>> By waiting at most 1 second for USR2_TXDC to be set, we avoid a potentital
>> deadlock.
>>
>> In case of the timeout, there is not much we can do, so we simply ignore
>> the transmitter state and optimistically try to continue.
>> 
>> Signed-off-by: Esben Haabendal <esben@geanix.com>
>
> For the next round you should consult "scripts/get_maintainer.pl
> drivers/tty/serial/imx.c" and add these people/lists on Cc.

Yes. The idea was to do the RFC here on linux-rt, with focus on the 2nd
patch in the series. When that is in good shape, I will send the first
patch separately to all the proper maintainers and lists.

>> ---
>>  drivers/tty/serial/imx.c | 7 ++++---
>>  1 file changed, 4 insertions(+), 3 deletions(-)
>> 
>> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
>> index 54b760d845c0..f7e4f38f08f3 100644
>> --- a/drivers/tty/serial/imx.c
>> +++ b/drivers/tty/serial/imx.c
>> @@ -26,6 +26,7 @@
>>  #include <linux/slab.h>
>>  #include <linux/of.h>
>>  #include <linux/io.h>
>> +#include <linux/iopoll.h>
>>  #include <linux/dma-mapping.h>
>>  
>>  #include <asm/irq.h>
>> @@ -1995,7 +1996,7 @@ imx_uart_console_write(struct console *co, const char *s, unsigned int count)
>>  	struct imx_port *sport = imx_uart_ports[co->index];
>>  	struct imx_port_ucrs old_ucr;
>>  	unsigned long flags;
>> -	unsigned int ucr1;
>> +	unsigned int ucr1, usr2;
>>  	int locked = 1;
>>  
>>  	if (sport->port.sysrq)
>> @@ -2026,8 +2027,8 @@ imx_uart_console_write(struct console *co, const char *s, unsigned int count)
>>  	 *	Finally, wait for transmitter to become empty
>>  	 *	and restore UCR1/2/3
>>  	 */
>> -	while (!(imx_uart_readl(sport, USR2) & USR2_TXDC));
>> -
>> +	read_poll_timeout_atomic(imx_uart_readl, usr2, usr2 & USR2_TXDC,
>> +				 0, 1000000, false, sport, USR2);
>
> You can make use of USEC_PER_SEC here.
>
> After fixing this, feel free to add my:
>
> Acked-by: Marc Kleine-Budde <mkl@pengutronix.de>

Thanks.

/Esben
