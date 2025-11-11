Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7313365A0F
	for <linux-rt-users@vger.kernel.org>; Tue, 11 Nov 2025 15:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762876237; cv=none; b=Iw5Oc/kzGYXkatApU1OWbXBpMdXrq/vhJhF+F2xL0/I3WtXSlHP4eGgWgZIdeGK2NhmjXIyX5yVvV4vgRGGXB/nOseZ/MyTWd1oeTpPFdu7phkshrOthnQkrLN7VAbnZkFg93hK5EOQRQJX5beDlQFCnD8zIergER4hIww2phuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762876237; c=relaxed/simple;
	bh=t5EmlaB/gdJ721DQJcMD3Tg49qWPOPS1lFdoUAMB+xs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jXGPshUhVSi/S9bCiLIyBfFKjUfdPjbez4OCPYvF5gR56st+i0jnQoz/o4ziCV/65a828i/4/Vpe4bv6Jr1X1AhwbFUC+IxpEZkaHO+QjB2crbtPoVZDmIwKh/KjU7wUAJyN4Mbo0B9yvR0jSFn2B+Gtjdr1J9l3KlTUAfEKV7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=V8L5VhrZ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yFGX/MNR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="V8L5VhrZ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yFGX/MNR"
Date: Tue, 11 Nov 2025 16:50:32 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762876234;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0wp/MOvePme1rxDWCowHdVvfPDfaZ182QSdmLOsi3RQ=;
	b=V8L5VhrZu8z8JzI14SmDrv1dwhGyBQMKDjssX+7uYRjUzlJfvG1uYuCNkhhFrzzSCD4T6p
	gn67hnRe3z8PewN8suaAwW1RHXG5kWAJ446kJVNA9wWne71+Dma7nABhjYloJmz2bCqI1M
	sFf2UDpQRGpxfDMWeTvwT5UzAPXtSJ5w64d5e+owWRyp9VQjGhpFoiYIboS1iCPHxwU5Zu
	vl2u6aXXWVaIBSbLFfG+A/q1UeCIoeyc+SVylIoHyKUyttNH2D4JZWac3VGpVn4zCdx1Ra
	pFdRpLC55tCVrUFQawr2JPHkzncYhDPOibQ+slfSY2u+Y+M05wXyAV4mKIbZ2Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762876234;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0wp/MOvePme1rxDWCowHdVvfPDfaZ182QSdmLOsi3RQ=;
	b=yFGX/MNRlZnzd0nizVP/Lm5WbtJXIS/4T17h4U8AyfV6gY3xmr2lniEgOpxGMyKOkKEyjD
	WBIivDenfWMXanBg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Derek Barbosa <debarbos@redhat.com>
Cc: Wander Lairson Costa <wander@redhat.com>, williams@redhat.com,
	linux-rt-users@vger.kernel.org
Subject: Re: [PATCH 0/3] Improve Makefile robustness and explicitness
Message-ID: <20251111155032.r8XNNyFU@linutronix.de>
References: <20251107161729.320087-1-wander@redhat.com>
 <20251111145020.C7DI111V@linutronix.de>
 <dgm5dmxmq56rtcorzcapb6ibzlch73xwqfavwtbzrbpi6ukfgv@h32wjmfahkfm>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <dgm5dmxmq56rtcorzcapb6ibzlch73xwqfavwtbzrbpi6ukfgv@h32wjmfahkfm>

On 2025-11-11 10:35:58 [-0500], Derek Barbosa wrote:
> Hey Sebastian,
Hi Derek,

> Part of the changes were to keep in line with what Daniel had in the makefile
> originally, and just doing some hacks to ensure that these flags are
> conditionally included based on arch support.
> 
> In the case of -fcf-protection, Clark and I noticed that if a particular host
> system was using, say, the sched debug file as a parsing logic "backend" by
> specifying it in the command line, it was most likely because the system does
> not have BTF support enabled.
> 
> We were particularly worried about much older systems with older compiler
> versions, which would prevent them from compiling stalld from source if they
> desired to use this legacy interface.
> 
> Not sure if this answers your question at all. Sorry for the rant.

I understand. I'm just trying to say my two words here what a distro/
builder should do here and the piece of software.

On Debian, the build flags start with the "dpkg-buildflags" command
which the CFLAGS for instance (among other things). So this is might
look as follows
| CFLAGS=-g -O2 -Werror=implicit-function-declaration -ffile-prefix-map=/build/pkg=. -fstack-protector-strong -fstack-clash-protection -Wformat -Werror=format-security -fcf-protection

on amd64. Should, for instance, -fcf-protection not be supported on
s390x it is dpkg-buildflags's job not to pass those on s390x. There
features which are enabled conditionally because not all architectures
enable/ provide them at the same time.

If the package maintainer decides to add a certain flag, such as
-fcf-protection, despite not working on all architectures then he can
keep the pieces.
In my opinion the package should not fiddle with what the upper layer
(build system) specified/ requested. It may have a default set of flags
(such as -O2 -g) which will be overwritten once the user supplied
something. The default set should not be something that is not required
and is not always provided by the compiler specified as minimum.

Sebastian
