Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC222C1589
	for <linux-rt-users@vger.kernel.org>; Wed, 12 Nov 2025 07:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762933294; cv=none; b=gDcN2pezWakOkafv97CvRFbYShodk1njJTV3cjwvaXvC4XqFmPmFHdppX6H7Rx3ZECkZcA8Q3FUO5bKnx+SEf5yuHecOHwUwm3SKPkuBWmhCHNpHdiYzgG9RAcljWcnZiM+3sD99bg5q4k3pA8s3V3Ss/szzIGTnWiUbpoeXQvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762933294; c=relaxed/simple;
	bh=adm/TJNrttmi7u/dSdG8vmsZgXcFj0zU690xeJA+T04=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VgzQFX6qjRDHY6OFkBqLgaU2YYtw0GLifo3Y++c2RalomjBZJSk+qeZA6LnARxgwqDJS1jo/havB5BcF0Z13F3qASNrBGHHPyZbxE8Vx9ZuCgSmsWC4eutluvy7hRw3aDMIf13MhhJTe2CW3JTNGxFRUDKudIJnGsd50m/gG+zA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VAgYSo3x; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SOPtHbMG; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VAgYSo3x";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SOPtHbMG"
Date: Wed, 12 Nov 2025 08:41:29 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762933290;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=adm/TJNrttmi7u/dSdG8vmsZgXcFj0zU690xeJA+T04=;
	b=VAgYSo3x21aug79dGyDToAwbVnbYPO9+iAnxsnruJbBXDIB5ijo6DlYEb9xdZD0+eCC8eH
	8C4XTKKcQ8sDCE3XIrW5h2GWhdGBS+/beEWYzRSyLtJF60og8hPa24WsFumpONCpG+WyfJ
	0lS61U+Z+uVl2BIeJgmhjuEYh+HPEfAXObSdIoyIy2zJjbz1y4G84kPKHriYCpYXBTBA/6
	ak/AjoSxt+8Daoq9OjfMafaiJyBtIQ7FmNiHcFS62M7kUSeR8n/+g4XrktXBHWcAY8uGUy
	HQ20jq9u6AbyVg1CpuUyhSpFcs8jPBTEdDA917BrNwqNRcSNtEpH9T+5uPynMA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762933290;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=adm/TJNrttmi7u/dSdG8vmsZgXcFj0zU690xeJA+T04=;
	b=SOPtHbMGAK+Ypnvqa7z4E9qOE7QP/Yk5q0XbqVGo7yuwnKNtNaxVCCVV7ahID7LRliq8xQ
	ORDSXPghk65LyABQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Derek Barbosa <debarbos@redhat.com>
Cc: Wander Lairson Costa <wander@redhat.com>, williams@redhat.com,
	linux-rt-users@vger.kernel.org, crwood@redhat.com
Subject: Re: [PATCH 0/3] Improve Makefile robustness and explicitness
Message-ID: <20251112074129.cohRpsWQ@linutronix.de>
References: <20251107161729.320087-1-wander@redhat.com>
 <20251111145020.C7DI111V@linutronix.de>
 <dgm5dmxmq56rtcorzcapb6ibzlch73xwqfavwtbzrbpi6ukfgv@h32wjmfahkfm>
 <20251111155032.r8XNNyFU@linutronix.de>
 <lufi4xb6bbpllszjdfsasor3ehkn3lyynpnmtogegm2l65eop2@4j64xkvwlw4g>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <lufi4xb6bbpllszjdfsasor3ehkn3lyynpnmtogegm2l65eop2@4j64xkvwlw4g>

On 2025-11-11 11:29:17 [-0500], Derek Barbosa wrote:
> > The default set should not be something that is not required
> > and is not always provided by the compiler specified as minimum.
>=20
> With this tidbit in mind, what else do you propose we strip out and leave=
 to the
> packagers? Is it worth retaining some of the debug & hardening flags, and
> leaving the rest to them?

I don't know what this is part of, I just seen the Makefile bits. I
don't worry if you keep some debug flags and or hardening which are
universal. Just don't set anything special which you might need to
filter out later=E2=80=A6 Or add later on additional bits once "new" debug =
or
hardening switches become a thing because this is IMHO not the place for
it. It should be passed by the upper layer.

A simple example would be using cmake: Set the .c files you want to
compile, set the libs you need as dependency and are done. cmake has a
profile for debug, release and release+debug. The build environment can
set custom flags. This is what I see is mostly done.

> Cheers,

Sebastian
