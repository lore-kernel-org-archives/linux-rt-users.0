Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D1340BF5
	for <linux-rt-users@vger.kernel.org>; Sun, 29 Jun 2025 08:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751185281; cv=none; b=bNvrs+rGeiVImNwVaTpoES4x8n8AGJWQgAryvTVwbDnu6+yDgXwzBuj211W+KuF8Do0zFfqnLxOJRGenkdhP25qs+BVxeVgyOwdyB7bu8mYS52cgxaJHx3tywYh/PVMY08yFRVf4anRejjO43JTiSLtxxzV4do4KdgXJp0nGGzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751185281; c=relaxed/simple;
	bh=r0zVBl49EQvW7LPtRXQeXwhtCYs+oLsCcLzqg2lKPXw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hb6ZpWH49lPMmp3Zjk8bJ5VHbWDh+eVXWDwdbJaXbfz9+BOV+VJHvx3rCYSYNyLVRnCw1te+OUOilj6lKuRaVs4aD/nkZbf3+w4G6DGktfSQlLeLAS5zv5L7bHLz+3ILBxkGer1Nwu9GRis8Yiue5L23BSB74zRx3xiac8+P1qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UwgYpcYe; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UwgYpcYe"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-235ea292956so7655795ad.1
        for <linux-rt-users@vger.kernel.org>; Sun, 29 Jun 2025 01:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751185280; x=1751790080; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4ptaD5EFfzkQfJ5EEgnCTsz0hAvUkZFbLIfkDCWEBmE=;
        b=UwgYpcYeJBO4hzAFuqOfwVs94LFGxWvxk8LzQnlHBGXjt7YdARVc6d3QkL8YyjFNJ/
         QTGptc9zPQjQ1gwpqcZFpdJ7XsTBPgmG/fudin5zEdz5TUDtWwWuATGBTyfQPlPHhuwM
         iePl+5EmEE4T2mDEXWxo2zkyrEj8FxYCI1AJ1FxKRV3Qz1Ceo78eV0EtqJPS5YELurSQ
         jQvZlEFeWgNXCV3YHknpW7rI9vkH+qCAfk7B4NbLrmvWg2jSQ87pd+AYnCsL+o/v3tqG
         x9m0Paes+towFkOPT6/N6ZtYz3ws/TDb3ZAJiWZoVE+xAX8JFmtyhJBY3NpPQnLzDkpV
         zAFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751185280; x=1751790080;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4ptaD5EFfzkQfJ5EEgnCTsz0hAvUkZFbLIfkDCWEBmE=;
        b=T90/isiPYrEHWiBTGKGI0OiIKyOcuwqYQNPsks76Ug2uQu03wlhLZmnrdTfl2ocLv2
         EV+hefJfbKgNKucD7UlnV7G88BhTvGvBHSxvRTOysPgbCT4y4dZmrBsz2qKHoE1xF1YJ
         fnoIo3F972tQ+eMSzJ8EJ+0VQLW5vkFgpJoCLmj0aX2r7UFw7wLNa7ZGFLx9WOCVIIDa
         2hRknChOBvBa/4sMf/Gv2HS7IAtv8RSplxVoEjdUEvgTqdVE9D+KDJ853T3fsufLB4S8
         MQlHOWEbXH25XXuws9X73K1nDGWmGlfliqLBMlQ061oDx2HrmpjsTG/EeD6Bo1VKHkQt
         kr9Q==
X-Gm-Message-State: AOJu0Yx18WEv+u/kUxgCBqZZXVffJxPfRl9eIdLuPXjrWZ6MuiDZJKnx
	2rcq5b3PS3G88fU30cxjUfwlzf6bAeZpEzdcYVrXFia2NUQUycc1m+Xr/y4WqLLK
X-Gm-Gg: ASbGncshrFlgtPfGb+81wuopy57HScFHKOm4CaMaWPH50vZBfVdjdriubZmzL2tPiM8
	UxqhtdT0UMv1MuFHUWl1NKTdoIF9o55htBMgma84VOlZ3+fsIDVjyEdp4/xW8RC9EXHsoGmpKdw
	3XpgITopAG+Wtwrouse1b+RuTm9MXP6Ad7iVJOMI8W8Hcr2wl5nASu939Jns3MirOMCpBt9ve1N
	n+uU1OpekFq+wnTiOuO6XLqVcnoJlhSBIWE0StfSgoLLW9J63DjlGexXFzSMcAxp3f/i2cPvZGq
	9lazjq6pBle2pDvTFHolYts5n4r4t8ZMXfSj+EBGr9a0BYr+w2yXY2mNLSo7xhDB9pjT
X-Google-Smtp-Source: AGHT+IE1+QY0/mdjRWiDKAHtjE9gSaTdnz1k3Y9eJjRPcmHuhVqKFSQ7dJjqEIOEBSz1LDR8RuTDaw==
X-Received: by 2002:a17:903:2983:b0:234:aa98:7d41 with SMTP id d9443c01a7336-23ac4685adbmr143903205ad.42.1751185279467;
        Sun, 29 Jun 2025 01:21:19 -0700 (PDT)
Received: from eric-wcnlab ([2001:288:7001:1099:b022:c80a:28f5:5d52])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23acb3cfcabsm53521035ad.253.2025.06.29.01.21.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jun 2025 01:21:19 -0700 (PDT)
Date: Sun, 29 Jun 2025 16:21:15 +0800
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: williams@redhat.com, jkacur@redhat.com
Cc: linux-rt-users@vger.kernel.org, jserv@ccns.ncku.edu.tw
Subject: Re: [PATCH 0/1] Makefile: Temporarily suppress -Werror=unused-result
Message-ID: <aGD3e43_k3KRzK1O@eric-wcnlab>
References: <20250618201738.635735-1-yphbchou0911@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250618201738.635735-1-yphbchou0911@gmail.com>

On Thu, Jun 19, 2025 at 04:17:37AM +0800, Cheng-Yang Chou wrote:
> Cheng-Yang Chou (1):
>   Makefile: Use -Wno-error=unused-result
> 
>  Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Hi Clark and John,

Gentle ping.
Please let me know if any changes are needed.

Thanks.

-chengyang
