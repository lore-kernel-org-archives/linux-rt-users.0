Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE2E1D6C65
	for <linux-rt-users@vger.kernel.org>; Fri, 13 Sep 2024 08:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726216175; cv=none; b=TX7wa/8QuKuNByWWd0q0PI4bbH8tjBm5J08BSzY/Nxon8QaH+AeBe4Od6LDmw3QbCgUmAMBQG6lHfzR0ane4rXw/lui59LR3VEg6auZ2Wpfw9hu+ePtJoTrIGgp8XREn+Fvgu6EF04okLGNob44skPOQId3USlf3DX3xh6WOPTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726216175; c=relaxed/simple;
	bh=NTB+uk+DbZWRpPO/98BGWQ9boDB40w+5+wa26a0elI4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QJUW6+ygA+rWdaCeQPotJCLyB0AQ9U2Zem8ngdT4BKPlp0iEcJ41aOp5tNojHbbskXu+j8QmznKAk87jLC/OqM2l2cEZOivymYAgc6RwBEe8nySuixAU4JtIyvD5upqlmcOqzKMfZyVDozdVtXbtgxkvYUfWtWuFJUgC+IRq4IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=Mb+YFdQo; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="Mb+YFdQo"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Content-Type:MIME-Version:Message-ID:Date:References:
	In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=NTB+uk+DbZWRpPO/98BGWQ9boDB40w+5+wa26a0elI4=; b=Mb+YFdQoIMqoGgInFfbEMZGiq8
	jcj42MCKEJQrEf/4WPUJCcKhCFxAi589GkdlABspfGyiRdrgBlkOwLkdwXLOdAm6TGsVSqu9AuX6q
	eOO2+TMrSNfs2OZDufQCmS6bYASwQ6j/rQ5rcfkrkSez4mx6MzmvcUpuDlapyg2yZgKCCvJvvcM4b
	8ZZYCPPMYTGXByk2T0sxixlrnWCgTi7Fc/vEmEM90icB5ano+UY120mDWL4aQmI7+BpW+HEHjTfhy
	LMM7sja6skVfTmFiSava2u9VwnuKUAJxaaSzmZwfV8ikX9NQJrDA3rRFKwg/9pmGGPCtnS2WSsVnr
	3TjM0z9g==;
Received: from sslproxy07.your-server.de ([78.47.199.104])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <esben@geanix.com>)
	id 1sp1gI-000C83-Ci; Fri, 13 Sep 2024 10:29:30 +0200
Received: from [80.62.117.18] (helo=localhost)
	by sslproxy07.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <esben@geanix.com>)
	id 1sp1gH-0007KL-2J;
	Fri, 13 Sep 2024 10:29:30 +0200
From: Esben Haabendal <esben@geanix.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: linux-rt-users@vger.kernel.org
Subject: Re: [RFC PATCH v2 2/2] serial: imx: Switch to nbcon console
In-Reply-To: <84ed5o9e6h.fsf@jogness.linutronix.de> (John Ogness's message of
	"Fri, 13 Sep 2024 10:05:50 +0206")
References: <cover.1712303358.git.esben@geanix.com>
	<2bc0b5d3f99184d8ddbf860666513f9fa7760af8.1712303358.git.esben@geanix.com>
	<87edb6gbsn.fsf@jogness.linutronix.de> <87frq459iv.fsf@geanix.com>
	<84ed5o9e6h.fsf@jogness.linutronix.de>
Date: Fri, 13 Sep 2024 10:29:29 +0200
Message-ID: <875xr0553q.fsf@geanix.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Authenticated-Sender: esben@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27396/Thu Sep 12 10:46:40 2024)

John Ogness <john.ogness@linutronix.de> writes:

> On 2024-09-13, Esben Haabendal <esben@geanix.com> wrote:
>> I have now gone through all usage of above mentioned registers in the
>> driver. I found a single missing lock/unlock, but other than that the
>> driver seems to be in good shape in this regards.
>
> Great. Please send a separate patch for the missing lock/unlock to
> mainline. It should be a mainline problem as well.

Ok. I will send that separate to this series then.

>> In the _probe() function, the following registers are accessed
>> unprotected: ucr1, ucr2, ucr3, uts. But I assume this should be safe,
>> as the uart port is not registred yet, and interrupt handlers have not
>> been registered.
>
> Sure.
>
>> I will send out a v3 short, hoping we can get this in a shape where we
>> can get it merged shortly after the 8250 driver nbcon patches.
>
> Great!
>
> Note that I am currently pushing the 8250 nbcon to mainline. It is in
> the review process and there have already been significant changes. It
> is all 8250-specific changes, so it probably is not related to your
> work. Just letting you know. I will CC you on the next series
> submission.

Thanks. I will follow the work there, and try to make any adjustments
that might be needed.

/Esben
