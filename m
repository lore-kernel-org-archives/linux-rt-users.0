Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB2603D3CEC
	for <linux-rt-users@vger.kernel.org>; Tue, 10 Mar 2026 18:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773165964; cv=none; b=HZlKkZnYHIDt0W+HRLNU72o3K9PClthZjppoVb9Prrf9JsdfKt4ODw3et9D+bcaWy1YNzPL8NjrJ73mjE6nM6GBJFZj9wZojC3CWFbyIF1mfzrEmCiNOjDU/5gm4WvUWsEx2p7E3PkLveGvJ9glgzWy/991f7jknsDzhXmCtvnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773165964; c=relaxed/simple;
	bh=uFP6qVgHH52Jzcr8Dh/qHFjumiUiSjM7j+Z3ogqtYfg=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=YUUV24kNuYIOXLxr9nwacmioKiWzzyzLUFMy6QdKkOgymIhsbOjz/a8fBSEQyTySZWFc9FDiO2NKyRbECrotYf6UArtu4xee3ti+4JwXl0xX2qeSi9RHZ2CxuR+n6YrnWcwEzWo6DqZyr1RXF+7r1wRLXdSBHduDDy0A5abbz5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MX1DjFEF; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MX1DjFEF"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-506a6cf8242so98913981cf.1
        for <linux-rt-users@vger.kernel.org>; Tue, 10 Mar 2026 11:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773165963; x=1773770763; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=uFP6qVgHH52Jzcr8Dh/qHFjumiUiSjM7j+Z3ogqtYfg=;
        b=MX1DjFEF8DHmkbE0HFmPYFbiniyZ7T+gT/WCG2onLvmqNDKu605QZ5Mx958HTHvyFj
         LoyE5x/13kUJmhITCC9H/Wl7ttn0MY96PIKA1CuAdPs7/gicZUyPOsOJfnooUHRb9sRy
         rgKHFJDpwsOBqwUTZorLvEqJN1rdYMBgqIv4X8wrf2h0m44ploEm3CJ1yWwjj/jjFnyL
         tAEhZ7hToRYQ+Uq50yKE688+P/RG9m+yvwE0YCy+pCH/tCWUZmPRATgDf0pou2Y1laj+
         P/4u+DO0NGO5hjyFJZVcMIl5zOb5+Hcd4wCCqfFo9rOZwSfPQiiCbnElmJfloPLSJghV
         rNxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773165963; x=1773770763;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uFP6qVgHH52Jzcr8Dh/qHFjumiUiSjM7j+Z3ogqtYfg=;
        b=fLGTLhVCMr+ung0mrk5r3B31eYNAdsP7I86FJqh3TNBAhTA4gUUtFV8FPxMjxW7zx+
         uOEvdJFZpMxpi7wMkrUNH6iEabWSbRtSpOdQvGp86jv3v1LcffjAlEj+Ur/BF8GfZpkI
         QLP0f+XwOpQh++gtOG04mDFC8IDSl8yNg76cUyMg0p3YVmlPCeZoYZCe4Zjp/ePFkVyL
         fEhgyD/WfwO3bLjYMGAYXk5KD3bor5XBUyJHsEgAZ+KkQl3zx0TxrEkutqMLlx+n0S8j
         6ULqno70B995wy8yBqHkrY3Re8zq4AdKfCZ9IlVwBLBx4OGoY3LDXim49gpkf0hi8zjt
         AXDg==
X-Gm-Message-State: AOJu0YwLThcDBZToUrt8XRZUSHj8/0xDC+QI1wqdOWtJSDI9RBIaLKBQ
	wwEfZn/8bPqzZ3ltbl0dNPEbaywLhpqACLcq+c0HfUIq0hFyqVGgBVGz
X-Gm-Gg: ATEYQzxGfKrwpms1owiQlULs+9ricvF7rzG/3RNeEtppx5HwKOuago4lXa85P0uTZpQ
	UxFhGuJkbZ31djpHpbwKZfSVARYzgv/UqaJ12cOCyFQPSAzEEV++mFw2DXeuLUXhkwObDIC+h7/
	WafhtQHqPk4WflsCLv+zyWHjBf2Tk5wrL0vlWFnU7zNhdhShFH1vXA9kj2B1pbH79GI94tgpUy+
	dnQAGN92NQZBO/4N6DZ+Hzed/D5Oa2KIuIy4b16owJRD+Dtd+phqbDfrn+5WdRsoSQ2o6n+NutE
	OLOgtAXOFsrCzfBhB0sB4zHz56YCEWqJ8KCPBvADJYhD8bMjwlS8HoIZIHL8NoyUxbKrd4TrACS
	GaqmWA48hHLbpNemg1k3HMlZ2eZTlpeQjLP828luctiR/mzcaisqprzSOk34lNiYezqFpFlLPbm
	H0Njs6XfLrecI7rpWtFpU67S7yD7pcuggj18k+3C62HtlB+FBwtFj8nGmNVRzyJomzDk8pmmeoD
	g==
X-Received: by 2002:a05:622a:1920:b0:4ee:1676:faa6 with SMTP id d75a77b69052e-508f46d3ab7mr212354351cf.20.1773165962685;
        Tue, 10 Mar 2026 11:06:02 -0700 (PDT)
Received: from Cumhall ([70.50.116.180])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50938848fa8sm356841cf.24.2026.03.10.11.06.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 11:06:02 -0700 (PDT)
Date: Tue, 10 Mar 2026 14:05:44 -0400 (EDT)
From: John Kacur <jkacur@gmail.com>
To: Costa Shulyupin <costa.shul@redhat.com>
cc: linux-rt-users <linux-rt-users@vger.kernel.org>, 
    John Kacur <jkacur@redhat.com>, 
    "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
Subject: Re: [PATCH v2] rt-tests: hwlatdetect: Add timestamp delta
In-Reply-To: <20260309230917.464377-2-costa.shul@redhat.com>
Message-ID: <24c14181-05de-6054-6ee5-195f3e076a23@gmail.com>
References: <20260309230917.464377-2-costa.shul@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII


8<------

Signed-off-by: John Kacur <jkacur@redhat.com>
