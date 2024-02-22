Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 567F160B8B
	for <linux-rt-users@vger.kernel.org>; Thu, 22 Feb 2024 12:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708605621; cv=none; b=a6pirJmIO2ZYeBF5vvp1gurqJ/GguB9I3mkJI5a1B9NQPvw2rA9QGN2Q2Vp4Z4u5BAGnmWaCEeoNxJ9ufCAr6WWVInj1ySBEqiKvQpyfht5YeUdTUmBSH2MN0rznzSSQC3YUcf8eCWMThk+qVk5f/JghrM3rnBSne0bSOMBKjG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708605621; c=relaxed/simple;
	bh=TZtFuYd1iqgRksuYe0yCZRGhy5pbEjhH6V9QPfyMHwE=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LN0jeCJqLHh3+gMdBB+vhZ9ybyu/uZNSOuDCMzMNTyah+bMcb9zJDRweDhvyU8yX/nVv/5ZEal0O7dAPejCsC15R+aM3quIJjae+WdHCMdrdalSlLmMVZMGVhg2gBFLmyfqb4wuMEfzzgpNEmGHSp0lftf79saLunHI0SJf4ank=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=J9PDv7wg; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XDuFAn1M; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="J9PDv7wg";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XDuFAn1M"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708605617;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TZtFuYd1iqgRksuYe0yCZRGhy5pbEjhH6V9QPfyMHwE=;
	b=J9PDv7wg800BsP/12a2ohoCk4t+08P4ctMZO1FYgJ0L4mNuMOt7kFllHIIU6DrqXx96TVh
	wwxrNQiZNJ006JIlBorMyexPl43ToXfLrSuga7GamBdQzkAmb10tE5fxv1dBqq0peB/nd9
	Y20NVaJ6h51JNnVadDU66bpv9usUYbk2R1EkPkNkqOhyBBGMotU/t3RsnLsilHb85kLqXi
	XlA39YPzaYi0jdE49FWQN2a+6e8ztZnJVtCryS7QNoyniWzYuGjLDqhTFmpVPiOYkSjZqg
	xsmYCUGHsrmJYwW2aziM/KMMtFKD5C83cJzEMG/PLsISZYlV3sC5Z7YpFmZ5zQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708605617;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TZtFuYd1iqgRksuYe0yCZRGhy5pbEjhH6V9QPfyMHwE=;
	b=XDuFAn1MIF1dL2S1DLtEGdxlrU1WdKZ1KWGVr+owutWy85gpvtIDPZf8LceDvrBf1BheQ5
	XFHkpYkuDNSiddDg==
To: Sahil Chandna <quic_chandna@quicinc.com>,
 linux-rt-users@vger.kernel.org, quic_chandna@quicinc.com,
 quic_akdwived@quicinc.com
Subject: Re: [PATCH 0/1] Fix NULL ptr dereference in nbcon driver
In-Reply-To: <20240222101626.1142-1-quic_chandna@quicinc.com>
References: <20240222101626.1142-1-quic_chandna@quicinc.com>
Date: Thu, 22 Feb 2024 13:45:53 +0106
Message-ID: <874je04qqu.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2024-02-22, Sahil Chandna <quic_chandna@quicinc.com> wrote:
> Add a missing check in nbcon driver which is causing NULL pointer
> dereference bug.

I believe the correct fix is here:

https://lore.kernel.org/lkml/20240123054033.183114-2-junxiao.chang@intel.com/

John
