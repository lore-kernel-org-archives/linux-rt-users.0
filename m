Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96ACD347524
	for <linux-rt-users@vger.kernel.org>; Thu,  9 Jul 2026 15:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783612471; cv=none; b=bBSwFogq6nqoi8eVuu/lJncoq/3X/sDiJCbTD23bdOMJ4ytJT5kD75n1Qx20n+fiHwoZqheV1yA9eUQIbBT6OjifansvCu0GMOJlrTgmSZke80tL2/uOeVuLLDwxuCzweQEcTxcdnoYBq9hjUqc8gKDOrsqZGNzOiqaJHksGPNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783612471; c=relaxed/simple;
	bh=3y6GdJYv7Dgt5sVoWsZJteFzO43v5wLB4YaiK9DIrDs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aL4uDZtznCk1wa4t/wMGKdUSZk14PBAv50tEwJwiQ3HevTl8o/a1/SF3W1LrhJNo29WmH3X2DhYB9Jb7OFr2UW818xGrDwTDKhNadWn1VTA9qHTBvH7YFI7MsfqBxeyKYmuk6NwvCeadMKlP8Y2sDeu2TbPJAkgmFUOnz1NYwgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf15.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id 32907C101B;
	Thu,  9 Jul 2026 15:54:22 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf15.hostedemail.com (Postfix) with ESMTPA id F1C9118;
	Thu,  9 Jul 2026 15:54:19 +0000 (UTC)
Date: Thu, 9 Jul 2026 11:54:27 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 driver-core@lists.linux.dev, linux-rt-devel@lists.linux.dev,
 linux-rt-users@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, Clark Williams <williams@redhat.com>, Danilo
 Krummrich <dakr@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Thomas
 Gleixner <tglx@linutronix.de>
Subject: Re: [RFC PATCH] sysfs: Add /sys/kernel/realtime entry
Message-ID: <20260709115427.3249f48a@gandalf.local.home>
In-Reply-To: <2026070922-kilowatt-matador-5e1c@gregkh>
References: <20260709143108.UYeCUUcd@linutronix.de>
	<2026070922-kilowatt-matador-5e1c@gregkh>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: xcr3uohwhm9jpa11to38oa6s9kkc5krm
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: F1C9118
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19laf4mXE6dugHSf6R/8MR7K3ns4R5b1Fk=
X-HE-Tag: 1783612459-275221
X-HE-Meta: U2FsdGVkX1+VyMkqRkuUx9fvOqbeD1dFtr+lhfRXZHcJyYXX84JoYutUCqXLiY33inqPk/fOh0t7mWFLA7HSN9+MyZpmQEUN/MWYZDP2+GPrW+gaZikqs9C3vNTPEIMw4cNgmGfY0yQkTTvbPyr2QoMMoro2Hop2Q8ik0jpxJlSTXrfLRP/5/X4RDwWyeSkMUgGGFK8j1GzjuEcHsZzhkSNjnZbmWn2/RSJcb1BQS82gx2WIjJzpY80+rz7O8XcAdsXhHBgoOFI31J00e17Em0jKliHROeV20YKT3s1tVZWqD9yjWoCnrSMpgpbrsd6nIqHqA2kJTYwdGa0Q4XuTLYkxJOy0JtwPou9cw8AQGccsrUNWmTXAk+fso4x0RdbG

On Thu, 9 Jul 2026 16:46:19 +0200
Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> At the very least, it's not ok as it's not documented in
> Documentation/ABI/ :)
> 
> But really, why is this needed?  Userspace shouldn't care, right?

User space most definitely does care if it's running on a real-time kernel
or not. Otherwise it may not be able to make its deadlines.

But I believe a more appropriate way is via uname, which I believe it
already does what we want:

  $ uname -a
  Linux bxtest 7.2.0-rc2-test+ #16 SMP PREEMPT_RT Thu Jul  9 11:50:36 EDT 2026 x86_64 GNU/Linux

-- Steve
