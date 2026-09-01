Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9929E3845DC
	for <linux-rt-users@vger.kernel.org>; Tue,  1 Sep 2026 10:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788259369; cv=none; b=LvY7t5QQjIDmNMLSDyiYZjV+ot08YxybreE+KaELEDaxTCbu1bdo3qEN9Qf+QJWhEO/5xwc8qDShr8dXp1VooPXQLxrTK/bqDLuNFVVXB1STbA1zTJxkijvsioe0qNgx/X2MoZDXrUIwdMwe43xQeZ+wnoOO/dpskIqYdI8cHf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788259369; c=relaxed/simple;
	bh=311dbp5om3AAGV73ZZzV/xKl4qJs12PEAqKg/K23DD0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ADTclzDgauNYtTH+AYdZ9LgeAUk4RFXDL1/v7c4ZnB5P+7cZVRluRvbfE0+pzr7Yq4nYWxMn0jxeIc3+cfTRCGgbpgJRtZDJvt1VY0DBkyXd1Qt2sfrjMUqd7xWN02NzODF0iyHmgXF5uhn41kdGhTMbDJZ8mOwdXFbN0qQHguU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=j1U3cMel; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nEhEzokN; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="j1U3cMel";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nEhEzokN"
Date: Tue, 1 Sep 2026 12:42:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1788259365;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rHTQIMMqUbeMha0slf25YUsYyo0Zgky3zxk0NytW/Sc=;
	b=j1U3cMel/3OsRhCjIsJ+CpbQyOEIiqf7UM6qZtiovNusAy0x/H2Puv9FIGW4CYb2uXgMqU
	eqq6wfs4kEkfc6Vrl3oelfcy0EkYpZsYyyUMLCKh977Z1I4PfgON/WADTiRvEKKIWN0Ww6
	XHUZFpIF4I1xviHAgFpV464DQ8oGZoif3PHt1u2Zf3riL9jNU1Ea4q7PklwNaGTIOjPIRW
	cX0IiUh40Zu1GH6DGQDYHSZWjKPGi79Wojk1XensH4Oort0Ug7Xy3qC6CbDJXgA6kNPQOY
	/vsqC5ZYmlJhSnjvYOzKraOQqoEb8y9MtRtwNnLHLCQKh34Xw6xRj92WK2NeeA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1788259365;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rHTQIMMqUbeMha0slf25YUsYyo0Zgky3zxk0NytW/Sc=;
	b=nEhEzokN7B0hpIaqmu3n3McB1/0QFRtae7oH748Dx+7ZOP+6th0qML8XbvfSvSjBku+Uw8
	yUwLe6n8QiP3aADQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Suneeth D <Suneeth.D@amd.com>
Cc: linux-rt-users@vger.kernel.org, williams@redhat.com, jkacur@redhat.com
Subject: Re: [PATCH v1] cyclictest: Fix BUILD failure for GCC_VER < 14
Message-ID: <20260901104244._9OYmYYI@linutronix.de>
References: <20260901094635.2173-1-Suneeth.D@amd.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260901094635.2173-1-Suneeth.D@amd.com>

On 2026-09-01 09:46:35 [+0000], Suneeth D wrote:
> timerthread() uses bool, which fails to compile under -Werror
> when stdbool.h is not included.
> 
> Fixes: 98fcd661ac59 (cyclictest: Acquire a lock before invoking pthread_cond_signal())
> Closes: https://lore.kernel.org/linux-rt-users/4ce24139-5f7e-4180-a290-bcc15fb4f559@amd.com/
> Signed-off-by: Suneeth D <Suneeth.D@amd.com>

Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Maybe mention that the default changed since GCC 15 switched to C23 like
mention by Tomas Glozar. This might look like I don't compile my things
but it is fine as it is ;)

Sebastian
