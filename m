Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8B115B117;
	Wed, 26 Jun 2024 07:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719386713; cv=none; b=lE/S0V28J+6IPe+HtwJKpLDvMGcNa/oblXdEOzbKO91rLl05vWz894OXbccbd4ZOKMO7+5uRFomnDK3ov7mnJoTVuVNSx4ritDtOrZOGL07YL7xQf9mII4vCXgJOnc7X3gwen11TtgKa093xM8VJMd/Akq7TQXKENAPQqq9QUzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719386713; c=relaxed/simple;
	bh=3QeZKNmf5UucjQPdUOezfuR2oHCnDs3KXTPt8fK56mo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fIpHibBObNNyG3y6fhkPvakKUCv1XFZ1+lNDzpJ7yS1OPKpCYMN2+qh7on+uMar+4EkTQgARByOI0UUfL557vECtdDZVyFIpW3AyEVoPohuBCGDb3ClPWR44A9iHE4B3v4mJLMRezMpP5FwFEm8MA7MM+GGiM8FLlf9HRW07lQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MtL2nRFg; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=9CqAsc4Q; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MtL2nRFg";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9CqAsc4Q"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719386703;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3QeZKNmf5UucjQPdUOezfuR2oHCnDs3KXTPt8fK56mo=;
	b=MtL2nRFgSbWqbfv7/IVpZWdKugQnButDyL4vnOVbwgWsFoa7khZi28+Gm0ATWWD8uzj75G
	3OKpDcXrF3Da5MN2zF7ck9DbVyU+DAnQj+l4jkTu90HqzjUpHZp1+fVPmqhqyXWDVxNdmG
	KDZE0v12WH5dh653+k/daniDQQ7t7BumIrJ2n1q0NUwi/mSA9dXAAwtSPGPDqvmoGtWVin
	ehQXK5a+VfGKqI9NQrDJX1aZlyXGgEjezc0DRlhYLymke2jwT4QrtZ5H6F4JyIFHsDCMIK
	AfplWymYX2tN0SFsDo6YDn/RK9UezADeTY9lNQyhe4AactMadMDUDmTHS+5MVw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719386703;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3QeZKNmf5UucjQPdUOezfuR2oHCnDs3KXTPt8fK56mo=;
	b=9CqAsc4Qk+gfhvNqDbLsH0II7z0NdACq8ZNpRyfa/q2GFXunQraCpiTnDmAhxwifXte4AJ
	sjpY6PqB4wSReoBQ==
To: Song Chen <chensong_2000@189.cn>, Andrew Halaney <ahalaney@redhat.com>
Cc: Derek Barbosa <debarbos@redhat.com>, pmladek@suse.com,
 rostedt@goodmis.org, senozhatsky@chromium.org,
 linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 williams@redhat.com, jlelli@redhat.com
Subject: Re: a question about how to debug this case in ftrace
In-Reply-To: <e6b0ba9e-e8f6-4c42-9f63-e3b67d7edbf0@189.cn>
References: <ZnGlt4uQRP_4nWu4@debarbos-thinkpadt14sgen2i.remote.csb>
 <6802e81c-1926-4195-812a-1a5fe13bcdde@189.cn>
 <xiune2bsqgin5ksk33q5bkihuz5qrv5casjofdyopes55zfcpc@uvvnlwxb4wcp>
 <4d198032-d4e1-4a84-8f56-1b31157e9323@189.cn>
 <e6b0ba9e-e8f6-4c42-9f63-e3b67d7edbf0@189.cn>
Date: Wed, 26 Jun 2024 09:31:03 +0206
Message-ID: <8734p0jhdc.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2024-06-26, Song Chen <chensong_2000@189.cn> wrote:
> ohh, by the way, i'm curious why softlockup/hardlockup/hungtask don't
> have ftrace dump as well as rcu stall, or is it possible to add a
> parameter in cmdline to redirect
> softlockup/hardlockup/hungtask/rcustall warning either to ftrace or
> printk.

Are you aware of the printk:console ftrace event? If you enable it, all
printk output also goes into the ftrace buffers.

John Ogness
