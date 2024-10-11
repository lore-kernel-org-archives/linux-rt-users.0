Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC2F20C493
	for <linux-rt-users@vger.kernel.org>; Fri, 11 Oct 2024 08:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728635790; cv=none; b=Rh8unc/Q8fFAhU1VozB/LqxetTjPHnEHJupbFTqOWOXTbMwR3aAv37OW+D+loSC6Lo/j/JR0GavLH6PoEh4Ca6pfGWOrRy5fQ4jHXF6zykYsau1Me6WtGt7z41SPph7K/ubJCAwy9YtLFBTdGm5EgLAUmi1Wr+e0GoAFMluH7LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728635790; c=relaxed/simple;
	bh=QRu7kZtDNOwdk2A02wovT8LvZTlCMTPeTp8BtUiu/94=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ed2yTZUIGT9by44dpC0L1H15fKIBrSI/rMR72pyBhGdKEnlTZ0v8bOppnM8QBGtzDXU7DYqsIzQmw08bfDvGqYiihJGD8uHqIgHEWop3JEiR38lL3nx3mE0Z86XQFS5HHz88u2fYj3Y1oS0+S+tYKQ2wxTbpXaqYfRUlNiMW634=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QG6oPd0S; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Kz4aWFBK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QG6oPd0S";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Kz4aWFBK"
Date: Fri, 11 Oct 2024 10:36:25 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728635786;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MtHHDYd6/TNFN8/DU8d4x6Bz28yLMAspywQJZz7Yvlg=;
	b=QG6oPd0S8MYPQzx23DlUbn8bY3FO+qMY1gMd2c5lhfqXZZJxvH/1kiIEPzt2RY3U36Ydog
	d6kIUSZ6P94QKKsDCTpItEHeC5oqEMcbYa53BWzX2XoVtMaCZdc3yLkKji6BNpos3J6oF9
	5ePvxWJq2O0Mj4m1hyqrMYMNc6HsVai0XcSN39uDrPlDxyD3AJRDHWuCbxUMMX++iwu6WG
	mJ8P2sCpyjsw9bq+8Xo4dh2fyg9dlPgTWIxmDfEUWadlHT4GRZ0Q1lYSg6sGZFBGPY4e/g
	1XRDrkNLE2ZXFmcq/T70fC4p/fEr8snMrt+jFNlEUgkZQwfbxRiKJU+VK511xA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728635786;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MtHHDYd6/TNFN8/DU8d4x6Bz28yLMAspywQJZz7Yvlg=;
	b=Kz4aWFBK/ffk7Wuhe9FqoTPKIiKJplyxOj+y06ltNTOfUAnDRgYLR05Ko+Y87qJahdoE2T
	G59chETKlBio5sCA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Le Chaudron Nautique <vanvan@chaudron-nautique.fr>
Cc: linux-rt-users@vger.kernel.org
Subject: Re: kernel module and priority or affinity
Message-ID: <20241011083625.rUt3iLHL@linutronix.de>
References: <f2da9d69-09a6-4086-953b-a24f355f0033@chaudron-nautique.fr>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <f2da9d69-09a6-4086-953b-a24f355f0033@chaudron-nautique.fr>

On 2024-10-07 12:42:04 [+0200], Le Chaudron Nautique wrote:
> Hello,
Hi,

> after a lot of reading, I believe I'm still missing something concerning
> "priority" level (or is it my understanding of the kernel ?).

See Scheduling policies in sched(7)
	https://manpages.debian.org/bookworm/manpages/sched.7.en.html#Scheduling_p=
olicies

=E2=80=A6
> If it write a kernel module (I used the site of embetronix for that) to
> manage the GPIO interrupts and output, what is the "priority" of this mod=
ule
> (since interrupts are priority 50 I assume ? I believe we can't change th=
is
> value)

As Alison wrote, ps is the tool to check. You can change it with chrt.

> If I use cpu isolation / interruts cpu affinity, is that equivalent to
> dedicate a cpu to this module ? Or will it still sometimes be "busy" with
> other cpus ?

taskset can be used to change the CPU affinity of a task.
	https://manpages.debian.org/bookworm/manpages-dev/sched_setaffinity.2.en.h=
tml

The isolated CPU is not part of the default CPU affinity mask of a task
so you have to set it explicitly. If no task has set affinity to this
CPU, the CPU remains idle.

You can use something like kernelshark/ trace-cmd to figure out what is
running on a certain CPU.

> If I am not mistaken, it is not possible to manage affinity between kernel
> module and cpu, it is only for the treads or interrupt by masking ?

The affinity can not be set for a module. The affinity can be set for
tasks/ treads and interrupts. The latter would be
	https://docs.kernel.org/core-api/irq/irq-affinity.html

> Thanks for your help.
>=20
> Mathieu

Sebastian
