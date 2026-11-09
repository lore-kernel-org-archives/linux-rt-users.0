Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794225147;
	b=haL7bY9crtffI6Q/ILtsMFIgEAQ7oJrIBYVjLYB2Vciu7q8YXWbq72HySW9+VRsNX9ou
	 qxxhV2xkv+lJv+S2cJOrVrU5/ZVE3GzwiWk42j4gxLt4zjwwjKGXz3mrgju+hZHb2Lh7d
	 XC0yQYZUQb4odONOfu9P1swF24/iQlo0zhKJLBkvMvIL8Sc7LUSjTNyzWRGwenBAPYH55
	 jWgi5GHsJiBhHGVBPqia3AOn9J5azl3NxTdw52vAlcJaAywhxneMOndMe+S6u35iQ40FG
	 EsD7vgt8rOz9c8UIpOmOmJU7JmXMER8Cwm4jIRt8Sl/WWL0SBX2dn6D6a2UJWfz2RVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794225147;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=sL4Tf4gB442/jnpHN7/fkKBV+N23gmACIheiz00tsf4=;
	b=FWZ4EL70kcjiTqkfhwy0xn98LlHJluWQ3hZR8Vhq2YxwCLexjNt1wkrgak2a8/QuH2aE
	 CTDsGM+oZwnVYPl47EA9cHhKZLVTnPvQ9Yb+bWk5ebRxgQZ4kTMZYeUC8hdMgobgk4tqP
	 +97EPHinCarP9LK5Fajm15tjHa+/3lwe12w9cx0IdazMVbgzPm3w1NwOnUTLglrNaq/jD
	 o/s4XamkYB6cXNtXPjzB9ImUdJn4TYB+DlHoU23pBTBZ0tj3HMFa/T82zTIRRW4aOFR0i
	 Wep7WI4VXjbJ78ZeekATYUSbwx9oH9u9CiuFCcskKQkIbwL7CoAyjgxuAiKJfVHKcjw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=IILi+mDM;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=DbuPyIHf;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE18B606A322
	for <linux-rt-users@vger.kernel.org>; Mon,  9 Nov 2026 11:52:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BE18B606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=IILi+mDM;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=DbuPyIHf
Date: Mon, 9 Nov 2026 12:52:23 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1794225145;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sL4Tf4gB442/jnpHN7/fkKBV+N23gmACIheiz00tsf4=;
	b=IILi+mDMNg13tzzZ4U3jh3u2UaSI26dF9/WUH+iTjZNVuIzEC+jDvRb3J6zUpWnb270QEq
	ux+9Ixx2ht16ynJaUBvbBBxaGbwSDtza4syN9WXaUi77dop+P3Hn/dusA679kp9JYYdK/P
	ODihlqEJSsI/zyh2nVSUXrNWO3uSbCIvkPU8Tmngb6y03/yDZtwBE/1gIe4Zxm+Z0a9igK
	SoP5HnD8o5BL5vfVoPIKB3vgefRC2BIBO2mpx/PnsuUkiL0xX2ApitWFra1SE3dZW/ePwB
	+EGkI2UcDD0BSqAWmkty6kLYGzt7uFulynSn7gQAkO3KP/id4wS5YY1t5WHDfw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1794225145;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sL4Tf4gB442/jnpHN7/fkKBV+N23gmACIheiz00tsf4=;
	b=DbuPyIHfxKvFyOp9XGCBGw5IUKmVgRD0mvM+jwPxidX5Y+ev9ZWrw44iA9BLWc+C4Fdjo4
	JiVFSjas6ylAauBQ==
From: "Ahmed S. Darwish" <darwi@linutronix.de>
To: Sana Sharma <sansshar@redhat.com>
Cc: linux-rt-users@vger.kernel.org, jkacur@redhat.com
Subject: Re: [PATCH v1] rteval: Covering edge cases in multi-stressor support
Message-ID: <avGz940EAsx6-GvX@lx-t490>
References: <au4t5C1-WpgWChOm@sansshar-thinkpadp1gen4i.boston.csb>
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Post: <mailto:linux-rt-users@vger.kernel.org>
List-Help: <mailto:linux-rt-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rt-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <au4t5C1-WpgWChOm@sansshar-thinkpadp1gen4i.boston.csb>

Hi Sana,

On Fri, 06 Nov 2026, Sana Sharma wrote:
>
> Added a number of unit and integration tests for edga case coverage
> Also added some logic to multi-stressor support to de-duplicate values
> and cleans up trailing spaces and commas.
>

For both the subject line and the changelog, please avoid passive language.

Per linux/Documentation/process/submitting-patches.rst:

  Describe your changes in imperative mood, e.g. "make xyzzy do frotz"
  instead of "[This patch] makes xyzzy do frotz" or "[I] changed xyzzy to
  do frotz", as if you are giving orders to the codebase to change its
  behaviour.

I did not look into the actual patch, but in general your description text
should've been something like:

  Subject: rteval: Cover multi-sressor edge cases

  Add unit and integration tests for better edge cases coverage.

  Add multi-stressor support for values de-duplication and stylistic
  clean-ups.

Note the imperative language change.

Thanks!

--
Ahmed S. Darwish
Linutronix GmbH
