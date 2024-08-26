Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB141197A6C;
	Mon, 26 Aug 2024 16:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724691413; cv=none; b=p+EU8B3qxkde2wNwu8RG4GfIo5U+VzRrhSsb4AmTp6/QjAAI4cZUQUxwhSvZOjesItZ/n283Spq/+sXwhLaRMpRQYCdt36ogRlHukitF69kbqq8E8P/LNJToV7IqPMjKnDXrIb0w5mHWcoxp97Fzzcaf1mlnvQkYF811HmH5kSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724691413; c=relaxed/simple;
	bh=xxwRw4YOaj8TLcPHOU91iuY6HhcCQVRbnNGCZn7HdkU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cFGyKE07vdl6pAqPAIhywLAITpaVz44pqgeWnbfym/3kQ34KjYwHZnKeO/dRI5VDggrEdjAP1U6ejqeaWDTNhM5Bz503vbeo6G4vKlSiR3XEizxohVLfXK9u2iD0h7d4aS+FUEXjr18Ay+hTXgVduUpW5mnjDo2zAcMEuIeWaCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=G/hUm7P1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Eh6mNGi+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="G/hUm7P1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Eh6mNGi+"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1724691409;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gC1Dl6gLiQeB9RGS1ZMPwFGcoDhW+yOH0OvpGdt7hZQ=;
	b=G/hUm7P1KRN0bex64Zt5mhqswA8uRtdhJy2onsHymv3rmDER2QaKQneNqXKGB9Mdx9tfl3
	2u/6vVoUOckIKbSmVHraCqq906vznTlPW6upgjUcaC9KV0AwTKhBIJDOy2QIWSieoxJW0J
	tXI1kuBOE/lb6h9EviAyEKxqVd9ecsLiP5inZRccMNQLSHlV/F5l+7O28WIdVNp781VDYr
	cHdzAAmoA2hnDbdhhcjfL9RR7ov6zRwUFLwkNz2e376KhNeSdcSLCmvxggHLcMNnvkqJV5
	o/mreEmoChWUDvIt0gWY+Xa3Kpj++Ag+u5YZ+oPdXY3eDi4Eemn3E7lxUypTzA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1724691409;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gC1Dl6gLiQeB9RGS1ZMPwFGcoDhW+yOH0OvpGdt7hZQ=;
	b=Eh6mNGi+joxXRxK+qzEX131wode5hGq7MJWGNC5Bd6Uvtp5CMh0gcQZPqf5FRj71fGvUFf
	I+c1usPeZ2bV1bAg==
To: Petr Mladek <pmladek@suse.com>, Derek Barbosa <debarbos@redhat.com>
Cc: pmaldek@suse.com, williams@redhat.com, tglx@linutronix.de,
 linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: test 1: was: Re: A Comparison of printk between upstream and
 linux-rt-devel
In-Reply-To: <Zsyafduo2UItzLAK@pathway.suse.cz>
References: <ZsdoD6PomBRsB-ow@debarbos-thinkpadt14sgen2i.remote.csb>
 <ZshiIdUFQs4CKW2t@pathway.suse.cz>
 <Zsjd0WUNIU8_kprt@debarbos-thinkpadt14sgen2i.remote.csb>
 <ZsyK-s2D8eqqBrXU@pathway.suse.cz>
 <ZsyVXMqM2SK0aYyV@debarbos-thinkpadt14sgen2i.remote.csb>
 <Zsyafduo2UItzLAK@pathway.suse.cz>
Date: Mon, 26 Aug 2024 19:02:49 +0206
Message-ID: <871q2b8bou.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2024-08-26, Petr Mladek <pmladek@suse.com> wrote:
>> [  111.777491]  ? __pfx_hrtimer_wakeup+0x10/0x10
>> ** 8555 printk messages dropped **
>> [  111.807996]  ? __lruvec_stat_mod_folio+0x86/0xd0
>> 
>
> I see. I guess that the panic CPU ended in a deadlock in
> console_flush_on_panic() after it ignored the console_lock().
> Otherwise, it would have flushed the last messages and rebooted.

For the 8250, I would expect the legacy driver (even during "hope and
pray" mode) to be fairly reliable.

If this is running in QEMU, you could attach gdb and dump the backtrace
for the panic CPU and investigate some state variables. If this is
reproducible, it may be worth investigating where/why the legacy
printing is choking.

John Ogness
