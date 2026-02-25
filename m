Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8059E3ACF00;
	Wed, 25 Feb 2026 12:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772021106; cv=none; b=aKKRbqcncOi2Ai0dwoVPh/9mqe90QOtCYES9IeyFI2w7L1imNP8grfrSoCSqY72nLxN+xT/8kmpQpRkmKa/nbd5ypit02Hese6219JhPFyshN5CY+AtthpKB/7YQjCc7Odyj7JHaguTUUlJE0/NVk86I+FxSGBSa/znKwlJizng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772021106; c=relaxed/simple;
	bh=NHDdeJ0QCZzEO4Xr3jUaDm72DW31Pup6QGPwy9pmDvg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=qCkE5XlRufvqKMOfvj1HTC8RqbQ43cywqRU8EurpwCroPjiYOgWoNnZb5dtQiX8HEE+iE12CYVGzFKnHeRoB8kF+iUqB5YDSxQlfcidElId0eMDObkDZr+8ljxHcrly4AYKeQtyT2mVn8mLA+xBJ6UDYPsaWplnYdrWTbZsZN+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=m3GyxspM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jnoYlLxy; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="m3GyxspM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jnoYlLxy"
Date: Wed, 25 Feb 2026 13:05:02 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772021104;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=hsPw+L3iw/cwuI7LWheAGPD7ax9W882AFiLpWV2wwxo=;
	b=m3GyxspMowyZtJK6Oqkb2GEhSsqpo8vzUQddUq4zn3CMXKgsx2f1Womktf0+mlrRFlN72V
	CBz9u5pLZ5tQuLXA8C6Ai2BuTaxeLr6WGz75nBakotqnPgvTBUcQjGyFR1ToOg/lMcvvR2
	lhUxuAWRjLGC4nlZvX8hPfog8wD7p2i0qbNAowB8beFAWCNn3JPUawG0hwQDWk5ogPb6gT
	OiaanSuDdkO7GEJF0gSTqJVnz5nQqYP7ZQbZe4LQx7/jALcxqdhBnBT0R8IRDrplmZpSlX
	3BSd+epe19lSMVKjw+FAQuZ5SSzJHyVux99VxHeeZnEL1//50C/KXldVfplibA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772021104;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=hsPw+L3iw/cwuI7LWheAGPD7ax9W882AFiLpWV2wwxo=;
	b=jnoYlLxyqGlfKxEZP5/3stbsVOY8M7QkmpoxK/9MMHX+gaoj3wlLzLRV84xBs+ezdPn5C/
	wF8oTJ2bwvvUGrAQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Thomas Gleixner <tglx@linutronix.de>, linux-rt-devel@lists.linux.dev
Cc: LKML <linux-kernel@vger.kernel.org>, linux-rt-users@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v7.0-rc1-rt1 | v6.19.3-rt1 | v6.18.13-rt4
Message-ID: <20260225120502.XKhQxj1F@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Dear RT folks!

I'm pleased to announce the following patch sets:
- v6.18.13-rt4
- v6.19.3-rt1
- v7.0-rc1-rt1

I updated the updated each devel tree to the latest version in order to
catch up. I dropped a few ARM related patches as they appeared in the
upstream tree. As of v7.0 there is one ARM patch left before it can
enable PREEMPT_RT on its own.

Known issues
    - Yoann Congal reported a bit spinlock in dm_exception_table_lock().
        https://lore.kernel.org/all/Z8GTjqgDe_5EkE3t@P-ASN-ECS-830T8C3.local

You can get this release via the git tree at:

    https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v6.18.13-rt4
    https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v6.19.3-rt1
    https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git 7.0-rc1-rt1

The RT patch is also available at its usual location for the individual
version:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.18/
    https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.19/
    https://cdn.kernel.org/pub/linux/kernel/projects/rt/7.0/

Sebastian
