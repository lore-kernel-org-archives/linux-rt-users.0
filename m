Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3703435ABD
	for <linux-rt-users@vger.kernel.org>; Fri, 10 Jul 2026 16:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783700455; cv=none; b=DlUWvN9bI4TQZYTPf//3CZYC+wCggi0w14uoo9N0XXWsO8DPfd/S5xS/MVs4BGbmMEcHuI3M9jxR02dEps1U8TyGuBmBVdwPHJ20l2Qb5B2F8+V9yaj2tHBbr75920KY/K5A5OITDddxk5IcWZURRH70mAaczpzSBr/IKPE496o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783700455; c=relaxed/simple;
	bh=GvwTa/62diZ/Zn8kt0oriCZbdJ698Nc4TIvwnU2j3EU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QqHPF3Tz7nMICL9bupV3JXdYj0p6JB3xXuLVCnEeZiiJCGUz6yuOD2yH5pcYScWTrI3B3g8B53JD8rml2utGTKie+sHwB7kqfNu7o/rFpUM7Ni3ro9iaW3vtSnM2AThvLNO6zGJtTGJZG4dALGGipg51rMqld5br6E0B4548n78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf01.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id 8EE291C85AB;
	Fri, 10 Jul 2026 16:13:58 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf01.hostedemail.com (Postfix) with ESMTPA id 028196000F;
	Fri, 10 Jul 2026 16:13:55 +0000 (UTC)
Date: Fri, 10 Jul 2026 12:14:05 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, driver-core@lists.linux.dev,
 linux-rt-devel@lists.linux.dev, linux-rt-users@vger.kernel.org, "Rafael J.
 Wysocki" <rafael@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Clark Williams
 <williams@redhat.com>, Danilo Krummrich <dakr@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Jan Kiszka
 <jan.kiszka@siemens.com>
Subject: Re: [RFC PATCH] sysfs: Add /sys/kernel/realtime entry
Message-ID: <20260710121405.0262ad6c@gandalf.local.home>
In-Reply-To: <2026071052-backstage-skype-f22d@gregkh>
References: <20260709143108.UYeCUUcd@linutronix.de>
	<2026070922-kilowatt-matador-5e1c@gregkh>
	<20260709152214.rH1O_8SM@linutronix.de>
	<748a489687000b21d0e8f961fc2f9f963b0bc1d1.camel@siemens.com>
	<20260710115145.32729a7c@gandalf.local.home>
	<2026071052-backstage-skype-f22d@gregkh>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 9e4zt8i1b9q184cadfietxgb15erzchr
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: 028196000F
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19Xu4sWlEIau/Z6FExvfaQhFYPafq2kbE0=
X-HE-Tag: 1783700035-510940
X-HE-Meta: U2FsdGVkX18WIHfCHAI+qI4jNCOhsm3KBDSzNZC9MKP4HTuSB5NErqVWSAgI7bXc0xs59wNQ3TNU4NLxR8/iNKRCv466blJPiDMnVsH4YM09JovS9AVeJ9OEOIk7NFo5XVFksNMkVkS1IwhclJrM7XJ9KmSmHMuor2u0IrCNQt31LoZiqWJot8J0zyLrbW6jCyKQiu2ifX19nVVKDsznSuOj1g+SWirnaZ56bPBSjIElwF+okAdqGYVsc9BFjnQeRqhnxd/ExAt0eKaFsWN0FSjHnAZ3Z54aeq++jFF8NzZPPEx1g9oYcT2KM6MFiri0u0wRUPXZOcuwjmwGAsE4hWUBt1KiDjymBuSaB2F7ybljcANAFhRUmdnZ8viEcnkDKK0hNh5kwIFRmxaqfeD0YA==

On Fri, 10 Jul 2026 18:05:12 +0200
Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> On Fri, Jul 10, 2026 at 11:51:45AM -0400, Steven Rostedt wrote:
> > On Fri, 10 Jul 2026 09:23:16 +0200
> > Florian Bezdeka <florian.bezdeka@siemens.com> wrote:
> >   
> > > uname might qualify, yes, but keep in mind that this sysfs based API is
> > > already used, so a removal might break applications. Yes, userspace can
> > > be fixed / adjusted, but it remains bad style, no?  
> > 
> > Then at most it will likely just stay in the -rt patch set. As it was never
> > mainlined, it's not breaking any user space that uses only the mainline
> > kernel.  
> 
> I never said I wouldn't take it, just that if I would, it has to be
> cleaned up...

I didn't say you wouldn't take it. But you brought up a valid point about
if it is even needed. The point I'm making is that it's not a regression
from the POV of mainline maintainers (people like you and Linus).

-- Steve
