Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD7417F7;
	Thu,  5 Jun 2025 14:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749134979; cv=none; b=dkTE2+xtO2vHlkSU1oBgPoruX3FeMNGqnX92OIes82+rFstm5KxDTijNiCQMr5ho0EMjJcrVHrCDomWAMzjCOdK+9dW7aVWTwnsYKw1M8eGB1pk6F3WMIc6j3456Fn27a57PLv3xuov4hc/5QThAhWYsftV10LJlhITlj0sAEek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749134979; c=relaxed/simple;
	bh=i4KQ/CbTmUS2tg9fpzEME1uJNKGOVp1RQubGQT5+cKE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SqA+1UD7xYBvIXJ19SmiuBTCuGfVf7obiu66Q2OuOfgOWxWP6IE/3do2tjwwnqgcRhYCblE+5XI1ly95QDefAAtLiiippd5n5H8S2ciRTQu0U5jkxfZBfg3NFTAEboYJ7zN9kUyXw8sqOSOfLV9atdpSI5oPubm3d+QVmbeYz0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf03.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id 2C6BD160BDA;
	Thu,  5 Jun 2025 14:49:34 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf03.hostedemail.com (Postfix) with ESMTPA id 2510D60010;
	Thu,  5 Jun 2025 14:49:32 +0000 (UTC)
Date: Thu, 5 Jun 2025 10:50:50 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Flot, Julien" <julien.flot@siemens.com>
Cc: "Schmidt, Adriaan" <adriaan.schmidt@siemens.com>, "Ziegler, Andreas"
 <ziegler.andreas@siemens.com>, "Kiszka, Jan" <jan.kiszka@siemens.com>,
 "linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>,
 "mathieu.desnoyers@efficios.com" <mathieu.desnoyers@efficios.com>,
 "MOESSBAUER, Felix" <felix.moessbauer@siemens.com>,
 "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Subject: Re: ftrace regression with PREEMPT_RT kernels
Message-ID: <20250605105050.219a4a1c@gandalf.local.home>
In-Reply-To: <5f721932e0bbf880d2817498e35b54eabb167d98.camel@siemens.com>
References: <240017f656631c7dd4017aa93d91f41f653788ea.camel@siemens.com>
	<20250605082846.179bca96@gandalf.local.home>
	<5f721932e0bbf880d2817498e35b54eabb167d98.camel@siemens.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 2510D60010
X-Stat-Signature: jhrb3c9c5kf83nx4mmdg39wx9uz1feey
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19oyUkklZPPVn8QRNFot8YIBTBKmBIbCbg=
X-HE-Tag: 1749134972-609192
X-HE-Meta: U2FsdGVkX18P1QOuTgCx3j54bNpitHCjdEY9PdqnN+Mmz0aXXnSDneIRQ6QN+LYiC0YDEqytiq7eWqNCiop94EVTZUP68cr9IdvgoGpteP+qzWp3/tAciXi3YgEeQnSQpN8LzWrvmPaerTaMup5VKZ8nuRpcL2g2zZFqJ6MZy/FzHNhAud1l4vE9E6BFGA8aN8ctm8f4mDxesvlPSD1ILWtu6nTKDbtR3YHsplcgAkkfrddddX91g5+rED0/3R+1Q4nZCTto/In3J85WmxkXyY6p8J7dvQVOsq8mTP2DLdvIJjvCpGUDL47onjSwk+60yOb8moNMAt2UyZUgTHRnBuUkpVsirxUg

On Thu, 5 Jun 2025 14:41:43 +0000
"Flot, Julien" <julien.flot@siemens.com> wrote:


> I have tried the patch, I am afraid it does not help. I have roughly
> the same results as in previous versions.

Bah, there's three more places that call
tracepoint_synchronize_unregister() :-p

Let me try to get rid of those too.

-- Steve

