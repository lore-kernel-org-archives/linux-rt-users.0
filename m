Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA053225771
	for <linux-rt-users@vger.kernel.org>; Mon, 14 Jul 2025 12:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752495607; cv=none; b=bbwgZY+LvKOPUaMtN0UcjrdazVGmImqvI0NYrIw7yDIyxlL2biUwkOldcmXaoEh/D5Tdq8HqTErmwoDeg3j6M76c9nAwQykJ8rwpL5lJBuSE9mIqmCmsRXp3/hIcKSaNOKfeyG7CfYa9xyuWZEp3BhjYkPKARbZ5uqzcOlQo57U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752495607; c=relaxed/simple;
	bh=zNKyyTJQQZ5e2+9C8BebIZDmdtWd+mgjMzwimJVJp4s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=go+l7u97lErU4K/GD96fncY1Grjn1NsP9Eo8JBqG5KJLKnHzWcacWflY56TuIL8JcYH3EZ6k07nmW/0dNT0L84rJX7Aw0TK7TWRgjnJYL7wzPoAI+GOTeHL4ibXMujk84EctbQjCRqzvTKbJWMitlApgH/E2n3GeENprMsb6KDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ccQQ+hYB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qZ4j0xXo; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ccQQ+hYB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qZ4j0xXo"
Date: Mon, 14 Jul 2025 14:20:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752495603;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=f6Ispm3IKEokXyDld9Z3MBQenkHw5xJAdh3VlAJvQ8w=;
	b=ccQQ+hYB7L43qX/Po4Fc8fbjYIQZr8xlIQBEt8WD75f77/bxhhLncOzIF7frEwOXl4Xp1o
	P8naoAYhDVUuDWikraUJ/+XJRVWLSVM88in/GCjoD1uHj7/CZpnOwgejQanZL3HzEG27ej
	U72cL8fNaA/0yEldi1F2l0adHDHZX+nhaYAx4f/SPs+EFHJIDsAfv23s0jFn0NGix9OcyG
	lhrSKOHvpCi2cxjCWkHlf2G3DrzEtKrwNbxrAKyl3VrSdSq6gGtl/6B0UyIrwx67jzwIfm
	VTcKl8ilRtpuX+xDm9I17JzxZLZup0kxgl2VH8fkjpWVSmolcKQMZP0GPWWaQw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752495603;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=f6Ispm3IKEokXyDld9Z3MBQenkHw5xJAdh3VlAJvQ8w=;
	b=qZ4j0xXoVXmWBG0vE7t8UDhjhW4WhWEk0ccJWUd7VRH8E50kndJZCC7iiyJgJaz/lF+qd1
	O3t57RaAEwoynmDA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: "Ahmed S. Darwish" <darwi@linutronix.de>
Cc: linux-rt-users@vger.kernel.org
Subject: Re: [PATCH v1 04/28] cyclictest.8: Synopsis: Remove -y
Message-ID: <20250714122002.o9yIrxhv@linutronix.de>
References: <20250704132721.13325-1-darwi@linutronix.de>
 <20250704132721.13325-5-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250704132721.13325-5-darwi@linutronix.de>

On 2025-07-04 15:26:57 [+0200], Ahmed S. Darwish wrote:
> @@ -41,7 +41,7 @@ in the set in numeric order, in a round\-robin fashion.
>  .br
>  The set of processors can be specified as A,B,C, or A-C, or A-B,D-F, and so on*.
>  The ! character can be used to negate a set.  For example, !B-D means to use all
> -available CPUs except B through D.  The cpu numbers are the same as shown in the 
> +available CPUs except B through D.  The cpu numbers are the same as shown in the

This looks identical. Is this white space clean up?

>  .I processor
>  field in /proc/cpuinfo.  See numa(3) for more information on specifying CPU sets.
>  * Support for CPU sets requires libnuma version >= 2.  For libnuma v1, PROC-SET,

Sebastian
