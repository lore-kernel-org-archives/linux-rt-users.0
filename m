Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793656090;
	b=qW9k/acb6O178D9YD6sFNB86yqbpkIPVW95xoAdKsjzroTCYpoEmNWHM0lperM+8MKrm
	 /sC30q5VrZGsRUCT7qFmQF0YCJ7y6rOZgGX5MT8hDUWvddEqhY7F9DYhh9H7Tb445s7dX
	 xtmlyMxxkhhA+tYLEJ9GnvAw08cU7L18WZmmjViUVimXoSGJlaI9/1QA9ymbgoLLVbneo
	 X23z7Vt/iQe4V7U5u4bcwbBt2khnY7zXTnEF8BasiAnDu9ElFXqV5XEV9iZwCvRfJK+ys
	 VD5wme13wiBPoIe/m+bsw9N0ft5lIiZUx6XEzes8l0W0htJ42g9PMHvGMdgKdmx+tAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793656090;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Sender:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=HL8n4hM1jkSziOepCQ+JNi3Ux30Dn49fTFbbZh+6dLE=;
	b=r68+L6LQ+w/HLK/92tndq0Iyl3T0ocQ4VtVmvkUSQHmKDGPjcm5BVopyQj+lR+0yUPcO
	 +N9H7eLkvu8S0G2/4fnEhc9f9lwCpZnvDOL/wXoriu6n7ljEU4z2Wk9TfadziutqNgmCI
	 47/RaV8iaMiN8df++petKqD8stBH7NJHthC2tgMaFQDwdBZc3rH4Cie+SL0LKXh6aVG7i
	 YFqQPqoKf+BAVrk0YCp6v+tmznSrDUEkFm30ENLHUhOL5uhqon1ilfAMyKsqNrJAL5ZV+
	 Gqipol+Jwa43pTZ47JARrNCXyfVsklZCTXc53GGzRZtQ5mqOoIiMd7ffdbIUqpvQdCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=redhat.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MqA4M3Rp;
	arc=none smtp.remote-ip=209.85.160.181
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960AE606A327
	for <linux-rt-users@vger.kernel.org>; Mon,  2 Nov 2026 21:48:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 960AE606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MqA4M3Rp
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-533797e72e8so22551181cf.2
        for <linux-rt-users@vger.kernel.org>; Mon, 02 Nov 2026 13:48:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793656088; x=1794260888; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=HL8n4hM1jkSziOepCQ+JNi3Ux30Dn49fTFbbZh+6dLE=;
        b=MqA4M3RpP6GU3Bg/kDkNIwMgSJzYy1CVEGPoKfoNbUWrFaYefT48NkwHvazE6UYAUh
         UTEMeaC9m4EiBCM9dMbo/pUa633Jj3NCgJKkeBQTdi/MsO8hdsRCFYLj+taGp3AzDoK+
         CVMLBmAa3xeLsgAdabj5+LEXG09bG1uXXRD5Tfv7gUPkcuWsSUNUa7m9rKxPsDK3cHWP
         +tUV4RgO93TEQlctFnGuRfpp1Gj+rol6U119hdOjQtQ8s3GxvIVxt6cq6RYheca52hJz
         0ZET5CMlTZ+pz4KACPfgJ3KgyfEsN9f5E+sz6NDlWs025lzy1vYUDQ+Nz55MxNm1t76J
         H1xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793656088; x=1794260888;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HL8n4hM1jkSziOepCQ+JNi3Ux30Dn49fTFbbZh+6dLE=;
        b=U4FheISIYxV0PxwRjfMk95MX5wnQL8df6NMEG8R9Aj3g9fmw6ba68iNk7dhmvy9GJ0
         ISR41fRXBNyO3zdFdHnkzB3Ma3jDmPO3iQ33Y3G7AQ96cpLkj1TrWuvkq31vExOZwQQQ
         VlqZUbxWMklS0ADmThkqd2FTv04DWuZxI5hg2Vi2K1KeCNgt1CZoliIsk2HKWElenH8Z
         dkQcPnCHaRk3d6TDOp4LymHRaG4F3a2wUkB8bkccWtLu3rUS6DZHyEVlqiEHVKmtXf6g
         PNlykpg/J7LNUjeKbQ8YuhnnRC+Qa8K47KMRHGkBqeZfhP+Ehh+QNf/whYSBIP3gAhO9
         gkDA==
