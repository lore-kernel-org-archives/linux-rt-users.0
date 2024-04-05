Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29EC315FD05
	for <linux-rt-users@vger.kernel.org>; Fri,  5 Apr 2024 08:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712307151; cv=none; b=WcNdieWHzyIZKv66IxMNjWMsPBRZC0uqCE2sDA+jE6P+DnWkJ120QShsUWHte1/RyK7qBtwelBdwYyfsyEEgszEpfEWvVde1aHnHYQlNGy6D4vKtp8uRnbT56p8LbBkI3hC5+h2HfPkBiwea/OENCSQWai0ncgZXZh/rKzw5LaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712307151; c=relaxed/simple;
	bh=T16rbFWn0qKmlOh6ajfvARtvUW3dIpQqyhnszMwXC80=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eVEVD37MbIeu7hiHvrI1zeyu9ZA4bwt5ka3YzDoRua/qIumBB7UAUQ2nRz3WDdQ97ukOT73SoxmJvgfDbaABju7SjJCdO1oK7hzsNCMfDdH7daabKgMSud/BzGnSpSUjTYuJEEQTG5SBpnQJLvf7AkkuAz4cm8WzRXViB2mLirU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KfHe+Yey; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1bIam/ip; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KfHe+Yey";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1bIam/ip"
Date: Fri, 5 Apr 2024 10:52:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712307148;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qNGnEMdTSzptwLWGd/+reytfXfmAUDKovrAN3UJPXzg=;
	b=KfHe+YeycH3+q9z8L0dPTwF8BeVmRVYS+Qr2T+krnhuTOMY+iW6ipJoHOaw1uAU0RWY0hQ
	SbTe9zlWXqSZYsNNi3OP7J5hCz/OEgF8xi8T6IgSj7ID9kZkMDwTOSWN6n4GYfBB1p0LLH
	Kb+a7BMr18GHplxTUscVwoPnIRMswkSH0iI7xZZQq1kg0Tiwphcff4XXzPPn1b1PiPps3g
	tzjINvyKDfv2prdekwdULtCvrJgxVIjZS5sw3f7zU30B1irLGeaMu/LYZycTBgrVWEO12p
	lRg1CaLUSZJzjwYuFsUD5w6+B/QeSUTkATkQm+JfKubmFNRfpgE4vy4tWvJG3Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712307148;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qNGnEMdTSzptwLWGd/+reytfXfmAUDKovrAN3UJPXzg=;
	b=1bIam/ipsWE+vQIPm6mVRJlwPomhj0IKf1WBhjsaPmQyqCbcE7O2M+9RpiAb2uvzg27ZrO
	o7fggiN2daOU8QAw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Nam Cao <namcao@linutronix.de>
Cc: Clark Williams <williams@redhat.com>, John Kacur <jkacur@redhat.com>,
	linux-rt-users@vger.kernel.org
Subject: Re: [PATCH] rt-tests: hackbench: drop incorrect and unnecessary
 usage of optind
Message-ID: <20240405085227.1GoglMTY@linutronix.de>
References: <20240402174659.202695-1-namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240402174659.202695-1-namcao@linutronix.de>

On 2024-04-02 19:46:59 [+0200], Nam Cao wrote:
> Variable "optind" is used as the last argument of getopt_long(). This
> means it "is set to the index of the long option relative to longopts"
> (from man page). NULL check is then performed on argv[optind], which is
> not valid, because in this case, optind is not an index to argv[].
> 
> There is another "optind" which is a global variable, which actually
> holds the index to argv[]. This is likely the actual intention here. By
> locally define another "optind", the "real optind" is shadowed in this
> scope.
> 
> Furthermore, the original optind "is the index of the next element to
> be processed in argv" (from man page), not the index to the current
> element. So doing NULL-check on argv[optind] with the "original optind"
> is also not valid.
> 
> There is no reason to do this NULL-check, since argv[optind] is not even
> read. Only optarg is read, which is never a NULL pointer in this case.
> 
> Delete this incorrect and unnecessary "optind".
> 
> Signed-off-by: Nam Cao <namcao@linutronix.de>

Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Sebastian
