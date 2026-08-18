Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D42002D77F7;
	Tue, 18 Aug 2026 10:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787049390; cv=none; b=AyZ4PbSe4hsvWibUoflF7SK1VvO6AayeSAEiry1CMns3Ot9IZ6VAw0DMXRcS+5YLesbC9AnNATeYrKLd/Mbk3CbaNWEMSItyGKjUuN0OX5M00pSaFqFwINLzG/ZBSbSHHesqMC57JSnpiBlWD++dbjgGlS73/zpf1CFS68k7Sxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787049390; c=relaxed/simple;
	bh=YKCYEuiw+WPOkBo1XX+ggIm3vxQiO6pL8TSJkLLoFzA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=VVQ0B8WRBDIZaMhuXNaNef4o88BZOU4NX0zl149BwnD4lS/cjrpUVTDPvB2QJaIBU34U2Z//wE9wWm7hDH4K0dsVy75l07RX+23bOnC1TP+mIxGwFo70Eo23OhbfdSeF9Sti8I6sIRW8N7wHW+iRf8RW/h+iepdGabIqFSmoGpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZWEAasM1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sZvKc+2q; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZWEAasM1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sZvKc+2q"
Date: Tue, 18 Aug 2026 12:36:23 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1787049384;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=DXNunXAcCQAPlbJmh7fTmshuW0hdTZXe+vBkLoBjgSg=;
	b=ZWEAasM1CB3twPSZFlC8vbklWcGVlHQAo7LJWfqJgp8E4z+4wogVV6H1TvxM4KCmIgWvfK
	hBrIMP1Dass1sOotPt4OURr/yRqiguXA9041Xn3kif6KKFUZEQgf808LtAEkSWSPevCcwT
	frCqTJ4PRI1ujVtiGE/eg3zadfOO5v2dwA25TyqRYF+3rY1m2JqPS2Hn/seIgvrkliMLRv
	YFK3snMFPwQZApdQLobS1wQ5knbnha31lDXqDatPILjkX7v2p2MbVr0QMNjXXJPvQXp5ps
	9C5oWmGRcHmgj3qxS6dOry3VOulZ+OZ+RYzxHCSyPqanTRB6Hn6cEyVkvf3QGg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1787049384;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=DXNunXAcCQAPlbJmh7fTmshuW0hdTZXe+vBkLoBjgSg=;
	b=sZvKc+2q6gGGLuo/doLQaJLdeqdkimGW/oVtCaleWGjLq87vUnPtLcXtYbHKftV5f7JezG
	a9M/928kb5++ufAQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Thomas Gleixner <tglx@linutronix.de>, linux-rt-devel@lists.linux.dev
Cc: LKML <linux-kernel@vger.kernel.org>, linux-rt-users@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v7.2-rt5
Message-ID: <20260818103623.FLTm9jnq@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Dear RT folks!

I'm pleased to announce the v7.2-rt5 patch set. 

Changes since v7.2-rt4:

  - Update the two ARM patches with the version that has been applied
    upstream.

  - Update 8250-nbcon series to v11 which has been applied upstream.

Known issues
    - Yoann Congal reported a bit spinlock in dm_exception_table_lock().
        https://lore.kernel.org/all/Z8GTjqgDe_5EkE3t@P-ASN-ECS-830T8C3.local

The delta patch against v7.2-rt4 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/7.2/incr/patch-7.2-rt4-rt5.patch.xz

You can get this release via the git tree at:

    https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v7.2-rt5

The RT patch against v7.2 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/7.2/older/patch-7.2-rt5.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/7.2/older/patches-7.2-rt5.tar.xz

Sebastian
