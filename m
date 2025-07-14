Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F9173FB1B
	for <linux-rt-users@vger.kernel.org>; Mon, 14 Jul 2025 12:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752495869; cv=none; b=YY3GYUn4g5bliBqgOxsPOQnVstY+IINpc9Y0+UU3OgU0N2GUwiJV7bQVD0tGH8e4/6F5EDy2+Lkf+rXGGKntMJClom7NGQtlbkBoG0gJdqTp5HDJkQt/BO+sXYDkmXEtCuM12DqMu6Bt9V2e5HlCzffw4AQftxiaeSJ3aFMA0tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752495869; c=relaxed/simple;
	bh=9TnGvRGLQecM8lmpyLJYsjdvsd2DLBYuvvwr/1ybVx4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gqug7EwY/7/UyqGQb0iL3y8wlYe6PHJGXWmIrfxE8uiatZtA5/xc3NtJO9WK0fWG9LIEyR9fQ2EQH0im9EDe26u6/uaYVtsmCVgrtC+5LDpovWJEVEqkgF0qf1YMR+uWsXVQXe8fgi6E0Hdmxk03wNt0PIdaXBNK51hbPP3y/4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OPpYHsfU; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/KQqXCxs; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OPpYHsfU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/KQqXCxs"
Date: Mon, 14 Jul 2025 14:24:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752495865;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KkupfMA7sccw6zl3insRvh/BzYLAcs8EScn6hUcASEU=;
	b=OPpYHsfUJ+b6lbKVNHbo3REdMPc0kIbjzbijkjaOwy/VpkkKV0diWZMhp0ERQSONksl2Vj
	9FwR8wI6DRZt27UkP81ka26MoIFQ/jQiB77U/0UUk39w6U1YAv0E8rf6hV+atJ/H0+4QoH
	G9AMG1rpsNuHo3vvOO4amamkZDe+wpXqurd76Xki0t6Rj2RodiS0f5t2RYk0sSxsIhnHKY
	u/AH1/A9FU+zzIl63QZqpUEBuUeXPcp8yeU5eVJdOJP2AG5SaBUj9WFcDHLgyedVrc+EKS
	RFNLM/wbKaIAq3k+FbOOuBdg6GEf87sHJJX04AD1lK//ttYawMb2cKUOLB43nQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752495865;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KkupfMA7sccw6zl3insRvh/BzYLAcs8EScn6hUcASEU=;
	b=/KQqXCxshOeWWeNzBLvI4H3UOUGKNAgasKwxWaQQCBZBnpcaZFoRPqMB0SeZOBM/sxNHnL
	ncdrY8kzyv8eN+AA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: "Ahmed S. Darwish" <darwi@linutronix.de>
Cc: linux-rt-users@vger.kernel.org
Subject: Re: [PATCH v1 08/28] cyclictest.8: Align source file to 75 columns
Message-ID: <20250714122424.sMbrjNu8@linutronix.de>
References: <20250704132721.13325-1-darwi@linutronix.de>
 <20250704132721.13325-9-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250704132721.13325-9-darwi@linutronix.de>

On 2025-07-04 15:27:01 [+0200], Ahmed S. Darwish wrote:
> Enforce proper column alignment for the whole cyclictest manpage source.
> Next commits will significantly expand the parameters' description text,
> and without such alignment the expanded text will be hard to read and
> review at the source.
> 
> Per man-pages(7): "please limit source code line length to no more than
> about 75 characters wherever possible."
> 
> Note, no content change, as verified before and after by
> "man ./cyclictest.8 | md5sum"

While this is already an improvement you could also go for "semantic
newlines".

> Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>

Sebastian
