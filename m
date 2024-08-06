Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F263A35;
	Tue,  6 Aug 2024 10:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722938587; cv=none; b=uj0jp0scHrJOpc+OlLWI40tZYyV4AYjiayzE231y8uExLhP1TpJ94r6lVRDjnIrThJw27x3Ml00y6ZUBx2FjkI8rhuxPVV7lqCyzAC7KKe8dE5UfZEX/1dToJylgW5mWbQ475TS4x0CGtKSDbc99Xr88Vp4RDd9JH48Sl9txeiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722938587; c=relaxed/simple;
	bh=21Y0pBIwI1HwR2U/LzZA8z4cSXds/LWXTl9nxaUvVYI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kCLVscIfQj3gI0ow5fu6143UdufethX7ULbY91hV84Gu+VjudkFZCoxBrVKXiryE5kl03pHVA94rrcd4XvmcCSy4ja+X80DGrgCxGQNHiIWzqqhdb8c2ght7025exjnbtC/vIPc9457Biy3WOf2mcGhDwEHmQ71Tb7b/zbBGWew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ye9wDXLy; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YwVtx5h/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ye9wDXLy";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YwVtx5h/"
Date: Tue, 6 Aug 2024 12:03:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722938583;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CJrVNiSI/EhQvj7Rlw5xd+RbUJSrKucNzsEUSMrER3w=;
	b=Ye9wDXLyEG1YGrxeXzdM4wDn35Pm8HgIT2GMjREevsmZpjkH9w7d0u3V2FvVo29k9nE0l5
	mBQQKQMBDDGsevQuOX+zeBCn0aQ9pKkmagioEcsKOziMw9k76+KUqFULSrDNZO7qZ6IOER
	+4mQ9+erau+G6RKuqLIkL8EeWmjvujTIPD3pkgqIDxri0LRpIHpo8sQEE9GjhTBS+ZdthC
	dTYoD90oZ3U9CO5KJQVJNuCYtzDi9S93VK3Zaa26CTHPNNxZehk8y32JOQphwLvsz1Q+OT
	7ZaVF7gguZFRf8/q4MXbXGb6xMGKh34kVBx9T0gL2xynnrmmEYWiRtMXXsbvWQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722938583;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CJrVNiSI/EhQvj7Rlw5xd+RbUJSrKucNzsEUSMrER3w=;
	b=YwVtx5h/onLbQ9kVaqP9fZ3ZiVEu5dYoPqDOBbRZWdoM5gDipsTsy0vAfbKrxprnSE32lz
	U0tbrXT2FbsBrgBQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Mark Brown <broonie@kernel.org>, linux-rt-users@vger.kernel.org,
	Arseniy Krasnov <avkrasnov@salutedevices.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	alsa-devel@alsa-project.org, linux-sound@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel@sberdevices.ru, oxffffaa@gmail.com,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v1] ASoC: meson: axg-fifo: set option to use raw spinlock
Message-ID: <20240806100302.Up0MShrZ@linutronix.de>
References: <20240729131652.3012327-1-avkrasnov@salutedevices.com>
 <1ja5i0wags.fsf@starbuckisacylon.baylibre.com>
 <2b16b95e-196e-4d8a-98c3-3be568cdd18a@sirena.org.uk>
 <1j5xsow839.fsf@starbuckisacylon.baylibre.com>
 <7dfdade5-3a57-4883-bfac-067c50ec0ffb@sirena.org.uk>
 <1j1q3cw5ri.fsf@starbuckisacylon.baylibre.com>
 <20240805153309.k_SfHw62@linutronix.de>
 <1jplqnuf5r.fsf@starbuckisacylon.baylibre.com>
 <20240806065021.PINvpze_@linutronix.de>
 <1jle1auhu9.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1jle1auhu9.fsf@starbuckisacylon.baylibre.com>

On 2024-08-06 11:21:50 [+0200], Jerome Brunet wrote:
> I have tweaked #1 and added a few tags but the gist remains the same.
> I was going to add you under 'Suggested-by' but maybe putting you as the
> actual Author would be more appropriate. 
> 
> What do you prefer ?

Suggested-by is fine.

Sebastian
