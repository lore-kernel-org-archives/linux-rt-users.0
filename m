Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793728525;
	b=jmXPRQF/5/D9R2k03iRqEHeyLIMUWLXQqAqpgzgPktpMhWxWSbk5LjPidRggYMhecSD8
	 ZwA+UWpJhMz2GMxZ+buv61JFCkgeC5LelbokYInXj5cyMhPMeYoIHOUtuLDXIQYgU6tzJ
	 CV6eVf7ZLfjclX5lqv7YrEDSn9G+ZayORpxL2Hw1NJ6MV2nm4u7xzLPQAHMpw1yRIHKru
	 CffNZmcqTQ7JYlhGzkJT9sfX+Zj32mkLtDoXYcFwLkoxh5gIrHTi6U5Ho4bim9NEE//Rt
	 vGOTjfI2cPy5P2X81Z2dSLwc8HP8DTb734TWAb6sd5xiHyR8fq9cKBUKQ3ubVG8A2DA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793728525;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Sender:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=o/jcBChagKqvFY/K/V6UTzh9HQjRQjKi/q/iCF4A08Y=;
	b=j0GB0HlKtDBI/TH1D1QWUBosgEtSRh71TJlRbjNTE3J+CPzEltALpwKv0RBsUulVp+dh
	 QC6A7lsiIk+YQK+SWk3CpYNqJyk18KDYLHamRnpW/jnp7qeYHygnILjZbz39N9wBL7bE5
	 urmAO2pJXlpCo6fGS9oELUd2xfE7XFw+cfQ1eiPU/nEMVrhlz6wb27qJyLsHEGrBfqs+i
	 44OYGljFrMoRrgVZKPm7gA91D3rjsqUFA/IeKvMCeXbpsBZST1eogMfXATbVEdrqxQ8XX
	 NQdAruidUmYCNffMlcPWXqIw+4Af7bWmKUO345hKyeWtrQcNvtDx9IbCvuyK6vfro7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=redhat.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nbCRm7Ma;
	arc=none smtp.remote-ip=209.85.128.182
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 286A3606A329
	for <linux-rt-users@vger.kernel.org>; Tue,  3 Nov 2026 17:55:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 286A3606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nbCRm7Ma
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-8b0dba37a7fso41551537b3.0
        for <linux-rt-users@vger.kernel.org>; Tue, 03 Nov 2026 09:55:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793728524; x=1794333324; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=o/jcBChagKqvFY/K/V6UTzh9HQjRQjKi/q/iCF4A08Y=;
        b=nbCRm7ManWaENP4fpg2jBVLxZ329vSEIqTSgm8xbGtIj8ciYoBoEoJbPsvqeLYF1lV
         uoUlK8E0T6PuGrXgFk0K3jkYcHs3mJ2wJLPnWlGvNMGzY6wrAS/LtjoLNYsn1P9m7+5N
         kBdsbXjVlW+9JZOLHYLN513OYKeVVSCyYgNO92uz0wxCN+xeo1y738uIk11jLoI5yB+M
         Rfn8wI7ErLX73QoBvclxEFUIF1qq3jW8d+NYaBaSPpOdghgxiGgWLrNzyIdBGH3shItN
         tHoyoLKXY4bC8kUG3vUP/dQSN1rTId18H2osYfdITDBI8A5idzNboE3N/8rnQK59k2Pv
         Q05A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793728524; x=1794333324;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=o/jcBChagKqvFY/K/V6UTzh9HQjRQjKi/q/iCF4A08Y=;
        b=pWgRly3f0cM1y5B/M4OTdWHrjP4n95lswdDe9EsVXZXw0ndYE8uY6tW6RUDQZ33+ve
         sc4N+crYCgnbdIHDq9yvjq7RbSPxePZaY0W1NZtg++vIw9ZjfwuovnWWmkhKcjRsexef
         7gKKnPsKMN8w80P2HSAzccpdKGN1u0pxSF5fML3O0ydG9D2oWNqa3NxWxxeVAKEeSqbK
         KyfF8B5AWzBtvZa18NAkNXZsYw09hBkaWa6fOQs3fBDK2oYo9PBgyfgt2pNHkPea86vM
         PiIc0NHck1niYwT4Zwx5UldMnTLTh0HZwL7VNq/q9X/PGSFe4FatOB+U1Uupp25C9OBL
         FHlQ==
