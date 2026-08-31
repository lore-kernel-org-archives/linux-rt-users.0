Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82DC036F8EA
	for <linux-rt-users@vger.kernel.org>; Mon, 31 Aug 2026 16:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788194560; cv=none; b=O4NnBFAJ0/TCEnIRvTETHh6Pox7fYU3C+PYhmf0XW7w4SUbQnpbD+b9iqObD0KqMbN6lLqjZFHJOdLPBpQan7pZf1HD3AO5casAP34qL/jUX5YHVnbg8sxGzSphn5RaBL1iLQ8JPvvVbn/BOHm3rW3Eg/tDQQ5At4UR/jhwoSuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788194560; c=relaxed/simple;
	bh=DlJ9PNo0SJAwa6SvI/MUMaMUVy4TwOolKkMMhRrIfIA=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=SI4yRHL+2DgriONrE2W4uE90ZMPgFWZufW6Xi3vhWI5WIGB+lIz+YH8fZZJIO8t2gAV94f0zIOLneKjDp+ZTHVKkgpM4VdIS+BroQz46Hm/UB7YYFiEe6HaGJWJl14iFGUBMx7oclQJWvZT5HqzywdzaXT4QVJjLjQ9Qmfh+dfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YgiRhXKX; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YgiRhXKX"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-936dfd009d1so6312985a.1
        for <linux-rt-users@vger.kernel.org>; Mon, 31 Aug 2026 09:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788194558; x=1788799358; darn=vger.kernel.org;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Fw+yiSTDTKc/L5jrXF0xcY49oxuKc3pbh+/W9PbkZoA=;
        b=YgiRhXKX37+srirrgA36B05Eu3TLVJ5WaMtNGGPlVv8Wo0mJrrGfND34VeC2TLR0FM
         5Wm/I5P0xRj1TfroT+tGL9mVaDQ1mM50g01LNdNNF4PLJbdPhx0/sLnuu5IHrGlZVBCE
         KUkZY0b9K2FlAL2l2syBWQlIahYqciK9vD0bSZNqzVx87oxb1xaM7UTZzeujxSP+2DpA
         gmXOgJTPSXtIFrhEVv5MvdlEb099VOp8zzUWL+8PX3vQ3ETzbi2CFawNeDEfDHmGys2T
         qmabhXcTmaBtqakJx2WDovZ4cPeT4diAvDku/tfq2iVMpq/bRHNFNhDz/jgecKB4X6r3
         osjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788194558; x=1788799358;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Fw+yiSTDTKc/L5jrXF0xcY49oxuKc3pbh+/W9PbkZoA=;
        b=cyKEUO0qquDnsQPcIZi4g1Df2lucgT+ED6QMeuQghfzAmlptBsGogIJ7i+xtUBlQoE
         X6jNZvE2pyqE7/VZuJ3N1S40wHUQftqpCJNN7S0Tc7y3FXVwk/A+A+sgQvZKpJv74r3o
         Y1ldsqjfeeP0R8w23MimCQep8Bp4CyE8QK0Y7TBqq262V2PDSVYL2T0a7CnEKqwHLtKi
         ugFZnhatSlMBNZBt3DRq/RkP5Kftp8/OqyIy2tQKo8LHQloY3EJa/M6lf7oHG1SX7Q6W
         nTHJZtd8B0Zs1nF67BX0c9Zb3lCcGKH4vH3CKeAmcdgpurBR/94GTdLuEQNbu1JVCN7v
         jx2g==
X-Gm-Message-State: AFuF++mX7fwU1+0hKgm+VTfnMo9HhKY4PZPAdXfIe7Gf1nV0x6Q8P9M9
	LqptVjc7SP6q5YId+6gu/ZZP2gBPNexGjLKjdk5mNBFPR+6uDkoml96Z
X-Gm-Gg: AR+sD11eZJgXJG8EdcqRgv23EKoLnQKtua8lnpE/XJiWXUAKDHu3olqLFyec287eFbR
	AeYyY6mPLtAYjt5kvXOQPuGb3nPg6gmCXtXDbkGA6y3II+85TzMx8PKClHStQ12Aph/paAStFEO
	2p3n1Dh2S5MWrWZ9YMtRe7gPtuvNZMhVq3B1TEUKmqjljGPYlhq0Z2nzIN99wJZ0ly+TI2t87rf
	svyufOFUhFodREZyd2ihxhaMDwfPTWP8A/7NJRi2GctuLj+3qC2nyBmAI90i4nTjHRbMeLRSsj2
	NRM1cG8GeMaR3xQdIptP8E32DNU3uqOuP1gQI6VmB38avftu/PUS1Tby0A/SQ+3wlqobv2+RqLj
	SjkEf2eImmNTvtolmkoFjzgUU7OcwJTO9JJ+RzuTrBJhdDrUZqx5OjKo689ZDQGEWety7XE3J3T
	/w0AZoqtl+uyI98QXhgXBDjkS+fY3JhXIqIryNEICSFtCIPEBZiVT9YtjnijhuCyxwc4Nn9Yq51
	pUDW44z5Xo8+SoLD8bh6DHAffnknwxxRB3RPCFyybTDVfU=
X-Received: by 2002:a05:620a:2951:b0:937:17f9:da2 with SMTP id af79cd13be357-93936be623cmr1068376285a.6.1788194558235;
        Mon, 31 Aug 2026 09:42:38 -0700 (PDT)
Received: from Cumhall ([70.53.55.174])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93932135248sm415856885a.39.2026.08.31.09.42.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 09:42:37 -0700 (PDT)
Date: Mon, 31 Aug 2026 12:42:34 -0400 (EDT)
From: John Kacur <jkacur@gmail.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
cc: linux-rt-users@vger.kernel.org, John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH 3/5] cyclictest: Make break_thread_id_lock a PI lock
In-Reply-To: <20260826132153.2476006-4-bigeasy@linutronix.de>
Message-ID: <0d4b0ceb-4903-ad36-fc79-ab60cc8f87e6@gmail.com>
References: <20260826132153.2476006-1-bigeasy@linutronix.de> <20260826132153.2476006-4-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Wed, 26 Aug 2026, Sebastian Andrzej Siewior wrote:

> break_thread_id_lock is acquired at the end once the application is
> about to terminate and the lock ensures that only the first thread
> writes/ updates the termination reason.
> 
> Given its usage there is no requirement to have it as PI lock but having
> it as PI will keep the RV-monitor quiet so let's do it.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: John Kacur <jkacur@redhat.com>
[snip]
