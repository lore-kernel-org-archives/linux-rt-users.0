Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794225377;
	b=iP8FyjrMoDjEoW0yPYl32ho40QjWrBN7OKcXfLqwN6ix+N7QglPw7ikatk8VX7RNkRZJ
	 qqJWY1cgmciOePvjrRg5aanyYFCB3mekR117ZJO514jVMGTKkSXUP4P0+7GWD5YaHxp/Y
	 d1O5hRJqzMUmsfWQ6cByoGBWfY2Rwn5WDO7e1HII55jIxB/xuSe+6zQDqU2KohVNrEHTn
	 mkIZhzDsOlfpFWq/OC/nnX1IUwKE7hCIvXdOKQpfajMh6fN0dGKMZoUW+dkizflurDe9d
	 LQncUpP237TyGyp1YInVNr4BlWIKU9HxMK9Y1Kd/wYG/EOXSdLPnyXt1qNu0TM4wGjg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794225377;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=jPkWbhzdSoLogw4XbCE1N4oC3ZOtMlA3YYq+6Je8kx8=;
	b=glhFeP1DT4rLrX04EZSaOoAjBRY8UYN6dyp8xO9oDb2Bb/WbOvoTTeBONYONEkApc/C6
	 WdePQPuZHOfMdZJnOmZR1Aw4Da70QHj/vK91lc7YDhO//2Vz+3TGIwiO7p+6sqjPSSuiI
	 6/JABSrhvGR4H5oKg/zq//2xgAEQaNEOy+ZOwD71Gzi+3jt/coLuTTSm4nHQpsjM1wVeb
	 7UcXDidyG6OBmXcKU/BZnqjzIw75fL77bGCBY8X+NQ45iBiLOZmQzymYfKm7lUTzVAYuQ
	 dQdaULCNy2aI126qAvgPpNZYgey2JmOoNIWXzCqyi4/VXlvwXY1F/dxe03B8FqfQZYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=3utRgpld;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=Bc9NETpa;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9CF606A321
	for <linux-rt-users@vger.kernel.org>; Mon,  9 Nov 2026 11:56:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2C9CF606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=3utRgpld;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=Bc9NETpa
Date: Mon, 9 Nov 2026 12:56:13 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1794225375;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jPkWbhzdSoLogw4XbCE1N4oC3ZOtMlA3YYq+6Je8kx8=;
	b=3utRgpldbyMXqnt/eMecqzMkpSo+f2gBNCQlG4usKfgCKf+TbrUeLEgoDBHc+SiuaZlEWc
	IjmdHwex1XSj+LayeuV5gAj06TUm0mG/skjoOBoQdS6pYsRj565ABmiKBhgoVKNyxqL7JI
	HP7277RDBW/yX/pZKiOMx+BmL5HXbeO1kuhcUlVVGLckH5+hajFUjE/LJ9mZwa8D/7Ab2Q
	OqT5pCps7Hbm6LQ8scMZbXTEMGoXNvOvFLy22Hl+GyCBq1cYTpphyFFAp+BdKjGDYI4ijv
	mPTOVhXgANKP621tZkC/Y849VHTvGjJn/RNQOGNvXKld/w8Z/gmrJnWnSorBjA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1794225375;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jPkWbhzdSoLogw4XbCE1N4oC3ZOtMlA3YYq+6Je8kx8=;
	b=Bc9NETpa5d4OnNERI7tH02hEr8DFG/HWDexDn5epn2HId5w0fQ/pnxbYjT46fuojCsCchk
	B9MxPy/mU7KoLXAA==
From: "Ahmed S. Darwish" <darwi@linutronix.de>
To: Sana Sharma <sansshar@redhat.com>
Cc: linux-rt-users@vger.kernel.org, jkacur@redhat.com
Subject: Re: [PATCH] rteval: Changed logic for when stress-ng is absent
Message-ID: <avG03ec8EXEVWZgY@lx-t490>
References: <au4xNH5aozR5P2MD@sansshar-thinkpadp1gen4i.boston.csb>
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
In-Reply-To: <au4xNH5aozR5P2MD@sansshar-thinkpadp1gen4i.boston.csb>

On Fri, 06 Nov 2026, Sana Sharma wrote:
>
> Changed the failure in case stressng it not found from a sys exit
> to return an empty list so as to make it more graceful
>
> Signed-off-by: Sana Sharma <sansshar@redhat.com>
> ---

Same problematic passive language here as well.

Beside that, commit changelogs should focus more on the "why" of things,
not just the "what."

Thanks,
Ahmed
