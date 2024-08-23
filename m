Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 929E2139D15;
	Fri, 23 Aug 2024 07:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724396953; cv=none; b=gt24BJfH7Sm5i7UDEN7qxmGHp5MlvlUzXhXYT82rPqUIghrYj0xZBHs5je8Ovgi2GTQ8zldamHfV1HPOciU3uZCF3AIsMqg1++oXtbotThRAb7A46VkARhHajp/RmvSyat9usHjQ7khZouUya9UrMP81ENJpoxDOK5eJx9LoOwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724396953; c=relaxed/simple;
	bh=9UhV2IODQREqR4uQoLzNBv5rfKibOFEm+2yCwhoz6q0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rOikVjpPlJ3D1qXGuTeqnbHoG/PfGjwvV9zRJHQimArEAnswfcSs4OgvgRIHlf8kipIwDVS7y/PBk8jWO+fzSRXoelQLGofA0/lKHkZBNtZJ0hwzHOydyBbu4vS7YF13dGcop4FASfhkU35WMeZoG+HX0G96Jhoe7dggXbEoR+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DoPNZBIg; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=G7TjziTy; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DoPNZBIg";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="G7TjziTy"
Date: Fri, 23 Aug 2024 09:09:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1724396949;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ixFolHKRyKqlh9t34LBP2UUWQ9fpJZXPE9R/jHylteM=;
	b=DoPNZBIgbwmZv3qRIw/8RUXm2LGnz6tVdKIAr2IfkFvodUKDBIUPiaVXDBIkCPks9t4Imq
	1r37HjbPAodMKg/gtW7sov0jgVpmTl6zOyXPdqVh18zfAmjazib+niZvsuaQ+2vX6Ts/9R
	/WzTZZ/hTOPo+WLrz9CYqxJaL5n7x9j4Oich7Br1F3JOy0/4E4Hbzgqe5lK6owJXv1hVpl
	95QU4K8X9RHRiqpFOkz9DHrWb4IPs3Ut1io1AFW/XMBy0nNTAGgvz6xCPdvFl+My1KnTlT
	xhx5C4TZt4HjhhNH9359RmZ5EN0qvA8ZvChP2+Zsukp+JQr6n1vREiq6PgHzCQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1724396949;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ixFolHKRyKqlh9t34LBP2UUWQ9fpJZXPE9R/jHylteM=;
	b=G7TjziTyjPITIfW/+YKjUEpim01KIJ0hqqFNlAhY9vTeQ3nhcFR0p8nGWcb1E8tv52lBFU
	n1FY2JY/T18lF0DA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Derek Barbosa <debarbos@redhat.com>
Cc: pmaldek@suse.com, williams@redhat.com, john.ogness@linutronix.de,
	tglx@linutronix.de, linux-rt-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: A Comparison of printk between upstream and linux-rt-devel
Message-ID: <20240823070908.D0GYffCS@linutronix.de>
References: <ZsdoD6PomBRsB-ow@debarbos-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZsdoD6PomBRsB-ow@debarbos-thinkpadt14sgen2i.remote.csb>

On 2024-08-22 12:32:15 [-0400], Derek Barbosa wrote:
> Hi,
Hi,

> TLDR: plain, vanilla 6.11.0-0.rc3 is slower on flush and 
> does not print traces in panic/crash context consistently.

Thank you for testing.

> For the stock kernel, we observed an average of about 14,263 messages printed
> within 30 seconds. The standard deviation here hovers at around 1.52 messages,
> with a variance of 2.3 messages.
> 
> For the "new printk" kernel, we observed an average of about 12,693 messages
> printed within 30 seconds. The standard devation here hovers at about 131.2  
> messages, with a variance of 17211 messages. 
> 
> We observe a rough 12-13 percent overall delta between new printk and the
> stock kernel in this test case, with a larger disparity in standard
> deviation/variance.

I am a bit confused. You write here ~14k messages within 30secs for
"stock" aka 6.11.0-0.rc3 and then ~12k messages for "new printk" aka
from the latest RT tree. At the top you write "6.11.0-0.rc3 is slower on
flush". This means something else I guess.

Regarding your RCU stall: You stuff a _lot_ into the printk buffer. And
then printk is forced print everything out in a single sitting. The
whole printing job is done within a preempt_disable region so RCU has to
wait until it is done. If printing of the whole buffer takes >60sec then
you see your RCU stall.
The current RT tree will do the printing from a kthread which remains
preemptible because your printing threads don't print any errors/ panics
for 30seconds. So RCU gets its turn.

Sebastian
