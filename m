Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B32B644C648
	for <linux-rt-users@vger.kernel.org>; Wed, 30 Sep 2026 06:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790751451; cv=none; b=BchaIQoT+TnpAna5zwkSSPxM6pGige1sdFtMluLiQBOA+dlYjN6mopArTbUTqziSPCDFJVSkz1if6qtdFhTzB2psvW9fEektsxCpyvdY90SO/anfHUkrPvP2LmnJNYg6bDHGJrFe22YwcVB2rS0qP5qTVAQpNrGAq667G+nJmXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790751451; c=relaxed/simple;
	bh=MovwWqUl5UBnnKq9W2laF8eeHuBZVZJnkTSMiuEVtY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h2FOW5vox5PAqNZWdzxvvO4XwgIIOP0k0MA8KgYGpD0q1dywk6hRkD1RP4hr617JjZ9K7qWssiLtXoekfLGLVRTCX2y9SdMZo0c6GqckDWaskqIH7tY563KhfhGaPUVvyT+9L1CNljbcRJEt9jt2JoqWl/xZYCAkNUJOxjD/GOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZyTQK74q; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bR3/RGV8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZyTQK74q";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bR3/RGV8"
Date: Wed, 30 Sep 2026 08:57:22 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1790751444;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2pHuVPOFuLPMQTAQDiObEu84YdSpcd75qj5zJPMXDnw=;
	b=ZyTQK74q4EA6PD81W3ye5BV2IOg+BC9oxosGIFqgntV08KB+vNXe+Qgk2+MIzUy6VKamMk
	LlLfzBszTwRmsz158aza9vv2jLbGtv7BLNw4eyiGMAmg2jS6Y+9ejqfwNMyp67cDLNJHGL
	bmjIsXumhgMhnLWVoKqBhNmfLBfPk3RYswqnzibUnWJW4lzDAK8xkl4dkXwFPlJZd+5vNQ
	fqPrLpCN3sXC2ED5MvuC1r8iN528zXerqg5XJC/7ZhmpDvwX+Uv/cMsqpJwxwiEMPvdkSO
	BplmFD8Vw9wYn8wxNNpQxDP5PGmm3KawQ9F6JsOU+P8RA8zQIj4P81MsM2wPyg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1790751444;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2pHuVPOFuLPMQTAQDiObEu84YdSpcd75qj5zJPMXDnw=;
	b=bR3/RGV836dSC8ciarjmXyPsBh1mZAiGjZaEkdSFqLATISGnLTfUFJIApEGqQ0xBiqT258
	SJpA09+wpLoz4CCw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: John Kacur <jkacur@gmail.com>
Cc: Costa Shulyupin <costa.shul@redhat.com>, John Kacur <jkacur@redhat.com>,
	"Ahmed S. Darwish" <darwi@linutronix.de>,
	Thomas =?utf-8?Q?Wei=C3=9Fschuh_=28Schneider_Electric=29?= <thomas.weissschuh@linutronix.de>,
	Lukas Beckmann <lbckmnn@mailbox.org>,
	Cheng-Yang Chou <yphbchou0911@gmail.com>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Subject: Re: [PATCH v3] clictest, cyclicdeadline: Exit with failure when
 breaktrace threshold is exceeded
Message-ID: <20260930065722.p7hnhaMe@linutronix.de>
References: <20260824101852.2237494-1-costa.shul@redhat.com>
 <d414bdc8-361f-9768-1f6c-f8e1e8b80f7a@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d414bdc8-361f-9768-1f6c-f8e1e8b80f7a@gmail.com>

On 2026-09-29 16:25:14 [-0400], John Kacur wrote:
> Maybe instead do ret = break_thread_id ? 2 : EXIT_SUCCESS;

I didn't pay attention to the json bits either. What about

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index 3364dc7524faa..d9587fdd76f8d 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -2340,9 +2340,6 @@ int main(int argc, char **argv)
 	if (!verbose && !quiet && refresh_on_max)
 		printf("\033[%dB", num_threads + 2);
 
-	if (strlen(jsonfile) != 0)
-		rt_write_json(jsonfile, ret, write_stats, NULL);
-
 	if (quiet)
 		quiet = 2;
 	for (i = 0; i < num_threads; i++) {
@@ -2372,6 +2369,9 @@ int main(int argc, char **argv)
 		}
 	}
 
+	if (strlen(jsonfile) != 0)
+		rt_write_json(jsonfile, ret, write_stats, NULL);
+
 
 	for (i=0; i < num_threads; i++) {
 		if (!statistics[i])

instead?

> John Kacur

Sebastian