X-Gm-Message-State: APuU4Z/dl/f0eBo5+SQ1H6tLJzyAISR6vbAcPzxKJw2G+iy8o5E7vlHc
	XfMUPmIugYMS2SEzCFPuL/oA5U/0mdlHnokrg/06bpqw7QTfMnFGX1fURGTiJw==
X-Gm-Gg: AYBFou1/ASZx/HOjhw86UMAd2/G0IaPHUOObtNHcQoheMYOcrG40m1EncO4QEMc1Zq2
	Mmz0EyWmK2IOxcqs+jYxWNJPyKwafeMBGeRA96IyK75dsexi9PAOe3PduKfF5+eg/ApT3gdlLwQ
	GnYvXpCj8AgjABv8jWuNvx3F7ORyI033CqaE4r894+BIOpLS3cCF99oBIGzGolaGmyw8Uugrzn/
	11qPp4Tbc5htsK5R1IHv/dlhaU9AZQgiL4a7WYlbjqWMPc8Hg5QI8Xkg0A/t6x2cIofE76FpamN
	gu2ex+5ARXZeK7hchYHGZd19Rn/cqQ5weFxhRd8V/5zTY59cLiPfgBfD8BtRxtmTq5TJYTqXR4Y
	JcYusEytESz3lZbP44eG+33bJHJ3VZNmAvyDdna0Hiltap5Mx0TNCpR3iwJ2KoGNAzn6MbmfEXL
	IaMtEvxoQKYG6TIPlwPKCHIr6Pll/KqKuew5i16MoGgW0J27dh5DoQ9w9eySp7J8yfJXOKqlkEz
	ZQNP65nXE+XWsp/1OvOQmQIcLtM94t+u0BorDUDeChcnB/S7xojTC7/Cr3CAWzwTV53z+DO1DYl
	O1y7wNC1ymbSSSP0EP0Jnh0jDUp0AnupQKOI9j8Y/+q6rnnmQsg/vSzSY0+5jdTydXIsWSyY71n
	tliI73ttRvVw7II8O1hOWFmVPzFhX03dzgFBW8AxHxCDffvErpGIyrEmDlrSJMwMh+0zR+gWG
X-Received: by 2002:a05:690c:31a:b0:8b2:ff8c:63b5 with SMTP id 00721157ae682-8b2ff8c6834mr12398657b3.46.1793728524157;
        Tue, 03 Nov 2026 09:55:24 -0800 (PST)
Received: from fionn.home (bras-base-toroon01zb3-grc-09-70-50-116-123.dsl.bell.ca. [70.50.116.123])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b30997aa84sm1700707b3.29.2026.11.03.09.55.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 09:55:23 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: Sana Sharma <sansshar@redhat.com>
Cc: linux-rt-users@vger.kernel.org
Subject: Re: [PATCH v1] rteval: Edited documentation for multistressor support
Date: Tue,  3 Nov 2026 12:55:17 -0500
Message-ID: <20261103175517.107723-3-jkacur@redhat.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <auSkiUhcFJAO2-_Y@fedora>
References: <auSkiUhcFJAO2-_Y@fedora>
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Post: <mailto:linux-rt-users@vger.kernel.org>
List-Help: <mailto:linux-rt-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rt-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Fri, 30 Oct 2026 at 10:07:05 -0400, Sana Sharma wrote:
> [PATCH v1] rteval: Edited documentation for multistressor support

Looks good - thanks for dropping the stale --stressng-option /
--stressng-arg entries and documenting the new flags. The content matches
the actual behaviour (workers default 0 = one per CPU).

Two tiny fixes for a v2:
 - the commit message says "docs/rteval.8"; the path is "doc/rteval.8".
 - typo: "specfically" -> "specifically".

John
