Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A5A0231C9C
	for <linux-rt-users@vger.kernel.org>; Thu, 27 Feb 2025 13:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740663788; cv=none; b=Eg1d4Ag5HEUgDVP0mKh0tcL4BMI2umx7lnOLy5lOAaOCjiejmw3mZewzzKo8bp54PEoFcYfV4arLU3hWAem8KD+5jjOK/BrayoUnrS9BbMmrGGx1dgb6OZheRtvlLKGEJY45S+9tsDwA9P7JL1jBJ0IoLY+1TVGZydL2Z2ADdlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740663788; c=relaxed/simple;
	bh=XFCCgJ0k5nw8INCoG1gONREVyzMBaQY81ZI4AecCGRs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=klClT1ccJBipo1Qs2ACwJ6LGrv4q0YGFjR/kLtnJPuUoNeKkO/pg30sCL1vmLYniqYxbnj2uCTOUjrTYAat1zIYDNndD2/D5PQLlvy7A1Grtc1FtjHLE+//pUdA85G2mpsZZ7Iby94noF2YXRyvqLKd6n+aETiXl3kx98Ra2vB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=U5lm9fQL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WZqhw39N; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="U5lm9fQL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WZqhw39N"
Date: Thu, 27 Feb 2025 14:43:04 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740663785;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RvbfOffyxveWdmPGYolcxGxN1HF6N3WIm0SJAES6EXw=;
	b=U5lm9fQL9Yf6GW54ri05aJUorkrW2CwldgtDRx4DI4KnmiIQtzp7ENDSpMtbWnxHOmldMh
	sm7iLOZ9EF8EbbIqlRheJfkP08Yj3KYPdNChU3wNqjr7snSVUOgcLI6GmkQE/RKoiI1UpQ
	iU2bEFoDLzUUlqpcZtUIlo7+A+rly9Yrv7VCtzAXlY36JHAcQgYrE6vNnoA5FCVV/CfL0Z
	3NAL5m6/ovv6eSoUBqVy/A6MmuZatWcq8qOqBCrIU2RMnN5Ctn8gOlq0V6s9EWZVJ7O/Lv
	PnnLK2J3WmRJ2OA2VdzC+qYTPWtpYyIwKc7tM2+L79kOFtUF9i2xonb3DuHW5A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740663785;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RvbfOffyxveWdmPGYolcxGxN1HF6N3WIm0SJAES6EXw=;
	b=WZqhw39NsoGODApa45P5bWANlYLC/Ge2JP1xstDGB++HHokJwW08c406i0I+3DWkrRbCWx
	vmBzsgGdJUy8EoDQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
	"Ziegler, Andreas" <ziegler.andreas@siemens.com>,
	"Kiszka, Jan" <jan.kiszka@siemens.com>,
	"MOESSBAUER, Felix" <felix.moessbauer@siemens.com>
Subject: Re: 6.1-rt: NOHZ tick-stop error: local softirq work is pending
Message-ID: <20250227134304.xLBfiIC7@linutronix.de>
References: <73c50e2fb53ba8cc2f1538abccc42e98fa63159b.camel@siemens.com>
 <20250224115557.AIFtijeu@linutronix.de>
 <d31ddc467399b53c3f0687db63cb64a3a7c77ca5.camel@siemens.com>
 <20250226091752.jCsLqq66@linutronix.de>
 <7cace5d70278f8ae1debe8cb8d392fb3f59291ff.camel@siemens.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7cace5d70278f8ae1debe8cb8d392fb3f59291ff.camel@siemens.com>

On 2025-02-26 23:23:30 [+0100], Florian Bezdeka wrote:
> > NAPI threads? You have RPS enabled by any chance?
> > Would commit
> >     dad6b97702639 ("net: Allow to use SMP threads for backlog NAPI.")
> >     80d2eefcb4c84 ("net: Use backlog-NAPI to clean up the defer_list.")
> 
> With NAPI threads I meant the kernel threads driving the NAPI poll
> which can be activated by "echo 1 > /sys/class/net/$device/threaded"
> 
> RPS is build configuration wise enabled but not configured.

If RPS is disabled then this might be something else.

> As Felix already reported, backporting the mentioned commits to 6.1
> would require some manual work. Simply picking all the dependencies
> seems too much for now. Will have a look again...

Can you reproduce this on a later (more recent) kernel? What are the
steps to reproduce this?

Sebastian
