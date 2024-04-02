Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB68860B96
	for <linux-rt-users@vger.kernel.org>; Tue,  2 Apr 2024 11:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712056757; cv=none; b=V11R2D+hGnqR52eVRANVatCLQvIJ8bNE9YxG3mRRqaodZRUEFM0Fx6XIs7KlHobQM+HtpTIfousLaSdEcihuI/2MsXfaB13MscY7D+PnF5zVL4uFGAbQLQdcIP/V5R8v8+0BsaaYocLjjE1Vr1AfjeZbut+hpstS0OeK3EmiCjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712056757; c=relaxed/simple;
	bh=cIZsdenaIdZIcmBV52A4bS+D/4i8Hc/CVDNeqBIWAco=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oQBjztiY/swQJvSB0bX6l8hK5vpHck+OfXxJ/LP/95Qpxo0/p2bEhflIDkTu/OhNUSwLAljgagJTH6vu8pkf4Y0g4D4GDvHQZsKPHZ4GGFcvfKbe9OufEs2pbpAW4k1sDqQcivFWgNg8S+dfyQPhzdlRScMBzoT12Ob1bN//kvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=cpUj/VZi; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="cpUj/VZi"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Content-Type:MIME-Version:Message-ID:Date:References:
	In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=cIZsdenaIdZIcmBV52A4bS+D/4i8Hc/CVDNeqBIWAco=; b=cpUj/VZinzaLWc0Y9hyIdPr9ZM
	EJW9P3ihTNBdKwRXvJmjGaYySKP1p475YX5//+Jb9j0KQOZTPSPuU8PJavOsaLZYyOEAE4ScP66Ya
	WfgeFeizUiSuvaYpxUgiofH+T/u0EBZv+56Fw0J/ACehd8xAq4UJe0nblII5YZaKM/C8p6JUFM6Wp
	7SDhAwFKI02hunax90nOhjDUMkDjyDh9pPuR/i1xZCQ2ABs1rQuSY+rd4ZLTmCSs8agpjFNrmMmN5
	znbxxldXG15BAcrXdBGH3CKrpdnejWDBRynblvkWoGFI/Wydy48aRHS5BCi/Pb8/38+Nd9Bw6ZJZZ
	R56kduiQ==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <esben@geanix.com>)
	id 1rrcAZ-0000sQ-Ty; Tue, 02 Apr 2024 13:19:11 +0200
Received: from [185.17.218.86] (helo=localhost)
	by sslproxy03.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <esben@geanix.com>)
	id 1rrcAY-0003Np-3A;
	Tue, 02 Apr 2024 13:19:11 +0200
From: Esben Haabendal <esben@geanix.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Petr Mladek <pmladek@suse.com>,  Steven Rostedt <rostedt@goodmis.org>,
  Sergey Senozhatsky <senozhatsky@chromium.org>,
  linux-rt-users@vger.kernel.org,  Martin =?utf-8?Q?Hundeb=C3=B8ll?=
 <martin@geanix.com>
Subject: Re: [PATCH 1/2] printk: export pr_flush()
In-Reply-To: <874jckqcxu.fsf@jogness.linutronix.de> (John Ogness's message of
	"Tue, 02 Apr 2024 12:31:01 +0206")
References: <d65ca57567e245aa99a944cefc195f2bc6974384.1712051763.git.esben@geanix.com>
	<874jckqcxu.fsf@jogness.linutronix.de>
Date: Tue, 02 Apr 2024 13:19:09 +0200
Message-ID: <87jzlgf1w2.fsf@geanix.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Authenticated-Sender: esben@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27233/Tue Apr  2 10:26:21 2024)

John Ogness <john.ogness@linutronix.de> writes:

> On 2024-04-02, Esben Haabendal <esben@geanix.com> wrote:
>> Outside prinkt users might wan't assure whatever printed has reached
>> its destination before continuing. E.g. during the shutdown-procedure,
>> where printk-buffers aren't emptied before the system goes down.
>
> This is a reposting of:
>
> https://lore.kernel.org/lkml/20231030092432.3434623-1-martin@geanix.com
>
> As I wrote in that thread:
>
> printk() tries to print directly from the calling context. Are you
> experiencing problems where you do not see the restarting message?

Yes, that is exactly what we are seing.

> (If your answer is "yes", please explain the scenario and provide
> information about the console driver you are using.)

It is an i.MX8MP system, and console is attached to ttymxc1
(drivers/tty/serial/imx.c).

Booting up, and simply executing "reboot" command. Without these two
patches, the "reboot: Restarting system" message is not written to
ttymxc1 console. With the patches, it is.

> I assume you have tried the latest RT development version.

I have reproduced the problem with v6.6.23-rt28. I haven't upgraded to
6.7 or 6.8 yet. Do you need me to retest with 6.8?

/Esben