X-Gm-Message-State: APuU4Z9c6ScZX0rB09cv6uG5jq0dSsfHu4bVu169XkMCvYU3iUuooeDz
	n3j9BoJ6ryhI0zLenRe4QHDNI3v6ZkqtWmyctsI+PFR26sg29mBmb5Z7
X-Gm-Gg: AYBFou3vFO8ocrF2w4C8SV0hSBkRnbFOmdwFJ1Xj0VOEcTSAS5vNLzA1hAOwphTTHzw
	ydell34mi3Nn7CP6Cqfdl2/w7+Inr8DDPqCz/LIiG//GUNrzb5nw/fo+32JvT0/Br/9Dg4740LQ
	q2ASGuIHGfji3ydVQWH7PLL1k0YXb7nzdzUYnMMgnaTfI1WZ67XOUunHqNnOCy2Om3rg3QGEeop
	iq/mLyyvoYM9N5mjqNPOoUAbcCh7I25FJ2V/QPuVPW7Y4RaGT+Ijyt+7J/rofPOVufjjYX5+hVb
	x+9YJKnIhsKosrwsZwfCrL2VhSnMYxIaLAYfsXTs4Vh85v5lL+0OruQaHWGA4zywhOA9eK1UaTH
	uXmK4FQJa7zwTw+idlK45GeunMmFOVHCzY/+tDUxYZnGBO7M16kyqN3TZeTDKhN6xjpYiiabCX5
	MkEtTbPt1ew58AXy11PKpUgpdJe1/vVxEWbu2hzOA3HdwCAUEwQSp/OyLVFb9ASAEyHqU20Dmnp
	VhEZKdyq4SGPEZ7KKplA+j8W6G8YYA3MgwcJ/sN5Z7St5KkDJBo/6jaV1bIp4Jo4p9xD+vsnETO
	wnZQ3r5xjglTKJjMSdXBFQVlL55CHt7Vk6yZ2rgGXYAl5MxE2YOgiEglR9PT0O8Hn0pfZ0Y6Aza
	FvwM8VO4oaDR7+y2D49Onlfs5YKUjcpes8Fh1vxNaGmbhmr4sRa9MzF08+Iebez0dHv8xQJ6okn
	gwJeoTUNuPt9Br/lu0Ys+ujfzBoHQ=
X-Received: by 2002:a05:622a:1247:b0:535:a5fa:ee02 with SMTP id d75a77b69052e-542b7dfcaa1mr191905521cf.66.1793656088417;
        Mon, 02 Nov 2026 13:48:08 -0800 (PST)
Received: from jkacur-thinkpadp1gen2.rmtcaon.csb (bras-base-toroon01zb3-grc-09-70-50-116-123.dsl.bell.ca. [70.50.116.123])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ca7f3f903sm100963826d6.17.2026.11.02.13.48.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 13:48:07 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: Costa Shulyupin <costa.shul@redhat.com>
Cc: linux-rt-users@vger.kernel.org,
	Crystal Wood <crwood@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Bart Wensley <bartwensley@gmail.com>
Subject: Re: [PATCH v3] rt-tests: hwlatdetect: Restore tracing parameters
Date: Mon,  2 Nov 2026 16:48:03 -0500
Message-ID: <20261102214803.100471-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261020180339.1062486-1-costa.shul@redhat.com>
References: <20261020180339.1062486-1-costa.shul@redhat.com>
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

On Tue, 20 Oct 2026 at 21:03:39 +0300, Costa Shulyupin wrote:
> rt-tests: hwlatdetect: Restore tracing parameters

Applied, thanks!

The DebugFS/tracefs rework and the hwlat.txt refresh Sebastian mentioned are
orthogonal to this fix and can be handled as separate patches.

Signed-off-by: John Kacur <jkacur@redhat.com>
