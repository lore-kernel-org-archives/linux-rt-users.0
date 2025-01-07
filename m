Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD261F1936
	for <linux-rt-users@vger.kernel.org>; Tue,  7 Jan 2025 14:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736259268; cv=none; b=YEGEKaogQLr0rx7cdrAIAn6o1kCnCcMmTTFTfVvviEGSxTOH9tkerEogedJ+rTjmWTe5TFx8prE2wNTvdG/rcdohDGxIm/Yk8lUWZReCR6+Z2+mBuzpJl7PWohE65gqvsxd7LOhfDA7nXs1WV/Z97faQNkZUhQDJgW9/OZ0Pwl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736259268; c=relaxed/simple;
	bh=oLiigFDFnU513ANtQgCGxzIZyNZ8eggli4YsSASB5gI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZT8VssYkhzeMyXp+NOWhp4mMRNschQV5qsBYqu1sPCikB5bH0/h5JcPqMnTXjgXga4blH01E7PHdodmbsW5KWvDiWgvuyuv5qqrmwnfysyYQQ0PY0whHMbTpuFrTGMBf0sA/ZhFqeaphUtnPsCSVIGRCdgmdR4US3Hxleu2LTDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YDCmBRi4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ulPuaa+X; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YDCmBRi4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ulPuaa+X"
Date: Tue, 7 Jan 2025 15:14:24 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1736259265;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8ZbqqOzV/NRDjrICL9HpH60Cn+aDfvt7oJ06pOJfMI8=;
	b=YDCmBRi4iDIm8H87ZNdSlqN0OZkBFJLNgUaQPcmrNh/CorMFJD57Eatr4xkfZWf0qPOkNH
	eZGhfKy8hls+E87cb4g5Bup7k8zhX7Ict96L2JiASDfLqXIKddvDo1nSsiErtN9ZBZxL+k
	Xu/5vwKFm/Rn61FOW0mWcIJXyQ75DMhfa+shlDgqdjA9Qsxo0J3S2ae+py1ogm80NGWpYA
	og5Y18KJX/Dj+FQvU8LdUsaPgXVhdSm+PEWOaHEGmGD/+sWxQElMdLLMV7uaU9TvO5+FZb
	/SIbBiT942bCCINCv49w5LE/Y7EkXBoXHRVW0w1R2irv/qil1Y7rO5Nhzb064A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1736259265;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8ZbqqOzV/NRDjrICL9HpH60Cn+aDfvt7oJ06pOJfMI8=;
	b=ulPuaa+XA+UbyMaVKV+OSe2H/Yh9lJ5QtGRPvlCUfMPG6pcEg0MMFnlF+fX3iZ0R2zgHpS
	VL8KK1f+ALUga9CA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Kurt Kanzenbach <kurt@linutronix.de>, John Kacur <jkacur@redhat.com>,
	Clark Williams <williams@redhat.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	linux-rt-users@vger.kernel.org
Subject: Re: rt-tests release tarball location
Message-ID: <20250107141424.EoC5uS6y@linutronix.de>
References: <20241228114346.6020d6b0@windsurf>
 <87h66b2c6m.fsf@kurt.kurt.home>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87h66b2c6m.fsf@kurt.kurt.home>

+John, +Clark
On 2025-01-07 10:41:37 [+0100], Kurt Kanzenbach wrote:
> On Sat Dec 28 2024, Thomas Petazzoni wrote:
> > Hello,
> >
> > I am one of the co-maintainers of Buildroot, an embedded Linux build
> > system. Among many other packages, we obviously have rt-tests as one of
> > our packages. When rt-tests is built, we download it from kernel.org.
> > Unfortunately, the rt-tests tarballs are moved around: the latest
> > release is available at https://www.kernel.org/pub/linux/utils/rt-tests/,
> > but as soon as another newer release is available, the older release
> > tarballs get moved to
> > https://www.kernel.org/pub/linux/utils/rt-tests/older/.
> >
> > This breaks the build for build systems such as Buildroot, that expect
> > a release tarball to stay at a given location, and not being moved
> > around.
> >
> > Would it possible to keep the tarballs at the same location? Either by
> > not having the older/ folder entirely, or by populating it immediately
> > with the latest release, so that all releases are always available from
> > the older/ folder?

John, any favorites?

> +1
> 
> For Gentoo I had to add both URLs to SRC_URI in the ebuilds. It first
> tries rt-tests/ and then rt-tests/older/ location, which is also not
> ideal.
>
> Thanks,
> Kurt

Sebastian
