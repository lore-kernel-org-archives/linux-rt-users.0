Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53DBB2E6CAB
	for <linux-rt-users@vger.kernel.org>; Mon, 31 Aug 2026 16:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788194455; cv=none; b=YcBuXNSzezDqGOcV25FzGG4ymeH+exRuZQlQdHUhxXPiAOenq5ssGfQDVFQmL7A4s1F9RNaYl/qh8BXgJ5v9k5oi4pZCyNAVIuBKUJa9GuiVTHHjKMzvsJCR5Dx0WG+4xvfxB5giCBuaZTa3Brow2ff2ZsEqWmTvGVXJ5JCQzKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788194455; c=relaxed/simple;
	bh=T2mjEt9fOlS034W0Htz0P6KS2Jcxm11QGObV386+1Lw=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=g+3Dn7FZ32rFQ7ZA7xuq0TlcOx20j4czEQgo1/7m0R/Ygr9qjgpj0dM/y9huJk2uiZFNvtCPLmx/TpYgaLq6emYOaXC/is/Qw4aWgzBPnXPaY87DPoKmLs8UJAXzRpSuEJ4dcVY3q8AGl760zH3no40NGyaDfZ7vTOE89XwHAYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ro7t4gu+; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ro7t4gu+"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-9384cb251fbso179626685a.2
        for <linux-rt-users@vger.kernel.org>; Mon, 31 Aug 2026 09:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788194453; x=1788799253; darn=vger.kernel.org;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=T2mjEt9fOlS034W0Htz0P6KS2Jcxm11QGObV386+1Lw=;
        b=ro7t4gu+FzFnbOZSlN3qmPF/POMb+DX5j6wfwS6lpDv8aUioqlRXbOPQW/9Jef06GY
         M92wIMmFpyIk32DCn8qba8aqtiK3+zXgTc8aDHe97jFB00t+8Qj/jqKD19k+NTlC93xi
         oJVkuJyqhmyc9QU9VPtnvV4EYE7ON44MIlYCJGE2klNt6pqytY7/NJ5IaAkVj/kHrKbd
         IEKO0VvQDbtk1uU+ifKvWVt3yAkRAkLEG24wCtxuFM8m3jtiTlfzKl/dn4z7xTm2lAKT
         Tj4lvIg9C8D5edh7olgdjk68TDkNONI0WdCsEQ+CONvPMDg03/eBRkVnIEpHft7CdjGx
         IgdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788194453; x=1788799253;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=T2mjEt9fOlS034W0Htz0P6KS2Jcxm11QGObV386+1Lw=;
        b=mNfkFB6/63dsYgJ/j1gvRuLHGBDvjFEwqWZwb/Flv1HmhNKN4ZVWkn/0kIO8gDItoj
         yYNR04BBGOyh3Sn4OyikW7yM/AlyOybB5sNyN4FLfcsI1knUugb2JT46k75uhiGLEYZO
         eEzn4b/dyD2Tuo82o/4Sn9ImJVoX7pNG9PA96vWZNZzKVSjFR0JBq73sl5njICuFKNYX
         8ACtBULPzjj96uxknEaqpc1Umsd6Iq37NTV3EMOgzfMwIhvFFrigGFnXwNd7IzZg88Ix
         PIwyz0OsumPQzaBYHOIZ4OvuwhD+rSOze740PtauzHkEMD+gC4AvHHOIpJMJippOf/I2
         flNw==
X-Gm-Message-State: AFuF++lwRkdWP1T+8QKUGl1rEbgOoEdgReoQVVnjyJri/BHULRRMWT12
	vctsztGqlFWNe/OQtDN87MW5y3Po9gfDK1E3ZoX9P9QqL1V11UnQXAS0
X-Gm-Gg: AR+sD116hToEOPsnU68Wd0BqlOyEPkI35O/sZjIN3B+YuTaXjF/pEhlG3aPpWomVMci
	YnC8yRPskfQkYusq2J9RQ6zZeU5aEAsXP6aubep7ydKKd3sFjYM5xyOmVGOunXlgtU74Lp+6l6d
	38Hz4ayiE5voi3LkQu4qZjrXDnRtYIqeeJq7ER8R2b9/VEfuGiBGBtHudlktcJuvEUhGcKMnkFx
	b6fkqFlVN/g1J/VlfPD2OiFruuxt4JZI+WDZ7cVp1cMnMKVgj1gYcbRJyd99oiA2HJaVexYsaOh
	Z1DgwQRcqCqQMZgKkb5VjSSvLo7UgEJd0c0ZQbaKByTEk3APxYOIvogN8EspaE9w3lc+BpnnXnq
	NyqEvOLNZSY6QEasjGS8jnmnzP5bzMp3b6vQglwdGd9uGlCgwp9RS0H8GnF60Z6ZoWKpu60axN7
	rbjGJxoRMHpPyEfYkRUv5noDGCwUTyxM9L+cNRl3a0t2ne9f70V6l/WODu1wBp9EDQEU1ixRHl8
	tdLr4JssfLu/jIoCge7arNvv9F1Kud/KokA
X-Received: by 2002:a05:620a:44cb:b0:939:15e:1a5 with SMTP id af79cd13be357-9391391a8a4mr3120192485a.35.1788194452956;
        Mon, 31 Aug 2026 09:40:52 -0700 (PDT)
Received: from Cumhall ([70.53.55.174])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-939173d47f4sm831127285a.32.2026.08.31.09.40.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 09:40:51 -0700 (PDT)
Date: Mon, 31 Aug 2026 12:40:48 -0400 (EDT)
From: John Kacur <jkacur@gmail.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
cc: linux-rt-users@vger.kernel.org, John Kacur <jkacur@redhat.com>, 
    Crystal Wood <crwood@redhat.com>
Subject: Re: [PATCH 1/5] rt-tests: cyclicdeadline: Remove unused
 `alloverflows'
In-Reply-To: <20260826132153.2476006-2-bigeasy@linutronix.de>
Message-ID: <fb20892e-bf6b-eba9-f44b-39710be0b32c@gmail.com>
References: <20260826132153.2476006-1-bigeasy@linutronix.de> <20260826132153.2476006-2-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII


[snip]
Signed-off-by: John Kacur <jkacur@redhat.com>
