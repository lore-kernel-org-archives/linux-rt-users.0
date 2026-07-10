Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23EA425CF9
	for <linux-rt-users@vger.kernel.org>; Fri, 10 Jul 2026 16:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783699936; cv=none; b=jHbuSWUEq5VRNRktpnjyV/X2MZ8z+Na4iaR6GI2005nP63IGbMGVU6zrA/IDtflvfO9ERUwF4cxfSLMHLI8mxBYNp+TI7ic+4TXFbu8vrx8oZhtH8KJ0Lck+jNK7ZoL+5NR/+Cs3IMfPZGO+AG5/n7m/wjPEEypWxU5lYOiRsU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783699936; c=relaxed/simple;
	bh=GdUdZfmf7MiuR/NXiH/XuRtoK4WmQXKBuhNL9m53M/s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SZGMJZjsJoRmmdZKFa5zLrtYyFaafWfFwSTBl40hOtA6tpoWOyDPpbxjMo1PxDwlUITmZwcCYJOCZJ/apnPeakg5ApUfXMidQxoXIW+iGK6CXnTrPnm5g61dtJsMvvDWsoANTTFUtn0FqtRKXv1FeNso4l8gqCtwKHN3B/9lg/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf03.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id 9925F404E5;
	Fri, 10 Jul 2026 16:12:00 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf03.hostedemail.com (Postfix) with ESMTPA id DDE6F6000A;
	Fri, 10 Jul 2026 16:11:57 +0000 (UTC)
Date: Fri, 10 Jul 2026 12:12:07 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Greg Kroah-Hartman	
 <gregkh@linuxfoundation.org>, driver-core@lists.linux.dev,
 linux-rt-devel@lists.linux.dev, linux-rt-users@vger.kernel.org, "Rafael J.
 Wysocki" <rafael@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Clark Williams
 <williams@redhat.com>, Danilo Krummrich	 <dakr@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Thomas Gleixner	 <tglx@linutronix.de>, Jan Kiszka
 <jan.kiszka@siemens.com>
Subject: Re: [RFC PATCH] sysfs: Add /sys/kernel/realtime entry
Message-ID: <20260710121207.7e55d6c3@gandalf.local.home>
In-Reply-To: <ae96c274f166301aba762d97caccddf176ad7968.camel@siemens.com>
References: <20260709143108.UYeCUUcd@linutronix.de>
	<2026070922-kilowatt-matador-5e1c@gregkh>
	<20260709152214.rH1O_8SM@linutronix.de>
	<748a489687000b21d0e8f961fc2f9f963b0bc1d1.camel@siemens.com>
	<20260710115145.32729a7c@gandalf.local.home>
	<ae96c274f166301aba762d97caccddf176ad7968.camel@siemens.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 9qt18usyjjtxnwu91jmx1hyunneue574
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: DDE6F6000A
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/gWt7CHnMoNhn0ZP27yxkPjM9qm1bxEo0=
X-HE-Tag: 1783699917-50465
X-HE-Meta: U2FsdGVkX1+r8SdiorZOat/FEemXjoEGUldToOgyALL/p3eV6MXEn3xt+O3HF4yMfz8lyXNbEs9nGjcXFwWemZVi7Sr11wavDbEBv/kYLQ1saf/46v9pVvJPqCyNxMozVsYwcDoxdEJLcX6gYSf0WF9fGEl3CeOQcrpqMrmi26mSI2tE29gpHLS9031VNkJBiTwm5alqm3hlXUX7TbVSbJ3o6kZhlPIJh+QLzC2sC34wnesOoJgU9X9U7LDS1sc1yNsv+rzhLTuelHQ8xQzkap/91hoQldoVzSFCU5x+qU0bE31Fyn41RcySEW/oABgVOkTO7xp1QMrCxlucoUDgym8dxPgfnSs6

On Fri, 10 Jul 2026 18:01:20 +0200
Florian Bezdeka <florian.bezdeka@siemens.com> wrote:
> 
> Depends on what you consider a valid update scenario. Updating from 6.1-
> rt with sysfs available to something like 6.18 (no sysfs anymore) will
> still break - as long as you do not (force) update userspace in
> lockstep.

The key difference above is the drop of "-rt" in the version.

The "Don't break user space" rule is from Linus, and he only cares about
what is in his tree. It was never "some external tree supported this and
now that code from that tree is accepted in his tree, he must support this
other feature too". To get any feature in, it must be accepted by upstream
maintainers, regardless if without it, it breaks user space from the
out-of-tree code. Greg already showed his reluctance about this change.
It's people like Greg that get to decide if it gets upstream or not. In
their POV, it's *not* a regression.

> 
> I learned meanwhile that our detection moved to uname meanwhile, so this
> is not a problem for us anymore.

Then I guess it's not a problem :-)

-- Steve
